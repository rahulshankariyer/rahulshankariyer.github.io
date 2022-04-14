%Initialization

%Size of the matrix

x = input('Enter the number of features');
y = input('Enter the number of training data sets');
z = input('Enter the number of testing data sets');

for i = 1 : z

    Xg(i) = 0;
    Xb(i) = 0;
    Y(i) = 0;

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

for i = 1 : z

    for j = 1 : k

            Xg(i) = Xg(i) + (class(j).C / d(j));    
            Xb(i) = Xb(i) + (opp(j).C / d(j));
            Y(i) = Y(i) + (1 / d(j));

    end
    
end

for i = 1 : z

    Zg(i) = Xg(i) / Y(i);
    Zb(i) = Xb(i) / Y(i);

end

for i = 1 : z

    if Zg(i) > Zb(i)

        classr(i).C = 1;

    elseif Zb(i) > Zg(i)

        classr(i).C = 0;

    else

        if class(1).C == 1

            classr(i).C = 1;

        elseif class(1).C == 0

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