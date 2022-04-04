%% Loads the Properties of the Quad Model

%% Start Code Below:
% Physical Properties
m = 1.0;                    % Mass [kg]
g = 9.8;                    % Gravity [m/s^]
L = 0.155;                  % Length of Arm [m]clea
eta = 1;                    % Propeller Efficiency [nd]
I = [0.01151    0       0;
        0   0.01169     0;
        0       0   0.01275];

% Linear Model & Controller
load('Linear_Model.mat')

% Sensor Noise Properties

% Mass Load Properties
mass = 0.9;                 % Mass Load [kg]
r = 1.5;

% 