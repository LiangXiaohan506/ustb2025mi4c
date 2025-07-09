% EEGLAB history file generated on the 07-Jul-2025
% ------------------------------------------------

EEG = loadcurry('F:\Acquisition\new\lgj-Acq 2025_07_07_2109\lgj-3\Acq 2025_07_07_2109.cdt', 'KeepTriggerChannel', 'True', 'CurryLocations', 'False');
EEG.etc.eeglabvers = '2025.0.0'; % this tracks which version of EEGLAB is being used, you may ignore it
EEG = eeg_checkset(EEG);
EEG = pop_editeventvals(EEG,'delete',1,'delete',2,'delete',3,'delete',4,'delete',5,'delete',6,'delete',7,'delete',8,'delete',9,'delete',10,'delete',11,'delete',12,'delete',13,'delete',14,'delete',15,'delete',16,'delete',17,'delete',18,'delete',19,'delete',20,'delete',21,'delete',22,'delete',23,'delete',24,'delete',25,'delete',26,'delete',27,'delete',28,'delete',29,'delete',30,'delete',31,'delete',32,'delete',33,'delete',34,'delete',35,'delete',36,'delete',37,'delete',38,'delete',39,'delete',40,'delete',41,'delete',42,'delete',43,'delete',44,'delete',45,'delete',46,'delete',47,'delete',48,'delete',49,'delete',50,'delete',51,'delete',52,'delete',53,'delete',54,'delete',55,'delete',56,'delete',57,'delete',58,'delete',59,'delete',60);
% pop_eegplot( EEG, 1, 1, 1);
EEG = pop_select( EEG, 'rmchannel',{'21', 'VEOG','HEOG','TRIGGER'});
EEG = pop_reref( EEG, [23 24] );
EEG = pop_eegfiltnew(EEG, 'locutoff',7,'hicutoff',35);
EEG = pop_epoch( EEG, {  '1'  '2'  '3'  '4'  }, [0  4], 'newname', 'Neuroscan Curry file epochs', 'epochinfo', 'yes');
EEG = pop_saveset( EEG, 'filename','S04_run3.set','filepath','F:\\Acquisition\\ustb2025mi4c\\');
