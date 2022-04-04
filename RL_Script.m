%% Define the Environment
numObs = 36; % Number of observations
numAct = 3;  % Number of actions
maxF = 1.0;  % Max Force [N]

oinfo = rlNumericSpec([numObs,1]);
oinfo.Name = 'States of the System';
oinfo.Description = 'string (1-3) together: x_dot,omega,euler,delta_x';

ainfo = rlNumericSpec([numAct,1], "UpperLimit", maxF, "LowerLimit", -maxF);
ainfo.Name = 'Agent Action';
ainfo.Description = 'x,y,z coordinates';

load rlCollaborativeTaskAgents
blks = ["Quadcopter_Model_V2/Quadcopter1/Mission Planner/RL Agent1", ...
    "Quadcopter_Model_V2/Quadcopter2/Mission Planner/RL Agent2",...
    "Quadcopter_Model_V2/Quadcopter3/Mission Planner/RL Agent3"];
obsInfos = {oinfo,oinfo,oinfo};
actInfos = {ainfo,ainfo,ainfo};


% Specify an Agents Options
opt = rlDDPGAgentOptions;               % Initialize the options
opt.DiscountFactor = 0.95;              % Discount on future rewards
opt.ExperienceBufferLength = 10^6;      % Replay buffer
opt.NumStepsToLookAhead = 1;
opt.MiniBatchSize = 100;                % Update parameters after every 100

rng(0)

% Create the Agent
agent1 = rlDDPGAgent(oinfo,ainfo,opt)   % Create the agent
agent2 = rlDDPGAgent(oinfo,ainfo,opt)   % Create the agent
agent3 = rlDDPGAgent(oinfo,ainfo,opt)   % Create the agent

env = rlSimulinkEnv('Quadcopter_Model_V2',blks);
validateEnvironment(env)

save('agent.mat','agent1','agent2','agent3')

%%

trainOpts = rlMultiAgentTrainingOptions;
trainOpts.AgentGroups = {1,2,3};
trainOpts.LearningStrategy = "centralized";
trainOpts.MaxEpisodes = 25000;
trainOpts.MaxStepsPerEpisode = 1000;
trainOpts.StopTrainingCriteria = "AverageReward";
trainOpts.StopTrainingValue = 600;
trainOpts.SaveAgentCriteria = "EpisodeReward";
trainOpts.SaveAgentValue = 400;
trainOpts.SaveAgentDirectory = pwd + "\run1\Agents";
trainOpts.Verbose = true;
trainOpts.Plots = "training-progress";

trainStats = train([agent1 agent2 agent3],env,trainOpts)