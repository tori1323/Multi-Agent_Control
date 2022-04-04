load('Linear_Model.mat')

%% Subsystem 1
s = tf('s');
B1 = [0;13.26;0];
C1 = [1 0 0];
G1 = C1*(s*eye(3)-A1)^-1*B1;

% Weight 1
e_s = .1;
M_s = 2;
omega_b = .01;
k_s = 6;
W1_s = (s + omega_b*M_s^(1/k_s))/(M_s^(1/k_s)*(s+omega_b*e_s^(1/k_s)))^k_s;

% Weight 2
e_t = .01;
M_t = 6;
omega_bt = 90;
k_t = 2;
W1_t = ((s + (omega_bt/(M_t^(1/k_t))))/((e_t^(1/k_t))*s+omega_bt))^k_t;


[K1,~,~] = mixsyn(G1,W1_s,[],W1_t);
C_tf = tf(K1);

% Transfer Functions
R = feedback(G1*C_tf,1);
D = feedback(G1,C_tf,-1);
N = -feedback(G1*C_tf,1);
% Set-Up Sims
t = 0:0.01:30;                     % Time of Sim
t2 = 0:0.01:100;                   % Time of Sim
t3 = 0:0.01:0.5;                   % Time of Sim
r = [ones(1,length(t))];           % Refernce Signal
d = [sin(0.1.*t2)];                % Disturbance
n = [sin(100.*t3)];                % Noise
% Matlab Simulation Function
[a] = lsim(R,r,t);
[b] = lsim(D,d,t2);
[c] = lsim(N,n,t3);

% Plot 2
figure 
hold on
subplot(3,1,1)
title('Reference Tracking')
hold on
plot(t,a(:,1))
plot(t,r)
line([0,30],[.99 .99],'Color','green','LineStyle','--')
xlabel('Time[s]')
ylabel('R Signal')
hold off
subplot(3,1,2)
title('Distrubance Rejection')
hold on
plot(t2,b(:,1))
plot(t2,d)
line([0,100],[.1 .1],'Color','green','LineStyle','--')
line([0,100],[-.1 -.1],'Color','green','LineStyle','--')
xlabel('Time[s]')
ylabel('D Signal')
hold off
subplot(3,1,3)
title('Noise Rejection')
hold on
plot(t3,c(:,1))
plot(t3,n)
line([0,0.5],[.01 .01],'Color','green','LineStyle','--')
line([0,0.5],[-.01 -.01],'Color','green','LineStyle','--')
hold off
xlabel('Time[s]')
ylabel('N Signal')
legend('Sim','Signal','Requirements')
hold off

%% Subsystem 2
B1 = [0;13.26;0];
C2 = [1 0 0];
G2 = C2*(s*eye(3)-A2)^-1*B2;

% Weight 2
e_s = .1;
M_s = 2;
omega_b = .01;
k_s = 6;
W1_s = (s + omega_b*M_s^(1/k_s))/(M_s^(1/k_s)*(s+omega_b*e_s^(1/k_s)))^k_s;

% Weight 2
e_t = .01;
M_t = 6;
omega_bt = 90;
k_t = 2;
W1_t = ((s + (omega_bt/(M_t^(1/k_t))))/((e_t^(1/k_t))*s+omega_bt))^k_t;


[K2,~,~] = mixsyn(G1,W1_s,[],W1_t);
C_tf = tf(K2);

% Transfer Functions
R = feedback(G1*C_tf,1);
D = feedback(G1,C_tf,-1);
N = -feedback(G1*C_tf,1);
% Set-Up Sims
t = 0:0.01:30;                     % Time of Sim
t2 = 0:0.01:100;                   % Time of Sim
t3 = 0:0.01:0.5;                   % Time of Sim
r = [ones(1,length(t))];           % Refernce Signal
d = [sin(0.1.*t2)];                % Disturbance
n = [sin(100.*t3)];                % Noise
% Matlab Simulation Function
[a] = lsim(R,r,t);
[b] = lsim(D,d,t2);
[c] = lsim(N,n,t3);

% Plot 2
figure 
hold on
subplot(3,1,1)
title('Reference Tracking')
hold on
plot(t,a(:,1))
plot(t,r)
line([0,30],[.99 .99],'Color','green','LineStyle','--')
xlabel('Time[s]')
ylabel('R Signal')
hold off
subplot(3,1,2)
title('Distrubance Rejection')
hold on
plot(t2,b(:,1))
plot(t2,d)
line([0,100],[.1 .1],'Color','green','LineStyle','--')
line([0,100],[-.1 -.1],'Color','green','LineStyle','--')
xlabel('Time[s]')
ylabel('D Signal')
hold off
subplot(3,1,3)
title('Noise Rejection')
hold on
plot(t3,c(:,1))
plot(t3,n)
line([0,0.5],[.01 .01],'Color','green','LineStyle','--')
line([0,0.5],[-.01 -.01],'Color','green','LineStyle','--')
hold off
xlabel('Time[s]')
ylabel('N Signal')
legend('Sim','Signal','Requirements')
hold off
%% Subsystem 3
G3 = C3*(s*eye(2)-A3)^-1*B3;

