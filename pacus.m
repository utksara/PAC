
function e = pacus(x)

Vin=x(1);
Vout=x(2);
Vh=x(3);
Va=x(4);
caout=x(5);
F=x(6);
Tw=x(7);
Twout=x(8);
sumin=x(9);
sumout=x(10);


h = 100;
A = 25;

cav = 25.56;
chv = 9.05;
cwv = 37.22;

cain = 0.001; 
%caout = 2.86;

chin = 2.0;
chout = 1.7;

cpin = 0.32;
cpout = 0.56;

cwin = 12;
cwout = 14.42;

delH = -17.6;

Vr = 12000;

Tin = 100+273;
Twin = 120+273; 
Tr = 110 + 273;

Cpa = 0.880*154; 
Cph = 4.184*24.1;
Cpp = 0.912*205; 
Cpw = 4.610*18; 

k = exp(13-Eaf/(R*(Tr)));

e(1) = Vout - Vin - Vh - Va ;
e(2) = Vin*cain - Vout*caout + Va*cav - k*caout*chout*Vr;
e(3) = Vin*chin - Vout*chout + Vh*chv - 3*k*caout*chout*Vr;
e(4) = Vin*cwin - Vout*cwout + Vh*cwv + 2*k*caout*chout*Vr;
e(5) = Vin*cpin - Vout*cpout + k*caout*chout*Vr;
e(6) = sumin - Vin*Tin*(Cpa*cain+Cph*chin+Cpp*cpin+Cpw*cwin);
e(7) = sumout - Vout*Tr*(Cpa*caout+Cph*chout+Cpp*cpout+Cpw*cwout);
e(8) = Tw - 0.5*(Twin + Twout);
e(9) = h*A*(Tw-Tr) - delH*k*caout*chout + sumin - sumout;
e(10) = F*Cpw*(Twin-Twout) - h*A*(Tw-Tr);
