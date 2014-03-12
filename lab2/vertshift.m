X_int = imread('photo1.jpg')
X_double = double(X_int)
X_double = 0.2989*X_double(:,:,1)+0.5870*X_double(:,:,2)+0.1140*X_double(:,:,3)
 
Ir=eye(201)
Ir=circshift(Ir,[100,0])
z = double(Ir)*X_double
Ir = eye(480)
Ir = circshift(Ir,[0,240])
z = z*Ir


imwrite(uint8(z),'photo1vertshift.jpg')
