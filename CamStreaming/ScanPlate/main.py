import cv2
import pytesseract

img = cv2.imread("test.jpg")
pytesseract.get_tesseract_version()
img = cv2.resize(img, (600,400))

cv2.imshow("car", img)
cv2.waitKey(0)
cv2.destroyAllWindows()



gray = cv2.cvtColor(img,cv2.COLOR_BGR2GRAY)

cv2.imshow("car_gray", gray)
cv2.waitKey(0)
cv2.destroyAllWindows()

filter = cv2.bilateralFilter(gray, 13,15,15)
edge = cv2.Canny(filter, 170,200)

cv2.imshow("car_edges", edge )
cv2.waitKey(0)
cv2.destroyAllWindows()

contor, href=cv2.findContours(edge.copy(), cv2.RETR_TREE, cv2.CHAIN_APPROX_SIMPLE)

ctn = sorted(contor, key=cv2.contourArea, reverse=True)[:10]


for c in ctn:
    peri=cv2.arcLength(c, True)
    epsilon=0.018*peri
    apporx=cv2.approxPolyDP(c,epsilon,True)
    if len(apporx)==4:
        x,y,w,h = cv2.boundingRect(apporx)
        cimg = img[y:y+h, x:x+w]
        cv2.imshow("plate", cimg)
        text=pytesseract.image_to_string(cimg, lang="eng")
        print(text)
        final = cv2.drawContours(img,[apporx],-1,(255,0,0),3)
        break

cv2.imshow("plate detected", img)
cv2.waitKey(0)
cv2.destroyAllWindows()

print(text)








