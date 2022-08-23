import cv2

image = cv2.imread('test.png', cv2.IMREAD_GRAYSCALE)
cv2.imshow('original', image)
cv2.waitKey()
image2 = image.ravel()
print(image2)
with open('input.txt', 'w') as f:
    f.write('\n'.join("{0:b}".format(int(e)) for e in image2))