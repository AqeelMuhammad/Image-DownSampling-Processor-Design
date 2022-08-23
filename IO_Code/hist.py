from turtle import color
import cv2
import numpy as np
import matplotlib.pyplot as plt

# Get historgram of the input image
inputImage = open("input.txt", "r")
content = inputImage.read()
contentList = content.split("\n")
inputImage.close()
intList = [int(x, 2) for x in contentList]
uint8List = [np.uint8(x) for x in intList]
image = np.array(uint8List)
imageIn = image.reshape(256, 256)
histr = cv2.calcHist([imageIn],[0],None,[256],[0,256])
plt.plot(histr, color='blue')

# Get histogram of the filtered image
inputImage = open("output_filtered.txt", "r")
content = inputImage.read()
contentList = content.split("\n")
inputImage.close()
intList = [int(x, 2) for x in contentList[:-1]]
uint8List = [np.uint8(x) for x in intList]
image = np.array(uint8List)
imageFiltered = image.reshape(256, 256)
histr = cv2.calcHist([imageFiltered],[0],None,[256],[0,256])
plt.plot(histr, color='red')

plt.show()
