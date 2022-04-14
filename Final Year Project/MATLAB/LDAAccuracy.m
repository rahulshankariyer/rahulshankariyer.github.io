%Initialization

%Size of the matrix

x = input('Enter the number of features');
y = input('Enter the number of data sets');
z = input('Enter the number of testing data sets');

%Number of good samples and bad samples

for i = 1 : z

    g(i) = 0;
    b(i) = 0;

end

%Number of true values

t = 0;

%Totals for all samples

for i = 1 : z

    for j = 1 : x

        total(i,j) = 0;

    end
    
end

%Training Data Sets

for i = 1 : y
    
    for j = 1 : x
        
        A(i,j) = input('Enter the value');
        
    end
    
    class(i).C = input('Enter the class','s');
    
end

%Testing Data Sets

for i = 1 : z
    
    for j = 1 : x
        
        B(i,j) = input('Enter the value');
        
    end
    
    classp(i).C = input('Enter the class','s');
    
end 

for i = 1 : z
    
    classr(i).C = '';
    
end

%Computation

for i = 1 : z

    for j = 1 : y

        %When the classification of the sample is good

        if strcmp(class(j).C,'good') == 1

            g(i) = g(i) + 1;
            for l = 1 : x
                
                Good(g(i),l,i) = A(j,l);

            end

        %When the classification of the sample is bad

        elseif strcmp(class(j).C,'bad') == 1

            b(i) = b(i) + 1;
            for l = 1 : x
                
                Bad(b(i),l,i) = A(j,l);

            end

        end

        %Totals for each sample

        for l = 1 : x

            total(i,l) = total(i,l) + A(j,l);

        end

    end
    
end

%Totals for good samples

for i = 1 : z

    for j = 1 : g(i)

        for l = 1 : x

            totalg(i,l) = totalg(i,l) + Good(j,l,i);

        end

    end
    
end

%Totals for bad samples

for i = 1 : z
    
    for j = 1 : b(i)

        for l = 1 : x

            totalb(i,l) = totalb(i,l) + Bad(j,l,i);

        end
        
    end
    
end

%Averages for good samples

for i = 1 : z

    for j = 1 : x

        avgg(i,j) = totalg(i,j) / g(i);

    end
    
end

%Averages for bad samples

for i = 1 : z

    for j = 1 : x

        avgb(i,j) = totalb(i,j) / b(i);

    end
    
end

%Averages for all samples

for i = 1 : z

    for j = 1 : x

        avg(i,j) = total(i,j) / y;

    end
    
end

%Difference between the values of each good sample and the total mean

for i = 1 : z

    for j = 1 : g(i)

        for l = 1 : x

            G0(j,l,i) = Good(j,l,i) - avg(i,l);

        end

    end
    
end

%Difference between the values of each bad sample and the total mean

for i = 1 : z

    for j = 1 : b(i)

        for l = 1 : x

            B0(j,l,i) = Bad(j,l,i) - avg(i,l);

        end

    end
    
end

%Covariance Matrices

G00 = permute(G0,[2 1 3]);

for i = 1 : z

    CovG(:,:,i) = (G00(:,:,i) * G0(:,:,i)) / g(i);
    CovB(:,:,i) = (B00(:,:,i) * B0(:,:,i)) / b(i);

end

%Pooled Covariance Matrix

for i = 1 : z

	Cov(:,:,i) = ((g(i) * CovG(:,:,i)) + (b(i) * CovB(:,:,i))) / (g(i) + b(i));
    
end

%Linear Model Coefficient vector

for i = 1 : z
    
    for j = 1 : x

        Beta(:,:,i) = (avgg(i,j) - avgb(i,j)) / Cov(:,:,i);  
        
    end
    
end

%Classification

Beta0 = permute(Beta,[2 1 3]);

for i = 1 : z
    
    for j = 1 : x

        X(i) = (B(i,j) - ((avgg(i,j) + avgb(i,j)) / 2)) * Beta0(:,:,i);
        Y(i) = -log(g(i) / b(i));

        if(X(i) > Y(i))

            classr(i).C = 'good';

        else

            classr(i).C = 'bad';

        end
        
    end
    
end

for i = 1 : z
    
    if strcmp(classp(i).C,classr(i).C)
        
        t = t + 1;
        
    end
    
end

Accuracy = t / z;
Accuracy_Percentage = Accuracy * 100;