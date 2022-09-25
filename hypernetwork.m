clc, clear

% hypernetwork
disp('The case where one hyperedge is generated each time');
m0=input('Please enter the number of network nodes before growth, m0: ');
m1=input('Please enter to generate hyperedges with m1 existing nodes each time a new node is introduced, m1£º ');
m=input('Please enter the number of newly generated edges each time a new node is introduced, m£º ');
N=input('Please enter the total number of network nodes after growth, N£º ');
disp('The connection of m0 nodes in the initial network is a complete graph');

if m>m0
    disp('The input parameter m is invalid'); return;
end

A=ones(m0); 
A(1:m0+1:m0^2)=0; 

for k=m0+1:N   
    C=k;  
    p=(sum(A)+1)/sum(sum(A)+1); 
    pp=cumsum(p); 
    A(k,k)=0;
    ind=[];
    while length(ind)<m1
        jj=find(pp>rand);
        jj=jj(1);
        ind=union(ind,jj);     
    end 
    
    ind; 
    gs=max(size(ind));
        for i=1:gs
            for j=1:gs
               if (ind(i)~=ind(j)) && (A(ind(i),ind(j))==0) && (A(ind(j),ind(i))==0)
                      A(ind(i),ind(j))=1;
                      A(ind(j),ind(i))=1;
               end 
            end
        end
    A(k,ind)=1; A(ind,k)=1;
end
A;
number=length(find(A))/2;
save data.mat;

