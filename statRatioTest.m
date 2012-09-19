
% Load data
x = load('ratioTestData1.txt');
y = load('ratioTestData2.txt');

% Calculates correlation coefficients
rodN = corrcoef(x(:,3),y(:,3));
rodS = corrcoef(x(:,5),y(:,5));

% Takes just a number
rodN = rodN(1,2);
rodS = rodS(1,2);


% Draw dN scatter
xlabel('dN[x]'); hold on;
ylabel('dN[y]');
scatter(x(:,3),y(:,3));
print -dpng dNplot.png;
hold off;

% Draw dS scatter
xlabel('dS[x]'); hold on;
ylabel('dS[y]');
scatter(x(:,5),y(:,5));
print -dpng dSplot.png;
hold off;

% Mean, standar desviation and variance
% N mean
xdNmean = sum(x(:,3))
ydNmean = sum(y(:,3))

% S mean
xdSmean = sum(x(:,5))
ydSmean = sum(y(:,5))

% N Variance
xdNVar = sum(x(:,4))
ydNVar = sum(y(:,4))

% S Variance
xdSVar = sum(x(:,6))
ydSVar = sum(x(:,6))

% N Standar Deviation
xdNSE = sqrt(xdNVar)
ydNSE = sqrt(ydNVar)

% S Standar Deviation
xdSSE = sqrt(xdSVar)
ydSSE = sqrt(xdSVar)

%-----------------
% Calculates R[N]
RdN = xdNmean/ydNmean

% Calculates R[S]
RdS = xdSmean/ydSmean

% Estimates Var(R[N])
VarRdN = (1/ydNmean^2)*(xdNVar+RdN^2*ydNVar-2*RdN*rodN*xdNSE*ydNSE)


% Estimates Var(R[S])
VarRdS = (1/ydSmean^2)*(xdSVar+RdS^2*ydSVar-2*RdS*rodS*xdSSE*ydSSE)

% Z stats
zdN = (RdN-1)/sqrt(VarRdN)
zdS = (RdS-1)/sqrt(VarRdS)

% p-values


% Store in a row
fid = fopen('temp_matlab_data','w');
fprintf(fid,'rodN\trodS\tRdN\tVarRdN\tRdS\tVarRdS\tzdN\tzdS\n');
fprintf(fid,'%.4f\t%.4f\t%.4f\t%d\t%.4f\t%.4f\t%.4f\t%.4f\n',rodN,rodS,RdN,VarRdN,RdS,VarRdS,zdN,zdS);
fclose(fid);

