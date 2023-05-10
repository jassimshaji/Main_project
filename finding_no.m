function [n0] = finding_no(index_value)
% phase diff
 phase_diff = (str2double(index_value)/255)*2*pi;

% Refractive Index(recommented)

 L = 10e-3;
 lambda = 650*10.^-9;
 phi = phase_diff;
 n0 = (phi*lambda)/(2*pi*L);
 