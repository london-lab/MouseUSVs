def columns_list_to_time(column_list):
	return [[column_to_time(start), column_to_time(end)] for [start, end] in column_list]

def column_to_time(column):
	return (column*512/float(1000000))

def time_to_column(time):
	return (time * 1000000)/512