# import the necessary packages
import os

# initialize the path to the fire and non-fire dataset directories
BRACE_PATH = "yesBrace"
NON_BRACE_PATH = "noBrace"


SAMPLE_BRACE_PATH = "/Users/samarth/Desktop/DefHacks-2.0/BraceForecast/sampdata"

# initialize the class labels in the dataset
CLASSES = ["Non-Brace", "Brace"]

# define the size of the training and testing split
TRAIN_SPLIT = 0.75
TEST_SPLIT = 0.25

# define the initial learning rate, batch size, and number of epochs
INIT_LR = 1e-2
BATCH_SIZE = 2
NUM_EPOCHS = 100

# set the path to the serialized model after training
MODEL_PATH = os.path.sep.join(["output", "detection.keras"])

# define the path to the output learning rate finder plot and
# training history plot
LRFIND_PLOT_PATH = os.path.sep.join(["output", "lrfind_plot.png"])
TRAINING_PLOT_PATH = os.path.sep.join(["output", "training_plot.png"])

# define the path to the output directory that will store our final
# output with labels/annotations along with the number of iamges to
# sample
OUTPUT_IMAGE_PATH = os.path.sep.join(["output", "examples"])
SAMPLE_SIZE = 50