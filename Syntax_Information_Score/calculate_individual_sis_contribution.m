% Input:
%   * laebls: array of labels for each syllable. Values should be between
%       1..Nc
%   * times_to_next: array of times in seconds between each syllable and
%       the next one. If the next syllable is in a different session, it's
%       time value can be set to 1 (or any value higher than 0.16)
%   * depth: the depth of the suffix tree.
% Output:
%    * individual_sis_contrib: the value in bits/symbol that each n-tuple
%       contributes to the SIS

function [individual_sis_contrib] = calculate_individual_sis_contribution(labels, times_to_next, depth)
    Nc = 8;
    validity_vector = clear_percent_of_sequences(times_to_next, 1);
    current_tree = create_tree_from_cls(labels, times_to_next, validity_vector, Nc, depth);
    zero_tree = create_tree_from_cls(labels, times_to_next, validity_vector, Nc, 0);
    previous_tree = create_tree_from_cls(labels, times_to_next, validity_vector, Nc, depth-1);
    individual_sis_contrib = calculate_sis(zero_tree, previous_tree, current_tree, Nc, depth);
end