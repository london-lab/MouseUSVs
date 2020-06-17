function sis = calculate_sis(zero_tree, previous_tree, current_tree, Nc, depth)
    sis = [];
    for ind = 1 : length(current_tree)
        p_ind = ceil(ind/Nc);
        z_ind = mod(ind-1, Nc) + 1;
        if(current_tree(ind) > 0 && previous_tree(p_ind) > 0 && zero_tree(z_ind) > 0)
            sis(ind) = current_tree(ind) * log2(current_tree(ind) / (previous_tree(p_ind)*zero_tree(z_ind)));
        end
    end
end