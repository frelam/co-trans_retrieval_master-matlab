function [ Results, f] = Label_Propogation_N(TEMP, P, WINDOWS, Co_Sample)
Num_LP = 5000;
f=zeros(WINDOWS, 1);
%------------------ Learning the distance-------------------------
for i = 1:length( Co_Sample )    % set value of the index equaling Co_Sample to 1
    k = find( TEMP == Co_Sample(i) );
    f(k) = 1;
end
for k = 1:Num_LP
    f = P*f;
    for i = 1:length( Co_Sample )    % set value of the index equaling Co_Sample to 1
        d = find( TEMP == Co_Sample(i) );
        f(d) = 1;
    end
end
[ TT, TEMP_R] = sort(f,'descend');
Results = TEMP( TEMP_R );