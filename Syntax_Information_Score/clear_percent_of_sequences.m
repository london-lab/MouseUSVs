function validity_vector = clear_percent_of_sequences(times_to_next, percent)
    validity_vector = zeros(size(times_to_next));
    syl_count = 1;
    for syl_ind = 1 : length(validity_vector)
        validity_vector(syl_ind) = syl_count;
        if(times_to_next(syl_ind) >= 0.16)
            syl_count = 1;
        else
            syl_count = syl_count + 1;
        end
    end
    syl_ind = length(validity_vector);
    while(syl_ind > 0)
        seq_len = validity_vector(syl_ind);
        for seq_ind = 1 : seq_len
            validity_vector(syl_ind) = seq_len;
            syl_ind = syl_ind - 1;
        end
    end
    validity_vector(validity_vector < 3) = 0;
    validity_vector(validity_vector > 0) = 1;
    
    sequence_starts = [];
    for ind = 1 : length(validity_vector) - 1
        if(validity_vector(ind) == 0 && validity_vector(ind+1) == 1)
            sequence_starts = [sequence_starts; ind+1];
        end
    end
    num_sequences_to_remove = int32(length(sequence_starts)*(1-percent));
    r_perm = randperm(length(sequence_starts));
    sequences_to_remove = sequence_starts(r_perm(1:num_sequences_to_remove));
    for rem_ind = 1 : length(sequences_to_remove)
        cur_ind = sequences_to_remove(rem_ind);
        while(validity_vector(cur_ind) == 1 && cur_ind <= length(validity_vector))
            validity_vector(cur_ind) = 0;
            cur_ind = cur_ind + 1;
        end
    end
end