X = [1 1;1.5 1.5; 0.5 1.5; 2 1.5; 1 2; 1 2.5; 1.5 2; 3.5 1.5; 4 2; 3.5 2.5; ...
    3.5 3; 3 3; 3 3.5; 4 3; 4 4];
opts = statset('Display','final');

[idx,ctrs] = kmeans(X,2);
 
plot(X(idx==1,1),X(idx==1,2),'r.','MarkerSize',12)
hold on
plot(X(idx==2,1),X(idx==2,2),'b.','MarkerSize',12)
plot(ctrs(:,1),ctrs(:,2),'kx',...
     'MarkerSize',12,'LineWidth',2)
plot(ctrs(:,1),ctrs(:,2),'ko',...
     'MarkerSize',12,'LineWidth',2)
legend('Cluster 1','Cluster 2','Centroids',...
       'Location','NW')
   
axis([0,6,0,6]);