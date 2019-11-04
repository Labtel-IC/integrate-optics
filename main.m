%c
%c                                                       ..'Ž`'..'Ž`..'Ž`..                                                   
%c       File: main
%c(Main File to Run The tests with MZM)
%c
%c     This main code is resposible to call and run the all the fuction to
%c related to this simulation. Here it is possible to change any 
%c configuration that was previouly stated on the Input data file of this 
%c simulation.
%c The equation here described represents the MZM transfer function at the 
%c time domain. Here an incoming electrical field Ein will be modulated by 
%c the changes of the refractive index on each branch of the MZM due to the 
%c voltage variation. V_pi represents a DC source. It is the polarisation
%c point of the MZM. The second electrical source is the RF modulating
%c signal represented by sin(2*pi *f*t). There are two RF sources, although
%c here their only difference is the phase that will be later introduced.
%c This simulation will work with the MZM varying some parameters to
%c observe the generation of optical comb formations.
%c
%c      Eout = Ein*cos( (phi_1-phi_2)/2 )*e^[j*( (phi_1+phi_2)/2 )]
%c                              
%c
%c          phi_1 = (pi/V_pi)*V*sin(2*pi*f*t)
%c
%c          phi_1 = (pi/V_pi)*V*sin(2*pi*f*t)
%c
%c                                           by P.Marciano LT
%c                                           04/11/2019
%c                                           pablorafael.mcx@gmail.com
%c 
%c     References:
%c
%c@article{combii,
%c  title={Demonstration of 16QAM-OFDM UDWDM Transmission Using a Tunable Optical Flat Comb Source},
%c  author={Hraghi, Abir and Chaibi, Mohamed Essghair and Menif, Mourad and Erasme, Didier},
%c  journal={Journal of Lightwave Technology},
%c  volume={35},
%c  number={2},
%c  pages={238--245},
%c  year={2017},
%c  publisher={IEEE}
%c}
%c
%c@article{kim2002chirp,
%c  title={Chirp characteristics of dual-drive. Mach-Zehnder modulator with a finite DC extinction ratio},
%c  author={Kim, Hoon and Gnauck, Alan H},
%c  journal={IEEE Photonics Technology Letters},
%c  volume={14},
%c  number={3},
%c  pages={298--300},
%c  year={2002},
%c  publisher={IEEE}
%c}
%c
%c@phdthesis{togneri2005analise,
%c  title={An{\'a}lise de Sistemas de Multiplexa{\c{c}}{\~a}o por Subportadora-SCM},
%c  author={Togneri, Arnaldo Paterline},
%c  year={2005},
%c  school={UNIVERSIDADE FEDERAL DO ESP{\'I}RITO SANTO}
%c}
%c
%c@article{oliveiralarge,
%c  title={Large Signal Analysis of Mach-Zehnder Modulator Intensity Response in a Linear Dispersive Fiber},
%c  author={Oliveira, JMB and Salgado, HM and Rodrigues, MRD}
%c}
%c%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%c                    G L O B A L  V A R I A B L E S                      %
%c%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%c   
%c
%c%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%c                   L I S T  O F  V A R I A B L E S                      %
%c%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%c   
%c
%c%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%c                             S T R U C T S                              %
%c%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%c   Here it will be added the functions that this code will call
%c   
%c
%c
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                          Start of the Program                           %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear ; clc; close all;

%% First Instance: Responsible to generate the basic signal and constants
% This is the first point of the program whre the file that loads the main
% configuration is loaded. This file is used to make the major definitions 
% needed for the simulation. Therefore, whatever modification needed will
% be done inside of it. No other part of this code must be changed. If you 
% do, please save this file with a different name.

tic; % Here it is important since this simulation will generate different 
     % MZM-InputFiles. The function "Set_MZ_Input_Data_Simp" requiers that
     % the tic to be inicializated. If not a error message will apear

main_inputdata; % This code is were the variables for this simulation will
                % be creatted and stored. The vast majority of variables
                % that the user can control should be within this file.

Make_MZ_Input_Files_Simp; % Call the script to creat different MZ-inputdata

ThisPower = zeros(1,Vbias_steps);
ThisPowerdBm = zeros(1,Vbias_steps);

for kk=1:Vbias_steps
    [Eout,H] = Mach_Zehnder_Modulator_simplificado(t,Cw,ElecSing,kk);
    [ThisPower(kk),ThisPowerdBm(kk)] = MeasPower(Eout,t); 
end

figure;

plot(Vbias,ThisPower);

a=a+1;




