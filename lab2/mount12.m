%step 1 flip ?
%step 2 left or right shift
%step 3 vert shift

M_int = imread('mount2.png');
M_double = double(M_int);
M_double = 0.2989*M_double(:,:,1)+0.5870*M_double(:,:,2)+0.1140*M_double(:,:,3);

vert = zeros(299,399);
for i = 1 : size(M_double,1);
	vert(i, end-i+1) = 1;
end


z = double(vert)*M_double;  %FLIP

Ir = eye(299);
Ir=circshift(Ir,[0,50]);
 
z= z *Ir %RIGHT SHIFT

Ir = eye(399);
Ir=circshift(Ir,[-100,0]);

z= Ir*z;%VERT SHIFT
vert = eye(299);
vert = fliplr(vert);

% x = fliplr(z);
x = z*vert;
imwrite(uint8(x),'mount2shift.jpg');

%whos M_double
%M_double      399x299              954408  double              

