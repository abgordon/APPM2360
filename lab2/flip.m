Y_int = imread('photo2.jpg');
Y_double = double(Y_int);
Y_double = 0.2989*Y_double(:,:,1)+0.5870*Y_double(:,:,2)+0.1140*Y_double(:,:,3);



Ir = eye(256)
B = flipud(Ir)
z = double(B)*Y_double;


whos
imwrite(uint8(z),'photo2flip.jpg');
