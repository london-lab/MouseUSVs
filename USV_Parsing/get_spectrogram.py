import config
from matplotlib.mlab import specgram
from read_wav_file import read_wav_file

def get_spectrogram(file_path):
	[wav_signal, wav_fs] = read_wav_file(file_path)

	spect_data = specgram(wav_signal, Fs=wav_fs, NFFT=config.specgram_NFFT, window=config.specgram_window)
	spect = spect_data[0]

	return spect