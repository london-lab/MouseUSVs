import config

def get_syllables_from_time_ranges_with_padding(original_spect, spect, time_ranges, syllable_padding):
	original_list = []
	clean_list = []
	padded_start_end_list = []
	padded_start_end_list.append([0, spect.shape[1]])

	for time_range_index in range(len(time_ranges)):
		[start, end] = time_ranges[time_range_index]
		
		if config.use_padding:
			if(start > config.syllable_padding):
				start -= config.syllable_padding
			else:
				start = 0
			if(end + syllable_padding < spect.shape[1]):
				end += syllable_padding
			else:
				end = spect.shape[1]

		add_syllable_to_lists(original_list, clean_list, original_spect, spect, start, end)
		padded_start_end_list.append([start, end])

	syllables = {}
	syllables["original_list"] = original_list
	syllables["clean_list"] = clean_list
	syllables["start_end_list"] = padded_start_end_list

	return syllables


def add_syllable_to_lists(original_list, clean_list, original_spect, spect, start, end):
	clean = spect[config.min_relevant_row:config.max_relevant_row, start:end]
	clean_list.append(clean[::-1])

	original = original_spect[config.min_relevant_row:config.max_relevant_row, start:end]
	original_list.append(original[::-1])