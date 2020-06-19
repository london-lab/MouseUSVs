function inds = get_indices_from_sequence_ids(times_to_next, sequence_ids)
    validity_vector = clear_percent_of_sequences(times_to_next, 1);
    seq_id_vec = zeros(size(validity_vector));
    cur_seq_id = 1;
    has_init = 0;
    for syl_id = 1 : length(times_to_next)
        if (validity_vector(syl_id) == 1)
            has_init = 1;
            if(ismember(cur_seq_id, sequence_ids))
                seq_id_vec(syl_id) = 1;
            end
        elseif(has_init && validity_vector(syl_id-1) ~= 0)
            cur_seq_id = cur_seq_id + 1;
        end
    end
    inds = find(seq_id_vec);
end