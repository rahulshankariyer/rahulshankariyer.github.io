%Initialization

%Size of the matrix

x = input('Enter the number of features');
y = input('Enter the number of training data sets');
z = input('Enter the number of testing data sets');

%Number of good samples and bad samples

for i = 1 : z

    g(i) = 0;
    b(i) = 0;

end

%Totals for all samples

for i = 1 : z

    for j = 1 : x

        total(i,j) = 0;

    end
    
end

%Number of true values

t = 0;

%Training Data Sets

for i = 1 : y
    
    for j = 1 : x
        
        A(i,j) = input('Enter the value');
        
    end
    
    class(i).C = input('Enter the class');
    
end

%Testing Data Sets

for i = 1 : z
    
    for j = 1 : x
        
        B(i,j) = input('Enter the value');
        
    end
    
    classp(i).C = input('Enter the class');
    
end

for i = 1 : z
    
    classr(i).C = 0;
    
end

for i = 1 : y 
    
    if class(i).C == 1
        
        opp(i).C = 0;
        
    elseif class(i).C == 0
        
        opp(i).C = 1;
        
    end
    
end

for i = 1 : z
    
    for j = 1 : y
        
        for k = 1 : x
            
            distance(j,k,i) = B(i,k) - A(j,k);
            
        end
        
    end
    
end
            
for i = 1 : z
    
    for j = 1 : y
        
        d(i,j) = 0;
        
    end
    
end   
    
for i = 1 : z
    
    for j = 1 : y
        
        for k = 1 : x
            
            d(i,j) = d(i,j) + (distance(j,k,i) * distance(j,k,i));
            
        end
        
    end
    
end

for i = 1 : z
    
    for j = 1 : y
        
        for k = 1 : x
            
            D(j,k,i) = A(j,k);
            
        end
        
    end
    
end
        
for i = 1 : z
    
    for j = 1 : y - 1
        
        for k = i + 1 : y
        
            if(d(i,j) > d(i,k))

                temp1 = d(i,j);
                d(i,j) = d(i,k);
                d(i,k) = temp1;
                temp2 = class(j).C;
                class(j).C = class(k).C;
                class(k).C = temp2;
                temp3 = opp(j).C;
                opp(j).C = opp(k).C;
                opp(k).C = temp3;

                for m = 1 : x

                    temp3 = D(j,m,i);
                    D(j,m,i) = D(k,m,i);
                    D(k,m,i) = temp3;

                end
                
            end
            
        end
        
    end
    
end

k = input('Enter the number of neighbours');

%Computation

for i = 1 : z

    for j = 1 : k

        %When the classification of the sample is good

        if class(j).C == 1

            g(i) = g(i) + 1;   
            for l = 1 : x
                
                G(g(i),l,i) = D(j,l,i);

            end

        %When the classification of the sample is bad

        elseif class(j).C == 0

            b(i) = b(i) + 1;   
            for l = 1 : x
                
                B(b(i),l,i) = D(j,l,i);

            end

        end

        %Totals for each sample

        for l = 1 : x

            total(i,l) = total(i,l) + D(j,l,i);

        end

    end
    
end

for i = 1 : z

    for j = 1 : k

        for l = 1 : x

            Good(j,l,i) = D(j,l,i) * class(j).C;
            Bad(j,l,i) = D(j,l,i) * opp(j).C;

        end

    end
    
end

%Totals for good samples

for i = 1 : z

    for j = 1 : g(i)

        for l = 1 : x

            totalg(i,l) = totalg(i,l) + G(j,l,i);

        end

    end
    
end

%Totals for bad samples

for i = 1 : z
    
    for j = 1 : b(i)

        for l = 1 : x

            totalb(i,l) = totalb(i,l) + B(j,l,i);

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

        avg(i,j) = total(i,j) / k;

    end
    
end

%Difference between the values of each sample and the total mean

for i = 1 : z

    for j = 1 : k

        for l = 1 : x

            G0(j,l,i) = Good(j,l,i) - avg(i,l);
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

for i = 1 : z
    
    for j = 1 : x

        ZG(i) = (-0.5 * ((B(i,j) - avgg(i,j)) / CovG(:,:,i)) * (B(i,j) - avgg(i,j))') - (0.5 * log(det(CovG(:,:,i)))) + log(g(i) / k);
        ZB(i) = (-0.5 * ((B(i,j) - avgb(i,j)) / CovB(:,:,i)) * (B(i,j) - avgb(i,j))') - (0.5 * log(det(CovB(:,:,i)))) + log(b(i) / k);

        if(ZG(i) > ZB(i))

            classr(i).C = 1;

        else

            classr(i).C = 0;

        end
        
    end
    
end

for i = 1 : z
    
    if classp(i).C == classr(i).C
        
        t = t + 1;
        
    end
    
end

Accuracy = t / z;
Accuracy_Percentage = Accuracy * 100;