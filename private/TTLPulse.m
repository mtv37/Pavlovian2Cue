% send a TTL pulse

global session % our global variable to store everything

% deliver a TTL to the TTL sync channel, without interrupting delay
% conditioning LED stimulus or 5V square
ttlOn = session.nidaq.TTLpulse;
if isfield(session.temp,'delayStimOn') && session.temp.delayStimOn == 1
    if session.temp.delivLED == 1
        ttlOn(session.nidaqCh.outIdx_stimulus-1)=1;   
    end
    if session.temp.delivSound == 1 && session.temp.soundTTL == 0 
        ttlOn(session.nidaqCh.outIdx_stimulus_sound-1)=1; 
    end
end
if isfield(session.nidaqCh,'outIdx_squareSwitch')
    ttlOn(session.nidaqCh.outIdx_squareSwitch-1) = 1;
end
for i = 1:10
    outputSingleScan(session.nidaq.s2,ttlOn);    
end
% set TTL sync to zero, without interrupting delay
% conditioning stimulus or 5V square
ttlOff = session.nidaq.outputZeros;
if isfield(session.temp,'delayStimOn') && session.temp.delayStimOn == 1
    if session.temp.delivLED == 1
        ttlOff(session.nidaqCh.outIdx_stimulus-1)=1;   
    end
    if session.temp.delivSound == 1 && session.temp.soundTTL == 0 
        ttlOff(session.nidaqCh.outIdx_stimulus_sound-1)=1; 
    end
end
if isfield(session.nidaqCh,'outIdx_squareSwitch') && session.temp.digSquareOn == 1
    ttlOff(session.nidaqCh.outIdx_squareSwitch-1) = 1;
end
outputSingleScan(session.nidaq.s2,ttlOff);
% update TTL count
session.TTLcountOut = session.TTLcountOut+1;
