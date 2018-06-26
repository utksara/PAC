function m = data_PAC(x,cprev)

if nargin<2
m(1)= 0.1; %ca0
m(2)= 0.1; %ch0
m(3)= 0.001; %cp0
m(4)= 0.001; %cw0
else
m(1)= cprev(1)-x*cprev(1); %ca0
m(2)= cprev(2)-3*x*cprev(1); %ch0
m(3)= (cprev(3)+x*cprev(1)); %cp0
m(4)= cprev(4)+2*x*cprev(1); %cw0
end

m(5) = 0.880*154; %;Cpa
m(6) = 4.184*24.1;%Cph
m(7) = 0.912*205; %Cpp
m(8) = 4.610*18; %Cpw

m(9) = 273+200; % Tin
m(10) = 273+167; % Trd
m(11) = 273+170; % Twd
m(12) = 273 + 35; % Tr0

%[m(5) m(6) m(7) m(8) ]