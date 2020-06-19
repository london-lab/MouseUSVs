% Input:
%    * syllables: 2D matrix where each row contains a syllable
%       representation.
%    * initial_labels: The initial labels of each syllable are used for
%       caluclating the starting SIS.
%    * times_to_next: array of times in seconds between each syllable and
%       the next one. If the next syllable is in a different session, it's
%       time value can be set to 1 (or any value higher than 0.16)
%    * Nc: number of labels.
%    * depth: The depth of the suffix tree for calculating the SIS.
% Output:
%    * all_train_sis_values: Values of SIS on the training-set throught the
%       algorithm.
%    * all_test_sis_values: Values of SIS on the test set for each step of
%       the algorithm.
%    * centroids_changed: The centroid id which had the highest SIS
%       change in each step.
%    * change_values: The change vector used on the changed centroid in
%       each step.
function [all_train_sis_values, all_test_sis_values, centroids_changed, change_values] = run_sim(syllables, initial_labels, times_to_next, Nc, depth)
    addpath(genpath('..\Syntax_Information_Score'));
    num_of_sequences = count_sequences(times_to_next);
    all_sequence_ids = randperm(num_of_sequences);
    train_sequence_ids = all_sequence_ids(1:2:num_of_sequences);
    test_sequence_ids = all_sequence_ids(2:2:num_of_sequences);
    train_syllable_ids = get_indices_from_sequence_ids(times_to_next, train_sequence_ids);
    test_syllable_ids = get_indices_from_sequence_ids(times_to_next, test_sequence_ids);

    init_centroids = get_centroids(syllables, initial_labels, Nc);
    centroids = init_centroids;
    selected_sis = get_sis_for_sequences(initial_labels, times_to_next, depth, train_syllable_ids);
    max_iteration = 10000;

    all_train_sis_values = [];
    centroids_changed = [];
    change_values = [];
    for iteration = 1 : max_iteration
        change_val = 0.9 + rand(1, size(syllables, 2))/5;
        cur_sis_values = zeros(1, Nc);
        for centroid_update = 1 : Nc
            fprintf('Starting centroid update at time %s\n', datestr(now,'HH:MM:SS.FFF'));
            cur_centroids = update_centroids(centroids, centroid_update, change_val);
            cur_labels = cluster_from_centroids(syllables, cur_centroids);
            cur_sis_values(centroid_update) = get_sis_for_sequences(cur_labels, times_to_next, depth, train_syllable_ids);
        end

        previous_sis = selected_sis;
        [selected_sis, best_change] = max(cur_sis_values);

        if(previous_sis > selected_sis)
            change_val = ones(1, size(syllables, 2));
            selected_sis = previous_sis;
        end

        all_train_sis_values = [all_train_sis_values; selected_sis];
        centroids = update_centroids(centroids, best_change, change_val);
        centroids_changed(iteration) = best_change;
        change_values(iteration, :) = change_val;
    end
    
    
    all_test_sis_values = [];
    centroids = init_centroids;
    for iteration = 1 : max_iteration
        change_val = change_values(iteration, :);
        centroid_update = centroids_changed(iteration);
        centroids = update_centroids(centroids, centroid_update, change_val);
        cur_labels = cluster_from_centroids(syllables, centroids);
        all_test_sis_values(iteration) = get_sis_for_sequences(cur_labels, times_to_next, depth, test_syllable_ids);
    end
end