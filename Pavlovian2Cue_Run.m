% run the pavlovian task 
% Mai-Anh Vu
% 11/17/2021
function Pavlovian2Cue_Run

global session
% if we're delivering unpredicted reward
if session.temp.currentUR>0 && session.exp.trials.unpredRew(session.temp.currentTrial)>0
    if toc(session.temp.itiTimer) >= floor(session.temp.ITI/2)
        disp('* unpred rew *')
        RewardDeliver(session.exp.trials.unpredRew(session.temp.currentTrial));
        session.temp.currentUR = -1;
    end
end
% if the right amount of time has passed to turn on the cue
if session.temp.currentTrial<=session.exp.n_trials && toc(session.temp.itiTimer)>=session.temp.ITI  
    Pavlovian2Cue_cueOn(session.exp.trials.cueRL(session.temp.currentTrial))
    if toc(session.temp.trialTimer)>= session.exp.trials.cueDur(session.temp.currentTrial)    
        % turn off stim
        Pavlovian2Cue_cueOff(session.exp.trials.cueRL(session.temp.currentTrial));
        % increment current Trial
        session.temp.currentTrial = session.temp.currentTrial + 1;
        % restart ITI timer & reset reward
        session.temp.itiTimer = tic;  
        session.temp.trialTimer = tic;      
        session.temp.rewDelivered = 0;
        % pick a new ITI from a uniform distribution on minRewInt:maxRewInt
        if session.temp.currentTrial <= session.exp.n_trials
            session.temp.ITI = session.exp.trials.iti(session.temp.currentTrial);
            session.temp.currentUR = session.exp.trials.unpredRew(session.temp.currentTrial);
            disp(['NEXT TRIAL #' num2str(session.temp.currentTrial) ' in ' num2str(session.temp.ITI) ' s'])
        else
            disp(['***** TASK FINISHED ' datestr(clock) ' *****'])
        end
    % if the right amount of time has passed to deliver reward
    elseif session.temp.rewDelivered == 0 && toc(session.temp.trialTimer)> session.exp.cue_rew_onset(session.exp.trials.cueRL(session.temp.currentTrial))
        % deliver reward (if not an omission)
        if session.exp.trials.rew(session.temp.currentTrial) == 1
            RewardDeliver(session.exp.trials.sizeSL(session.temp.currentTrial)); % deliver reward
            session.temp.rewDelivered = 1;
        end
        
    end
end
    


%turn on one of 2 cues
function Pavlovian2Cue_cueOn(cueNum)
global session % our global variable to store everything

stimOn = session.nidaq.outputZeros;
% turn on sound if it isn't on yet

if session.exp.cue_freq(cueNum) > 0 % tone
    if session.temp.cueOn==0 
        play(session.temp.cues.(['cue' num2str(cueNum)]),session.temp.cues.fs);
        session.temp.trialTimer = tic;
        session.temp.cueOn = 1;

    end
    stimOn(session.nidaqCh.(['outIdx_stimulus_sound' num2str(cueNum)])-1)=1;         
elseif session.exp.cue_freq(cueNum) == -1 % LED
    if session.temp.cueOn==0 
        session.nidaq.s4.queueOutputData(session.temp.cues.(['cue' num2str(cueNum)]));
        session.nidaq.s4.startBackground();        
        session.temp.trialTimer = tic;
        session.temp.cueOn = 1;
    end 
    stimOn(session.nidaqCh.outIdx_stimulus_led-1)=1;
end
% send signal
outputSingleScan(session.nidaq.s2,stimOn);


% turn off sound stim for pavlovian
function Pavlovian2Cue_cueOff(cueNum)
global session % our global variable to store everything

% turn off sound or LED
if session.exp.cue_freq(cueNum) > 0  % sound 
    stop(session.temp.cues.(['cue' num2str(cueNum)]));
elseif session.exp.cue_freq(cueNum) == -1 % LED
end
session.temp.cueOn = 0;

% turn off corollary discharge
stimOff = session.nidaq.outputZeros;
outputSingleScan(session.nidaq.s2,stimOff);

% specific version of RewardDeliver that doesn't interrupt cue
% RewardDeliver(varargin)
function RewardDeliver(varargin)

global session % our global variable to store everything

% check if it's already decided to be small(1), large(2), or medium(3)
if nargin==1 && varargin{1}<=numel(session.rew.vol)
    whichRew = varargin{1};
else % otherwise flip a coin
    % deliver a small or large reward, determined probabilistically from a
    % binomial (aka coinflip) distribution. if no probability given,
    % default to medium reward
    if session.rew.lgRewProb==-1 || ~isfield(session.rew,'lgRewProb')
        whichRew = 3;
    else
        whichRew = binornd(1,session.rew.lgRewProb/100)+1;
    end
end
% make sure we're not interrupting the cues
rewOn = session.nidaq.rewardPulse;
if session.temp.cueOn == 1
    if session.exp.cue_freq(session.exp.trials.cueRL(session.temp.currentTrial)) > 0
        rewOn(session.nidaqCh.(['outIdx_stimulus_sound' num2str(session.exp.trials.cueRL(session.temp.currentTrial))])-1) = 1;
    elseif session.exp.cue_freq(session.exp.trials.cueRL(session.temp.currentTrial)) == -1
        rewOn(session.nidaqCh.outIdx_stimulus_led-1) = 1;
    end    
end
% send rew
for i = 1:session.rew.duration(whichRew) 
    outputSingleScan(session.nidaq.s2,rewOn);
end
% make sure we're not interrupting the cues
rewOff = session.nidaq.outputZeros;
if session.temp.cueOn == 1
    if session.exp.cue_freq(session.exp.trials.cueRL(session.temp.currentTrial)) > 0
        rewOff(session.nidaqCh.(['outIdx_stimulus_sound' num2str(session.exp.trials.cueRL(session.temp.currentTrial))])-1) = 1;
    elseif session.exp.cue_freq(session.exp.trials.cueRL(session.temp.currentTrial)) == -1
        rewOff(session.nidaqCh.outIdx_stimulus_led-1) = 1;
    end    
end
outputSingleScan(session.nidaq.s2,rewOff);    

% keep track of total volume and #small and #large rewards
session.rew.totalVolDelivered = session.rew.totalVolDelivered+session.rew.vol(whichRew);
session.rew.rewCounts(whichRew) = session.rew.rewCounts(whichRew)+1;
session.rew.rewSize = [session.rew.rewSize; whichRew];

% display an updated count on reward delivery
disp(['total rew delivered (uL): ' num2str(session.rew.totalVolDelivered)])
disp(['#sm rew: ' num2str(session.rew.rewCounts(1)) '; #lg rew: ' num2str(session.rew.rewCounts(2)) '; #med rew: ' num2str(session.rew.rewCounts(3))]);




