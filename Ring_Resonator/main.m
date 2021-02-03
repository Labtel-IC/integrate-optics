clear all;
clc;

Local = [pwd '\input_files\'];
MZ_Input_File  ='MZ_Input_Data';
MZ_Input_Data;

nNyx = 2^10;
fc = 12.5e9;
T  = 1/fc;
nT = 10;
tf = T*nT
t = linspace(0,tf,nNyx*nT);
f = time2freq(t);

lambda = linspace(1500*1e-9,1600*1e-9,nNyx*nT)

% lambda = 1500*1e-9;

Ein = ones(1,length(t)); 

% Sinal = randint(1,nT,2);
Sinal = [0 0 0 0 1 1 0 0 0 0];
% Sinal(Sinal==0)= -1;
Sinalret = rectpulse(Sinal,nNyx);
Sinal_steps = length(Sinalret);

for i=-2:0.5:0
    
    V0 = i + (0*sin(2*pi*fc*t));
    [Eout,Edrop,Tout] = Ring_Resonator_Singlebus(lambda,Ein,V0);
    plot(lambda,Eout);
    hold on
    axis([1500e-9 1600e-9 -1.5 1.5]);
    xlabel('wavelength')
    ylabel('Eout')
    
end



% [Eout,Edrop,Tout] = Ring_Resonator_Singlebus(lambda,Ein,V0);
% load C:/Users/Thiago/Desktop/testestets.mat;
% ax1 = axes; 
% lum.x0 = lum.x0*10^-9;
% lum.y0 = (lum.y0-min(lum.y0))/(max(lum.y0)-min(lum.y0));
% Eout = (Eout-min(Eout))/(max(Eout)-min(Eout));
% plot(lum.x0,lum.y0)
% % plot(lambda,Eout,lum.x0,lum.y0);
% axis([1500e-9 1600e-9 -0.5 1.5]);
% % legend('MatLab','Lumerical');
% xlabel('Wavelength')
% ylabel('Eout normalizado')



% plot(f,Tout);
% axis([-8e7 8e7 -2 2]);




