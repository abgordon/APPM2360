n = 256
DCT = zeros(n);    %(row, column)
f = sqrt(2/n)
for i = 1:n
	for j = 1:n
		DCT(i,j) = f*cos((pi*(i-.5)*(j-.5))/n)
	end
end
whos