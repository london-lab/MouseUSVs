from extract_all_syllables_from_file import extract_all_syllables_from_file
from filter_syllables import filter_syllables
from columns_list_to_time import columns_list_to_time

def extract_syllables_from_file(file_path):
	syllables = extract_all_syllables_from_file(file_path)
	filtered_syllables = filter_syllables(syllables)
	start_end_list = filtered_syllables["start_end_list"]
	filtered_syllables["time_list"] = columns_list_to_time(start_end_list[1:])
	return filtered_syllables