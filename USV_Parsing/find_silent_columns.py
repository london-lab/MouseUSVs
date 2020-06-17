import config

def find_silent_columns(spect):
	column_count = 0
	silent_columns = []
	columns_size = spect.shape[1]
	
	for column in range(columns_size):
		if(sum(spect[config.min_relevant_row:config.max_relevant_row, column]) <= config.silent_threshold and column < columns_size - 1): #Silent column
			column_count += 1
		else:
			if(column_count >= config.min_silence_area):
				silent_columns.extend(range(column - column_count, column - 1))

			column_count = 0
	return silent_columns