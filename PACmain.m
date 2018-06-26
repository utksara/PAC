
clear all

Hs(1)= -2000.6860;
hs(1) =200.2237;

objv = [Hs(1);hs(1)];

a = data_PAC();
%-------------------------
Hour=8;
N =10;
T = 0:Hour/N:Hour;
Tr0 = a(12)/a(10);
Tw0 = a(9)/a(11);
x0 = 0.00;
%yd = [a(10),a(11),0.93];
yd = [1,1,0.93];
i=1;
differ = 100;

F=0.05;
CR = 0.05;
dd=1;
    
while differ>2

%----------------------------------------------
disp('fukoff')
    y0=[Tr0;Tw0;x0;Hs(i);hs(i)];
    y0H=[Tr0;Tw0;x0;Hs(i)+dd;hs(i)];
    y0h=[Tr0;Tw0;x0;Hs(i);hs(i)+dd];
%----------------------------------------------  
    [t,yH] = ode45(@PACfn,T,y0H);   
    [t,yh] = ode45(@PACfn,T,y0h);
 
    [t,y]  = ode45(@PACfn,T,y0);
    
    d1 = abs(1-y(100,1)/yd(1));
    d2 = abs(1-y(100,2)/yd(2));
    d3 = abs(1-y(100,3)/yd(3));
%     d4 = abs(1-y(2,1)/y(1,1));
    
    d1H = abs(1-yH(100,1)/yd(1));
    d2H = abs(1-yH(100,2)/yd(2));
    d3H = abs(1-yH(100,3)/yd(3));
%     d4H = abs(1-yH(2,1)/yH(1,1));
    
    d1h = abs(1-yh(100,1)/yd(1));
    d2h = abs(1-yh(100,2)/yd(2));
    d3h = abs(1-yh(100,3)/yd(3));
%     d4h = abs(1-yh(2,1)/yh(1,1));
    
    differ  = 100* norm([d1 d2 d3 ],2)/3;
    differH = 100* norm([d1H d2H d3H ],2)/3;
    differh = 100* norm([d1h d2h d3h ],2)/3;
        
    ys(i) = differ; %y(100,1);

    if i == 1
        move = [0.01;0.01;0.01];

    else
        move(1) = -grad_PAC(differH,differ,dd);
        move(2) = -grad_PAC(differh,differ,dd);

        move(3) = 1 ;
        
        move = move/norm([move(1) move(2) move(3)],2);
        
        move = [move(1);move(2);0]*1.414/norm([move(1) move(2)],2) - move;
    end
    alpha = 100;%abs(100*move(3)/norm([move(1) move(2)],2));
    
    Hs(i+1) = Hs(i)-alpha*move(1);
    hs(i+1) = hs(i)-alpha*move(2);
    
    Hs(i+1) = - abs(Hs(i+1));
    hs(i+1) =   abs(hs(i+1));

%-----------------------------------------------------------------------------
%     R = randi([1:length(objv)]);
%     
%     A=objv;
%     B=objv;
%     C=objv;
%  
%     while or(A==B,or(B==C,or(A==C,or(objv==A,or(objv==B,objv==C)))))
%         
%     A(1)=-10 - rand*990;
%     A(2)= 10 + rand*990;
%     
%     B(1)=-10 - rand*990;
%     B(2)= 10 + rand*990;
%     
%     C(1)=-10 - rand*990;
%     C(2)= 10 + rand*990;
%     end
%     
%     for j=1:length(objv)
%         r(j) =rand;
%         if or(r(j)<CR,j==R)
%            objvnew(j) = A(j) + F*(B(j)-C(j));
%         else
%            objvnew(j)=objv(j); 
%         end
%     end
%     
%     objvnew(1) = - abs(objvnew(1));
%     objvnew(2) =   abs(objvnew(2));
%     
%     y0=[Tr0;Tw0;x0;objv(1);objv(2)];
%     y0new=[Tr0;Tw0;x0;objvnew(1);objvnew(2)];
%     
%     [t,y] = ode45(@PACfn,T,y0);
%     [t,ynew] = ode45(@PACfn,T,y0new);
%     
%     d1 = abs(1-y(N,1)/yd(1));
%     d2 = abs(1-y(N,2)/yd(2));
%     d3 = abs(1-y(N,3)/yd(3));
% 
%     d1new = abs(1-ynew(N,1)/yd(1));
%     d2new = abs(1-ynew(N,2)/yd(2));
%     d3new = abs(1-ynew(N,3)/yd(3));
%     
%     differ  = 10* norm([d1 d2 d3 ],2)/3
%     differnew = 10* norm([d1new d2new d3new ],2)/3;
%     
%     if (differ>differnew)
%         objv = objvnew;
%         differ=differnew;
%         differnew
%     end
%     
%     lmao1(i)=objvnew(1);
%     lmao2(i)=objvnew(2);
 %--------------------------------------------------------------------------
    i=i+1;
    
end

    hold on
%     y(:,1) = y(:,1)/yd(1);
%     y(:,2) = y(:,2)/yd(2);
    plot(T,y(:,1)) ;
    plot(T,y(:,2)) ;
    plot(T,y(:,3)) ;
