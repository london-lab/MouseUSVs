function centroids = get_centroids(compact_syllables, classification_list, num_of_classes)
    syllable_size = size(compact_syllables, 2);
    centroids = zeros(num_of_classes, syllable_size);
    for class_id = 1 : num_of_classes
        class_indices = classification_list == class_id;
        centroids(class_id, :) = mean(compact_syllables(class_indices, :));
    end
end