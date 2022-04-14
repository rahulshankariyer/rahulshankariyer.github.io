%Initialization

%Size of the matrix

x = input('Enter the number of features');
y = input('Enter the number of data sets');

%Number of good samples and bad samples

g = 0;
b = 0;

%Totals for good samples

for i = 1 : x
    
    totalg(i) = 0;
    
end

%Totals for bad samples

for i = 1 : x
    
    totalb(i) = 0;
    
end

%Totals for all samples

for i = 1 : x
    
    total(i) = 0;
    
end

%Samples

for i = 1 : y
    
    for j = 1 : x
        
        A(i,j) = input('Enter the value');
        
    end
    
    class(i).C = input('Enter the class');
    
end

for i = 1 : y 
    
    if class(i).C == 1
        
        opp(i).C = 0;
        
    elseif class(i).C == 0
        
        opp(i).C = 1;
        
    end
    
end

%Input vector

for i = 1 : x
    
    I(i) = 0;
    
end

%Input new sample

for i = 1 : x
    
    a = input('Enter the value');
    I(i) = a;
    
end

k = input('Enter the number of neighbours');

for i = 1 : k
    
    %When the classification of the sample is good
    
    if class(i).C == 1
            
        g = g + 1;
        for j = 1 : x
                
            totalg(j) = totalg(j) + A(i,j);            
                
        end
            
    %When the classification of the sample is bad
        
    elseif class(i).C == 0
            
        b = b + 1;
        for j = 1 : x
                
            totalb(j) = totalb(j) + A(i,j);            
                
        end
            
    end
        
    %Totals for each sample
    
    for j = 1 : x
        
        total(j) = total(j) + A(i,j);
        
    end
        
end

for i = 1 : k
    
    for j = 1 : x
        
        Good(g,j) = A(i,j) * class(i).C;
        Bad(b,j) = A(i,j) * opp(i).C;
        
    end
    
end

%Averages for good samples

for i = 1 : x
    
    avgg(i) = totalg(i) / g;
    
end

%Averages for bad samples

for i = 1 : x
    
    avgb(i) = totalb(i) / b;
    
end

%Averages for all samples

for i = 1 : x
    
    avg(i) = total(i) / k;
    
end

%Difference between the values of each sample and the total mean

for i = 1 : k
    
    for j = 1 : x
        
        G0(i,j) = Good(i,j) - avg(j);
        B0(i,j) = Bad(i,j) - avg(j);
        
    end
    
end

%Covariance Matrices

CovG = (G0' * G0) / g;
CovB = (B0' * B0) / b;

%Pooled Covariance Matrix

Cov = ((g * CovG) + (b * CovB)) / (g + b);

%Linear Model Coefficient vector

Beta = (avgg - avgb) / Cov;

%Classification

ZG = (-0.5 * ((I - avgg) / CovG) * (I - avgg)') - (0.5 * log(det(CovG))) + log(g / k);
ZB = (-0.5 * ((I - avgb) / CovB) * (I - avgb)') - (0.5 * log(det(CovB))) + log(b / k);

if(ZG > ZB)
    
    display('The classification of the given data is good');
    
else
    
    display('The classification of the given data is bad');
    
end

