function  [Eout,H] = MZM(t,Ein,U,MZ_Input_File)
%c
%c function [Eout,H] = MZM(t,Ein,MZ_Input_File);
%c
%c This script is responsible to reproduce the output field of a MZM
%c modulator of one or two arms depending on the inputs.
%c
%c
%c                                           Updated by P.Marciano LG
%c                                           18/09/2017
%c                                           pablorafael.mcx@gmail.com
%c%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%c                   L I S T  O F  V A R I A B L E S                      %
%c%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%c
%c	Modulador Mach-Zehnder
%c
%c  Entrada:
%c  Shift         : Deslocamento da Saida
%c 	t  			  : Vetor de tempo                                      [s]
%c  Ein			  : Campo Eletrico de Entrada                         [V/m]  
%c                  (dominio do tempo)
%c  U1t 		  : Tensao de entrada no braco 1 do modulador           [V]  
%c                  (dominio do tempo)
%c  U2t 		  : Tensao de entrada no braco 2 do modulador           [V] 
%c                  (dominio do tempo)
%c  MZ_Input_File :Arquivo de entrada contendo parametros do modulador
%c
%c  Saida
%c  Eout          : Campo Eletrico optico modulado no tempo           [V/m]
%c  H             : Funcao de tranferencia eletrica do modulador
%c 
%c
%c%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%c                             S T R U C T S                              %
%c%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%c
%c   Usa: time2freq_lamb
%%
U1t = 0;
U2t = 0;
Shift = -2.3;
if (nargin <= 3),
  MZ_Input_File  ='MZ_Input_Data';
  eval([MZ_Input_File]);
else
    [L,U0,U_pi1,U_pi2,~,~,nopt,nel,~,~,C,alfa0] = Import_Data_MZM (...
                                                            MZ_Input_File);%Import the data from files 
end

U_pi       = U_pi1;
tps        = t/1E-12;
ccmns      = 30;			     	% Velocidade da luz [cm/ns]
freqTHz    = time2freq_lamb(tps);
freqGHz    = freqTHz*1e-3;			% Frequencia em GHz
freqGHz    = -fftshift(freqGHz);
freqGHz(1) = freqGHz(2);
%

%%%%%%%  FUNCAO DE TRANSFEWRENCIA ELETRICA DO MODULADOR  %%%%%%%%%%%
%
alfaf  = 0.5*alfa0*(abs(freqGHz).^0.5);
gamaf  = 2*pi*abs(freqGHz).*(nel - nopt)/ccmns;
atn    = alfaf + 1j*gamaf;
H      = (1./(atn*L)).*(1 - exp(-atn*L));
% %
  %The final part of the following equation is the Chirp parameter and it
  %should not be removed, because it will be the key parameter to create
  %the optical carriers at the same level.
  Eout = Ein.*cos((pi/2).*(U1t - U2t - U0 + Shift)/U_pi).*exp(-1j*(pi/2).*((U1t + U2t)/U_pi));
end
