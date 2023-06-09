%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% A* ALGORITHM Demo
% Interactive A* search demo
% 04-26-2005
%   Copyright 2009-2010 The MathWorks, Inc.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure
%DEFINE THE 3-D MAP ARRAY
grid_size=51;
MAX_X=17;
MAX_Y=51;
MAX_Z=6;
MAX_VAL=51;
%This array stores the coordinates of the map and the 
%Objects in each coordinate
MAP=2*(ones(MAX_X,MAX_Y,MAX_Z));

% Obtain Obstacle, Target and Robot Position
% Initialize the MAP with input values
% Obstacle=-1,Target = 0,Robot=1,Space=2
axis([1 MAX_X+1 1 MAX_Y+1 1 MAX_Z+1])
grid on;
hold on;
n=0;%Number of Obstacles

% BEGIN Interactive Obstacle, Target, Start Location selection
xTarget=10;%X Coordinate of the Target
yTarget=50;%Y Coordinate of the Target
zTarget=1;
MAP(xTarget,yTarget,zTarget)=0;%Initialize MAP with location of the target
text(xTarget,yTarget,zTarget,'Target')
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
xobstacle=[];
yobstacle=[];
zobstacle = [];
for i=1:length(xobstacle)
    MAP(xobstacle(i),yobstacle(i),zobstacle(i))=-1;%Put on the closed list as well
    plot3(xobstacle,yobstacle,zobstacle,'ro');
 end%End of While loop

%%%%%%%%%%%%%%%%%%%%%%%%TEST AVEC DS BLOCS%%%%%%%%%%%%%%%%%
[X,Y,Z]=coordobsta3D([9,17;11,12;1,6]); %coordonnée du cube
for i=1:length(X)
    MAP(X(i),Y(i),Z(i))=-1;%Put on the closed list as well
    plot3(X,Y,Z,'ro');
 end%End of While loop
[X,Y,Z]=coordobsta3D([1,11;8,9;1,6]); %coordonnée du cube
for i=1:length(X)
    MAP(X(i),Y(i),Z(i))=-1;%Put on the closed list as well
    plot3(X,Y,Z,'ro');
 end%End of While loop
[X,Y,Z]=coordobsta3D([9,17;4,5;1,6]); %coordonnée du cube
for i=1:length(X)
    MAP(X(i),Y(i),Z(i))=-1;%Put on the closed list as well
    plot3(X,Y,Z,'ro');
 end%End of While loop


 %voiture
[X,Y,Z]=coordobsta3D([7,13;18,21;1,2]); %coordonnée de la pyramide
for i=1:length(X)
    MAP(X(i),Y(i),Z(i))=-1;%Put on the closed list as well
    plot3(X,Y,Z,'ro');
 end%End of While loop

 %%%pyramide%%%%%%%%%%%%%%%%%%%%
[X,Y,Z]=Pyramide3D([3,26,1,14,5]) %coordonnée du cube
for i=1:length(X)
    MAP(X(i),Y(i),Z(i))=-1;%Put on the closed list as well
    plot3(X,Y,Z,'ro');
 end%End of While loop



%TROU DE FIN
[X,Y,Z]=coordobsta3D([1,20;48,49;1,3]); %coordonnée du cube
for i=1:length(X)
    MAP(X(i),Y(i),Z(i))=-1;%Put on the closed list as well
    plot3(X,Y,Z,'ro');
 end%End of While loop
[X,Y,Z]=coordobsta3D([1,20;48,49;5,6]); %coordonnée du cube
for i=1:length(X)
    MAP(X(i),Y(i),Z(i))=-1;%Put on the closed list as well
    plot3(X,Y,Z,'ro');
 end%End of While loop
[X,Y,Z]=coordobsta3D([1,9;48,49;1,6]); %coordonnée du cube
for i=1:length(X)
    MAP(X(i),Y(i),Z(i))=-1;%Put on the closed list as well
    plot3(X,Y,Z,'ro');
 end%End of While loop
[X,Y,Z]=coordobsta3D([11,20;48,49;1,6]); %coordonnée du cube
for i=1:length(X)
    MAP(X(i),Y(i),Z(i))=-1;%Put on the closed list as well
    plot3(X,Y,Z,'ro');
 end%End of While loop

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
xval=10;%Starting Position
yval=1;%Starting Position
zval=1;
xStart=xval;%Starting Position
yStart=yval;%Starting Position
zStart=zval;%Starting Position
MAP(xval,yval,zval)=1;
plot3(xval,yval,zval,'bo');
%End of obstacle-Target pickup

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%LISTS USED FOR ALGORITHM
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%OPEN LIST STRUCTURE
%--------------------------------------------------------------------------
%IS ON LIST 1/0 |X val |Y val |Parent X val |Parent Y val |h(n) |g(n)|f(n)|
%--------------------------------------------------------------------------
OPEN=[];
%CLOSED LIST STRUCTURE
%--------------
%X val | Y val |
%--------------
% CLOSED=zeros(MAX_VAL,2);
CLOSED=[];

%Put all obstacles on the Closed list
k=1;%Dummy counter
for i=1:MAX_X
    for j=1:MAX_Y
        for p=1:MAX_Z
            if(MAP(i,j,p) == -1)
                CLOSED(k,1)=i; 
                CLOSED(k,2)=j; 
                CLOSED(k,3)=p; 
                k=k+1;
            end
        end
    end
