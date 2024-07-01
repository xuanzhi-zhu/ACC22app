clear all 
close all

load data t j xi

x_vec = xi(:,1:2);
hx_vec = xi(:,3:4);
xs_vec = xi(:,6:7);
xo1_vec = xi(:,8:9);
xo2_vec = xi(:,10:11);

layout = [1;1;1;1]*ones(1,8);
% h=create_axis(layout,15,...
%     'innerymargin',0.015,...
%     'botmargin',.13,...
%     'innerxmargin',0.06,...
%     'leftmargin',0.05);
h=create_axis(layout,18,...
    'innerymargin',0.018,...
    'botmargin',0.15,...
    'innerxmargin',0.015,...
    'leftmargin',0.05);
colors = get(gca,'colororder');
blue=colors(1,:);
red=colors(2,:);
yellow=colors(3,:);
purple=colors(4,:);
green=colors(5,:);
lineWidth = 1.5;
markerSize = 3;
% for I = 1:size(dirs,1)
%     lines = [lines plot(t,xi(:,dirs(I,:)),'color',colors(I,:))];
%     set(lines(end),'linestyle','--')
%     hold on
% end
% hold off
% legend(lines(1:2:8),{'$x$','$\hat{x}$','$\xs$','$\xo[1]$'},...
%     'location','southeast')

%1st component of: x,\hat{x},\xs,\xo[1]
plot(t,x_vec(:,2),'LineWidth',lineWidth,'LineStyle','-','Color',blue);hold on;
plot(t,hx_vec(:,2),'-*','MarkerEdgeColor',green,'LineWidth',lineWidth,'MarkerSize',markerSize,'Color',green);hold on;
plot(t,xs_vec(:,2),'LineWidth',lineWidth,'LineStyle','-.','Color',purple);hold on;
plot(t,xo1_vec(:,2),'LineWidth',lineWidth,'LineStyle','--','Color',red);hold on;
plot(t,xo2_vec(:,2),'LineWidth',lineWidth,'LineStyle',':','Color',yellow);

leg=legend({'$x_2$','$\widehat{x}_2$','$x_{s,2}$','$\widehat{x}_{1,2}$','$\widehat{x}_{2,2}$'},'fontsize',12);
legend('boxoff')
leg.Orientation='vertical';
set(leg,...
    'Location','northeast')
pos = leg.Position;
set(leg,...
    'Position',pos+[-0.15 -0.1 0 0.1])
grid on
xlim = [0,10];
ylim = [min([min(x_vec(:,2)),min(hx_vec(:,2)),min(xs_vec(:,2)),min(xo1_vec(:,2)),min(xo2_vec(:,2))]) max([max(x_vec(:,2)),max(hx_vec(:,2)),max(xs_vec(:,2)),max(xo1_vec(:,2)),max(xo2_vec(:,2))])];
ylim = enlarge(ylim,1.1);
xticks = ([0 1 2 3 4 5 6 7 8 9 10]);
xticklabels({'0','1','2','3','4','5','6','7','8','9','10'})
set(gca,'xlim',xlim,'ylim',ylim)
xlabel('$t\,[s]$','fontsize',12)
ax = gca; % current axes
ax.FontSize = 12;

matlabfrag2('sims_x2')