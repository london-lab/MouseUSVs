load('DB_Table_EntropyTree.mat');
initial_labels = mupet_classification_8;
load('small_mupet_syllables_8.mat');
syllables = V';
Nc = 8;
depth = 1;
[all_train_sis_values, all_test_sis_values, centroids_changed, change_values] = run_sim(syllables, initial_labels, times_to_next, Nc, depth);
