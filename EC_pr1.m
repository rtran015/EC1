%% Extra Credit Problem 1 – Due November 28, 2022
% Raymond Tran
% Circle Creation: Output a circle when given 3 points

%% 1.1. Ask the User to input three points on a XY-plane in the form of the following: P = [x1 y1; x2 y2; x3 y3]
clc; clear;
P = input('Input three points on an XY-plane in the form of the following P = [x1 y1; x2 y2; x3 y3]: ');

% Set dummy numbers for P for testing
% P = [-12 -13; -31 -67; 14 54];

%% 1.3. IF statement that evaluates the 3 points. Display error if 2 points are equal, or if 3 points form a line
% Assign inputs to points A, B, C (makes code easier to read)
A = P(1,:); 
B = P(2,:); 
C = P(3,:); 

% Calculate slopes between each point to determine collinearity
% Note: If any 2 line segments share the same slope and a mutual point in
% space, then the 2 line segments are collinear
mAB = (B(1,2) - A(1,2))/(B(1,1) - A(1,1));
mBC = (C(1,2) - B(1,2))/(C(1,1) - B(1,1));
mAC = (C(1,2) - A(1,2))/(C(1,1) - A(1,1));

% If statements to display error for a nondefinitive circle
if (isequal(A,B) || isequal(B,C) || isequal(C,A))       % checks if any 2 points are equal
    error('Error: Circle is not definitive')
elseif (mAB == mBC || mBC == mAC || mAC == mAB)         % checks if 3 points are collinear
    error('Error: Circle is not definitive')
else
end


%% 1.2 Use above points to determine the radius and center-point of a circle that touches all 3 points

% Quadratic equation to determine center and radius of circle
syms x_c y_c r
eqn1 = (A(1,1) - x_c)^2 + (A(1,2) - y_c)^2 - r^2 == 0;
eqn2 = (B(1,1) - x_c)^2 + (B(1,2) - y_c)^2 - r^2 == 0;
eqn3 = (C(1,1) - x_c)^2 + (C(1,2) - y_c)^2 - r^2 == 0;

eqnsmatrix = [eqn1; eqn2; eqn3];
[r, x_c, y_c] = solve(eqnsmatrix, [r, x_c, y_c]);       % Symbolic radius and center-point of circle
circle = double([r, x_c, y_c]);                         % Assign variable 'circle' as a double of the circle properties 
circle = circle(2,:);                                   % Reassign circle as 1x3 with positive radius

%% 1.4. Plot the circle with conditions for circle and point color

% 1st IF construct: determine color of circle based on radius
radius = circle(1,1);                   % assign new variable 'radius'
if radius < 10
    circlecolor = 'k';
elseif radius < 100
    circlecolor = 'b';
else
    circlecolor = '#7E2F8E';
end

% 2nd IF construct: determine color of points based on quadrant of
% center-point

centerpoint = (circle(1, 2:3));         % assign new variable 'centerpoint'
signs = centerpoint >= [0 0];           % assign new logical variable 'signs'. A logical 0 means the coordinate is negative, logical 1 is positive

if isequal(signs,[1 1])                 % centerpoint is [1 1], which means (+, +) aka quadrant I
    pointcolor = 'b';
elseif isequal(signs,[0 1])             % quadrant II (-,+)
    pointcolor = 'r';
elseif isequal(signs,[0 0])             % quadrant III (-,-)
    pointcolor = 'k';
else                                    % quadrant IV (-,-)
    pointcolor = 'g';
end

% Plot the circle
syms x y
fimplicit((x-centerpoint(1,1)).^2 + (y-centerpoint(1,2)).^2 - radius^2, 'Color', circlecolor)
axis([centerpoint(1,1)-radius*1.1, centerpoint(1,1)+radius*1.1, centerpoint(1,2)-radius*1.1, centerpoint(1,2)+radius*1.1]) % set axes based on center and radius with 10% padding
axis square

% Plot points
hold on
plot(P(:,1),P(:,2), 'O','Color', pointcolor) % P refers to the original 3x2 of 3 points input by user

%% 1.5. Add text to chart 
% Add x-axis and y-axis labels, title. 
xlabel('x-axis')
ylabel('y-axis')
sgtitle("Plot Three Given Points and Their Tangent Circle")

% Add variable text box for radius and center point
str = sprintf('Radius = %.2f\nCenter-point = (%.f, %.f)', radius, centerpoint(1,1), centerpoint(1,2));
annotation('textbox','String',str,'FitBoxToText','on');
hold off

