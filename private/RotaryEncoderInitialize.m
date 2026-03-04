
% RotaryEncoderInitialize intializes the data acquisition session to read
% rotary encoder input into Matlab (see RotaryEncoderGUI.m) 
% 
% updated by Mai-Anh Vu, 10/24/18
%
% NI board wiring: A=37/PFI8, B=45/PFI10, Z=3/PFI9
%
% Quadrature encoding (X1, X2, or X4) reference: 
% https://www.linearmotiontips.com/what-is-quadrature-encoding/
%
% Details for our encoder: https://cdn.usdigital.com/assets/datasheets/E2_datasheet.pdf?k=636758977285753184
%
% this uses the following other scripts: 

global session % our global variable to store everything

% add clock
addAnalogInputChannel(session.nidaq.s, session.temp.dev, 'ai0', 'Voltage');

% add our rotary encoder to the session
[ch_rotEnc,session.nidaqCh.chIdx_rotEnc] = addCounterInputChannel(session.nidaq.s, session.temp.dev, 3, 'Position');
session.nidaqCh.chIdx_rotEnc=session.nidaqCh.chIdx_rotEnc+1;

% configure our channel: set quadrature encoding type
ch_rotEnc.EncoderType = 'X4'; 

% some setup parameters to calculate position from raw data
session.wheel.encoderCPR = 5000; % our encoder can do 32-5000, our disc is 5000
session.wheel.encoderCPR = session.wheel.encoderCPR*4; % x 4
session.wheel.counterNBits = 32; % we have 32-bit counter channels
session.wheel.signedThreshold = 2^(session.wheel.counterNBits-1);
session.wheel.wheelDiam = 7.5*2.54/100; % wheel diameter in meters (diam = 7.5")
session.wheel.wheelCirc = pi*session.wheel.wheelDiam; % in meters
% active channel
session.exp.rotEnc = 1;
