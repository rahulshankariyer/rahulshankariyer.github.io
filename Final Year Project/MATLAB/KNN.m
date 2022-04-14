n = input('Enter the number of values:');

for i = 1 : n
    value(i).X1 = input('Acid Durability:');
    value(i).X2 = input('Strength:');
    value(i).Y = input('Classification:','s');
end

values.X1 = input('Acid Durability:');
values.X2 = input('Strength:');

for i = 1 : n
    distance(i).X1 = values.X1 - value(i).X1;
    distance(i).X2 = values.X2 - value(i).X2;
    distance(i).X3 = (distance(i).X1 * distance(i).X1) + (distance(i).X2 * distance(i).X2);
end

A = [0 0 0 0];

for i = 1 : n
    A(1,i) = distance(i).X3;
end

for i = 1 : n-1
    for j = i+1 : n
        if(distance(i).X3 > distance(j).X3)
            temp1 = distance(i).X3;
            distance(i).X3 = distance(j).X3;
            distance(j).X3 = temp1;
            temp2 = value(i).Y;
            value(i).Y = value(j).Y;
            value(j).Y = temp2;
        end
    end
end

k = input('Enter the number of neighbours');

g = 0;
b = 0;

for i = 1 : k
    if(strcmp(value(i).Y,'good') == 1)
        g = g + 1;
    elseif(strcmp(value(i).Y,'bad') == 1)
        b = b + 1;
    end
end

if(g > b)
    values.Y = 'good';
elseif(b > g)
    values.Y = 'bad';
else
    values.Y = value(1).Y;
end

display('The classification of the given data is:');
display(values.Y);       
        

