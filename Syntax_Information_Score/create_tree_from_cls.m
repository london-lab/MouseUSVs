function tree = create_tree_from_cls(labels, times_to_next, validity_vector, Nc, depth)
    tree = zeros(1, power(Nc, depth+1));
    for syl_ind = 1 : length(labels) - depth
        for seq_ind = 0 : depth
            cur_validity = validity_vector(syl_ind:syl_ind+depth);
            if(are_same_sequence(times_to_next(syl_ind:syl_ind+depth)) && sum(cur_validity) == length(cur_validity))
                tree_ind = get_tree_ind(labels(syl_ind:syl_ind+depth), Nc);
                tree(tree_ind) = tree(tree_ind) + 1;
            end
        end
    end
    tree = tree/sum(tree);
end

function same_sequence = are_same_sequence(times_to_next)
    same_sequence = true;
    for time_ind = 1 : length(times_to_next) - 1
        if(times_to_next(time_ind) >= 0.16)
            same_sequence = false;
        end
    end
end