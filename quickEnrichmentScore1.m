function [ES,ESUP,ESDOWN] = quickEnrichmentScore1(S,S1,List,order,display)

Or_list = List;


[List,Rank] = sort(List,order);
N = length(Rank);
Nh = length(S);


tmp = ismember(Rank,S);

hitCases = cumsum(tmp);
missCases = cumsum(1-tmp);
NR = length(S);
Phit = hitCases/NR;
Pmiss = missCases/(N-Nh);

[m,t] = max(abs(Phit - Pmiss));
ESUP = Phit(t)-Pmiss(t);
RS = Phit-Pmiss;

if display
    subplot(2,1,1);

    plot(0:N,[0 Phit-Pmiss]);
    hold on
    plot([0,N],[0 0],'--','color',[.502,.502,.502]);

    set(gca,'xlim',[0,N]);
    title('Running Sum');
    set(gca,'ylim',[-1,1]);
    subplot(2,1,2);
    concolmap1(List,Rank,S);
end




[Or_list,Rank] = sort(Or_list,order);
N = length(Rank);
Nh = length(S1);


tmp = ismember(Rank,S1);

hitCases = cumsum(tmp);
missCases = cumsum(1-tmp);
NR = length(S1);
Phit = hitCases/NR;
Pmiss = missCases/(N-Nh);

[m,t] = max(abs(Phit - Pmiss));
ESDOWN = Phit(t)-Pmiss(t);
RS = Phit-Pmiss;

if display
    subplot(2,1,1);

    plot(0:N,[0 Phit-Pmiss],'r');
    hold on
    plot([0,N],[0 0],'--','color',[.502,.502,.502]);

    set(gca,'xlim',[0,N]);
    title('Running Sum');
    set(gca,'ylim',[-1,1]);
    subplot(2,1,2);
    concolmap1(List,Rank,S1);
    hold off
end

ES = (ESUP - ESDOWN)/2;
end




function concolmap1(data,Rank,S)



minn = min(min(data));
maxx = max(max(data));



colormap(hsv(256));


if minn && maxx
        data = (data - minn)./(maxx-minn);    
else
    if length(data)>1
        data = (data - min(min(data)))./(max(max(data))-min(min(data)));
    end
end

data = data*256;


itx = find(ismember(Rank,S));

data(itx) = 256 -data(itx);

h = image(data);

set(gca,'xticklabel',[]);
set(gca,'yticklabel',[]);

set(gca,'position',[0.1300    0.4    0.7750    0.1]);





end