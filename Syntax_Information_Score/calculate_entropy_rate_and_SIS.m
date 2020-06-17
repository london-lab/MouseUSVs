% Input:
%   * laebls: array of labels for each syllable. Values should be between
%       1..Nc
%   * times_to_next: array of times in seconds between each syllable and
%       the next one. If the next syllable is in a different session, it's
%       time value can be set to 1 (or any value higher than 0.16)
% Output:
%    * entropy_rate_values: a matrix where each row corresponds to the
%       tree's depth and column to a repetition. The value is the entropy
%       rate
%    * sis_values: same format, with SIS values instead of entropy_rates

function [entropy_rate_values, sis_values] = calculate_entropy_rate_and_SIS(labels, times_to_next)
    Nc = 8;
    db_percent = 0.6;
    repetitions = 25;
    depths = 2;
    sis_values = zeros(depths, repetitions);
    entropy_rate_values = zeros(depths+1, repetitions);

    for i = 1 : repetitions
        validity_vector = clear_percent_of_sequences(times_to_next, db_percent);
        for depth = 1 : depths
            current_tree = create_tree_from_cls(labels, times_to_next, validity_vector, Nc, depth);
            zero_tree = create_tree_from_cls(labels, times_to_next, validity_vector, Nc, 0);
            previous_tree = create_tree_from_cls(labels, times_to_next, validity_vector, Nc, depth-1);
            full_sis = calculate_sis(zero_tree, previous_tree, current_tree, Nc, depth);
            sis_values(depth, i) = sum(full_sis);

            leaf_probs = create_tree_from_cls(labels, times_to_next, validity_vector, Nc, depth-1);
            entropy_rate_values(depth+1, i) = calculate_entropy_rate(current_tree, leaf_probs, Nc);
            if(depth == 1)
                entropy_rate_values(1, i) = calculate_entropy(create_tree_from_cls(labels, times_to_next, validity_vector, Nc, 0));
            end            
        end
    end
end