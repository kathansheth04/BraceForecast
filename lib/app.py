from tensorflow.keras.models import load_model
from imutils import paths
import numpy as np
import matplotlib
import imutils
import random
import cv2
import os
from tensorflow.keras.preprocessing.image import ImageDataGenerator
from tensorflow.keras.optimizers import SGD
from tensorflow.keras.utils import to_categorical
from sklearn.model_selection import train_test_split
from sklearn.metrics import classification_report
import matplotlib.pyplot as plt
import argparse
import sys
from flask import Flask, render_template, request, redirect, jsonify

app = Flask(__name__)

app.config["IMAGE_UPLOADS"] = "/home/kathansheth/defhacks/lib/Screens/sampdata"

name_array = []
email_array = []
address_array = []
headers: {"Content-Type": "application/json"}
@app.route("/", methods=["POST", "REST", "GET"])
def upload_image():
    
    print("[INFO] loading model...")
    model = load_model("/home/kathansheth/defhacks/website/output/detection.keras")

    print("[INFO] predicting...")
    bracePaths = list(paths.list_images("yesBrace"))
    nonBracePaths = list(paths.list_images("noBrace"))


    # combine the two image path lists, randomly shuffle them, and sample  
    # them
    imagePaths = list(paths.list_images("/home/kathansheth/defhacks/lib/Screens/sampdata"))
    random.shuffle(imagePaths)
    imagePaths = imagePaths[:50]

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
        CLASSES = ["Non-Brace", "Brace"]
        label = CLASSES[j]
        # draw the activity on the output frame

        if label == "Non-Brace":
            text = "Non-Brace"
            return jsonify("0")

        else:
            text = "Brace"
            return jsonify("1")

                

        output = imutils.resize(output, width=500)
        cv2.putText(output, text, (35, 50), cv2.FONT_HERSHEY_SIMPLEX,
            1.25, (0, 255, 0), 5)

        # write the output image to disk	 
        filename = "{}.png".format(i)
        p = os.path.sep.join([os.path.sep.join(["static", "result_img"]), filename])
        cv2.imwrite(p, output)
    
    

if __name__ == "__main__":
    app.debug = True
    port = int(os.environ.get('PORT', 5000))
    app.run()