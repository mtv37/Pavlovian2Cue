% initialize inputs and outputs for auditory/visual pavlovian task
% Mai-Anh Vu
% 11/17/2021

global session % our global variable to store everything

% % add digital input channel (breakout #2 J11: P0.16) to record reward delivery
% [~,session.nidaqCh.chIdx_rew] = addDigitalChannel(session.nidaq.s,session.temp.dev,'Port0/Line16','InputOnly');
% add digital input channel (breakout #1 J71: P0.1) to record reward delivery
[~,session.nidaqCh.chIdx_rew] = addDigitalChannel(session.nidaq.s,session.temp.dev,'Port0/Line1','InputOnly');
session.nidaqCh.chIdx_rew=session.nidaqCh.chIdx_rew+1;

% add digital input channel (J47: P0.3) to record licking
[~,session.nidaqCh.chIdx_lick] = addDigitalChannel(session.nidaq.s,session.temp.dev,'Port0/Line3','InputOnly');
session.nidaqCh.chIdx_lick=session.nidaqCh.chIdx_lick+1;

% % add digital output channel (breakout #2 J10: P0.17) to trigger reward delivery
% [ch_rew,session.nidaqCh.outIdx_rew] = addDigitalChannel(session.nidaq.s2,session.temp.dev,'Port0/Line17','OutputOnly');
% add digital output channel (breakout #1 J42: P1.3) to trigger reward delivery
[ch_rew,session.nidaqCh.outIdx_rew] = addDigitalChannel(session.nidaq.s2,session.temp.dev,'Port1/Line3','OutputOnly');
session.nidaqCh.outIdx_rew=session.nidaqCh.outIdx_rew+1;

% timers & listeners
session.temp.itiTimer = tic; % start a task timer
session.temp.taskTimer = tic; % start a task timer
session.temp.ITI = session.exp.iti_initial;
session.temp.currentTrial = 1;
session.temp.currentUR = -1;
session.nidaq.lh3 = session.nidaq.s.addlistener('DataAvailable', @(src,event) Pavlovian2Cue_Run);
session.temp.cueOn = 0; % cue is initially off
session.temp.rewDelivered = 0; % we haven't yet delivered this trial's reward

% cue 1 sound setup if applicable
session.exp.stimulus_sound1 = 0;
session.exp.stimulus_sound2 = 0;
if session.exp.cue_freq(1)>0 && session.exp.cue_prob(1) > 0
    % add digital output channel (J16 (second board): P0.14) to reflect cond. sound stim
    [ch_cond,session.nidaqCh.outIdx_stimulus_sound1] = addDigitalChannel(session.nidaq.s2,session.temp.dev,'Port0/Line14','OutputOnly');
    session.nidaqCh.outIdx_stimulus_sound1=session.nidaqCh.outIdx_stimulus_sound1+1;
    % add a digital input channel (J49 (second board): P0.10) to record sound stimulus
    [~,session.nidaqCh.chIdx_stimulus_sound1] = addDigitalChannel(session.nidaq.s,session.temp.dev,'Port0/Line10','InputOnly');
    session.nidaqCh.chIdx_stimulus_sound1 = session.nidaqCh.chIdx_stimulus_sound1+1;
    session.exp.stimulus_sound1 = 1;
end
% cue 2 sound if applicable
if session.exp.cue_freq(2)>0 && session.exp.cue_prob(2) > 0
    % add digital output channel (J16 (second board): P0.12) to reflect cond. sound stim
    [ch_cond,session.nidaqCh.outIdx_stimulus_sound2] = addDigitalChannel(session.nidaq.s2,session.temp.dev,'Port0/Line12','OutputOnly');
    session.nidaqCh.outIdx_stimulus_sound2=session.nidaqCh.outIdx_stimulus_sound2+1;
    % add a digital input channel (J49 (second board): P0.8) to record sound stimulus
    [~,session.nidaqCh.chIdx_stimulus_sound2] = addDigitalChannel(session.nidaq.s,session.temp.dev,'Port0/Line8','InputOnly');
    session.nidaqCh.chIdx_stimulus_sound2 = session.nidaqCh.chIdx_stimulus_sound2+1;
    session.exp.stimulus_sound2 = 1;
end
% LED if applicable
if session.exp.cue_freq(1) == -1 || session.exp.cue_freq(2) == -1
    
    % add digital output channel (J51: P0.5) to trigger LED stim
    [~,session.nidaqCh.outIdx_stimulus_led] = addDigitalChannel(session.nidaq.s2,session.temp.dev,'Port0/Line5','OutputOnly');
    session.nidaqCh.outIdx_stimulus_led=session.nidaqCh.outIdx_stimulus_led+1;
    % add a digital input channel (J52: P0.0) to record LED stimulus
    [~,session.nidaqCh.chIdx_stimulus_led] = addDigitalChannel(session.nidaq.s,session.temp.dev,'Port0/Line0','InputOnly');
    session.nidaqCh.chIdx_stimulus_led = session.nidaqCh.chIdx_stimulus_led+1;
    session.exp.stimulus_led = 1;

    % add digital output channel (ao3) to trigger LED ANALOG stim
    session.nidaq.s4 = daq.createSession('ni');
    session.nidaq.s4.Rate = 1000; % samples/second 
    %session.nidaq.s4.IsContinuous = 1; % continuous
    [~,session.nidaqCh.outIdx_stimulus_led_analog] = addAnalogOutputChannel(session.nidaq.s4, session.temp.dev, 'ao3', 'Voltage');
    session.nidaqCh.outIdx_stimulus_led_analog = session.nidaqCh.outIdx_stimulus_led_analog+1;
    session.nidaq.s4.queueOutputData(zeros(500,1)); % send 0s in case
    session.nidaq.s4.startBackground();

    % add a digital input channel (ai22) to record LED ANALOG stimulus
    [~,session.nidaqCh.chIdx_stimulus_led_analog] = addAnalogInputChannel(session.nidaq.s,session.temp.dev,'ai22','Voltage');
    session.nidaqCh.chIdx_stimulus_led_analog = session.nidaqCh.chIdx_stimulus_led_analog+1;
    session.exp.stimulus_led_analog = 1;
end

% activate channels & setup reward magnitudes
session.exp.rew=1;
session.exp.lick=1;
session.rew.duration = [10 23 13]; % photometry
session.rew.vol = [5 9 7]; % S L M 

% keep track of reward volume delivered (uL)
session.rew.totalVolDelivered = 0;
session.rew.rewCounts = [0 0 0];
session.rew.rewSize = [];
if session.exp.delayCond==1
    session.rew.rewTrials = 0;
    session.rew.omitTrials = 0;
end



