% mergeUnmergeSpikes.m
% This is an example file on how to use processSpikesForSorting.
% Fill in the file_path where your data is located and the file_prefix of
% the files which spikes you want to concatenate for sorting (variable
% file_prefix_all in this example.) If you have files from two or 
% more different tasks you can still concatenate the spikes but should make
% sure that you create different bdfs for each task (unless you know
% what you're doing.)

% Merge files
file_path = 'Z:\data\Jango_12a1\CerebusData\LearnAdapt\KO-08-07-15\';
file_prefix = 'Jango';

% Run processSpikesForSorting for the first time to combine spike data from
% all files with a name starting with file_prefix.
mergingStatus = processSpikesForSorting_sn(file_path,file_prefix,1);

%-------------------------------------------------------------------------------------
%%
%-------------------------------------------------------------------------
file_path = 'Z:\data\Jango_12a1\CerebusData\PICexperiment\06-15-14 Cypro\';
file_prefix = 'Jango';

mergingStatus = 'merged spikes';
mergingStatus = processSpikesForSorting_sn(file_path,file_prefix,0);
 
     
file_prefix1 = 'Jango_IsoBoxBaseline_Utah12EMGs_06152014_SN_KG_001';
file_prefix2 = 'Jango_IsoBoxBaseline_Utah12EMGs_06152014_SN_KG_002';
file_prefix3 = 'Jango_IsoBoxCypro_Utah12EMGs_06152014_SN_KG_003';
file_prefix4 = 'Jango_IsoBoxCypro_Utah12EMGs_06152014_SN_KG_004';

 
 if strcmp(mergingStatus,'processed')
     % If everything went well, create bdfs for your files (you might
     % want to split them up by task.)
     
     bdf1 = get_nev_mat_data([file_path file_prefix1],'verbose','rothandle',0,1,'ignore_jumps');
     bdf2 = get_nev_mat_data([file_path file_prefix2],'verbose','rothandle',0,1,'ignore_jumps');
    bdf3 = get_nev_mat_data([file_path file_prefix3],'verbose','rothandle',0,1,'ignore_jumps');
   bdf4 = get_nev_mat_data([file_path file_prefix4],'verbose','rothandle',0,1,'ignore_jumps');
  bdf5 = get_nev_mat_data([file_path file_prefix5],'verbose','rothandle',0,1,'ignore_jumps');
 end

%------------------------------------------------------------------------

cd('Z:\data\Jango_12a1\BDFStructs\PICexperiment\06-15-14\')
save(strcat(file_prefix1,'-s'), 'bdf1')
save(strcat(file_prefix2,'-s'), 'bdf2')
 save(strcat(file_prefix3,'-s'), 'bdf3')
save(strcat(file_prefix4,'-s'), 'bdf4')

