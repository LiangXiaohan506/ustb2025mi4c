% EEGLAB history file generated on the 07-Jul-2025
% ------------------------------------------------

EEG = loadcurry('F:\Acquisition\new\lgj-Acq 2025_07_07_2109\lgj-6\Acq 2025_07_07_2213.cdt', 'KeepTriggerChannel', 'True', 'CurryLocations', 'False');
EEG.etc.eeglabvers = '2025.0.0'; % this tracks which version of EEGLAB is being used, you may ignore it
EEG = eeg_checkset(EEG);
EEG = pop_select( EEG, 'rmchannel',{'21', 'VEOG','HEOG','TRIGGER'});
EEG = pop_reref( EEG, [22 23] );
EEG = pop_eegfiltnew(EEG, 'locutoff',7,'hicutoff',35);
EEG = pop_epoch( EEG, {  '1'  '2'  '3'  '4'  }, [0  4], 'newname', 'Neuroscan Curry file epochs', 'epochinfo', 'yes');
EEG = pop_saveset( EEG, 'filename','S04_run6.set','filepath','F:\\Acquisition\\ustb2025mi4c\\');
