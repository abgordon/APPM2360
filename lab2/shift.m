X_int = imread('photo1.jpg')
X_double = double(X_int)
X_double = 0.2989*X_double(:,:,1)+0.5870*X_double(:,:,2)+0.1140*X_double(:,:,3)

Ir=eye(480)
Ir=circshift(Ir,[0,240])
z = X_double*double(Ir)


imwrite(uint8(z),'photo1shift.jpg')






%whos x_int:
%  X_int      201x480x3            289440  uint8   