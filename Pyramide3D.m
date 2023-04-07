function [x_pyra,y_pyra,z_pyra]=Pyramide3D(Pyramid_coordinates)
% Pyramid_coordinates = [x_base,y_base, z_base,cote_base,pyramid_height]
%rem on doit avoir cote_base >= 2*height
x_pyra=[];
y_pyra=[];
z_pyra=[];
%parameters
height=Pyramid_coordinates(5) ;
b=Pyramid_coordinates(4);
x0=Pyramid_coordinates(1) ;
y0= Pyramid_coordinates(2);
z0=Pyramid_coordinates(3);
xmax=x0+b;
ymax=y0+b;
increment=floor(b/height) ;%increment
c=0;
for k=z0:z0+height
    c=c+increment;
    for i= x0+c-1:xmax-c
        for j= y0+c-1:ymax-c
            x_pyra=[x_pyra,i];
            y_pyra=[y_pyra,j];
            z_pyra=[z_pyra,k];
        end
    end
end

end