function x4=skala_parsial_pivoting(A,b)
n=length(b);
s=zeros(n,1);
%faktor skala
for k=1:n
    s(k)=max(abs(A(k,:)));
end
%membentuk sistem segitiga atas
for i=1:n-1
%pertukaran baris untuk memilih pivot terbesar setelah diskala
    A1=A; b1=b;
    for k=i+1:n
        p=i;
        if abs(A(p,i))/s(i)<abs(A(k,i))/s(k)
            p=k;
        else
            p=i;
        end
    end
    A1(i,:)=A(p,:);A1(p,:)=A(i,:);
    b1(i)=b(p);b1(p)=b(i);
    %eliminasi per kolom
    for j=i+1:n
        lambda=A1(j,i)/A1(i,i);
        for k=i:n
            A1(j,k)=A1(j,k)-lambda*A1(i,k);
        end
            b1(j)=b1(j)-lambda*b1(i);
    end
    A=A1;b=b1;
end
%menjalankan subtitusi mundur
x4=zeros(n,1);%menyiapkan vektor penyelesaian
x4(n)=b1(n)/A1(n,n);
for k=n-1:-1:1;
    sum=0;
    for j=k+1:n
        sum=sum+A1(k,j)*x4(j);
    end
    x4(k)=(b1(k)-sum)/A1(k,k);
end