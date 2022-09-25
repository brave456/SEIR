% Information dissemination laws under different network structures

function RPSEIR1()

% Import Matrix
load data3.mat; 
A;
Graph=A;

% Setting probability
alpha=0.3;  
beta=0.7;  
gamma=0.3;  

% Build State_list matrix is used to mark the status of each node
M=max(size(A(:,2)));  
State_list = [1:M;zeros(3, M)]';

cycleNum = 50;                     
time = 20;  

% To eliminate the influence of random factors
for i0 = 1 : cycleNum  

    State_list(:,2) = 5;   
    State_list(923,2) = 1;

    I_sum = 1;
    S_SUM = zeros(time,1);
    E_SUM = zeros(time,1);
    I_SUM = zeros(time,1);
    R_SUM = zeros(time,1);

    for i1=1:time    
        I_ID=[];                 
        I_ID = find(State_list(:,2) == 1);   
       
        for i = 1:length(I_ID);  
            I_i = I_ID(i);       

            neighbor_ID=[];     
            neighbor_State=[]; 
            S_ID=[];             
            E_ID=[];            
            neighbor_ID = find(Graph(I_i,:) == 1);   
            neighbor_State = State_list(neighbor_ID,:);         
            S_ID = neighbor_State(neighbor_State(:,2) == 5);    
            E_ID = neighbor_State(neighbor_State(:,2) == 2);   

            for ii = 1:length(S_ID)
                S_i=[];
                S_i = S_ID(ii);
                if (rand <= alpha);
                    State_list(S_i,2) = 2;
                else
                    State_list(S_i,2) = 1;
                end
            end

            for ii = 1:length(E_ID)
                E_i=[];
                E_i = E_ID(ii);
                if (rand <= beta);
                    State_list(E_i,2) = 1;
                else
                    State_list(E_i,2) = 3;
                end
            end

            if (rand <= gamma );
               State_list(I_i,2) = 3;
            end 
        end
        
        % Statistics of nodes in various states  
        idx5 = find(State_list(:,2) == 5);       
        S_sum = size(idx5,1);                    
        S_SUM(i1,1) =S_sum;
        S_SUM_P=S_SUM/M;
        S_matrix(:,i0) = S_SUM_P;

        idx2 = find(State_list(:,2) == 2);
        E_sum = size(idx2,1);
        E_SUM(i1,1) =E_sum;
        E_SUM_P=E_SUM/M;
        E_matrix(:,i0) = E_SUM_P;

        idx1=[];
        idx1 = find(State_list(:,2) == 1);
        I_sum = size(idx1,1);
        I_SUM(i1,1) =I_sum;
        I_SUM_P=I_SUM/M;
        I_matrix(:,i0) = I_SUM_P;

        idx3 = find(State_list(:,2) == 3);
        R_sum = size(idx3,1);
        R_SUM(i1,1) =R_sum;
        R_SUM_P=R_SUM/M;
        R_matrix(:,i0) = R_SUM_P;

    end
end
       S_final_matrix = sum(S_matrix,2)/cycleNum;
       E_final_matrix = sum(E_matrix,2)/cycleNum;
       I_final_matrix = sum(I_matrix,2)/cycleNum;
       R_final_matrix = sum(R_matrix,2)/cycleNum;
       
    % Place four curves in one diagram
    plot([1:time],E_final_matrix,'^-','color',[235/255 120/255 15/255],'linewidth',2,'MarkerEdgeColor',[235/255 120/255 15/255],'MarkerFaceColor',[235/255 120/255 15/255]);hold on;
    plot([1:time],E_final_matrix,'v-','color',[150/255 150/255 150/255],'linewidth',2,'MarkerEdgeColor',[150/255 150/255 150/255],'MarkerFaceColor',[150/255 150/255 150/255]);hold on;
    plot([1:time],I_final_matrix,'o-','color',[72/255 118/255 255/255],'linewidth',2,'MarkerEdgeColor',[72/255 118/255 255/255],'MarkerFaceColor',[72/255 118/255 255/255]);hold on;
    plot([1:time],R_final_matrix,'s-','color',[46/255 139/255 87/255],'linewidth',2,'MarkerEdgeColor',[46/255 139/255 87/255],'MarkerFaceColor',[46/255 139/255 87/255]);hold on;
    axis([1 time 0 1])
    xlabel('t','FontAngle','italic','Fontname', 'Times New Roman','FontWeight','normal','FontSize',20);
    set(gca,'FontName','Times New Roman','FontWeight','demi','FontSize',10)
    ylabel('\rho','FontAngle','italic','Fontname', 'Times New Roman','FontWeight','normal','FontSize',20);
    set(gca,'FontName','Times New Roman','FontWeight','demi','FontSize',10)
    legend('the unknown nodes','the known nodes','the infected nodes','the immune nodes',0);
    hold on;
end
