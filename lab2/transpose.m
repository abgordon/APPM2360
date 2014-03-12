Y_int = imread('photo2.jpg')
Y_double = double(Y_int)
Y_double = 0.2989*Y_double(:,:,1)+0.5870*Y_double(:,:,2)+0.1140*Y_double(:,:,3)

X_int = imread('photo1.jpg')
X_double = double(X_int)
X_double = 0.2989*X_double(:,:,1)+0.5870*X_double(:,:,2)+0.1140*X_double(:,:,3)

a = X_double.'
b = Y_double.'


imwrite(uint8(a),'photo1transpose.jpg')
imwrite(uint8(b),'photo2transpose.jpg')
