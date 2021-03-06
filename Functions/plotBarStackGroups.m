function fig = plotBarStackGroups(stackData, groupLabels)
%% Plot a set of stacked bars, but group them according to labels provided.
%%.
%% Params: 
%%      stackData is a 3D matrix (i.e., stackData(i, j, k) => (Group, Stack, StackElement)) 
%%      groupLabels is a CELL type (i.e., { 'a', 1 , 20, 'because' };)
%%
%% Copyright 2011 Evan Bollig (bollig at scs DOT fsu ANOTHERDOT edu
%%
%% 
NumGroupsPerAxis = size(stackData, 1);
NumStacksPerGroup = size(stackData, 2);

FontSizeValues = 12;
% Count off the number of bins
groupBins = 1:NumGroupsPerAxis;
MaxGroupWidth = 0.80; % Fraction of 1. If 1, then we have all bars in groups touching
groupOffset = MaxGroupWidth/NumStacksPerGroup;
fig = figure('units','normalized','outerposition',[0 0 1 1]);
    hold on; 
for i=1:NumStacksPerGroup

    Y = squeeze(stackData(:,i,:));
    
    % Center the bars:
    internalPosCount = i - ((NumStacksPerGroup+1) / 2);
    
    % Offset the group draw positions:
    groupDrawPos = (internalPosCount)*groupOffset + groupBins;
    
    h(i,:) = bar(Y, 'stacked');
    set(h(i,:),'BarWidth',groupOffset);
    set(h(i,:),'XData',groupDrawPos);
    h(i,2).FaceColor = h(i,:).FaceColor;
    h(i,2).FaceAlpha = 0.65;
    h(i,2).LineStyle = '--';
    xtips2 = h(i,2).XEndPoints;
    ytips2 = h(i,2).YEndPoints;
    labels2 = string(h(i,2).YData + h(i,1).YData);
    text(xtips2,ytips2,labels2,'HorizontalAlignment','center',...
        'VerticalAlignment','bottom','FontSize', FontSizeValues)
    
end
    
hold off;
grid on;
set(gca,'FontSize',20);
ylabel('Execution Time [ms]','FontSize',20);
set(gca,'yscale','log');
set(gca,'XTickMode','manual');
set(gca,'XTick',1:NumGroupsPerAxis);
set(gca,'XTickLabelMode','manual');
set(gca,'XTickLabel',groupLabels);
end 
