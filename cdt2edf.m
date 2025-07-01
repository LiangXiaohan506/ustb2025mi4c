% EEGLAB history file generated on the 01-Jul-2025
% ------------------------------------------------

% 清除工作区
clear all;
close all;

% 定义基础路径和子文件夹列表
base_path = 'F:\Acquisition\ysh-Acq 2025_06_26_1119';
subfolders = {'ysh-1', 'ysh-2', 'ysh-3', 'ysh-4', 'ysh-5', 'ysh-6'};
output_prefix = 'F:\Acquisition\ustbMI4C\S04_run';

% 循环读取和保存
for i = 1:length(subfolders)
    % 构造输入文件路径
    input_file = fullfile(base_path, subfolders{i}, 'Acq 2025_06_26_1119.cdt');
    
    % 读取 .cdt 文件
    EEG = loadcurry(input_file, 'KeepTriggerChannel', 'true', 'CurryLocations', 'false');
    EEG.etc.eeglabvers = '2025.0.0'; % 跟踪 EEGLAB 版本，可忽略
    EEG = eeg_checkset(EEG); % 检查数据集完整性
    
    % 构造输出文件路径
    output_file_edf = [output_prefix num2str(i) '.edf'];
    output_file_txt = [output_prefix num2str(i) '.txt'];
    
    % 保存为 .edf 文件
    pop_writeeeg(EEG, output_file_edf, 'TYPE', 'EDF');
    pop_expevents(EEG, output_file_txt, 'samples');
    
    % 打印进度
    fprintf('已处理 %s 并保存为 %s\n', input_file, output_file_edf, output_file_txt);
end

fprintf('所有文件处理完成！\n');
