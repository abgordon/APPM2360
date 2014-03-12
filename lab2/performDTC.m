Y_int = imread('photo2.jpg');
Y_double = double(Y_int);
Y_double = 0.2989*Y_double(:,:,1)+0.5870*Y_double(:,:,2)+0.1140*Y_double(:,:,3);
n = 256;
DCT = zeros(n);    %(row, column)


DCT = zeros(256);
for i = 1:n
	for j = 1:n
		DCT(i,j) = sqrt(2/n)*cos((pi*(i-.5)*(j-.5))/n);
	end
end

%z=dct(Y_double);

z = DCT*Y_double*DCT;

imwrite(uint8(z),'DCTmap.jpg')
p = 0.5;
%when p=0, no data are saved
%when p=1, all data are saved
for i = 1:n
	for j = 1:n
		if i+j>p*2*n;
			z(i,j)=0;
		end
	end
end
% 
%q=idct(z);

q = DCT*z*DCT;
% 
imwrite(uint8(q),'DCTinversemap.jpg')
