%Initialization

%Size of the matrix

x = input('Enter the number of features');
y = input('Enter the number of training data sets');

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

%Total vector for good and bad samples

Good = [];
Bad = [];

%Difference between the values of each sample and the total mean

G0 = [];
B0 = [];

%Input vector

for i = 1 : x
    
    I(i) = 0;
    
end

%Samples

for i = 1 : y
    
    for j = 1 : x 
        
        A(i,j) = input('Enter the value');    
        
    end
    
    class(i).C = input('Enter the class','s');
    
end

for i = 1 : y
    
    for j = 1 : x
        
        distance(i,j) = A(i,j) - I(j);
        
    end
    
end

for i = 1 : y
    
    d(i) = 0;
    
end

for i = 1 : y
    
    for j = 1 : x
        
        d(i) = d(i) + (distance(i,j) * distance(i,j));
        
    end
    
end

for i = 1 : y-1
    
    for j = i+1 : y
        
        if(d(i) > d(j))
            
            temp1 = d(i);
            d(i) = d(j);
            d(j) = temp1;
            temp2 = class(i).C;
            class(i).C = class(j).C;
            class(j).C = temp2;
            
            for m = 1 : x
                
                temp3 = A(i,m);
                A(i,m) = A(j,m);
                A(j,m) = temp3;
                
            end
            
        end       
                   
   end
    
end

k = input('Enter the number of neighbours');

%Computation

for i = 1 : k
    
    %When the classification of the sample is good
    
    if strcmp(class(i).C,'good') == 1
            
        g = g + 1;
        for j = 1 : x
                
            totalg(j) = totalg(j) + A(i,j);
            Good(g,j) = A(i,j);
                
        end
            
    %When the classification of the sample is bad
        
    elseif strcmp(class(i).C,'bad') == 1
            
        b = b + 1;
        for j = 1 : x
                
            totalb(j) = totalb(j) + A(i,j);
            Bad(b,j) = A(i,j);
                
        end
            
    end
        
    %Totals for each sample
    
    for j = 1 : x
        
        total(j) = total(j) + A(i,j);
        
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

%Difference between the values of each good sample and the total mean

for i = 1 : g
    
    for j = 1 : x
        
        G0(i,j) = Good(i,j) - avg(j);
        
    end
    
end

%Difference between the values of each bad sample and the total mean

for i = 1 : b
    
    for j = 1 : x
        
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

%Input new sample

for i = 1 : x
    
    a = input('Enter the value');
    I(i) = a;
    
end

%Classification

X = (I - ((avgg + avgb) / 2)) * Beta';
Y = -log(g / b);

if(X > Y)
    
    display('The classification of the given data is good');
    
else
    
    display('The classification of the given data is bad');
    
end





