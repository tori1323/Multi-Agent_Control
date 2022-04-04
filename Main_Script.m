% Initialize the model variables
run('Properties_Quad.m')
run('initial_conditions.m')
load('agent.mat')
load('Linear_Model.mat')

% Run the simulation and graph
sim('Quadcopter_Model_V2',2)
logsout = ans.logsout;
graphing(logsout)
