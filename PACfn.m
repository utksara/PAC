% unitsv
% energy- kJ
% flow rate- mol per hour
% mass- tonn (1000 kg)
% area- meter sq
function M=PACfn(t,y)

M=zeros(5,1);

Tr=y(1);
Tw =y(2);   
x =y(3);

a = data_PAC();
ca0= a(1);
ch0= a(2);
cp0= a(3);
cw0= a(4);

delH = y(4);
h = y(5);

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
mf= 70;%1.280;
m = 100;% 1;

Eaf = 4.1786e+04;
Eab = Eaf-delH;
R = 8.314;

kf = exp(14-Eaf/(R*(Tr*Trd)));
kb = exp(4-1*Eab/(R*(Tr*Trd)));
% kf = exp(4);
% kb = exp(1);

Tin = 273+180;

S =Tr*Trd*(ap*Cpp*cp0 + aw*Cpw*cw0 - ah*Cph*ch0 - Cpa*ca0);%summation of ai.Cpi.ci0
M(2)= ((Tin/Twd-Tw)*mf/m + (Tr*Trd/Twd-Tw)*h*A/(Cpw*m));
M(3)= (kf*ca0*ch0*(1-3*ah*x)*(1-x)- kb*cp0*cw0*(1+2*aw*x)*(1+x*ap))/(ca0);
M(1)= Tr*(-delH*V0*ca0*M(3) - (Tr*Trd-Twd*Tw)*h*A - M(3)*S )/(Qr(Tr,x));
M(4)= 0;
M(5)= 0;


% X(1)= -delH*V0*ca0*M(3);0
% X(2)= -h*A*(Tr-Tw);
% X(3)= -M(3)*S;
% X
end