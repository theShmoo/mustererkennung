function [ w ] = mutliPerco( X,t,maxEpoches )

%% Initialise w,y

sX = size(X);

w = zeros(sX(1),size(unique(t),1));
C = 2; %Max Step Size
n = 0; %iteration of the epoche
failClass = true; %number of errors in one iteration

%%Iterate until all patterns correctly classified or maxEpoches is reached
while n < maxEpoches && failClass == true
    n = n + 1;
    failClass = false;
    
    for i = 1:sX(2)
        [~,index] = max(w'*X(:,i));
        %If it is not classified correctly
        if index ~= t(i)
            % Adjust the step size on the maximum amount of use the step
            % will make
            l = min((dot((w(:,index) - w(:,t(i))),X(:,i)) + 1)/dot(2*X(:,i),X(:,i)),C);
            assert(l > 0);
            % substract the feature vector from the wrong weight vector
            w(:,index) = w(:,index) - X(:,i)*l;
            % add the feature vecotr to the correct weight vector
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

