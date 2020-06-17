import config
import copy
from get_spectrogram import get_spectrogram
from new_clean_spectrogram import new_clean_spectrogram
from find_silent_columns import find_silent_columns
from columns_to_start_end_list import columns_to_start_end_list
from remove_short_syllables import remove_short_syllables
from get_syllables_from_time_ranges_with_padding import get_syllables_from_time_ranges_with_padding

def extract_all_syllables_from_file(file_path):
	original_spect = []
	spect = []
	spect_data = []
	wav_signal = []
	silent_columns = []
	significant_columns = []
	syllables_time_list = []
	long_syllables_time_list = []

	print "Extracting syllables from file " + file_path

	spect = get_spectrogram(file_path)

	original_spect = copy.copy(spect)

	new_clean_spectrogram(spect)

	silent_columns = find_silent_columns(spect)

	spect[:, silent_columns] = config.silence
	significant_columns = sorted(list(set(range(spect.shape[1])) - set(silent_columns)))
	syllables_time_list = columns_to_start_end_list(significant_columns)
	long_syllables_time_list = remove_short_syllables(syllables_time_list)
	syllables = get_syllables_from_time_ranges_with_padding(original_spect, spect, long_syllables_time_list, config.syllable_padding)

	print "Done\n"

	return syllables