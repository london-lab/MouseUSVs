function sis_value = get_sis_for_sequences(cur_labels, times_to_next, depth, syllable_ids)
    labels = cur_labels(syllable_ids);
    times = times_to_next(syllable_ids);
    [individual_sis_contrib] = calculate_individual_sis_contribution(labels, times, depth);
    sis_value = sum(individual_sis_contrib);
end

