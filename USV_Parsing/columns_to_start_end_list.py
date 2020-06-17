def columns_to_start_end_list(columns):
	prev = -100
	current = -100
	start_end_list = []
	start = -1
	for column in columns:
		prev = current
		current = column
		if(prev + 1 != current):
			if(start != -1):
				start_end_list.append([start, prev])
			start = current
	if(start != -1):
		start_end_list.append([start, columns[len(columns) - 1]])
	return start_end_list