clear all

Hs(1)= -17.6860;
hs(1) = 219.2237;

%---------------------------

a = data_PAC();
     
Hour=4;
N =100;
T = 0:Hour/N:Hour;
Tr0 = a(12)/a(10);
Tw0 = a(9)/a(11);
x0 = 0.00;
x = x0;
cprev =  [a(1);a(2);a(3);a(4)];

for i=1:5
        
        j=1;
    while j<70
 
    n = j/100;
        
    cprev(1) = 0.5*3*n;
    cprev(2) = a(2)*(1-n);
    cprev(3) = a(3)*(1-n);
    cprev(4) = a(4)*(1-n);
    
    y0=[Tr0;Tw0;x0;x;cprev];

    [t,y] = ode45(@PAC_cont_function,T,y0);
     
    x = y(100,3);
    
    lol(j) = (cprev(3)+cprev(1)*x)/(cprev(2)-3*cprev(1)*x);
    j=j+1;
    end
    maxlol(i)=lol(j-1);
 
%hold on
%plot(lol)

x
    m=0.7;
    cprev(1) = 0.5*3*m;
    cprev(2) = a(2)*(1-m);
    cprev(3) = a(3)*(1-m);
    cprev(4) = a(4)*(1-m);
    
a = data_PAC(x,cprev);

cprev;

end
plot(maxlol)
    % y(:,1) = y(:,1)/yd(1);
    % y(:,2) = y(:,2)/yd(2);
%     plot(T,y(:,1)) ;
%     plot(T,y(:,2)) ;
%[y(N,1),y(N,2),y(N,3)] - 