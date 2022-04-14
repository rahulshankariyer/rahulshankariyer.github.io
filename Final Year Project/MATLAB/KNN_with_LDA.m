%Initialization

%Size of the table

n = input('Enter the number of values:');

%Number of good samples and bad samples

g = 0;
b = 0;

%Totals for good samples

totalX1g = 0;
totalX2g = 0;

%Totals for bad samples

totalX1b = 0;
totalX2b = 0;

%Totals for all samples

totalX1 = 0;
totalX2 = 0;

%Total vector for good and bad samples

Good = [];
Bad = [];

%Difference between the values of each sample and the total mean

G0 = [];
B0 = [];

for i = 1 : n
    
    %Samples
    
    value(i).X1 = input('Acid Durability:');
    value(i).X2 = input('Strength:');
    value(i).Y = input('Classification:','s');
    
%Computation
    
    %When the classification of the sample is good
    
    if strcmp(value(i).Y,'good') == 1
        
        g = g + 1;
        totalX1g = totalX1g + value(i).X1;
        Good(g,1) = value(i).X1;
        totalX2g = totalX2g + value(i).X2;
        Good(g,2) = value(i).X2;
        
    %When the classification of the sample is bad
    
    elseif strcmp(value(i).Y,'bad') == 1
        
        b = b + 1;
        totalX1b = totalX1b + value(i).X1;
        Bad(b,1) = value(i).X1;
        totalX2b = totalX2b + value(i).X2;
        Bad(b,2) = value(i).X2;
        
    end
    
    %Totals for each sample
    
    totalX1 = totalX1 + value(i).X1;
    totalX2 = totalX2 + value(i).X2;
    
end

%Averages for good samples

avgX1g = totalX1g / g;
avgX2g = totalX2g / g;

%Averages for bad samples

avgX1b = totalX1b / b;
avgX2b = totalX2b / b;

%Averages for all samples

avgX1 = totalX1 / n;
avgX2 = totalX2 / n;

%Mean vector for good samples and bad samples

G = [avgX1g avgX2g];
B = [avgX1b avgX2b];

%Difference between the values of each good sample and the total mean

for i = 1 : g
    
    G0(i,1) = Good(i,1) - avgX1;
    G0(i,2) = Good(i,2) - avgX2;
    
end

%Difference between the values of each bad sample and the total mean

for i = 1 : b
    
    B0(i,2) = Bad(i,2) - avgX2;
    B0(i,2) = Bad(i,2) - avgX2;
    
end

%Covariance Matrices

CovG = (G0' * G0) / g;
CovB = (B0' * B0) / b;

%Pooled Covariance Matrix

Cov = ((g * CovG) + (b * CovB)) / (g + b);

%Linear Model Coefficient vector

Beta = (G - B) / Cov;

%Input new sample

values.X1 = input('Acid Durability:');
values.X2 = input('Strength:');

%Sample Vector

I = [values.X1 values.X2];

%Classification

A = (I - ((G + B) / 2)) * Beta';
C = -log(g / b);

if(A > C)
    
    values.Y = 'good';
    
else
    
    values.Y = 'bad';
    
end

%Output

display('The classification of the given data is:');
display(values.Y);

