# Multi-Agent Control for Quadcopters
## AAE 59000 - Multi-Agent Autonomy and Control course at Purdue Univerity

This repository contains the following files:
* Controller_LQR - Creates a gain matrix for the controller u = -Ky.
* Dynamic_Inversion - Creates the needed variables for the controller in Multi_Agent_Problem.
* graphing - Graphs the states of the quadcopters and load from the simulation.
* Hinf_Controller_Create - Hinf controller attempt.
* initial_conditions - Initial conditions of the quadcopter and mass.
* Main_Script - Open this script to run the bare minimum to run the model.
* Properties_Quad - Properties of the quadcopter and mass.
* RL_Script - Defines the agent and environment.  Also has code to train the agent.
* agent - Saves the agents created in the RL_Script.
* Linear_Model - Saves the variables needed for the controller.
* Mutli_Agent_Problem - The Simulink model.

The user only needs to run Main_Script to run the simulations.  Go to RL_Script to train the agents.
