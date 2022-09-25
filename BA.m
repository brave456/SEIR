clc, clear

% BA network
m0=input('Please enter the number of network nodes before growth, m0: ');
m=input('Please enter the number of newly generated edges each time a new node is introduced, m£º ');
N=input('Please enter the total number of network nodes after growth, N£º ');
disp('Connection of m0 nodes in the initial network£º1 means all isolated points£»2 represents a complete diagram£»3 indicates random connection of some edges');
se=input('Please select the initial network condition 1, 2 or 3£º ');
if m>m0
    disp('Illegal input parameter m'); return;
end
x=100*rand(1,m0); y=100*rand(1,m0);
if se==1
    A=zeros(m0);
elseif se==2
    A=ones(m0); A(1:m0+1:m0^2)=0; 
else
    A=zeros(m0); B=rand(m0); B=tril(B);
    A(B<=0.1)=1;
    A=A+A';
end 
for k=m0+1:N
    x(k)=100*rand; y(k)=100*rand; 
    p=(sum(A)+1)/sum(sum(A)+1); 
    pp=cumsum(p); 
    A(k,k)=0; 
    ind=[];
    while length(ind)<m
        jj=find(pp>rand);
        jj=jj(1);
        ind=union(ind,jj);
    end
    A(k,ind)=1; A(ind,k)=1;
end
plot(x,y,'ro','MarkerEdgeColor','g','MarkerFaceColor','r','markersize',8);
hold on, A2=tril(A); [i,j]=find(A2); 
for k=1:length(i)
    plot([x(i(k)),x(j(k))],[y(i(k)),y(j(k))],'linewidth',1.2)
end

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
number=length(find(A))/2

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
