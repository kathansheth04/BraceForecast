
# import the necessary packages
from tensorflow.keras.models import load_model
from pyimagesearch import config
from imutils import paths
import numpy as np
import imutils
import random
import cv2
import os

# load the trained model from disk
print("[INFO] loading model...")
model = load_model(config.MODEL_PATH)

print("[INFO] predicting...")
bracePaths = list(paths.list_images(config.BRACE_PATH))
nonBracePaths = list(paths.list_images(config.SAMPLE_BRACE_PATH))


# combine the two image path lists, randomly shuffle them, and sample
# them
imagePaths = list(paths.list_images(config.SAMPLE_BRACE_PATH))
random.shuffle(imagePaths)
imagePaths = imagePaths[:config.SAMPLE_SIZE]

# loop over the sampled image paths
for (i, imagePath) in enumerate(imagePaths):
	# load the image and clone it
	image = cv2.imread(imagePath)
	output = image.copy()

	# resize the input image to be a fixed 128x128 pixels, ignoring
	# aspect ratio
	image = cv2.resize(image, (128, 128))
	image = image.astype("float32") / 255.0
		
	# make predictions on the image
	preds = model.predict(np.expand_dims(image, axis=0))[0]
	j = np.argmax(preds)
	label = config.CLASSES[j]

	# draw the activity on the output frame

	if label == "Non-Brace":
		text = "Non-Brace"

	else:
		text = "Brace"

			

	output = imutils.resize(output, width=500)
	cv2.putText(output, text, (35, 50), cv2.FONT_HERSHEY_SIMPLEX,
		1.25, (0, 255, 0), 5)

	# write the output image to disk	 
	filename = "{}.png".format(i)
	p = os.path.sep.join([config.OUTPUT_IMAGE_PATH, filename])
	cv2.imwrite(p, output)