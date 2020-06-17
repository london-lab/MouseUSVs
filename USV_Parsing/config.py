from matplotlib import mlab
import glob

files = []
signal_length = -1 # -1 stands for all the file
specgram_NFFT = 256
specgram_window = mlab.window_hanning
noise_threshold = 3.5
no_noise_level = -10
silence = 0
noise_level = 10
noisy_row_ratio = 2
reduce_noisy_row_ratio = 5
strength_in_column = 0.05
allowed_noise_in_column = 2
square_size = 3
similar_in_square = 3
silent_threshold = 0
min_silence_area = 40
min_syllable_length = 8
min_syllable_ratio = 0.3
use_padding = True
syllable_padding = 4
trim_rate = 0.1
trim_skip = 4
min_relevant_row = 35
max_relevant_row = 125
run_second_clean = False
remove_iterations = 2
sequence_interval = 0.1536