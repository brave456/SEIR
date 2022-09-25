clc,clear

% NW network
N=100;
k=8;
p=0.0004;
t=0:2*pi/N:2*pi-2*pi/N;
x=100*sin(t);
y=100*cos(t);
plot(x,y,'ko','MarkerEdgeColor','k','MarkerFaceColor','r','markersize',6);

% Adjacency matrix initialization
A=zeros(N);  
for i=1:N  
    for j=i+1:i+k/2  
        jj=(j<=N)*j+(j>N)*mod(j,N);
        A(i,jj)=1;
        A(jj,i)=1;
    end
end
B=rand(N);
% Intercept the lower triangle
B=tril(B);
C=zeros(N);
C(B>=1-p)=1;

 % Complete adjacency matrix
C=C+C';  
A=A|C;
for i=1:N-1
    for j=i+1:N
        if A(i,j)~=0
            plot([x(i),x(j)],[y(i),y(j)],'linewidth',1.2);
        end
    end
end
A;

% Average degree of network nodes
deg=sum(A);  
ave_degree=sum(deg)/N;

% Draw the histogram of each node degree
figure, bar([1:N],deg);
title('Degree of each node in the network diagram');
xlabel('$v_{i}$','Interpreter','Latex'), ylabel('$k$','Interpreter','Latex')

% Degree distribution diagram of network nodes
degrange=minmax(deg);
pinshu=hist(deg,[degrange(1): degrange(2)]);
df=pinshu/N;
figure, bar([degrange(1):degrange(2)],df,'r')
title('Degree distribution of network graph');
xlabel('$k$','Interpreter','Latex'), ylabel('$P$','Interpreter','Latex')

% Number of network sides
A;
number=length(find(A))/2;

% Clustering coefficient
a=A;
n=length(a);
for i=1:n
    m=find(a(i,:));
    ta=a(m,m);
    Lta=tril(ta);
    if  length(m)==0 | length(m)==1
        c(i)=0;
    else
        c(i)=sum(sum(Lta))/nchoosek(length(m),2);
    end
end
TC=mean(c);

% Degree correlation coefficient
a=A;
d=sum(a);
M=sum(d)/2;
[i,j]=find(triu(a));
ki=d(i); kj=d(j);
r=(ki*kj'/M-(sum(ki+kj)/2/M)^2)/(sum(ki.^2+kj.^2)/2/M-(sum(ki+kj)/2/M)^2);

A;
save data.mat;
