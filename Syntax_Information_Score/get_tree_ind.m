function tree_ind = get_tree_ind(seq, Nc)
    tree_ind = 1;
    factor = 1;
    for seq_ind = length(seq):-1:1
        tree_ind = tree_ind + (seq(seq_ind)-1)*factor;
        factor = factor * Nc;
    end
end