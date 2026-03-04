% daqSessionPlotEvent_Pavlovian2Cue shows a real-ish time plot of 
% sound stimuli from 2-cue Pavloviain task, pulling data 
% from the session's data buffer (see daqSessionUpdateDataBuffer.m), and 
% plotting it on the axes specified by the variable 'ax' (can put on as
% many axes as desired)
%
% updated by Mai-Anh Vu, 11/17/2021


function daqSessionPlotEvent_Pavlovian2Cue(varargin)
    global session % our global variable to store everything
    
    for v = 1:length(varargin)
        ax = varargin{v};
        hold(ax,'on')

        % chunk to display
        x = session.temp.data(:,1);
        xlim1 = session.temp.k*session.temp.refreshDisplay;
        xlim2 = (session.temp.k+1)*session.temp.refreshDisplay;
    
        ylim = get(ax,'YLim');
        y1 = ones(size(x))*ylim(1);
        if isfield(session.exp,'stimulus_sound1') && session.exp.stimulus_sound1 == 1 % if cue 1 is sound
            y1(session.temp.data(:,session.nidaqCh.chIdx_stimulus_sound1)==1) = ylim(2);
        elseif isfield(session.exp,'stimulus_led') % if cue 2 is sound
            y1(session.temp.data(:,session.nidaqCh.chIdx_stimulus_led)>0) = ylim(2);
        end
        y2 = ones(size(x))*ylim(1);
        if isfield(session.exp,'stimulus_sound2') && session.exp.stimulus_sound2 == 1 % if cue 2 is sound
            y2(session.temp.data(:,session.nidaqCh.chIdx_stimulus_sound2)==1) = ylim(2);
        elseif isfield(session.exp,'stimulus_led') % if cue 2 is LED
            y2(session.temp.data(:,session.nidaqCh.chIdx_stimulus_led)>0) = ylim(2);            
        end
        plot(ax,x,y1,'-','Color',[0 0.4470 0.7410],'LineWidth',2,'LineStyle',':') % blue (lines1)
        plot(ax,x,y2,'-','Color',[0.8500 0.3250 0.0980],'LineWidth',2,'LineStyle',':') % orange (lines(2)
        if ~isempty(x)
            set(ax,'XLim',[xlim1 xlim2],'YLim',[-1 1])
            plot(ax,get(ax,'XLim'),[0 0],'k')
        end        
        set(ax,'YLim',ylim);
    end
end
