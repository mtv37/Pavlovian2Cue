% daqSessionPlotEvent_Velocity shows a real-ish time plot of velocity from
% the rotary encoder, pulling data from the session's data buffer (see
% daqSessionUPdateDataBuffer.m), and plotting it on the axes specified by
% the variable 'ax'
%
% updated by Mai-Anh Vu, 10/29/2018


function daqSessionPlotEvent_Velocity(ax)
    global session % our global variable to store everything
    hold(ax,'on')
    % some setup parameters to calculate position from raw data
    signedData = session.temp.data(:,session.nidaqCh.chIdx_rotEnc);
    signedData(signedData > session.wheel.signedThreshold) = signedData(signedData > session.wheel.signedThreshold)-2^session.wheel.counterNBits;
    positionMeters = signedData * session.wheel.wheelCirc/session.wheel.encoderCPR;
    


    % chunk to display
    x = session.temp.data(:,1);
    xlim1 = session.temp.k*session.temp.refreshDisplay;
    xlim2 = (session.temp.k+1)*session.temp.refreshDisplay;
    
    % display velocity (derivative of position)      
    y = diff(positionMeters)*session.nidaq.s.Rate; % m/s
    %y = smooth(y,51); % for now smooth over a 25ms window
    
    % debug: plot raw data
%     y = session.temp.data(:,session.nidaqCh.chIdx_rotEnc);
%     y(y>2^31) = 2^32-y(y>2^31);
    if length(x)>length(y)
        y = [nan; y];
    end
    plot(ax,x,y,'-r','LineWidth',2,'Color',[0.6350 0.0780 0.1840]) % color = lines7
    if ~isempty(x)
        set(ax,'XLim',[xlim1 xlim2],'YLim',[-1 1])
        plot(ax,get(ax,'XLim'),[0 0],'k')
    end
    ylabel(ax,'velocity (m/s)')     
end
