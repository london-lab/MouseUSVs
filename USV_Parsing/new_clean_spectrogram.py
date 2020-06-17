import config
from numpy import median, where
from log import info

def new_clean_spectrogram(spect):
	remove_noisy_frequencies(spect)
	keep_only_strong_cells_in_column(spect)
	clear_lonely_cells(spect)
	clear_lonely_cells(spect)


def remove_noisy_frequencies(spect):
	median_row_sum = median(spect) * spect.shape[1]
	for row in range(len(spect)):
		sum_of_row = sum(spect[row])
		if(sum_of_row > median_row_sum * config.noisy_row_ratio):
			info("Reduced the energy in row " + str(row))
			spect[row] = spect[row] * (median_row_sum / (sum_of_row * config.noisy_row_ratio))

def keep_only_strong_cells_in_column(spect):
	for col in range(spect.shape[1]):
		col_sum = sum(spect[:, col])
		for row in range(len(spect)):
			if(spect[row, col] < col_sum * config.strength_in_column):
				spect[row, col] = config.silence;
			# else:
			# 	spect[row, col] = config.noise_level;

def clear_lonely_cells(spect):
	indices = where(spect > 0)
	for index in range(len(indices[0])):
		row = indices[0][index]
		col = indices[1][index]
		square_sum = get_square_sum(spect, row, col)
		if square_sum < spect[row,col] * config.similar_in_square:
			spect[row, col] = config.silence

def get_square_sum(spect, row, col):
	square_size = config.square_size
	square_sum = 0
	for r in range(row - square_size, row + square_size):
		for c in range(col - square_size, col + square_size):
			if r>0 and c>0 and r<len(spect) and c<spect.shape[1] and c!=col:
				square_sum += spect[r,c]
	return square_sum