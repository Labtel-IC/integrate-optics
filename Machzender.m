clear all;
clc;

Local = [pwd '\input_files\'];
MZ_Input_File  ='MZ_Input_Data';

% eval([MZ_Input_File]);
MZ_Input_Data;

nNyx = 2^6;
vLuz = 3e8;
compOnda = 1550e-9;
fc = vLuz/compOnda;
tf=1/fc;
fa = nNyx*fc;
ta = 1/fa;
t = 0:ta:tf;
f = time2freq(t);
Ein = ones(1,length(t));

Vbias = -8:0.5:8;
Vbias_steps = length(Vbias);
Vpi = 3.9;

tic;

Make_MZ_Input_Files_Simp;

PotenciamW = zeros(1,Vbias_steps);
PotenciadB = zeros(1,Vbias_steps);

for arq = 1:Vbias_steps
    [Eout,H] = Mach_Zehnder_Modulator_simplificado(t,Ein,0,arq);
    [PotenciamW(arq),PotenciadB(arq)] = MeasPower(Eout,t);
end

norm = PotenciamW./max(PotenciamW);
plot(Vbias,norm);