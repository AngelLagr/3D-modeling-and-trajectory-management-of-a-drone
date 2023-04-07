
function [xcoordObsta,ycoordObsta,zcoordObsta]=coordObsta3D(CoordCube)
%cube=[xinf,xsupp;yinf,ysupp,zinf,zsupp]
xcoordObsta=[];
ycoordObsta=[];
zcoordObsta=[];
for i=CoordCube(1,1):1:CoordCube(1,2)
    for j=CoordCube(2,1):1:CoordCube(2,2)
        for k=CoordCube(3,1):1:CoordCube(3,2)
            xcoordObsta=[xcoordObsta,i];
            ycoordObsta=[ycoordObsta,j];
            zcoordObsta=[zcoordObsta,k];
        end
    end
end

end