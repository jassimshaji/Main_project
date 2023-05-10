%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% RECONSTRUCTION OF OFF-AXIS HOLOGRAM
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Citation for this code/algorithm or any of its parts:
% Tatiana Latychevskaia, Petr Formanek, C. T. Koch, Axel Lubk
% "Off-axis and inline electron holography: Experimental comparison",
% Ultramicroscopy 110, 472 - 482 (2010)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% The code is written by Tatiana Latychevskaia, 2010
% Matlab version for this code is R2010b
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
close all
clear all
% addpath('C:/Program Files/MATLAB/R2010b/myfiles');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Input parameters
N = 1024;          % Number of pixels in hologram NxN 
R = 80;            % Radius (in pixels) of the cutout window in the Fourier domain
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% reading hologram in BIN format
    fid = fopen('off-axis_Kugel5_015.bin', 'r');
    hologram = fread(fid, [N, N], 'real*4');
    fclose(fid); 
    
%       figure, imshow(flipud(rot90(hologram)), []);
%       title('Off-axis hologram')
%       xlabel({'x / px'})
%       ylabel({'y / px'})
%       axis on
%       set(gca,'YDir','normal')
%       colormap('gray')
%       colorbar;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Calculating Fourier transform and showing absolute value of the result
     spectrum = FT2Dc(hologram);
     spectrum_abs = abs(FT2Dc(hologram));
     
      figure, imshow(flipud(rot90(log(spectrum_abs))), []);
      title('Fourier spectrum in log scale / a.u.')
      xlabel({'u / px'})
      ylabel({'v / px'})
      axis on
      set(gca,'YDir','normal')
      colormap('gray')
      colorbar;   
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Blocking the central part of the spectrum
R0 = 10;
spectrum_abs1 = zeros(N,N); 
for ii=1:N
    for jj=1:N
     
    x = ii - N/2;
    y = jj - N/2;
    
    if (sqrt(x^2 + y^2) > R0) 
        spectrum_abs1(ii, jj) = spectrum_abs(ii,jj); 
    end
    end
end
      figure('Name','Centeral Block');
      imshow(rot90(log(abs(spectrum_abs1))), []);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Blocking half of the spectrum
     spectrum_abs1(1:N/2,:) = 0; 
      figure('Name','half blocked');
      imshow(rot90(log(abs(spectrum_abs1))), []);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Finding the position of the side-band in the spectrum
maximum = max(max(spectrum_abs1));
[x0, y0] = find(spectrum_abs1==maximum)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Shifting the complex-valued spectrum to the center
spectrum2 = zeros(N,N);
x0 = x0 - N/2 - 1;
y0 = y0 - N/2 - 1;

for ii = 1:N-x0
    for jj = 1:N-y0    
        spectrum2(ii, jj) = spectrum(ii+x0,jj+y0); 
    end
end
      figure('Name','Centered');
      imshow(rot90(log(abs(spectrum2))), []);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Selecting the central part of the complex-valued spectrum spectrum
spectrum3 = zeros(N,N);
for ii=1:N
    for jj=1:N
     
    x = ii - N/2;
    y = jj - N/2;
    
    if (sqrt(x^2 + y^2) < R) 
        spectrum3(ii, jj) = spectrum2(ii, jj); 
    end
    end
end    
%       figure('Name','Centered side-band');
%       imshow(rot90(log(abs(spectrum3))), []); 
     
      figure, imshow(flipud(rot90(log(abs(spectrum3)))), []);
      title('Fourier spectrum in log scale / a.u.')
      xlabel({'u / px'})
      ylabel({'v / px'})
      axis on
      set(gca,'YDir','normal')
      colormap('gray')
%     colorbar;  % cannot be shown because of values log(0) 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Reconstruction by inverse Fourier transform  
     reconstruction = IFT2Dc(spectrum3);
     rec_abs = abs(reconstruction);
     rec_phase = angle(reconstruction);
     
%       figure, imshow(flipud(rot90(rec_abs)), []);
%       title('Reconstructed amplitude / a.u.')
%       xlabel({'x / px'})
%       ylabel({'y / px'})
%       axis on
%       set(gca,'YDir','normal')
%       colormap('gray')
%       colorbar;  
% 
%       figure, imshow(flipud(rot90(rec_phase)), []);
%       title('Reconstructed phase wrapped / rad')
%       xlabel({'x / px'})
%       ylabel({'y / px'})
%       axis on
%       set(gca,'YDir','normal')
%       colormap('gray')
%       colorbar; 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Phase unwrapping  
%     rec_phase_unwrapped = Phase_unwrapping(rec_phase);
%       figure, imshow(flipud(rot90(rec_phase_unwrapped)), []);
%       title('Reconstructed phase unwrapped / rad')
%       xlabel({'x / px'})
%       ylabel({'y / px'})
%       axis on
%       set(gca,'YDir','normal')
%       colormap('gray')
%       colorbar; 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Saving reconstructed amplitude as JPG image
%         p = rec_abs;
%         p = (p - min(min(p)))/(max(max(p)) - min(min(p)));
%         imwrite (rot90(p), 'Reconstructed_amplitude.jpg');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Saving reconstructed phase as JPG image       
%         p = rec_phase_unwrapped;
%         p = (p - min(min(p)))/(max(max(p)) - min(min(p)));
%         imwrite (rot90(p), 'Reconstructed_phase.jpg');