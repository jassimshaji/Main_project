function [D] = Thermaldiffusivity(x1_val,y1_val,x2_val,y2_val,index,conc_val)
w = 2e-3;
t = 1;
% phase diff
 index_value = index;
 phase_diff = (str2double(index_value)/255)*2*pi;

% Refractive Index(recommented)

 L = 10e-3;
 lambda = 650e-9;
 phi = phase_diff; 
 n = (phi*lambda)/(2*pi*L);
 n0 = finding_no(index);
 disp("THE DELTA_N VALUE IS :");
 disp(n);

 % radial distance
 x1 =x1_val;
 y1 = y1_val;
 x2 = x2_val;
 y2 = y2_val;
 r = sqrt((y2 - y1)^2 + (x2 - x1)^2);
 r_dist = r*2.2e-4;
 disp("THE RADIAL DISTANCE : ");
 disp(r_dist);



% Thermal Diffusivity

 D = (log(n/n0)+(2*r_dist*r_dist/w*w))/8*t;
 disp("THE THERMAL DIFFUSIVITY IS : ")
 disp(D)

%Display data points in corresponding phasediff map

if conc_val == "0.5"
   disp("0.5ul")
   figure('Name','Phase difference_0.5ul_im_sol '); f = imshow("PhaseUnwrapped\0.5ul_withsol\Phasediff\Reconstructed_nopump_im_sol_uwphasediff.jpg");
   datatip(f, x1_val,y1_val)
   figure('Name','Phase difference_0.5ul_im_sol '); f = imshow("PhaseUnwrapped\0.5ul_withsol\Phasediff\Reconstructed_nopump_im_sol_uwphasediff.jpg");
   datatip(f, x2_val,y2_val)
elseif conc_val == "1"
    disp("1ul")
    figure('Name','Phase difference_1ul_im_sol '); f = imshow("PhaseUnwrapped\1ul_withsol\Phasediff\Reconstructed_1ul_nopump_im_sol_uwphasediff.jpg");
    datatip(f, x1_val,y1_val)
    figure('Name','Phase difference_1ul_im_sol '); f = imshow("PhaseUnwrapped\1ul_withsol\Phasediff\Reconstructed_1ul_nopump_im_sol_uwphasediff.jpg");
    datatip(f, x2_val,y2_val)
elseif conc_val == "10"
    disp("10ul")
    figure('Name','Phase difference_10ul_im_sol '); f = imshow("PhaseUnwrapped\10ul_withsol\Phasediff\Reconstructed_10ul_nopump_im_sol_uwphasediff.jpg");
    datatip(f, x1_val,y1_val)
    figure('Name','Phase difference_10ul_im_sol '); f = imshow("PhaseUnwrapped\10ul_withsol\Phasediff\Reconstructed_10ul_nopump_im_sol_uwphasediff.jpg");
    datatip(f, x2_val,y2_val)
elseif conc_val == "50"
     disp("50ul")
     figure('Name','Phase difference_50ul_im_sol '); f = imshow("PhaseUnwrapped\50ul_withsol\Phasediff\Reconstructed_50ul_nopump_im_sol_uwphasediff.jpg");
     datatip(f, x1_val,y1_val)
     figure('Name','Phase difference_50ul_im_sol '); f = imshow("PhaseUnwrapped\50ul_withsol\Phasediff\Reconstructed_50ul_nopump_im_sol_uwphasediff.jpg");
     datatip(f, x2_val,y2_val)
elseif conc_val == "100"
    disp("100ul")
     figure('Name','Phase difference_100ul_im_sol '); f = imshow("PhaseUnwrapped\100ul_withsol\Phasediff\Reconstructed_100ul_nopump_im_sol_uwphasediff.jpg");
     datatip(f, x1_val,y1_val)
     figure('Name','Phase difference_100ul_im_sol '); f = imshow("PhaseUnwrapped\100ul_withsol\Phasediff\Reconstructed_100ul_nopump_im_sol_uwphasediff.jpg");
     datatip(f, x2_val,y2_val)
end

