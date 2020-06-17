import config

def get_strength(spect, start, end):
	count = 0
	for column in range(start, end):
		if(sum(spect[:, column]) > config.silent_threshold):
			count += 1
	return count/float(end-start+1)