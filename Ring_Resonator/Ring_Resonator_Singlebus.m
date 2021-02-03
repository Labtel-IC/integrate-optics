function [Eout,Edrop,Tout]=Ring_Resonator(lambda,Ein,V0)

neff = 2.61;
Rlength = 10e-6*2*pi;
alpha = -log(10^(-7/10));
a = exp(-alpha*Rlength/2);
k = 0.274;
r = sqrt(1-k^2);
gap = 10e-6;

neff = 4.18 - (900000.*lambda);

%mode=0, Ring Resonator 
%mode=1, Ring Resonator Modulator
mode=1;
if (mode==0)
    
    Beta=(2*pi*neff)./(lambda);
    teta=(Beta.*Rlength);
    
elseif (mode==1)
    
    Beta=(2*pi*neff)./(lambda);
    Vpi=7;
    teta = (Beta.*Rlength)+((pi*V0*0.88)/Vpi);

end


%type=0, Ring Resonator all-pass
%type=1, Ring Resonator add-drop
type=0;
if (type==0)

%   Eout = Ein.*((r-a*exp(j*teta)))./(1-conj(r)*a*exp(j*teta));

%   Eout = Ein.*(exp(1j*(pi+teta)).*((a-r*exp(-1j*teta))./(1-r*a*exp(1j*teta))));

  Eout = Ein.*((-sqrt(a)+r*exp(-1j*teta)) ./ (-sqrt(a)*conj(r)+exp(-1j*teta)));

%   Tout = Ein.*(((a^2)+(r^2)-(2*a*r*cos(teta)))./(1+((r*a)^2)-(2*a*r*cos(teta))));

    Tout = 0;

    Edrop = 0;
    
elseif (type==1)
    
    Eout=(r-conj(r)*sqrt(a)*exp(1j*teta)) ./ (1-sqrt(a)*(conj(r)^2).*exp(1j*teta));
    
	Edrop=(conj(k)*conj(k)*sqrt(a*exp(1j*teta))) ./ (1-sqrt(a)*conj(r)^2*exp(1j*teta));
    
    Tout=0;
    
end

    
    
    



