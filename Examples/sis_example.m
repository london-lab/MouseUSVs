load('DB_Table_EntropyTree.mat');
labels = mupet_classification_8;
depth = 1;
[individual_sis_contrib] = calculate_individual_sis_contribution(labels, times_to_next, depth)
figure; bar(individual_sis_contrib);
