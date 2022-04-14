x=input('Enter the number of parameters');
y=input('Enter the number of values');
A=[];
for j=1:y
    for i=1:x
        A(j,i)=input('Enter the value');
    end
end
c=input('How many centroids?');
for k=1:c
    cluster(k).B=[];
    z=input('Enter a number');
    if(z>=1 && z<=y)
        for i=1:x
            centroid(k).value=A(z,i);
            cluster(k).B(1,i)=centroid(k).value;
        end
    end
end
for k=1:c
        d(k).value=1;
end
for j=1:y 
    C=[];
    mn=0;    
    for k=1:c        
        sum(k).value=0;         
        for i=1:x
            distance(i).value=A(j,i)-cluster(k).B(1,i);
            sum(k).value=sum(k).value+(distance(i).value*distance(i).value);
        end
        C(1,k)=sum(k).value;
        if(k==1 || (k>1 && (sum(k).value<sum(k-1).value)))
            mn=k; 
            d(mn).value=d(mn).value+1;
        end
    end 
    for i=1:x
        cluster(mn).B(d(mn).value,i)=A(j,i);
    end
end
for k=1:c
    s(k).value=0;
    for i=1:x
        for j=1:d(k).value
            s(k).value=s(k).value+cluster(k).B(j,i);
            s(k).value=s(k).value/c;            
        end
        centroid(k).value=s(k).value;
    end    
end
for k=1:c
    cluster1(k).B=[];    
end
for k=1:c
    while cluster1(k)~=cluster(k)
        cluster1(k)=cluster(k);
        for k=1:c
        d(k).value=1;
        end
        for j=1:y 
            C=[];
            mn=0;    
            for k=1:c        
                sum(k).value=0;         
                for i=1:x
                    distance(i).value=A(j,i)-centroid(k);
                    sum(k).value=sum(k).value+(distance(i).value*distance(i).value);
                end
                C(1,k)=sum(k).value;
                if(k==1 || (k>1 && (sum(k).value<sum(k-1).value)))
                    mn=k; 
                    d(mn).value=d(mn).value+1;
                end
            end 
            for i=1:x
                cluster(mn).B(d(mn).value,i)=A(j,i);
            end
        end
        for k=1:c
            s(k).value=0;
            for i=1:x
                for j=1:d(k).value
                    s(k).value=s(k).value+cluster(k).B(j,i);
                    s(k).value=s(k).value/c;                    
                end
                centroid(k).value=s(k).value;
            end    
        end
    end
end
for k=1:c
    display(cluster(k).B);
    display(centroid(k));
end
   
            
