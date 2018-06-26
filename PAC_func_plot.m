clear all

maxim = 0;
minim = 0;

Hinit = -110;
Hfinal = Hinit + 100;

hinit = 10;
hfinal = hinit + 100;
OptVal = 10;

a = data_PAC();
%-------------------------
for seq1=1:1
        for seq2=1:1
            Hour=8;
            N =10;
            T = 0:Hour/N:Hour;
            Tr0 = a(12)/a(10);
            Tw0 = a(9)/a(11);
            x0 = 0.00;
            %yd = [a(10),a(11),0.93];
            yd = [1,1,0.93];

            Hs = Hinit:(Hfinal-Hinit)/N:Hfinal;
            hs = hinit:(hfinal-hinit)/N:hfinal;

                for i=1:length(hs)
                    for j=1:length(Hs)

                %----------------------------------

                     y0=[Tr0;Tw0;x0;Hs(j);hs(i)];

                     [t,y] = ode45(@PACfn,T,y0);
                %----------------------------------------------  

                    d1 = abs(1-y(length(y)-1,1)/yd(1));
                    d2 = abs(1-y(length(y)-1,2)/yd(2));
                    d3 = abs(1-y(length(y)-1,3)/yd(3));    

                    differ(i,j)  = 100* (norm([d1 d2 d3 ],2)/3);
                %----------------------------------------------
                    end
                end
                
                hold on
            [sx,sy] = gradient(differ);
            x = ones(size(hs))'*hs;
            y = Hs'*ones(size(Hs));

             figure((seq1-1)*10+seq2);
               rect = [100, 100, 800, 560]; 
               
            surf(x,y,differ);%sqrt(sx.^2+sy.^2)); 
               view(2); colormap jet; shading interp; 
               cbh = colorbar; set(cbh,'FontSize',12,'FontWeight','bold');
               m3 = max(max(differ));%sqrt(sx.^2+sy.^2)));
              % h = plot3(x,y,m3*ones(size(x)),'w-');
              %plot arrows
              % set(h,'LineWidth',2.0);
              % set(h,'Color','w','LineWidth',1.5);
               axis equal; axis tight; axis ij;
               axis([min(hs) max(hs) min(Hs) max(Hs)]);
               xlabel('x (\mum)','FontSize',12,'FontWeight','bold'); ylabel('y (\mum)','FontSize',12,'FontWeight','bold');
               set(gca,'FontSize',12,'FontWeight','bold'); box on;
               title('Constrained FTTC: Neo Hookean','FontSize',12,'FontWeight','bold');

            %[u,v,w] = surfnorm(x,y,differ);
            %quiver3(x,y,differ,u,v,w); hold on, surf(x,y,differ), hold off

            Hinit = -110-seq1*100;
            Hfinal = Hinit + 100;

            hinit = 10+seq2*100;
            hfinal = hinit + 100;

                if (OptVal > min(min(differ)))
                    save = [seq1,seq2];
                    [OptVal,I1] = min(min(differ));
                    [junk,I2] = min(min(differ(I1,:)));
                end
        end
end
