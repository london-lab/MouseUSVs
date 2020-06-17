import config

def remove_short_syllables(syllables_time_list):
	output_list = []
	for syllable_index in range(len(syllables_time_list)):
		[start, end] = syllables_time_list[syllable_index]
		if(end - start >= config.min_syllable_length):
			output_list.append([start, end])
	return output_list