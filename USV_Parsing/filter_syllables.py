import copy
import config
from numpy import vstack
from trim_edges import trim_edges
from clean_spectrogram import keep_only_strong_cells_in_column

def filter_syllables(syllables):
	original_list = syllables["original_list"]
	clean_list = syllables["clean_list"]
	start_end_list = syllables["start_end_list"]

	filtered_start_end_list = []
	filtered_start_end_list.append(start_end_list[0])
	filtered_original_syllables = []
	filtered_clean_syllables = []
	for syllable_index in range(len(clean_list)):
		percent_updates = 5
		if(syllable_index > 0 and len(clean_list) > percent_updates and syllable_index % (len(clean_list)/percent_updates) == 0):
			print str(round((float(syllable_index)/len(clean_list))*100)) + "%"
		clean_syllable = vstack(clean_list[syllable_index])
		original_syllable = vstack(original_list[syllable_index])

		enhanced_syllable = copy.copy(original_syllable)
		keep_only_strong_cells_in_column(enhanced_syllable)

		[start, end] = trim_edges(clean_syllable, 0, len(clean_syllable[0]))
		[absolute_start, absolute_end] = start_end_list[syllable_index + 1]
		filtered_start_end_list.append([absolute_start + start, absolute_start + end])

		original = original_syllable[:, start:end]
		filtered_original_syllables.append(original)
		clean = enhanced_syllable[:, start:end]
		filtered_clean_syllables.append(clean)

	filtered_syllables = {}
	filtered_syllables["original_list"] = filtered_original_syllables
	filtered_syllables["clean_list"] = filtered_clean_syllables
	filtered_syllables["start_end_list"] = filtered_start_end_list

	return filtered_syllables