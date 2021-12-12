import cv2
import sys

args = sys.argv
if len(args) == 3:
    img = cv2.imread(args[1],0)
    threshold = int(args[2]) 
    ret, img_bin = cv2.threshold(img, threshold, 255, cv2.THRESH_BINARY)
    cv2.imshow('image',img_bin)
    cv2.imwrite('./' + args[2] + '_' + args[1], img_bin)
    cv2.waitKey(0)
    cv2.destroyAllWindows()
else:
    print('Invalid Number of Argument')
    print('Please execute \'python digitalizeImage.py filename threshold\'')
