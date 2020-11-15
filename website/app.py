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
from flask import Flask, render_template, request, redirect

app = Flask(__name__)

app.config["IMAGE_UPLOADS"] = "/Users/samarth/Desktop/defhacks/website"

name_array = []
email_array = []
address_array = []



@app.route('/')
def index():
    return render_template('index.html')

@app.route('/send', methods=['GET', 'POST'])
def send():

    if request.method == "POST":

        req = request.form
        # print(req)

        name = req.get("name")
        name_array.append(name)
        name_array[0] = name
    

        email = req.get("email")
        email_array.append(email)
        email_array[0] = email


        address = req.get("address")
        address_array.append(address)
        address_array[0] = address

        print(address)

        return redirect(request.url)

    return render_template('index.html')

@app.route("/upload-image", methods=["GET", "POST"])
def upload_image():

    if request.method == "POST":

        if request.files:

            image = request.files["file_image"]

            image.save(os.path.join(app.config["IMAGE_UPLOADS"], "" + email_array[0] + ".png"))

            print(image)

            # return redirect(request.url)
    
    print("[INFO] loading model...")
    model = load_model(os.path.sep.join(["output", "fire_detection.keras"]))

    print("[INFO] predicting...")
    bracePaths = list(paths.list_images("yesBrace"))
    nonBracePaths = list(paths.list_images("noBrace"))


    # combine the two image path lists, randomly shuffle them, and sample
    # them
    imagePaths = list(paths.list_images("/Users/samarth/Desktop/defhacks/machineLearning/sampdata"))
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

        else:
            text = "Brace"

                

        output = imutils.resize(output, width=500)
        cv2.putText(output, text, (35, 50), cv2.FONT_HERSHEY_SIMPLEX,
            1.25, (0, 255, 0), 5)

        # write the output image to disk	 
        filename = "{}.png".format(i)
        p = os.path.sep.join([os.path.sep.join(["output", "examples"]), filename])
        cv2.imwrite(p, output)
    
    return render_template("index.html")

if __name__ == "__main__":
    app.debug = True
    port = int(os.environ.get('PORT', 5000))
    app.run()