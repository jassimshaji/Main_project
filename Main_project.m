close all;
%NxM ;N = 1080; M = 1920;
N = 1080;
M = 1920;
R = 100;


%converting reference image to binary file
img = imread("Samples\Zn_ph10\0.5ul\sol_nopump.bmp");
% fid = fopen('reference.bin', 'w+');
% fwrite(fid, img, 'real*8');
% fclose(fid);

%Reading the binary file
% fid = fopen('reference.bin', 'r');
% hologram = fread(fid, [N, M], 'real*8');
hologram = double(img(1:N,1:M,2));
% fclose(fid);


% Calculating Fourier transform and showing absolute value of the result

     spectrum = FT2Dc(hologram);
     spectrum_abs = abs(spectrum);
     figure('Name','Fourier spectrum');
     imshow(log(spectrum_abs), []);



% Blocking the central part of the spectrum

R0 = 2;
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

% Finding the position of the side-band in the spectrum

maximum = max(max(spectrum_abs1));
[x0, y0] = find(spectrum_abs1==maximum);

% Shifting the complex-valued spectrum to the center

spectrum2 = zeros(N,N);
x0=1;
y0=108;
% x0 = x0 - N/2 - 1;
% y0 = y0 - N/2 - 1;

for ii = 1:N-x0
    for jj = 1:N-y0    
        spectrum2(ii, jj) = spectrum(ii+x0,jj+y0); 
    end
end

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

% Reconstruction by inverse Fourier transform
     
     reconstruction = IFT2Dc(spectrum3);
     rec_abs = abs(reconstruction);
     rec_phase = angle(reconstruction);
     
     %figure('Name','Reconstructed amplitude');
     %imshow(rec_abs, []); 

     figure('Name','Reconstructed phase wrapped');
     
     imshow(rec_phase, []); 
     colorbar;
% Phase unwrapping  

    rec_phase_unwrapped = Phase_unwrapping(rec_phase);
    %figure('Name','Reconstructed phase unwrapped');
    %imshow(rec_phase_unwrapped, []);
    %colorbar;
%phase difference without Zn0

           Rf = imread('Reconstructed_reference_phase.jpg');
           imSol = imread('Reconstructed_im_phase.jpg');
           zrimSol = imabsdiff(Rf,imSol);
           figure('Name','Phase difference without Zn0 '); g = imshow(zrimSol);
%            imwrite(zrimSol,'Reconstructed_min1_sol_phasediff.jpg', 'jpg');


%phase difference with Zn0

           Rf = imread('Reconstructed_reference_phase.jpg');
           imSol = imread('Reconstructed_im_sol_phase.jpg');
           zrimSol = imabsdiff(Rf,imSol);
           figure('Name','Phase difference with Zn0 '); f = imshow(zrimSol);


% Saving reconstructed amplitude as JPG image

        p = rec_abs;
        p = (p - min(min(p)))/(max(max(p)) - min(min(p)));
        %imwrite (p, 'Reconstructed_reference_amplitude.jpg');

% Saving reconstructed phase as JPG image
        
        p = rec_phase;
        p = (p - min(min(p)))/(max(max(p)) - min(min(p)));
        imwrite (p, 'Reconstructed_sol_nopump_phase.jpg');




