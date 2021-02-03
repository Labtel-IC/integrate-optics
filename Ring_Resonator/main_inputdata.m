%c
%c                                                       ..'Ž`'..'Ž`..'Ž`..                                                   
%c       File: main_inputdata
%c
%c       This code is used to set up the input parameters that will be used
%c in the whole simualation.
%c
%c
%c
%c
%c
%c                                           by P.Marciano LT
%c                                           04/11/2019
%c                                           pablorafael.mcx@gmail.com
%c 
%c
%c%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%c                    G L O B A L  V A R I A B L E S                      %
%c%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%c
%c%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%c                   L I S T  O F  V A R I A B L E S                      %
%c%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%c
%c
%c   
%c   t           :This is the time vector for your simulation, it 
%c                will run just as much periods of your signal you
%c                need and/or want to simulate.                        [s]
%c   f           :This is the frequency vector for your simulation, it 
%c                will run just as much periods of your signal you need 
%c                and/or want to simulate.                             [Hz]
%c   Po          :The power of the signal                               [w]
%c   Eo_CW       :This is the Amplitude of the signal                   [V]
%c   nsamp       :numpre of up sampling                                 [-]
%c   M           :Order of Gausian filter                               [-]
%c   m           :Modulation number                                     [-]
%c   k           :Number of bits per simble                             [-]
%c   p           :Auxiliar variable to store the current directory      [-]
%c   Local       :It stores where the files for the MZM will be stored  [-]
%c	 L		     :Comprimento do dispositivo                          [cm]
%c   U0          :Tensao de polarizacao                                [V]
%c   eletrodes	 :Numero de eletrodos (1,2). Definido pelo 
%c                numero de variaveis de entrada na funcao
%c                Mach_Zehnder_Modulator                                [-]
%c   U_pi1       :Tensao de chaveamento para 1 eletrodo                 [V]
%c   U_pi2       :Tensao de chaveamento para 2 eletrodos                [V]
%c   eta1        :Sensibilidade no caminho 1                        [1/V.m]
%c   eta2        :Sensibilidade no caminho 2                        [1/V.m]
%c   nopt	     :Indice de refracao optico                             [-]
%c   nel	     :Indice de refracao eletrico                           [-]
%c   alfa_ins	 :Perda por insercao                                   [dB]
%c   phi_0 		 :Constante de fase entre os dois caminhos              [-]
%c   alfa0		 :Perda condutiva                           [dB/cm.GHz^0.5]
%c   C           :Parametro de chirp                                    [-]
%c
%c   
%c
%c%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%c                             S T R U C T S                              %
%c%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%c   Here it will be added the functions that this code will call
%c   
%c
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                          Start of the Program                           %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
close all; clc; clear;
%% Files parameters
p = pwd;                    %Geting the current path of the main program
Local = [p '\input_files\'];%variable that shows where the input files for
                                                     %the mzm will be saved

%%  MZM Parameters
MZ_Input_Data;                   %Loading the basic data to be saved
L        =  10.00;
% U0       =  2.390;
U_pi1    =   3.80;
U_pi2    =   3.80;
eta1     =  89.00;%1;%
eta2     = -12.70;%-1;%
nopt     =   2.17;
nel      =   2.60;
alfa_ins =   5.10;
phi_0    =   0.00;
alfa0    =   1.07;
% C        = (eta1+eta2)/(eta1-eta2);
% alfa0    = 10^(alfa0/20);

%% Variable of the program
fc = 1e9; % Center frequency of the optical carrier
Nyq = 2^4; % Nyquest number
F = 1e6; % Center frequency of the electrical signal
T = 1/F; % Electrical signal Period
NuT = 2^4; % Number of periods of the electrical signal on this simulation
tf = NuT*T; % Final time of this simulation
Fa = Nyq*fc; % Sampling Ratio of the electrical signal
Ta = 1/Fa; % Sampring period of the electrical signal
NumPon = tf/Ta;% Total number of points for this simulation
t = linspace(0,tf,NumPon+1); % Time vector for this simulation
f = time2freq(t); % Frequency vector for this simulation
Cw = ones(1,length(t));
Amp1 = 1; % Amplitudo of the electrical signal
Amp2 = 1; % Amplitudo of the electrical signal

pha1 =  90*pi/180; % Phase of the electrical signal
pha2 =  180*pi/180; % Phase of the electrical signal

ElecSing.U1t = Amp1.*sin(2*pi*F*t + pha1); % One modulating electrical signal
ElecSing.U2t = Amp2.*sin(2*pi*F*t + pha2); % Other modulating electrical signal

Vbias = -8:0.1:8; % Polarizatin voltage
Vbias_steps = length(Vbias); % The total number of different polarizations 

figure;
plot(t,ElecSing.U1t,t,ElecSing.U2t);

figure
plot((f),20*log10(abs(fftshift(fft(ElecSing.U1t)./length(ElecSing.U1t)))),(f),20*log10(abs(fftshift(fft(ElecSing.U2t)./length(ElecSing.U2t)))),(f),20*log10(abs(fftshift(fft(Cw)./length(Cw)))))


a=1;