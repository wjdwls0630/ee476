function IDS = nmos_sat (x,alpha,Vth,n)
    %Vgs = x;
    %n = 1.3480;
    %Vth = 372e-3;
    %Fit the NMOS equation to the saturation model
    IDS = alpha.*(x-Vth).^(n);

end