clc
clear
close all

M = csvread('./outputs/vsg.csv');
x = M(:,1);
y = (M(:,2));
Vth = 0.3852;


%% Look for the best fit function
ft_pmos = fittype( 'pmos_sat (x,alpha,Vth,n)');
%f_nmos = fit( x, y, ft_nmos);
f_pmos = fit( x, y, ft_pmos, 'startpoint',[0.0008599,Vth,1.388]);
%fitoptions('Method','linearLeastSquares');

%% Extract constansts and recontruct the functionu
alpha = f_pmos.alpha;
n = f_pmos.n;
Vth = f_pmos.Vth;
ISD = alpha.*(x-Vth).^(n);
figure(1)
x0=10;
y0=10;
width=1100;
height=400;
set(gcf,'position',[x0,y0,width,height])
font = 12;
alw = 1.8;
fsz = 10;
lw = 2.5; %Linewidth
msz = 8;
ax = subplot(1,1,1);
plot(M(:,1),M(:,2)*1e3,'b','Linewidth',2);
hold on
grid on
plot(x,ISD*1e3,'--r','Linewidth',2);
xlabel("VSG [V]")
ylabel("ISD [mA]")
title("Saturation ISD Fit Comparison",'fontsize',24);
ax.XAxis.FontSize = 18;
ax.XAxis.FontName = 'times';
ax.YAxis.FontSize = 18;
ax.YAxis.FontName = 'times';
legend('Simulation Data',strcat('Fit Plot: \alpha = ',...
    string(1e3*alpha),' mA/V^n, Vth = ',string(Vth), ' n = ',string(n)),'Location','Northwest','Fontsize',14);