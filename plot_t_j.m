clear all 
close all

load data t j xi

global A B H
A = [0,1;
     0,0];
B = [0;1];
H = eye(2);
run('Hc.init_Hc.m')
run('Ho.init.m')

out1 = zeros(size(t));
out2 = zeros(size(t));
out3 = zeros(size(t));
outc = zeros(size(t));

for i = 1:1:length(t)
    x = xi(i,1:2);
    hx = xi(i,3:4);
    eta = xi(i,5);
    xs = xi(i,6:7);
    hx1 = xi(i,8:9);
    hx2 = xi(i,10:11);
    tau = xi(i,12);
    q = xi(i,13);
    
    out1(i) = (tau >= tau_max) && (q < q_max);
    out2(i) = (norm(xs-hx1) >= delta);
    out3(i) = (tau >= tau_max) && (q == q_max);
    outc(i) = (eta <= lb_c);
end

%j v.s. sampled t
sc_j = out2 + out3;
cp_j = outc;

%j~=0 v.s. sampled t
sc_j_1 = find(sc_j~=0);
cp_j_1 = find(cp_j~=0);

%t v.s. sampled t
sc_t = t(sc_j_1);
cp_t = t(cp_j_1);

%inter t v.s. t
sc_inter = sc_t - [0;sc_t(1:end-1)];
cp_inter = cp_t - [0;cp_t(1:end-1)];

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

COLOURS=get(gca,'colororder');
blue=COLOURS(1,:);
red=COLOURS(2,:);
yellow=COLOURS(3,:);
purple=COLOURS(4,:);
green=COLOURS(5,:);
light_blue=COLOURS(6,:);
dark_red=COLOURS(7,:);
grey=0.3*ones(3,1);

lineWidth=1.5;
xlim=[0,10];
markerSize=1.5;

%sensor-controller channel
for i = 1:1:length(sc_t)
    if i == 1
        h1 = plot([sc_t(i) sc_t(i)],[0 sc_inter(i)],'LineWidth',lineWidth,'LineStyle','-.','Color',blue);
    else
        plot([sc_t(i) sc_t(i)],[0 sc_inter(i)],'LineWidth',lineWidth,'LineStyle','-.','Color',blue);
    end
hold on;
plot(sc_t(i),sc_inter(i),'o','Color',blue,'LineWidth',lineWidth,'MarkerSize',markerSize);
end

%controller-plant channel
for i = 1:1:length(cp_t)
    if i == 1
        h2 = plot([cp_t(i) cp_t(i)],[0 cp_inter(i)],'LineWidth',lineWidth,'LineStyle','-','Color',red);
    else
        plot([cp_t(i) cp_t(i)],[0 cp_inter(i)],'LineWidth',lineWidth,'LineStyle','-','Color',red);
    end
hold on;
plot(cp_t(i),cp_inter(i),'o','Color',red,'LineWidth',lineWidth,'MarkerSize',markerSize);
end

grid on
ylim = [0 max(max(sc_inter),max(cp_inter))];
ylim = enlarge(ylim,1.1);
ylim(1) = 0;
xticks = ([0 1 2 3 4 5 6 7 8 9 10]);
xticklabels({'0','1','2','3','4','5','6','7','8','9','10'})
set(gca,'xlim',xlim,'ylim',ylim)

xlabel('$t\,[s]$','fontsize',12)
ylabel('$\text{inter-transmission times}\,[s]$','fontsize',12)
ax = gca;
ax.FontSize = 12;

lineWidththin=0.5;
%draw rectangle
plot([6 6.1],[0 0],'Color',grey,'LineWidth',lineWidththin);hold on;
plot([6 6],[0 0.02],'Color',grey,'LineWidth',lineWidththin);hold on;
plot([6.1 6.1],[0 0.02],'Color',grey,'LineWidth',lineWidththin);hold on;
plot([6 6.1],[0.02 0.02],'Color',grey,'LineWidth',lineWidththin);
line([5.71 6],[0.5 0],'Color',grey,'LineWidth',lineWidththin)
line([9.53 6.1],[0.5 0],'Color',grey,'LineWidth',lineWidththin)

leg=legend([h1 h2],{'s-c channel','c-p channel'},'fontsize',12);
legend('boxoff')
leg.Orientation='vertical';
set(leg,...
    'Location','northeast')
pos = leg.Position;
set(leg,...
    'Position',pos+[-0.15 -0.1 0 0.1])

%mini pic
axes('Position',[.59 .34 .35 .275]);
for i = 1:1:length(cp_t)
    if i == 1
        h2 = plot([cp_t(i) cp_t(i)],[0 cp_inter(i)],'LineWidth',lineWidth,'LineStyle','-','Color',red);
    else
        plot([cp_t(i) cp_t(i)],[0 cp_inter(i)],'LineWidth',lineWidth,'LineStyle','-','Color',red);
    end
hold on;
plot(cp_t(i),cp_inter(i),'o','Color',red,'LineWidth',lineWidth,'MarkerSize',markerSize);
end
ax = gca;
set(ax,'xlim',[6 6.1],'ylim',[0 0.02])
ax.FontSize = 12;
grid on

matlabfrag2('sims_t_j')