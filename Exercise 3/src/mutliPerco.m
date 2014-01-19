function [ w ] = mutliPerco( X,t,maxEpoches )

%% Initialise w,y

sX = size(X);

w = zeros(sX(1),size(unique(t),1));
l = 0.5; %Learningrate
n = 0; %iteration of the epoche
failClass = true; %number of errors in one iteration

assert(l > 0);

%%Iterate until all patterns correctly classified or maxEpoches is reached
while n < maxEpoches && failClass == true
    n = n + 1;
    failClass = false;
    
    for i = 1:sX(2)
        [~,index] = max(w'*X(:,i));
        if index ~= t(i)
            w(:,index) = w(:,index) - X(:,i)*l;
            w(:,t(i)) = w(:,t(i)) + X(:,i)*l;
            failClass = true;
            %l = l*exp(-n/10); Maybe make a better learing function
        end
    end
end

if failClass == false
   fprintf('The algorithm classified all patterns correctly at the epoche %d!\n',n) 
end


end

