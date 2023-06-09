close all;
%NxM ;N = 1080; M = 1920;
N = 1080;
M = 1920;
R = 100;

%Name of figures
sol_nopump = "PhaseWrapped\50ul_withsol\Reconstructed_50ul_sol_nopump_phase.jpg";
im = 'PhaseWrapped\50ul_withsol\Reconstructed_50ul_im_sol_phase.jpg';
min1 = 'PhaseWrapped\50ul_withsol\Reconstructed_50ul_min1_sol_phase.jpg';
min5 ='PhaseWrapped\50ul_withsol\Reconstructed_50ul_min5_sol_phase.jpg' ;

%Naming the writing pictures
name_im_sol ='PhaseWrapped\50ul_withsol\Phasediff\Reconstructed_50ul_nopump_im_sol_phasediff.jpg' ;
name_min1_sol ='PhaseWrapped\50ul_withsol\Phasediff\Reconstructed_50ul_nopump_min1_sol_phasediff.jpg';
name_min5_sol ='PhaseWrapped\50ul_withsol\Phasediff\Reconstructed_50ul_nopump_min5_sol_phasediff.jpg';

%converting reference image to binary file
 img = imread("Samples\Zn_ph10\0.5ul\sol_nopump.bmp");



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


% Reconstruction by inverse Fourier transform
     
     reconstruction = IFT2Dc(spectrum3);
     rec_abs = abs(reconstruction);
     rec_phase = angle(reconstruction);
     

     

%phase difference im_sol

             Rf = imread(sol_nopump);
             imSol = imread(im);
             zrimSol = imabsdiff(Rf,imSol);
             figure('Name','Phase difference im_sol '); g = imshow(zrimSol);
             datatip(g, 505,400)
             imwrite(zrimSol,name_im_sol, 'jpg');


%phase difference min1_sol

           Rf = imread(sol_nopump);
           imSol = imread(min1);
           zrimSol = imabsdiff(Rf,imSol);
           figure('Name','Phase difference min1_sol '); f = imshow(zrimSol);
           datatip(f, 505,400)
           imwrite(zrimSol,name_min1_sol, 'jpg');


%phase difference min5_sol

           Rf = imread(sol_nopump);
           imSol = imread(min5);
           zrimSol = imabsdiff(Rf,imSol);
           figure('Name','Phase difference min5_sol '); f = imshow(zrimSol);
           datatip(f, 505,400)
           imwrite(zrimSol,name_min5_sol, 'jpg');

 % Saving reconstructed phase as JPG image
         
          p = rec_phase;
          p = (p - min(min(p)))/(max(max(p)) - min(min(p)));
         %imwrite (p, 'Reconstructed_sol_nopump_phase.jpg');





