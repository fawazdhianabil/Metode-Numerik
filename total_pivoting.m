function x5=total_pivoting(A,b)
n=length(b);
mutan=zeros(1,n-1);%menyimpan data kolom yang dipertukarkan
for i=1:n-1
    d=max(abs(A(i:end,i:end)));%magnitudo terbesar setiap kolom
    pp=find(d==max(d));
    p=pp(1)+i-1;
    mutan(i)=p;
    AA=A;
    AA(:,i)=A(:,p);AA(:,p)=A(:,i);%pertukaran kolom;
    %pertukaran baris untuk memilih pivot terbesar
    t=find(abs(AA(i:end,i))==max(abs(AA(i:end,i))));
    p1=t(1)+i-1;
    A2=AA;b1=b;
    A2(i,:)=AA(p1,:);A2(p1,:)=AA(i,:);
    b1(i)=b(p1);b1(p1)=b(i);
    %eliminasi per kolom
    for j=i+1:n
        lambda=A2(j,i)/A2(i,i);
        for k=i:n
            A2(j,k)=A2(j,k)-lambda*A2(i,k);
        end
        b1(j)=b1(j)-lambda*b1(i);
    end
    A=A2;b=b1;
end
%menjalankan subtitusi mundur
z=zeros(n,1);%menyiapkan vektor penyelesaian
z(n)=b1(n)/A2(n,n);
for k=n-1:-1:1
    sum=0;
    for j=k+1:n
        sum=sum+A2(k,j)*z(j);
    end
    z(k)=(b1(k)-sum)/A2(k,k);
end
%transformasi dengan matriks permutasi
P=eye(n);
for k=1:n-1
    P1=matriks_perm(n,k,mutan(k));
    P=P*P1;
end
x5=P*z;