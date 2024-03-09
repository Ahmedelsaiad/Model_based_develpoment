g=9.81;
inti_dis=0;
inti_velo=0.1;
mdl=gcs;
Lengthh=1:2:11;
for i=1:numel(Lengthh)
    L=Lengthh(i);
    res=sim(mdl);
    plot(res.logsout.get('displacement').Values);
    grid on;
    hold on ;
    lables{i}="L= "+num2str(L);
    
end
legend(lables);