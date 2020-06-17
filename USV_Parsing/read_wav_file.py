import config
import scipy.io.wavfile
import wave

def read_wav_file(file_name):
	signal_length = config.signal_length
	if(signal_length == -1):
		return read_wav_file_with_scipy(file_name)

	# else:
		return read_wav_file_with_wave(file_name, signal_length)

def read_wav_file_with_scipy(file_name):
	[rate, wav_data] = scipy.io.wavfile.read(file_name)
	wav_signal = wav_data / pow(2,15)
	wav_data = []
	return [wav_signal, rate]

def read_wav_file_with_wave(file_name, signal_length):
	wav_file = wave.open(file_name, 'r')
	wav_fs = wav_file.getframerate()

	wav_signal = []
	for frame in range(wav_length):
		val = wav_file.readframes(1)
		value = struct.unpack("<h", val)
		wav_signal.extend([value[0] / pow(2,15)])
	
	return [wav_signal, wav_fs]