clc
clear
close all

M = csvread('./outputs/q5d.csv');
x = M(:,1);
y = (M(:,2));
Vth = 0.4;


%% Look for the best fit function
ft_nmos = fittype( 'nmos_sat (x,alpha,Vth,n)');
%f_nmos = fit( x, y, ft_nmos);
f_nmos = fit( x, y, ft_nmos, 'startpoint',[0.000817,Vth,1.268]);
%fitoptions('Method','linearLeastSquares');

%% Extract constansts and recontruct the functionu
alpha = f_nmos.alpha;
n = f_nmos.n;
Vth = f_nmos.Vth;
IDS = alpha.*(x-Vth).^(n);
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
plot(x,IDS*1e3,'--r','Linewidth',2);
xlabel("VGS [V]")
ylabel("IDS [mA]")
title("Saturation IDS Fit Comparison",'fontsize',24);
ax.XAxis.FontSize = 18;
ax.XAxis.FontName = 'times';
ax.YAxis.FontSize = 18;
ax.YAxis.FontName = 'times';
legend('Simulation Data',strcat('Fit Plot: \alpha = ',...
    string(1e3*alpha),' mA/V^n, Vth = ',string(Vth), ' n = ',string(n)),'Location','Northwest','Fontsize',14);