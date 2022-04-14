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

%Number of true values

t = 0;

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

        if(strcmp(class(j).C,'good') == 1)

            g(i) = g(i) + 1;            

        elseif(strcmp(class(j).C,'bad') == 1)

            b(i) = b(i) + 1;            

        end

    end
    
end

for i = 1 : z

    if g(i) > b(i)

        classr(i).C = 'good';

    elseif b(i) > g(i)

        classr(i).C = 'bad';

    else
        
        classr(i).C = class(1).C;        

    end
    
end

for i = 1 : z
    
    if strcmp(classp(i).C,classr(i).C)
        
        t = t + 1;
        
    end
    
end

Accuracy = t / z;
Accuracy_Percentage = Accuracy * 100;
        