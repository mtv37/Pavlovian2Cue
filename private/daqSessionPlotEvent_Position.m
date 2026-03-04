% daqSessionPlotEvent_Position shows a real-ish time plot of position from
% the rotary encoder, pulling data from the session's data buffer (see
% daqSessionUPdateDataBuffer.m), and plotting it on the axes specified by
% the variable 'ax'
%
% updated by Mai-Anh Vu, 10/29/2018


function daqSessionPlotEvent_Position(ax)

    global session % our global variable to store everything
    
    hold(ax,'on')
        
    % some setup parameters to calculate position from raw data
    signedData = session.temp.data(:,session.nidaqCh.chIdx_rotEnc);
    signedData(signedData > session.wheel.signedThreshold) = 2^session.wheel.counterNBits-signedData(signedData > session.wheel.signedThreshold);
    positionDataDeg = signedData * 360/session.wheel.encoderCPR;
        
    % chunk to display
    x = session.temp.data(:,1);
    xlim1 = session.temp.k*session.temp.refreshDisplay;
    xlim2 = (session.temp.k+1)*session.temp.refreshDisplay;
           
    % display position
    y = positionDataDeg;
    plot(ax,x,y,'-b','LineWidth',2,'Color',[ 0 0.4470 0.7410]); % color = lines1
    if ~isempty(x)
        set(ax,'XLim',[xlim1 xlim2])
        plot(ax,get(ax,'XLim'),[0 0],'k')
    end
    ylabel(ax,'position')         
    
end
