import cv2
from imutils import contours
import numpy as np

# Load in image, grayscale, and Otsu's threshold
image = cv2.imread('images/QR_2.jpeg')
mask = np.zeros(image.shape, dtype=np.uint8)
gray = cv2.cvtColor(image, cv2.COLOR_BGR2GRAY)
thresh = cv2.threshold(gray,0,255,cv2.THRESH_OTSU + cv2.THRESH_BINARY_INV)[1]

# Detect vertical lines
vertical_kernel = cv2.getStructuringElement(cv2.MORPH_RECT, (1,80))        
remove_vertical = cv2.morphologyEx(thresh, cv2.MORPH_OPEN, vertical_kernel)
cnts = cv2.findContours(remove_vertical, cv2.RETR_TREE, cv2.CHAIN_APPROX_SIMPLE)
cnts = cnts[0] if len(cnts) == 2 else cnts[1]
cv2.fillPoly(mask, cnts, (255,255,255))

# Find contours on mask and sort from left to right
mask = cv2.cvtColor(mask, cv2.COLOR_BGR2GRAY)
cnts = cv2.findContours(mask, cv2.RETR_EXTERNAL, cv2.CHAIN_APPROX_SIMPLE)
cnts = cnts[0] if len(cnts) == 2 else cnts[1]
cnts, _ = contours.sort_contours(cnts, method="left-to-right")

# Iterate through contours and find width of each line
barcode_width = []
for c in cnts:
    x,y,w,h = cv2.boundingRect(c)
    current = image.copy()
    cv2.rectangle(current, (x, y), (x + w, y + h), (36,255,12), -1)
    cv2.putText(current, 'Width: {}'.format(w), (15,50), cv2.FONT_HERSHEY_SIMPLEX, 1.5, (36,255,12), 3)
    barcode_width.append(w)
    cv2.imshow('current', current)
    cv2.waitKey(175)

print("Barcode Width:", barcode_width)
print('Barcode Bars: ', len(barcode_width))
print('Total Pixels: ', sum(barcode_width))
cv2.waitKey()
