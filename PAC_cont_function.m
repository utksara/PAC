%____ units______%
% energy- kJ
% quantity- moles
% mass- tonnes (1000 kg)
% area- meter sq
% time- hours
% conc- moles per litre
% heat tranf ceoff- kJ/(K hour m2)
% volume - litres


function M=PACfn(t,y)

M=zeros(5,1);

Tr=y(1);
Tw =y(2);   
x =y(3);

a = data_PAC();

ca0= y(5);
ch0= y(6);
cp0= y(7);
cw0= y(8);

delH = -17.6860;
h = 219.2237;

Cpa = a(5);
Cph = a(6);
Cpp = a(7);
Cpw = a(8);
Trd = a(10);
Twd = a(11);

ah=ca0/ch0;
ap=ca0/cp0;
aw=ca0/cw0;

A = 25.5;
V0= 12.5*1000;
mf= 1;
m = 1.28;

Eaf = 4.1786e+04;
Eab = Eaf-delH;
R = 8.314e-3;

kf = exp(13-Eaf/(R*(Tr*Trd)));
kb = exp(4-1*Eab/(R*(Tr*Trd)));
% kf = exp(4);
% kb = exp(1);

Tin = 273+180;

S =V0*Tr*(ap*Cpp*cp0 + aw*Cpw*cw0 - ah*Cph*ch0 - Cpa*ca0);%summation of ai.Cpi.ci0
M(2)= ((Tin/Twd-Tw)*mf/m + (Tr*Trd/Twd-Tw)*h*A/(Cpw*m))/Twd;
M(3)= (kf*ca0*ch0*(1-3*ah*x)*(1-x)- kb*cp0*cw0*(1+2*aw*x)*(1+x*ap))/(ca0);
M(1)= Tr*(-delH*V0*ca0*M(3) - h*A*(Tr-Tw) - M(3)*S )/(Qr(Tr,x));
M(4)= 0;
M(5)= 0;
M(6)= 0;
M(7)= 0;
M(8)= 0;

% X(1)= -delH*V0*ca0*M(3);0
% X(2)= -h*A*(Tr-Tw);
% X(3)= -M(3)*S;
% X
end