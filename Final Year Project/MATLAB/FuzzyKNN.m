%Initialization

%Size of the matrix

x = input('Enter the number of features');
y = input('Enter the number of data sets');

Xg = 0;
Xb = 0;
Y = 0;

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
    
    I(i) = input('Enter the value');
    
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
            temp3 = opp(i).C;
            opp(i).C = opp(j).C;
            opp(j).C = temp3;
            
            for m = 1 : x
                
                temp3 = A(i,m);
                A(i,m) = A(j,m);
                A(j,m) = temp3;
                
            end
            
        end
        
    end
    
end

k = input('Enter the number of neighbours');

for i = 1 : k
        
        Xg = Xg + (class(i).C / d(i));    
        Xb = Xb + (opp(i).C / d(i));
        Y = Y + (1 / d(i));
    
end

Zg = Xg / Y;
Zb = Xb / Y;

if Zg > Zb
    
    display('The classification of the given data is good');
    
elseif Zb > Zg
    
    display('The classification of the given data is bad');
    
else
    
    if class(1).C == 1
        
        display('The classification of the given data is good');
        
    elseif class(1).C == 0
        
        display('The classification of the given data is bad');
        
    end
    
end