end
CLOSED_COUNT=size(CLOSED,1);
%set the starting node as the first node
xNode=xval;
yNode=yval;
zNode=zval;
OPEN_COUNT=1;
path_cost=0;
goal_distance=distance3D(xNode,yNode,zNode,xTarget,yTarget,zTarget);
OPEN(OPEN_COUNT,:)=insert_open3D(xNode,yNode,zNode,xNode,yNode,zNode,path_cost,goal_distance,goal_distance);
OPEN(OPEN_COUNT,1)=0;
CLOSED_COUNT=CLOSED_COUNT+1;
CLOSED(CLOSED_COUNT,1)=xNode;
CLOSED(CLOSED_COUNT,2)=yNode;
CLOSED(CLOSED_COUNT,3)=zNode;
NoPath=1;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% START ALGORITHM
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
while((xNode ~= xTarget || yNode ~= yTarget || zNode ~= zTarget) && NoPath == 1)
 exp_array=expand_array3D(xNode,yNode,zNode,path_cost,xTarget,yTarget,zTarget,CLOSED,MAX_X,MAX_Y,MAX_Z);
 exp_count=size(exp_array,1);
 %UPDATE LIST OPEN WITH THE SUCCESSOR NODES
 %OPEN LIST FORMAT
 %--------------------------------------------------------------------------
 %IS ON LIST 1/0 |X val |Y val |Z val |Parent X val |Parent Y val |Parent Z val |h(n) |g(n)|f(n)|
 %--------------------------------------------------------------------------
 %EXPANDED ARRAY FORMAT
 %--------------------------------
 %|X val |Y val |Z val ||h(n) |g(n)|f(n)|
 %--------------------------------
 for i=1:exp_count
    flag=0;
    for j=1:OPEN_COUNT
        if(exp_array(i,1) == OPEN(j,2) && exp_array(i,2) == OPEN(j,3) && exp_array(i,3) == OPEN(j,4))
            OPEN(j,10)=min(OPEN(j,10),exp_array(i,6)); %#ok<*SAGROW>
            if OPEN(j,10)== exp_array(i,6)
                %UPDATE PARENTS,gn,hn
                OPEN(j,5)=xNode;
                OPEN(j,6)=yNode;
                OPEN(j,7)=zNode;
                OPEN(j,8)=exp_array(i,4);
                OPEN(j,9)=exp_array(i,5);
            end%End of minimum fn check
            flag=1;
        end%End of node check
%         if flag == 1
%             break;
    end%End of j for
    if flag == 0
        OPEN_COUNT = OPEN_COUNT+1;
        OPEN(OPEN_COUNT,:)=insert_open3D(exp_array(i,1),exp_array(i,2),exp_array(i,3),xNode,yNode,zNode,exp_array(i,4),exp_array(i,5),exp_array(i,6));
    end%End of insert new element into the OPEN list
 end%End of i for
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 %END OF WHILE LOOP
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 %Find out the node with the smallest fn 
  index_min_node = min_fn3D(OPEN,OPEN_COUNT,xTarget,yTarget,zTarget);
  if (index_min_node ~= -1)    
   %Set xNode and yNode to the node with minimum fn
   xNode=OPEN(index_min_node,2);
   yNode=OPEN(index_min_node,3);
   zNode=OPEN(index_min_node,4);
   path_cost=OPEN(index_min_node,8);%Update the cost of reaching the parent node
  %Move the Node to list CLOSED
  CLOSED_COUNT=CLOSED_COUNT+1;
  CLOSED(CLOSED_COUNT,1)=xNode;
  CLOSED(CLOSED_COUNT,2)=yNode;
  CLOSED(CLOSED_COUNT,3)=zNode;
  OPEN(index_min_node,1)=0;
  else
      %No path exists to the Target!!
      NoPath=0;%Exits the loop!
  end%End of index_min_node check
end%End of While Loop
%Once algorithm has run The optimal path is generated by starting of at the
%last node(if it is the target node) and then identifying its parent node
%until it reaches the start node.This is the optimal path

i=size(CLOSED,1);
Optimal_path=[];
xval=CLOSED(i,1);
yval=CLOSED(i,2);
zval=CLOSED(i,3);
i=1;
Optimal_path(i,1)=xval;
Optimal_path(i,2)=yval;
Optimal_path(i,3)=zval;
i=i+1;

if ((xval == xTarget) && (yval == yTarget) && (zval == zTarget))
    inode=0;
   %Traverse OPEN and determine the parent nodes
   parent_x=OPEN(node_index3D(OPEN,xval,yval,zval),5);%node_index returns the index of the node
   parent_y=OPEN(node_index3D(OPEN,xval,yval,zval),6);
   parent_z=OPEN(node_index3D(OPEN,xval,yval,zval),7);
   while( parent_x ~= xStart || parent_y ~= yStart || parent_z ~= zStart)
           Optimal_path(i,1) = parent_x;
           Optimal_path(i,2) = parent_y;
           Optimal_path(i,3) = parent_z;
           %Get the grandparents:-)
           inode=node_index3D(OPEN,parent_x,parent_y,parent_z);
           parent_x=OPEN(inode,5);%node_index returns the index of the node
           parent_y=OPEN(inode,6);
           parent_z=OPEN(inode,7);
           i=i+1;
   end
 j=size(Optimal_path,1);
 Optimal_path
 %Plot the Optimal Path!
 
 p=plot3(Optimal_path(j,1),Optimal_path(j,2),Optimal_path(j,3),'bo');
 j=j-1;
 for i=j:-1:1
  set(p,'XData',Optimal_path(i,1),'YData',Optimal_path(i,2),'ZData',Optimal_path(i,3));
 drawnow ;
 end;
 plot3(Optimal_path(:,1),Optimal_path(:,2),Optimal_path(:,3));
else
 h=msgbox('Sorry, No path exists to the Target!','warn');
 uiwait(h,5);
end

    


