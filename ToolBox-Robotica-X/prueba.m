function y=prueba(GDL)

for i=1:GDL
    for j=1:4
%         if(D(i,j)~=0)
            fprintf(1,'Dame el valor del parámetro D(%d,%d)\n',i,j);
            De(i,j) = input('','s');%char(Parametros(1,i)));
%         else
%             De(i,j)=0;
%         end
    end
end

De