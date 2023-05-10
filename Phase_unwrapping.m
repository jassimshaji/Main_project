%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Phase unwrapping procedure is based on the approach proposed by 
% Marvin A. Schofield and Yimei Zhu in 
% "Fast phase unwrapping algorithm for interferometric applications"
% Optics Letters 28(14), 1194 - 1196 (2003)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% This code is part of the code for RECONSTRUCTION OF OFF-AXIS HOLOGRAM,
% Citation for the code is
% Tatiana Latychevskaia, Petr Formanek, C. T. Koch, Axel Lubk
% "Off-axis and inline electron holography: Experimental comparison",
% Ultramicroscopy 110, 472 - 482 (2010)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% The code is written by Tatiana Latychevskaia, 2010
% The version of Matlab for this code is R2010b
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [out] = Phase_unwrapping(in)

[Nx Ny] = size(in);

f = zeros(Nx,Ny);
for ii = 1:Nx
    for jj = 1:Ny
        x = ii - Nx/2 - 1;
        y = jj - Ny/2 - 1;        
        f(ii,jj) = x^2 + y^2;
    end
end

a = IFT2Dc(FT2Dc(cos(in).*IFT2Dc(FT2Dc(sin(in)).*f))./(f+0.000001));
b = IFT2Dc(FT2Dc(sin(in).*IFT2Dc(FT2Dc(cos(in)).*f))./(f+0.000001));

out = real(a - b);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
