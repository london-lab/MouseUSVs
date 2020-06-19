function num_sequences = count_sequences(times_to_next)
    validity_vector = clear_percent_of_sequences(times_to_next, 1);
    num_sequences = 0;
    if(validity_vector(1) == 1)
        num_sequences = num_sequences + 1;
    end
    for syl_ind = 1 : length(times_to_next) - 1
        if (validity_vector(syl_ind) == 0 && validity_vector(syl_ind+1) == 1)
            num_sequences = num_sequences + 1;
        end
    end
end