% MATLAB code to compute explicit FDM for:
% U_t = U_xx - lambda*U_x
% n is the time step
% j is the position step
% Matrix is a grid of (t_n, x_j)

% Need to clear the previous u and whatnot values for each run
clear all
% Defining Lambda 
lambda = 3;         
% Setting up x (iterate for various Nx)
xmin = 0; xmax = 1;
Nx = 128;
dx = (xmax-xmin)/Nx;
% Setting up t (calculated from stability)
tmin = 0; tmax = 0.2;
% dt = 2/lambda^2;                % From stability dt < 2/lambda^2
dt = 128;
Nt = ceil((tmax - tmin)/dt);    % Minimum Nt
dt = (tmax-tmin)/Nt;            % Update dt

% Creating mesh
xmesh = xmin:dx:xmax;
% Initial condition
u_init = sin(3*pi*xmesh/2);
u(1,:) = u_init;

% For each time value
for n = 1:Nt
    % Go along the x direction from 2 to 2nd last
    for j = 2:size(u,2)-1
        u(n+1,j) = u(n,j) +dt*((u(n,j-1)-2*u(n,j)+u(n,j+1))/dx^2 - ...
            lambda*((u(n,j+1)-u(n,j-1))/(2*dx)));
    end
    % Set the boundary values for the next time value
    u(n+1,1) = u(n,1);
    u(n+1,end) = u(n,end);
end

% Taking the average value of the solution
u_avg = mean(u(Nt,:));

% Contour Plot
% contourf(u');
disp(u_avg);