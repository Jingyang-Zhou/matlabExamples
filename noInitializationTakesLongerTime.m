% compare speed between with or without initialization

numConditions = 7;

for clength = 1 : numConditions
    
    %% with initialization
    
    
    withInitRsp = zeros(1000, 1000, 2^clength);
    
    tic;
    for k = 1 : size(withInitRsp, 2)
        for k1 = 1 : size(withInitRsp, 3)
            withInitRsp (:, k, k1) = k * k1 + 1;
        end
    end
    initTime(clength) = toc;
    
    %% without initialization
    
    
    for k = 1 : size(withInitRsp, 2)
        for k1 = 1 : size(withInitRsp, 3)
            withoutInitRsp (:, k, k1) = k * k1 + 1;
        end
    end
    noInitTime(clength) = toc;
end

figure (100), clf
plot(initTime), hold on
plot(noInitTime), 
legend('initTime', 'noInitTime')
set(gca, 'xTick', 1: numConditions, 'xTickLabel', 1 : numConditions)
xlabel('nth condition')
ylabel('time (s)')
title('No initialization takes longer')