% Weight 1
e_s = .0001;
M_s = 4;
omega_b = 1;
k_s = 2;
W1_1 = (s + omega_b*M_s^(1/k_s))/(M_s^(1/k_s)*(s+omega_b*e_s^(1/k_s)))^k_s;
W1_2 = (s + omega_b*M_s^(1/k_s))/(M_s^(1/k_s)*(s+omega_b*e_s^(1/k_s)))^k_s;

W_s = [W1_1   0;
        0   W1_2];

% Weight 2
e_t = .01;
M_t = 2;
omega_bt = 1000;
k_t = 1;
W2_1 = ((s + (omega_bt/(M_t^(1/k_t))))/((e_t^(1/k_t))*s+omega_bt))^k_t;
W2_2 = ((s + (omega_bt/(M_t^(1/k_t))))/((e_t^(1/k_t))*s+omega_bt))^k_t;
W_t = [W2_1   0;
        0   W2_2];
P = augw(G3,W_s,[],W_t);
P = minreal(P);

[K3,~,gamma] = hinfsyn(P,2,4)

C_tf = tf(K3);

R = feedback(series(C_tf,G3),eye(2));
t = 0:0.01:30;                                          % Time of Sim
r = [ones(1,length(t)); ones(1,length(t))];             % Refernce Signal
[a] = lsim(R,r,t);

% Plot 1
figure 
hold on
subplot(2,1,1)
title('Reference Tracking: 1')
hold on
plot(t,a(:,1))
plot(t,r(1,:))
line([0,30],[.99 .99],'Color','green','LineStyle','--')
xlabel('Time[s]')
ylabel('R Signal: 1')
hold off
subplot(2,1,2)
title('Reference Tracking: 2')
hold on
plot(t,a(:,2))
plot(t,r(2,:))
line([0,30],[.99 .99],'Color','green','LineStyle','--')
xlabel('Time[s]')
ylabel('R Signal: 2')
legend('Sim','Signal','Requirements')
hold off

%% Subsystem 4
B4 = -4;
G4 = C4*(s*eye(1)-A4)^-1*B4;

% Weight 2
e_s = .001;
M_s = 2;
omega_b = 1;
k_s = 3;
W4_s = (s + omega_b*M_s^(1/k_s))/(M_s^(1/k_s)*(s+omega_b*e_s^(1/k_s)))^k_s;

% Weight 2
e_t = .001;
M_t = 2;
omega_bt = 10;
k_t = 2;
W4_t = ((s + (omega_bt/(M_t^(1/k_t))))/((e_t^(1/k_t))*s+omega_bt))^k_t;


[K4,~,~] = mixsyn(G4,W4_s,[],W4_t);
C_tf4 = tf(K4);

S = feedback(1,G4*C_tf4);
T = 1-S;
dis = norm(W4_s*S,inf)
nos = norm(W4_t*T,inf)

% Transfer Functions
R = feedback(G4*C_tf4,1);
D = feedback(G4,C_tf4,-1);
N = -feedback(G4*C_tf4,1);
% Set-Up Sims
t = 0:0.01:30;                     % Time of Sim
t2 = 0:0.01:100;                   % Time of Sim
t3 = 0:0.01:0.5;                   % Time of Sim
r = [ones(1,length(t))];           % Refernce Signal
d = [sin(0.1.*t2)];                % Disturbance
n = [sin(100.*t3)];                % Noise
% Matlab Simulation Function
[a] = lsim(R,r,t);
[b] = lsim(D,d,t2);
[c] = lsim(N,n,t3);

% Plot 2
figure 
hold on
subplot(3,1,1)
title('Reference Tracking')
hold on
plot(t,a(:,1))
plot(t,r)
line([0,30],[.99 .99],'Color','green','LineStyle','--')
xlabel('Time[s]')
ylabel('R Signal')
hold off
subplot(3,1,2)
title('Distrubance Rejection')
hold on
plot(t2,b(:,1))
plot(t2,d)
line([0,100],[.1 .1],'Color','green','LineStyle','--')
line([0,100],[-.1 -.1],'Color','green','LineStyle','--')
xlabel('Time[s]')
ylabel('D Signal')
hold off
subplot(3,1,3)
title('Noise Rejection')
hold on
plot(t3,c(:,1))
plot(t3,n)
line([0,0.5],[.01 .01],'Color','green','LineStyle','--')
line([0,0.5],[-.01 -.01],'Color','green','LineStyle','--')
hold off
xlabel('Time[s]')
ylabel('N Signal')
legend('Sim','Signal','Requirements')
hold off