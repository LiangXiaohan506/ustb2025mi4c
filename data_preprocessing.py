import mne
import os
import numpy as np
from sklearn.preprocessing import StandardScaler

edf_file = r'F:\Acquisition\ustbMI4C\edf'
txt_file = r'F:\Acquisition\ustbMI4C\txt'
save_feature = r'F:\Acquisition\ustb2025mi4c\Feature'
save_label = r'F:\Acquisition\ustb2025mi4c\Label'

event_id = [16, 32, 64, 96]
tmin, tmax = 0.0, 4.0
id_to_label = {16: 0, 32: 1, 64: 2, 96: 3}

for filename_edf in os.listdir(edf_file):
    # 1. 读取 .edf 文件
    raw = mne.io.read_raw_edf(os.path.join(edf_file, filename_edf), preload=True)
    # 2. 提取 Epoch 数据
    filename_txt = filename_edf.replace('.edf', '.txt')
    data = np.loadtxt(os.path.join(txt_file, filename_txt), skiprows=1)
    events = np.column_stack((data[:, 2].astype(int), np.zeros(len(data)), data[:, 1].astype(int))).astype(int)
    # 3. 通道筛选：只保留 EEG 通道，并去掉“21”、“VEOG”、“HEOG”
    exclude_channels = ['21', 'VEOG', 'HEOG', 'Status']
    exclude_channels = [ch for ch in exclude_channels if ch in raw.ch_names]  # 确保通道存在
    raw.drop_channels(exclude_channels)
    # 4. 全局重参考（平均参考）
    raw_avg = raw.set_eeg_reference(ref_channels='average', projection=True, ch_type='eeg')
    # 5. 带通滤波：0.5 Hz - 100 Hz
    raw_filt = raw_avg.filter(l_freq=0.5, h_freq=100.0, method='fir', phase='zero', picks='eeg')
    # 6. 降采样到 250 Hz
    raw_res, events = raw_filt.resample(sfreq=250, events=events)
    # 7. 创建 Epochs（时间窗口：[0.0, 4.0] 秒）
    epochs = mne.Epochs(raw_res, events, event_id=event_id, tmin=tmin, tmax=tmax, baseline=None, preload=True)
    # 8. 标准化
    epoch_data = epochs.get_data()[:, :-1, :-1]  # 形状：(n_epochs, n_channels, n_times)
    epoch_shape = epoch_data.shape
    scaler = StandardScaler()
    for i in range(epoch_shape[0]):
        epoch_data[i] = scaler.fit_transform(epoch_data[i])
    # 9. 提取原始事件 ID 作为标签
    labels = epochs.events[:, -1]
    new_labels = np.array([id_to_label[id_] for id_ in labels])
    # 10. 保存特征和标签
    np.save(os.path.join(save_feature, "{}.npy".format(filename_edf.partition('.')[0])), epoch_data)
    np.save(os.path.join(save_label, "{}.npy".format(filename_edf.partition('.')[0])), new_labels)
