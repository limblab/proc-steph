%plotLinearRnnPredExamples

x = 0:0.05:5990*.05-.05;

EMGind=1

start=100; stop = 120;
start=120; stop = 140;
start=140; stop = 160;
start=160; stop = 180;
start=180; stop = 200;
start=200; stop = 220;
start=50; stop = 70;
start=80; stop = 100;
start=90; stop = 110;
start=30; stop = 50;
start=40; stop = 60;
start=20; stop = 40;
start=250; stop = 270;
start=220; stop = 240;
start=260; stop = 280;
start=1; stop = 299;


calculateVAF(pred_hybrid_rnn_mm_Iso(start/.05:stop/.05,EMGind),actual_Iso(start/.05:stop/.05,EMGind))
calculateVAF(pred_hybrid_lin_Iso(start/.05:stop/.05,EMGind),actual_Iso(start/.05:stop/.05,EMGind))


calculateVAF(pred_hybrid_rnn_mm_Wm(start/.05:stop/.05,EMGind),actual_Wm(start/.05:stop/.05,EMGind))
calculateVAF(pred_hybrid_lin_Wm(start/.05:stop/.05,EMGind),actual_Wm(start/.05:stop/.05,EMGind))

calculateVAF(pred_hybrid_rnn_mm_Spr(start/.05:stop/.05,EMGind),actual_Spr(start/.05:stop/.05,EMGind))
calculateVAF(pred_hybrid_lin_Spr(start/.05:stop/.05,EMGind),actual_Spr(start/.05:stop/.05,EMGind))







% plot Iso
figure;hold on
plot(start:.05:stop,actual_Iso(start/.05:stop/.05,EMGind),'k')
plot(start:.05:stop,pred_hybrid_rnn_mm_Iso(start/.05:stop/.05,EMGind),'Color',[.5 0 .5])
plot(start:.05:stop,pred_hybrid_lin_Iso(start/.05:stop/.05,EMGind),'c')
RvafI=calculateVAF(pred_hybrid_rnn_mm_Iso(start/.05:stop/.05,EMGind),actual_Iso(start/.05:stop/.05,EMGind));
LvafI=calculateVAF(pred_hybrid_lin_Iso(start/.05:stop/.05,EMGind),actual_Iso(start/.05:stop/.05,EMGind));
legend('Actual', strcat('RNN: ', num2str(RvafI)), strcat('Linear: ', num2str(LvafI))); legend boxoff

% plot Spr
figure;hold on; ylim([0 1]);
plot(start:.05:stop,actual_Spr(start/.05:stop/.05,EMGind),'k')
plot(start:.05:stop,pred_hybrid_rnn_mm_Spr(start/.05:stop/.05,EMGind),'Color',[.7 0 .9])
plot(start:.05:stop,pred_hybrid_lin_Spr(start/.05:stop/.05,EMGind),'c')
Rvaf=calculateVAF(pred_hybrid_rnn_mm_Spr(start/.05:stop/.05,EMGind),actual_Spr(start/.05:stop/.05,EMGind))
Lvaf=calculateVAF(pred_hybrid_lin_Spr(start/.05:stop/.05,EMGind),actual_Spr(start/.05:stop/.05,EMGind))
legend('Actual', strcat('RNN: ', num2str(Rvaf)), strcat('Linear: ', num2str(Lvaf))); legend boxoff
set(findall(gcf, '-property', 'FontSize'), 'FontSize', 10,'Fontname','Arial')
set(findall(gcf,'type','text'),'fontSize',10,'fontWeight','bold','Fontname','Arial')
set(gca,'YTick',0:.2:1)

% plot Wm
figure;hold on; ylim([0 1]);
plot(start:.05:stop,actual_Wm(start/.05:stop/.05,EMGind),'k')
plot(start:.05:stop,pred_hybrid_rnn_mm_Wm(start/.05:stop/.05,EMGind),'Color',[.7 0 .9])
plot(start:.05:stop,pred_hybrid_lin_Wm(start/.05:stop/.05,EMGind),'c')
Rvaf=calculateVAF(pred_hybrid_rnn_mm_Wm(start/.05:stop/.05,EMGind),actual_Wm(start/.05:stop/.05,EMGind))
Lvaf=calculateVAF(pred_hybrid_lin_Wm(start/.05:stop/.05,EMGind),actual_Wm(start/.05:stop/.05,EMGind))
legend('Actual', strcat('RNN: ', num2str(Rvaf)), strcat('Linear: ', num2str(Lvaf))); legend boxoff
set(findall(gcf, '-property', 'FontSize'), 'FontSize', 10,'Fontname','Arial')
set(findall(gcf,'type','text'),'fontSize',10,'fontWeight','bold','Fontname','Arial')
set(gca,'YTick',0:.2:1)
xlabel('Time (in sec)')

%plot iso
figure;hold on; ylim([0 1]);
plot(start:.05:stop,actual_Iso(start/.05:stop/.05,EMGind),'k')
plot(start:.05:stop,pred_hybrid_rnn_mm_Iso(start/.05:stop/.05,EMGind),'Color',[.7 0 .9])
plot(start:.05:stop,pred_hybrid_lin_Iso(start/.05:stop/.05,EMGind),'c')
Rvaf=calculateVAF(pred_hybrid_rnn_mm_Iso(start/.05:stop/.05,EMGind),actual_Iso(start/.05:stop/.05,EMGind))
Lvaf=calculateVAF(pred_hybrid_lin_Iso(start/.05:stop/.05,EMGind),actual_Iso(start/.05:stop/.05,EMGind))
legend('Actual', strcat('RNN: ', num2str(Rvaf)), strcat('Linear: ', num2str(Lvaf))); legend boxoff
set(findall(gcf, '-property', 'FontSize'), 'FontSize', 10,'Fontname','Arial')
set(findall(gcf,'type','text'),'fontSize',10,'fontWeight','bold','Fontname','Arial')
set(gca,'YTick',0:.2:1)
xlabel('Time (in sec)')



