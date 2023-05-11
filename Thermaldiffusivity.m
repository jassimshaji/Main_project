
w = 2e-3;
t = 1;



% phase diff
%  index_value = "7";
%  phase_diff = (str2double(index_value)/255)*2*pi;
%  disp("PHASE DIFFERENCE IS : ")
%  disp(phase_diff)

% Refractive Index(recommented)

  L = 10e-3;
  lambda = 650*10.^-9;
  phi = 0.0117645;
  phi0 = 0.027451; 
 n = (phi*lambda)/(2*pi*L);
 n0 = (phi0*lambda)/(2*pi*L);    %finding_no("3");
 disp("THE N0 VALUE IS :");
 disp(n0);
 disp("THE DELTA_N VALUE IS :");
 disp(n);

 % radial distance
 x1 =901;
 y1 = 555;
 x2 = 901;
 y2 = 565;
 r = sqrt((y2 - y1)^2 + (x2 - x1)^2);
 r_dist = r*2.2e-5;
 disp("THE RADIAL DISTANCE : ");
 disp(r_dist);



% Thermal Diffusivity

 D = (log(n/n0)+(2*r_dist*r_dist/w*w))/8*t;
 disp("THE THERMAL DIFFUSIVITY IS : ")
 disp(D)

