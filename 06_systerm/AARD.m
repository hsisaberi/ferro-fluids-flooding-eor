function [a, AARD]=AARD(target,output)
%     N=numel(target);
%     q=100/N;
%     o=zeros(1,N);
%     for i=1:N
%         w=(target(i)-output(i))/(target(i));
%         o(i)=w;
%     end
%     a=abs(sum(o));
%     a=q*a;
    a=1;
    find_target_zero = find(target==0);
    target(find_target_zero)=[];
    
    output(find_target_zero)=[];
    
    
    N=numel(target);
    AARD=100/N*sum(abs((target-output)./target));
    
end