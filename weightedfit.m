% generate data
x = 0:.1:10;
y = x.*x + randn(size(x));
w = linspace(.5, .7,length(x));
x = x(:);
y = y(:);
w = w(:);
%plot data
plot(x,y,'.');
%fit
ft = fittype('poly2');
cf = fit(x,y,ft,'Weight',w);
% Plot fit
hold on
plot(cf,'fit',0.95);