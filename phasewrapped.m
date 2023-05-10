function [] = phasewrapped(in,in1)
%NxM ;N = 1080; M = 1920;
N = 1080;
M = 1920;
R = 100;
img = imread(in);

hologram = double(img(1:N,1:M,2));



% Calculating Fourier transform and showing absolute value of the result

      spectrum = FT2Dc(hologram);
      spectrum_abs = abs(spectrum);


%      figure('Name','Fourier spectrum');
%      imshow(log(spectrum_abs), []);



% Blocking the central part of the spectrum

R0 = 2;
spectrum_abs1 = zeros(N,M); 
for ii=1:N
    for jj=1:M
     
    x = ii - N/2;
    y = jj - M/2;
    
    if (sqrt(x^2 + y^2) > R0) 
        spectrum_abs1(ii, jj) = spectrum_abs(ii,jj); 
    end
    end
end
%   figure;
%   imshow(log(spectrum_abs1), []); 
  % Blocking half of the spectrum

  spectrum_abs1(1:N/2,:) = 0;
%   figure;
%   imshow(log(spectrum_abs1), []); 

% Finding the position of the side-band in the spectrum

maximum = max(max(spectrum_abs1));
[x0, y0] = find(spectrum_abs1==maximum);

% Shifting the complex-valued spectrum to the center

spectrum2 = zeros(N,M);
 x0=1;
 y0=108;
%  x0 = x0 - N/2 - 1;
%  y0 = y0 - N/2 - 1;

for ii = 1:N-x0
    for jj = 1:M-y0    
        spectrum2(ii, jj) = spectrum(ii+x0,jj+y0); 
    end
end
% figure;
% imshow(log(spectrum2), []); 

% Selecting the central part of the complex-valued spectrum spectrum

spectrum3 = zeros(N,M);
for ii=1:N
    for jj=1:M
     
    x = ii - N/2;
    y = jj - M/2;
    
    if (sqrt(x^2 + y^2) < R) 
        spectrum3(ii, jj) = spectrum2(ii, jj); 
    end
    end
end
% figure;
% imshow(log(spectrum3), []);

% Reconstruction by inverse Fourier transform
     
     reconstruction = IFT2Dc(spectrum3);
     %rec_abs = abs(reconstruction);
     rec_phase = angle(reconstruction);
     


 % Saving reconstructed phase as JPG imagex
         
          p = rec_phase;
          p = (p - min(min(p)))/(max(max(p)) - min(min(p)));
          imwrite (p, in1);
         