clear all

Hs(1)= -17.6860;
hs(1) = 2000.2237;

%---------------------------

a = data_PAC();
     
Hour=8;
N =100;
T = 0:Hour/N:Hour;
Tr0 = a(12)/a(10);
Tw0 = a(9)/a(11);
x0 = 0.00;
x = x0;

cprev =  [a(1);a(2);a(3);a(4)];

for i=1:5
    
    y0=[Tr0;Tw0;x0;x;cprev];

    [t,y] = ode45(@PAC_cont_function,T,y0);
     
    x = y(100,3);
    
    a = data_PAC(x,cprev);
    
    cprev(1) = a(1);
    cprev(2) = a(2);
    cprev(3) = a(3);
    cprev(4) = a(4);
    
    disp('    AH        HCl        PAC       water'); 
    disp(cprev');

end