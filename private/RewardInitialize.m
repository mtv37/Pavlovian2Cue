% initialize inputs and outputs for reward & task
% updated 8/6/2020 to move reward and TTL out to second breakout board
% updated 8/10/2021 to only set session.rew.

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

% for unpredicted reward or delay conditioning, initialize a timer, ITI field, and third listener
if session.exp.unpredReward==1 || session.exp.delayCond==1
    session.temp.rewTimer = tic; % start a reward timer    
    session.temp.ITI = Inf;
    if session.exp.unpredReward==1
        session.nidaq.lh3 = session.nidaq.s.addlistener('DataAvailable', @(src,event) RewardUnpredDeliver);
    elseif session.exp.delayCond==1
        session.nidaq.lh3 = session.nidaq.s.addlistener('DataAvailable', @(src,event) delayCondTask);
        session.temp.stimSwitch = 0;

        % classical cond stim: LED
        if  session.rew.delayCondLED == 1
            % add digital output channel (J51: P0.5) to trigger cond. LED stim
            [ch_cond,session.nidaqCh.outIdx_stimulus] = addDigitalChannel(session.nidaq.s2,session.temp.dev,'Port0/Line5','OutputOnly');
            session.nidaqCh.outIdx_stimulus=session.nidaqCh.outIdx_stimulus+1;
            % add a digital input channel (J52: P0.0) to record LED stimulus
            [~,session.nidaqCh.chIdx_stimulus] = addDigitalChannel(session.nidaq.s,session.temp.dev,'Port0/Line0','InputOnly');
            session.nidaqCh.chIdx_stimulus = session.nidaqCh.chIdx_stimulus+1;
            session.exp.stimulus = 1;
            session.temp.delivLED = 1;
        else
            session.temp.delivLED = 0;
        end
        % classical cond stim: sound
        if  session.rew.delayCondSound == 1
            try
                % add digital output channel (J16 (second board): P0.14) to reflect cond. sound stim
                [ch_cond,session.nidaqCh.outIdx_stimulus_sound] = addDigitalChannel(session.nidaq.s2,session.temp.dev,'Port0/Line14','OutputOnly');
                session.nidaqCh.outIdx_stimulus_sound=session.nidaqCh.outIdx_stimulus_sound+1;
                % add a digital input channel (J49 (second board): P0.10) to record sound stimulus
                [~,session.nidaqCh.chIdx_stimulus_sound] = addDigitalChannel(session.nidaq.s,session.temp.dev,'Port0/Line10','InputOnly');
                session.nidaqCh.chIdx_stimulus_sound = session.nidaqCh.chIdx_stimulus_sound+1;
                session.temp.soundTTL = 0;
            catch
                session.temp.soundTTL = 1;
                disp('Sorry, need 2nd breakout board to record sound.')
                disp('Will send a triple TTL for each sound delivery')
                disp('instead.')
            end
            session.exp.stimulus_sound = 1;
            session.temp.delivSound = 1;
        else
            session.temp.delivSound = 0;
        end 
        
    end
end

% active channel
session.exp.rew=1;
session.exp.lick=1;

%%%%%% REWARD VOLUME %%%%%%
% duration of the square reward pulse in ms, calibrated as follows
% reward inputs: 1 = sm, 2 = lg, 3 = med
% relevant calibrations: 914E photometry (10/28/21):
%   5uL     13
%   9uL     25
%   7uL     19
%   13 uL   39
% relevant calibrations: 914G 2p:
%   5uL     25
%   9uL     40
%   7uL     33
% 
% if these values aren't set elsewhere, set them here
if ~isfield(session,'rew') || ~isfield(session.rew,'duration')
    % SET THESE IN THIS ORDER: S L M
    session.rew.duration = [13 25 19]; % photometry
    %session.rew.duration = [25 40 33]; % 2p
    session.rew.vol = [5 9 7];
end

% keep track of reward volume delivered (uL)
session.rew.totalVolDelivered = 0;
session.rew.rewCounts = [0 0 0];
session.rew.rewSize = [];
if session.exp.delayCond==1
    session.rew.rewTrials = 0;
    session.rew.omitTrials = 0;
end

% let's have a paused variable to keept track of whether or not we're
% pausing the reward timer
session.temp.rewPaused = 0;


