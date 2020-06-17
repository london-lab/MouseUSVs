import config
from get_strength import get_strength

def trim_edges(spect, start, end):
	skip = (end-start)/(config.min_syllable_length-1)
	middle = (start+end)/2
	for column in range(middle, middle+(end-middle), skip):
		if(get_strength(spect, column, end) < config.trim_rate):
			end = column
			break
	for column in range(middle, start, -1 * skip):
		if(get_strength(spect, start, column) < config.trim_rate):
			start = column - 1
			break
	return (start, end)