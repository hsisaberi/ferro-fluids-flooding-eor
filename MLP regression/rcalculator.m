function r=rcalculator(inputvar,targetvar)

    n=numel(inputvar);
    r1=0;
    for i=1:n
        r1=(inputvar(i)-mean(inputvar))*(targetvar(i)-mean(targetvar))+r1;
    end

    r2=0;
    for i=1:n
        r2=(((inputvar(i)-mean(inputvar))^2)*((targetvar(i)-mean(targetvar)))^2)^(1/2)+r2;
    end

    r=r1/r2;
    
end