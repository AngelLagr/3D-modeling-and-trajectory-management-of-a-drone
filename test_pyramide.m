% % [A1,B1,C1] = Pyramide3D(0,0,0,10,5)
% [A1,B1,C1] = coordobsta3D(0,5,0,5,5)
% plot3(A1,B1,C1)  
val_min=0;
% [X,Y,Z]=coordobsta3D([val_min,5;val_min,5;val_min,15])
% plot3(X,Y,Z,'ob')
% hold on
% plot3([val_min 5],[val_min 5],[val_min 15],'square')
% hold on
% plot3([val_min-2 20],[val_min-2 20],[val_min-2 20],'or')


[s1,s2,s3] = sphere(7);
r=0.55 ; Xs = s1*r; Ys = s2*r; Zs = s3*r;
[A1,B1,C1] =Pyramide3D([3,26,1,14,5]);


for i=1:length(A1)
    surf(Xs+A1(i),Ys+B1(i),Zs+C1(i));
    axis equal;
    hold on;
end

% plot3([val_min 30],[val_min 30],[val_min 30],'or')