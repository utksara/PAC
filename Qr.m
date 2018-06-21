function r=Qr(Tr,x)

a = data_PAC;
Cpa = a(5);
Cph = a(6);
Cpp = a(7);
Cpw = a(8);

V0=12.4;

ca0= a(1);
ch0= a(2);
cp0= a(3);
cw0= a(4);

ah=ca0/ch0;
ap=ca0/cp0;
aw=ca0/cw0;
Trd = a(10);

r = Trd*Tr*V0*(Cpa*ca0*(1-x)+Cph*ch0*(1-ah*3*x)+Cpp*cp0*(1+ap*x)+Cpw*cw0*(1+2*aw*x));

