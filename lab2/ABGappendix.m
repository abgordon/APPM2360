%-----------------question 1-----------------%
X_int = imread('photo1.jpg')    %reading files with given "imread" function
Y_int = imread('photo2.jpg')
% 
X_double = double(X_int)    %values are integers - need to be cast as doubles (or floats) before being multiplied by percent values
Y_double = double(Y_int)
% %whos
% 0.2989*X_double(:,:,1)
% 0.5870*X_double(:,:,2)    my original idea to convert values to grayscale
% 0.1140*X_double(:,:,3)    however this is problematic because X_double is
% still a 3-d array which can't be multiplied by transformation matrices
% 
% 0.2989*Y_double(:,:,1)
% 0.5870*Y_double(:,:,2)
% 0.1140* Y_double(:,:,3) 
X_double = 0.2989*X_double(:,:,1)+0.5870*X_double(:,:,2)+0.1140*X_double(:,:,3) %correct implementation here, summation of the three 
Y_double = 0.2989*Y_double(:,:,1)+0.5870*Y_double(:,:,2)+0.1140*Y_double(:,:,3) %pixel values in a 2-D array

imwrite(uint8(X_double),'photo1output.jpg')
imwrite(uint8(Y_double),'photo2output.jpg') % saving changed array of pixels with given "imwrite" function, first casting it as a uint class 
                                            % (pixels can only be rewritten to a photo as integer values)
                                            
%-----------------question 2-----------------%
%file reading and converting to 2-D array                                           
X_int = imread('photo1.jpg')
X_double = double(X_int)
X_double = 0.2989*X_double(:,:,1)+0.5870*X_double(:,:,2)+0.1140*X_double(:,:,3)

%whos x_int:
%  X_int      201x480x3            289440  uint8  
%dimensions of 'photo1' are 201x480, if we multiply it by a 480x480
%identity matrix dimensions will still be 201x480 by rules of matrix
%multiplication, so if we apply a shift to Ir using circshift and right
%multiply X*Ir, it will horizontal shift
Ir=eye(480)
Ir=circshift(Ir,[0,240])
z = X_double*double(Ir)

imwrite(uint8(z),'photo1shift.jpg')
   

%-----------------question 3-----------------%
X_int = imread('photo1.jpg')
X_double = double(X_int)
X_double = 0.2989*X_double(:,:,1)+0.5870*X_double(:,:,2)+0.1140*X_double(:,:,3)
 
%this time we want to shift vertically; LEFT multiplying yields a vertical
%shift while right multiplying is horizontal
%this time we want a 201x201 ID matrix, 201x201 X 201x480 yields a 201x480
Ir=eye(201)
Ir=circshift(Ir,[100,0])
z = double(Ir)*X_double

%same shift as last question
Ir = eye(480)
Ir = circshift(Ir,[0,240])
z = z*Ir

imwrite(uint8(z),'photo1vertshift.jpg')

%-----------------question 4-----------------%

Y_int = imread('photo2.jpg')
Y_double = double(Y_int)
Y_double = 0.2989*Y_double(:,:,1)+0.5870*Y_double(:,:,2)+0.1140*Y_double(:,:,3)

% flipping is a horizontal shift so we need to perform a left multiply
% what we want to do is flip the rows of the ID matrix so that instead of
% the 1's reading from the top left to bottom right, they go on the
% diagonal from the lower left to top right
% this left multiply flips the image
Ir = eye(256)
B = flipud(Ir) %used built in flip function on my ID matrix (not photo2! :D)
z = double(B)*Y_double;

imwrite(uint8(z),'photo2flip.jpg');

%-----------------question 5-----------------%
Y_int = imread('photo2.jpg')
Y_double = double(Y_int)
Y_double = 0.2989*Y_double(:,:,1)+0.5870*Y_double(:,:,2)+0.1140*Y_double(:,:,3)

X_int = imread('photo1.jpg')
X_double = double(X_int)
X_double = 0.2989*X_double(:,:,1)+0.5870*X_double(:,:,2)+0.1140*X_double(:,:,3)

% .' notation means transpose
% effectively this rotates the photo counter-clockwise 90?
% this makes sense; transpose turns rows into columns and columns into rows
% so we can see that the leftmost column is now the topmost row
% transposing again returns it to its original state
a = X_double.'
b = Y_double.'

imwrite(uint8(a),'photo1transpose.jpg')
imwrite(uint8(b),'photo2transpose.jpg')

%-----------------question 6-----------------%
%reading mount2 with same process as other pictures
M_int = imread('mount2.png');
M_double = double(M_int);
M_double = 0.2989*M_double(:,:,1)+0.5870*M_double(:,:,2)+0.1140*M_double(:,:,3);

%a slightly more complicated filling out of a matrix with ones on top-right
%to bottom-left diagonal to perform the flip
%we have to use this for loop to populate the matrix because it is not
%square (M = 399x299)
vert = zeros(299,399);
for i = 1 : size(M_double,1);
	vert(i, end-i+1) = 1;
end

z = double(vert)*M_double;  %Vertical flip

Ir = eye(299);
Ir=circshift(Ir,[0,50]);
 
z= z *Ir %Right shift

Ir = eye(399);
Ir=circshift(Ir,[-100,0]);

z= Ir*z;%Vertical shift

%a new square matrix to right multiply (399x299) X (299x299)=399x299 matrix
vert = eye(299);
vert = fliplr(vert);

x = z*vert; %horizontal flip
imwrite(uint8(x),'mount2shift.jpg');

%whos M_double
%M_double      399x299              954408  double 
%-----------------question 8-----------------%

Y_int = imread('photo2.jpg');
Y_double = double(Y_int);
Y_double = 0.2989*Y_double(:,:,1)+0.5870*Y_double(:,:,2)+0.1140*Y_double(:,:,3);
n = 256;
DCT = zeros(n); 

%this is our DCT declaration script; using the provided for loop, I just
%filled in the function from page 3 of the lab assignment
%D(i,j) fills in a matrix with values based on the current row and column
%as it iterates through
DCT = zeros(n);
for i = 1:n
	for j = 1:n
		DCT(i,j) = sqrt(2/n)*cos((pi*(i-.5)*(j-.5))/n);
	end
end

%here we convert our orignal image to our DCT map by left and right
%multiplying by DCT
z = DCT*Y_double*DCT;

imwrite(uint8(z),'DCTmap.jpg')

%provided function to zero out values of our DCT matrix, starting at the
%high-frequency values in the bottom left

p = 0.25;
%when p=0, no data are saved
%when p=1, all data are saved
for i = 1:n
	for j = 1:n
		if i+j>p*2*n;
			z(i,j)=0;
		end
	end
end

%convert back to our original image with high-frequency values filtered
%out, using the same operation as before
%we can do this because DCT = DCT^-1, so this can be thought of as
%(DCT*DCT^-1)x(Y_double)x(DCT*DCT^-1) = (I)x(Y_double)x(I) = Y_double
q = DCT*z*DCT;

%write our picture to file 
imwrite(uint8(q),'DCTinversemap.jpg')
