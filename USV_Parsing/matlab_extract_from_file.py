import sys
from scipy.io import savemat
from extract_syllables_from_file import extract_syllables_from_file

def matlab_extract_from_file(file_path):
	syllables = extract_syllables_from_file(file_path)
	return syllables["time_list"]

if __name__ == '__main__':
	file_path = str(sys.argv[1])
	output_path = str(sys.argv[2])
	time_list = matlab_extract_from_file(file_path)
	result = {}
	result["time_list"] = time_list;
	savemat(output_path, result)
	sys.stdout.write(str(time_list))