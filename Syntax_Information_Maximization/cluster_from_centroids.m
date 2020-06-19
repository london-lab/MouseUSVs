function labels = cluster_from_centroids(syllables, centroids)
    num_of_syllables = size(syllables, 1);
    num_of_batches = 3;
    max_num = floor(num_of_syllables/num_of_batches)*num_of_batches;
    all_indices = 1:max_num;
    all_batches = reshape(all_indices, num_of_batches, []);
    clear all_indices;
    labels = zeros(num_of_syllables, 1);
    for batch_id = 1 : num_of_batches + 1
        if(batch_id > num_of_batches)
            if(max_num < num_of_syllables)
                batch_indices = max_num+1:num_of_syllables;
            else
                continue;
            end
        else
            batch_indices = all_batches(batch_id, :);
        end
        all_distances = calculate_distance(syllables(batch_indices, :), centroids);
        [~, cur_labels] = min(all_distances, [], 2);
        labels(batch_indices) = cur_labels;
    end
end