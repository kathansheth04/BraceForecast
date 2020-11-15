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

            return redirect(request.url)