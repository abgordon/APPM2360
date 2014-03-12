X_int = imread('photo1.jpg')
Y_int = imread('photo2.jpg')
% 
X_double = double(X_int)
Y_double = double(Y_int)
% %whos
% 0.2989*X_double(:,:,1)
% 0.5870*X_double(:,:,2)
% 0.1140*X_double(:,:,3)
% 
% 0.2989*Y_double(:,:,1)
% 0.5870*Y_double(:,:,2)
% 0.1140* Y_double(:,:,3) 
X_double = 0.2989*X_double(:,:,1)+0.5870*X_double(:,:,2)+0.1140*X_double(:,:,3)
Y_double = 0.2989*Y_double(:,:,1)+0.5870*Y_double(:,:,2)+0.1140*Y_double(:,:,3)



imwrite(uint8(X_double),'photo1output.jpg')
imwrite(uint8(Y_double),'photo2output.jpg')