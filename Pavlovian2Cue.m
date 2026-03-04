% Mai-Anh Vu, 10/2/2021
function varargout = Pavlovian2Cue(varargin)
global session % our global variable to store everything
% Pavlovian2Cue MATLAB code for Pavlovian2Cue.fig
%      Pavlovian2Cue, by itself, creates a new Pavlovian2Cue or raises the existing
%      singleton*.
%
%      H = Pavlovian2Cue returns the handle to a new Pavlovian2Cue or the handle to
%      the existing singleton*.
%
%      Pavlovian2Cue('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in Pavlovian2Cue.M with the given input arguments.
%
%      Pavlovian2Cue('Property','Value',...) creates a new Pavlovian2Cue or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the Pavlovian2Cue before Pavlovian2Cue_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Pavlovian2Cue_OpeningFcn via varargin.
%
%      *See Pavlovian2Cue Options on GUIDE's Tools menu.  Choose "Pavlovian2Cue allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Pavlovian2Cue

% Last Modified by GUIDE v2.5 19-Oct-2022 11:53:00

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Pavlovian2Cue_OpeningFcn, ...
                   'gui_OutputFcn',  @Pavlovian2Cue_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT

% --- Executes just before Pavlovian2Cue is made visible.
function Pavlovian2Cue_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Pavlovian2Cue (see VARARGIN)

% Choose default command line output for Pavlovian2Cue
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);


% UIWAIT makes Pavlovian2Cue wait for user response (see UIRESUME)
% uiwait(handles.figure1);

% --- Outputs from this function are returned to the command line.
function output = Pavlovian2Cue_OutputFcn(hObject, eventdata, handles)
global session
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
session.handles=handles;
output = session;


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%% SAVING OUTPUT %%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


% --- Executes on button press in save_path_button.
function save_path_button_Callback(hObject, eventdata, handles)
% hObject    handle to save_path_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.save_path,'String',uigetdir(get(handles.save_path,'String')));


function save_path_Callback(hObject, eventdata, handles)
% hObject    handle to save_path (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of save_path as text
%        str2double(get(hObject,'String')) returns contents of save_path as a double


% --- Executes during object creation, after setting all properties.
function save_path_CreateFcn(hObject, eventdata, handles)
% hObject    handle to save_path (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function filename_prefix_Callback(hObject, eventdata, handles)
% hObject    handle to filename_prefix (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of filename_prefix as text
%        str2double(get(hObject,'String')) returns contents of filename_prefix as a double


% --- Executes during object creation, after setting all properties.
function filename_prefix_CreateFcn(hObject, eventdata, handles)
% hObject    handle to filename_prefix (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end    

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%% TASK SETUP %%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function cue1_prob_Callback(hObject, eventdata, handles)
% hObject    handle to cue1_prob (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of cue1_prob as text
%        str2double(get(hObject,'String')) returns contents of cue1_prob as a double
if str2double(get(hObject,'String'))<0
    set(hObject,'String','0');
elseif str2double(get(hObject,'String'))>100
    set(hObject,'String','100');
end 
set(handles.cue2_prob,'String',num2str(100-str2double(get(hObject,'String'))));
if str2double(get(handles.cue1_prob,'String'))==0
    set(handles.cue1_freq,'Enable','off');
    set(handles.cue1_duration_mean,'Enable','off');
    set(handles.cue1_duration_std,'Enable','off');
    set(handles.cue1_rew_prob,'Enable','off');    
else
    set(handles.cue1_freq,'Enable','on');
    set(handles.cue1_duration_mean,'Enable','on');
    %set(handles.cue1_duration_std,'Enable','on');
    set(handles.cue1_rew_prob,'Enable','on');
end
if str2double(get(handles.cue2_prob,'String'))==0
    set(handles.cue2_freq,'Enable','off');
    set(handles.cue2_duration_mean,'Enable','off');
    set(handles.cue2_duration_std,'Enable','off');
    set(handles.cue2_rew_prob,'Enable','off');    
else
    set(handles.cue2_freq,'Enable','on');
    set(handles.cue2_duration_mean,'Enable','on');
    %set(handles.cue2_duration_std,'Enable','on');
    set(handles.cue2_rew_prob,'Enable','on'); 
end



% --- Executes during object creation, after setting all properties.
function cue1_prob_CreateFcn(hObject, eventdata, handles)
% hObject    handle to cue1_prob (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function cue2_prob_Callback(hObject, eventdata, handles)
% hObject    handle to cue2_prob (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of cue2_prob as text
%        str2double(get(hObject,'String')) returns contents of cue2_prob as a double
if str2double(get(hObject,'String'))<0
    set(hObject,'String','0');
elseif str2double(get(hObject,'String'))>100
    set(hObject,'String','100');
end 
set(handles.cue1_prob,'String',num2str(100-str2double(get(hObject,'String'))));
if str2double(get(handles.cue1_prob,'String'))==0
    set(handles.cue1_freq,'Enable','off');
    set(handles.cue1_duration_mean,'Enable','off');
    set(handles.cue1_duration_std,'Enable','off');
    set(handles.cue1_rew_prob,'Enable','off');    
else
    set(handles.cue1_freq,'Enable','on');
    set(handles.cue1_duration_mean,'Enable','on');
    %set(handles.cue1_duration_std,'Enable','on');
    set(handles.cue1_rew_prob,'Enable','on');
end
if str2double(get(handles.cue2_prob,'String'))==0
    set(handles.cue2_freq,'Enable','off');
    set(handles.cue2_duration_mean,'Enable','off');
    %set(handles.cue2_duration_std,'Enable','off');
    set(handles.cue2_rew_prob,'Enable','off');    
else
    set(handles.cue2_freq,'Enable','on');
    set(handles.cue2_duration_mean,'Enable','on');
    %set(handles.cue2_duration_std,'Enable','on');
    set(handles.cue2_rew_prob,'Enable','on'); 
end

% --- Executes during object creation, after setting all properties.
function cue2_prob_CreateFcn(hObject, eventdata, handles)
% hObject    handle to cue2_prob (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function cue1_freq_Callback(hObject, eventdata, handles)
% hObject    handle to cue1_freq (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of cue1_freq as text
%        str2double(get(hObject,'String')) returns contents of cue1_freq as a double

% --- Executes during object creation, after setting all properties.
function cue1_freq_CreateFcn(hObject, eventdata, handles)
% hObject    handle to cue1_freq (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function cue2_freq_Callback(hObject, eventdata, handles)
% hObject    handle to cue2_freq (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of cue2_freq as text
%        str2double(get(hObject,'String')) returns contents of cue2_freq as a double


% --- Executes during object creation, after setting all properties.
function cue2_freq_CreateFcn(hObject, eventdata, handles)
% hObject    handle to cue2_freq (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end





function cue2_relVol_Callback(hObject, eventdata, handles)
% hObject    handle to cue2_relVol (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of cue2_relVol as text
%        str2double(get(hObject,'String')) returns contents of cue2_relVol as a double


% --- Executes during object creation, after setting all properties.
function cue2_relVol_CreateFcn(hObject, eventdata, handles)
% hObject    handle to cue2_relVol (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function cue1_relVol_Callback(hObject, eventdata, handles)
% hObject    handle to cue1_relVol (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of cue1_relVol as text
%        str2double(get(hObject,'String')) returns contents of cue1_relVol as a double


% --- Executes during object creation, after setting all properties.
function cue1_relVol_CreateFcn(hObject, eventdata, handles)
% hObject    handle to cue1_relVol (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function cue2_rew_onset_Callback(hObject, eventdata, handles)
% hObject    handle to cue2_rew_onset (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of cue2_rew_onset as text
%        str2double(get(hObject,'String')) returns contents of cue2_rew_onset as a double


% --- Executes during object creation, after setting all properties.
function cue2_rew_onset_CreateFcn(hObject, eventdata, handles)
% hObject    handle to cue2_rew_onset (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function cue1_duration_mean_Callback(hObject, eventdata, handles)
% hObject    handle to cue1_duration_mean (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of cue1_duration_mean as text
%        str2double(get(hObject,'String')) returns contents of cue1_duration_mean as a double


% --- Executes during object creation, after setting all properties.
function cue1_duration_mean_CreateFcn(hObject, eventdata, handles)
% hObject    handle to cue1_duration_mean (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function cue2_duration_mean_Callback(hObject, eventdata, handles)
% hObject    handle to cue2_duration_mean (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of cue2_duration_mean as text
%        str2double(get(hObject,'String')) returns contents of cue2_duration_mean as a double


% --- Executes during object creation, after setting all properties.
function cue2_duration_mean_CreateFcn(hObject, eventdata, handles)
% hObject    handle to cue2_duration_mean (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function cue1_duration_std_Callback(hObject, eventdata, handles)
% hObject    handle to cue1_duration_std (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of cue1_duration_std as text
%        str2double(get(hObject,'String')) returns contents of cue1_duration_std as a double


% --- Executes during object creation, after setting all properties.
function cue1_duration_std_CreateFcn(hObject, eventdata, handles)
% hObject    handle to cue1_duration_std (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function cue2_duration_std_Callback(hObject, eventdata, handles)
% hObject    handle to cue2_duration_std (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of cue2_duration_std as text
%        str2double(get(hObject,'String')) returns contents of cue2_duration_std as a double


% --- Executes during object creation, after setting all properties.
function cue2_duration_std_CreateFcn(hObject, eventdata, handles)
% hObject    handle to cue2_duration_std (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function cue1_rew_onset_Callback(hObject, eventdata, handles)
% hObject    handle to cue1_rew_onset (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of cue1_rew_onset as text
%        str2double(get(hObject,'String')) returns contents of cue1_rew_onset as a double


% --- Executes during object creation, after setting all properties.
function cue1_rew_onset_CreateFcn(hObject, eventdata, handles)
% hObject    handle to cue1_rew_onset (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function cue1_rew_prob_Callback(hObject, eventdata, handles)
% hObject    handle to cue1_rew_prob (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of cue1_rew_prob as text
%        str2double(get(hObject,'String')) returns contents of cue1_rew_prob as a double


% --- Executes during object creation, after setting all properties.
function cue1_rew_prob_CreateFcn(hObject, eventdata, handles)
% hObject    handle to cue1_rew_prob (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function cue2_rew_prob_Callback(hObject, eventdata, handles)
% hObject    handle to cue2_rew_prob (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of cue2_rew_prob as text
%        str2double(get(hObject,'String')) returns contents of cue2_rew_prob as a double


% --- Executes during object creation, after setting all properties.
function cue2_rew_prob_CreateFcn(hObject, eventdata, handles)
% hObject    handle to cue2_rew_prob (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function ur_rew1_Callback(hObject, eventdata, handles)
% hObject    handle to ur_rew1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ur_rew1 as text
%        str2double(get(hObject,'String')) returns contents of ur_rew1 as a double


% --- Executes during object creation, after setting all properties.
function ur_rew1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ur_rew1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



% --- Executes on button press in cue1_rew_S.
function cue1_rew_S_Callback(hObject, eventdata, handles)
% hObject    handle to cue1_rew_S (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of cue1_rew_S


% --- Executes on button press in cue1_rew_M.
function cue1_rew_M_Callback(hObject, eventdata, handles)
% hObject    handle to cue1_rew_M (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of cue1_rew_M


% --- Executes on button press in cue1_rew_L.
function cue1_rew_L_Callback(hObject, eventdata, handles)
% hObject    handle to cue1_rew_L (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of cue1_rew_L


% --- Executes on button press in cue2_rew_S.
function cue2_rew_S_Callback(hObject, eventdata, handles)
% hObject    handle to cue2_rew_S (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of cue2_rew_S


% --- Executes on button press in cue2_rew_M.
function cue2_rew_M_Callback(hObject, eventdata, handles)
% hObject    handle to cue2_rew_M (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of cue2_rew_M


% --- Executes on button press in cue2_rew_L.
function cue2_rew_L_Callback(hObject, eventdata, handles)
% hObject    handle to cue2_rew_L (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of cue2_rew_L

function ur_rew2_Callback(hObject, eventdata, handles)
% hObject    handle to ur_rew2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ur_rew2 as text
%        str2double(get(hObject,'String')) returns contents of ur_rew2 as a double


% --- Executes during object creation, after setting all properties.
function ur_rew2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ur_rew2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%% RUNTIME %%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


function iti_min_Callback(hObject, eventdata, handles)
% hObject    handle to iti_min (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of iti_min as text
%        str2double(get(hObject,'String')) returns contents of iti_min as a double
if str2double(get(hObject,'String')) < 3 
    set(hObject,'String','3')
end

% --- Executes during object creation, after setting all properties.
function iti_min_CreateFcn(hObject, eventdata, handles)
% hObject    handle to iti_min (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function iti_max_Callback(hObject, eventdata, handles)
% hObject    handle to iti_min (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of iti_min as text
%        str2double(get(hObject,'String')) returns contents of iti_min as a double
if str2double(get(hObject,'String')) < str2double(get(handles.iti_min,'String'))
    set(hObject,'String',(get(handles.iti_min,'String')))
end

% --- Executes during object creation, after setting all properties.
function iti_max_CreateFcn(hObject, eventdata, handles)
% hObject    handle to iti_min (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end





function n_trials_Callback(hObject, eventdata, handles)
% hObject    handle to n_trials (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of n_trials as text
%        str2double(get(hObject,'String')) returns contents of n_trials as a double


% --- Executes during object creation, after setting all properties.
function n_trials_CreateFcn(hObject, eventdata, handles)
% hObject    handle to n_trials (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function iti_initial_Callback(hObject, eventdata, handles)
% hObject    handle to iti_initial (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of iti_initial as text
%        str2double(get(hObject,'String')) returns contents of iti_initial as a double


% --- Executes during object creation, after setting all properties.
function iti_initial_CreateFcn(hObject, eventdata, handles)
% hObject    handle to iti_initial (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls susually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% SIMILAR TO generateTrialOrder used in VirMEn but here allows probabilities to be set
% separately for each cue. Here n_trials = # trials. cue2Prob is the prob
% of cue 2 vs cue 1. 'otherProbs' should be p x 2 matrix, where each row p
% has values for each of the 2 cues.
function trialOrderMatrix = generateTrialOrder2(nTrials,cue2Prob,otherDims)
% here, we generate trials, where trial types are binary, noted by 1s and
% 2s. the probabilities in dimprobs, reflect the probability of a 2.
rng('shuffle'); % shuffle random number generator
maxIt = 20000; % max iterations for scrambling
pause(1)

% let's first generate the cue vectors
c.cue2 = 2*ones(round(nTrials*cue2Prob),1);
c.cue1 = ones(nTrials-numel(c.cue2),1);

% now let's sort those trials types
for i = 1:size(otherDims,1)
    for cc = 1:2                
        trialTypesSoFar = unique(c.(['cue' num2str(cc)])(:,:),'rows');
        tmp = [];            
        for tt = 1:size(trialTypesSoFar,1)
            theseTrials = c.(['cue' num2str(cc)]) == trialTypesSoFar(tt,:);
            theseTrials = ones(sum(sum(theseTrials,2)==size(trialTypesSoFar,2)),1);
            n2 = otherDims(i,cc)*numel(theseTrials);
            % if the # trials isn't an int, randomly (50/50) round up/down
            if floor(n2) < n2
                n2 = floor(n2) + round(rand(1,1));
            end
            theseTrials(1:n2) = 2;
            tmp = [tmp; repmat(trialTypesSoFar(tt,:),numel(theseTrials),1) theseTrials];
        end
        c.(['cue' num2str(cc)]) = tmp;
    end
end

trialOrderMatrix = [c.cue1; c.cue2];

% let's control the # of cues in a row, if the prob is .5
cueConsecMax = 3;
if cue2Prob == .5
    % scramble 500 times first
    for i = 1:500
        trialOrderMatrix = trialOrderMatrix(randsample((1:nTrials),nTrials),:);
    end
    % now scramble as much as necessary so there aren't 3 same cues in a
    % row
    it = 1;
    nCueConsecMax = cueConsecMax+1;
    while it <= maxIt && nCueConsecMax > cueConsecMax        
        trialOrderMatrix = trialOrderMatrix(randsample((1:nTrials),nTrials),:);
        nCueConsecMax = max(diff([1; find(diff(trialOrderMatrix(:,1))~=0)]));
        it = it + 1;
    end      
else % just scramble it 2500 times
    for t = 1:2500
        trialOrderMatrix = trialOrderMatrix(randsample((1:nTrials),nTrials),:);
    end
end

%%% generate sound cues
function cues = generateSoundLEDCues(freqs,dur,varargin)
ip = inputParser;
ip.addParameter('relativeVolume',ones(size(freqs)))
ip.parse(varargin{:});
for j = fields(ip.Results)'
    eval([j{1} '=ip.Results.' j{1} ';']);
end

cues = struct;
nSeconds = dur;
%sounds.fs = 2.25*max(freqs);
cues.fs = 44100;
for f = 1:numel(freqs)
    if freqs(f) == -1 % LED data
        cues.(['cue' num2str(f)]) = [ones(1000*nSeconds(f),1)*relativeVolume(f); 0];
    else % tone audioplayer object
        cues.(['cue' num2str(f)]) = audioplayer(relativeVolume(f) * sin(linspace(0, nSeconds(f)*freqs(f)*1000*2*pi, round(nSeconds(f)*cues.fs))),cues.fs);
    end
end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%% PHOTOMETRY LEDs %%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


% --- Executes on button press in led_470.
function led_470_Callback(hObject, eventdata, handles)
% hObject    handle to led_470 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of led_470


% --- Executes on button press in led_570.
function led_570_Callback(hObject, eventdata, handles)
% hObject    handle to led_570 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of led_570


% --- Executes on button press in led_405.
function led_405_Callback(hObject, eventdata, handles)
% hObject    handle to led_405 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of led_405


function rec_freq_Callback(hObject, eventdata, handles)
% hObject    handle to rec_freq (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of rec_freq as text
%        str2double(get(hObject,'String')) returns contents of rec_freq as a double


% --- Executes during object creation, after setting all properties.
function rec_freq_CreateFcn(hObject, eventdata, handles)
% hObject    handle to rec_freq (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%% RUN %%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


% --- Executes on button press in run_setup_ok.
function run_setup_ok_Callback(hObject, eventdata, handles)
global session
% hObject    handle to run_setup_ok (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
warning('off','daq:Session:onDemandOnlyChannelsAdded')
% disable a bunch of things from further editing
set(handles.save_path_button,'Enable','off')
set(handles.save_path,'Enable','off')
set(handles.filename_prefix,'Enable','off')
set(handles.cue1_prob,'Enable','off')
set(handles.cue2_prob,'Enable','off')
set(handles.cue1_freq,'Enable','off')
set(handles.cue2_freq,'Enable','off')
set(handles.cue1_relVol,'Enable','off')
set(handles.cue2_relVol,'Enable','off')
set(handles.cue1_duration_mean,'Enable','off')
set(handles.cue2_duration_mean,'Enable','off')
set(handles.cue1_duration_std,'Enable','off')
set(handles.cue2_duration_std,'Enable','off')
set(handles.cue1_rew_onset,'Enable','off')
set(handles.cue2_rew_onset,'Enable','off')
set(handles.cue1_rew_prob,'Enable','off')
set(handles.cue2_rew_prob,'Enable','off')
set(handles.cue1_rew_S,'Enable','off')
set(handles.cue1_rew_M,'Enable','off')
set(handles.cue1_rew_L,'Enable','off')
set(handles.cue2_rew_S,'Enable','off')
set(handles.cue2_rew_M,'Enable','off')
set(handles.cue2_rew_L,'Enable','off')
set(handles.ur_rew1,'Enable','off')
set(handles.ur_rew2,'Enable','off')
set(handles.iti_min,'Enable','off')
set(handles.iti_max,'Enable','off')
set(handles.iti_initial,'Enable','off')
set(handles.n_trials,'Enable','off')
set(handles.led_470,'Enable','off')
set(handles.led_570,'Enable','off')
set(handles.led_405,'Enable','off')
set(handles.rec_freq,'Enable','off')
set(handles.treadmillBall,'Enable','off')
set(handles.treadmillLinear,'Enable','off')
set(handles.run_setup_ok,'Enable','off')

%%%%% saving out the data
% the mouse prefix (replace spaces with underscore)
session.mouse = get(handles.filename_prefix,'String');
session.mouse = strjoin(strsplit(session.mouse,' '),'_');
if strncmp(session.mouse(end),'_',1)
    session.mouse = session.mouse(1:end-1);
end
% the filename (and also update that field)
filename = [session.mouse '_' datestr(clock,'YYYY.mm.dd_HH.MM.ss')];
session.dataFilename = fullfile(get(handles.save_path,'String'),filename);

%%%%% initialize some session variables
session.temp.refreshDisplay=3;
session.exp.pav_2cue = 1;
session.exp.delayCond = 0;
session.exp.cue_prob = [str2double(get(handles.cue1_prob,'String')),...
    str2double(get(handles.cue2_prob,'String'))];
session.exp.cue_freq = [str2double(get(handles.cue1_freq,'String')),...
    str2double(get(handles.cue2_freq,'String'))];
session.exp.cue_relativeVol = [str2double(get(handles.cue1_relVol,'String')),...
    str2double(get(handles.cue2_relVol,'String'))];
session.exp.cue_duration_mean = [str2double(get(handles.cue1_duration_mean,'String')),...
    str2double(get(handles.cue2_duration_mean,'String'))];
session.exp.cue_duration_std = [str2double(get(handles.cue1_duration_std,'String')),...
    str2double(get(handles.cue2_duration_std,'String'))];
session.exp.cue_rew_onset = [str2double(get(handles.cue1_rew_onset,'String')),...
    str2double(get(handles.cue2_rew_onset,'String'))];
session.exp.cue_rew_prob = [str2double(get(handles.cue1_rew_prob,'String')),...
    str2double(get(handles.cue2_rew_prob,'String'))];
if get(handles.cue1_rew_S,'Value')==1
    cue1magstr = 'S';
    cue1idx = 1;
elseif get(handles.cue1_rew_M,'Value')==1
    cue1magstr = 'M';
    cue1idx = 3;   
else
    cue1magstr = 'L';
    cue1idx = 2;
end
if get(handles.cue2_rew_S,'Value')==1
    cue2magstr = 'S';
    cue2idx = 1;
elseif get(handles.cue2_rew_M,'Value')==1
    cue2magstr = 'M';
    cue2idx = 3;   
else
    cue2magstr = 'L';
    cue2idx = 2;
end
session.exp.cue_rew_mag_str = {cue1magstr cue2magstr};
session.exp.cue_rew_mag = [cue1idx cue2idx];
session.exp.ur_rew_n = [str2double(get(handles.ur_rew1,'String')),...
    str2double(get(handles.ur_rew2,'String'))];
session.exp.ur_rew_mag = [cue1idx cue2idx];
session.exp.iti_interval = [str2double(get(handles.iti_min,'String')),...
    str2double(get(handles.iti_max,'String'))];
session.exp.iti_initial = str2double(get(handles.iti_initial,'String'));
session.exp.n_trials = str2double(get(handles.n_trials,'String'));

%%%%% initialize other things
daqSessionInitialize; 
if get(handles.treadmillLinear,'Value')==1
    RotaryEncoderInitialize;
else
    BallInitialize;
end
Pavlovian2Cue_Initialize;
% initialze LEDs
session.exp.LEDwavelengths = [470 570 405];
session.exp.LEDon = [get(handles.led_470,'Value'),...
    get(handles.led_570,'Value'),...
    get(handles.led_405,'Value')];
session.exp.LEDrecFreq = str2double(get(handles.rec_freq,'String'));
if sum(session.exp.LEDon)>0 && session.exp.LEDrecFreq>0
    session.exp.LED = 1;
    LEDInitialize; % initialize
end
% initialize TTL signals (in & out)
session.exp.ttlOut = 1;  
session.exp.ttlIn = 1;
TTLSyncInitialize; % initialize
%%%%% finalize setup
daqSessionInitializeDataBuffer; % initialize the data buffer for vis.
daqSessionInitializeOutputs; % gather the output channels and initialize


%%%%% generate trial table
trialOrderMatrix = generateTrialOrder2(session.exp.n_trials,...
    session.exp.cue_prob(2)/100,...
    session.exp.cue_rew_prob/100);
session.exp.trials = table((1:session.exp.n_trials)',...
    trialOrderMatrix(:,1),trialOrderMatrix(:,2),...
    'VariableNames',{'trialNum','cueRL','rew'});
session.exp.trials.rew = session.exp.trials.rew-1;
% add in reward magnitude
session.exp.trials.sizeSL = zeros(size(session.exp.trials.trialNum));
session.exp.trials.sizeSL(session.exp.trials.cueRL==1) = session.exp.cue_rew_mag(1);
session.exp.trials.sizeSL(session.exp.trials.cueRL==2) = session.exp.cue_rew_mag(2);
% add in cue durations
session.exp.trials.cueDur = zeros(size(session.exp.trials.trialNum));
for cc = 1:2
    session.exp.trials.cueDur(session.exp.trials.cueRL==cc) = abs(normrnd(session.exp.cue_duration_mean(cc),...
        session.exp.cue_duration_std(cc),sum(session.exp.trials.cueRL==cc),1));
end
% add in ITI
if range(session.exp.iti_interval)>0
    session.exp.trials.iti = transpose(randsample(session.exp.iti_interval(1):session.exp.iti_interval(2),session.exp.n_trials,1));
else
    session.exp.trials.iti = repmat(session.exp.iti_interval(1),session.exp.n_trials,1);
end
session.exp.trials.iti(1) = session.exp.iti_initial;

% unpred rewards
session.exp.trials.unpredRew = zeros(size(session.exp.trials.trialNum));
if sum(session.exp.ur_rew_n>0) == 2
    % make sure we're not asking for too many
    while sum(session.exp.ur_rew_n)>=session.exp.n_trials
        session.exp.ur_rew_n = session.exp.ur_rew_n - 1;
    end    
    % which trials? (unpred rew will be in preceding ITI)
    unpredRewTrials = randsample(session.exp.n_trials,sum(session.exp.ur_rew_n));
    while ismember(1,unpredRewTrials) % make sure it's not the first trial
        unpredRewTrials = randsample(session.exp.n_trials,sum(session.exp.ur_rew_n));
    end
    % magnitude
    unpredRewMag = [repmat(session.exp.cue_rew_mag(1),session.exp.ur_rew_n(1),1);...
        repmat(session.exp.cue_rew_mag(2),session.exp.ur_rew_n(2),1)];
    unpredRewMag = unpredRewMag(randsample(numel(unpredRewMag),numel(unpredRewMag)));
    % fill in table
    session.exp.trials.unpredRew = zeros(size(session.exp.trials.trialNum));
    session.exp.trials.unpredRew(unpredRewTrials) = unpredRewMag;
end

%%% generate sound cues
%maxdur = 2*max(session.exp.cue_duration_mean + 3*session.exp.cue_duration_std);
maxdur = session.exp.cue_duration_mean;
session.temp.cues = generateSoundLEDCues(session.exp.cue_freq,maxdur,'relativeVolume',session.exp.cue_relativeVol);

%%% enable start button
set(handles.run_start,'Enable','on') 


% --- Executes on button press in run_start.
function run_start_Callback(hObject, eventdata, handles)
global session % our global variable to store everything
% hObject    handle to run_start (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% update buttons and editable text windows
set(handles.run_start,'Enable','off')
set(handles.run_stop,'Enable','on')
session.starttime = datestr(clock);
session.temp.itiTimer = tic; % start a task timer
session.temp.trialTimer = tic; % start a task timer
disp('*******************')
daqSessionRecord; % start the session

% --- Executes on button press in run_stop.
function run_stop_Callback(hObject, eventdata, handles)
global session % our global variable to store everything
% hObject    handle to run_stop (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.run_stop,'Enable','off') % turn off the stop button
daqSessionClose; % close data acquisition session
% see if you want to save out data
answer = questdlg('Save acquired data?', ...
	'Save acquired data?', ...
	'Yes','No','Yes');
% Handle response
switch answer
    case 'Yes'
        daqSessionSave; % save out the full data from the session
    case 'No'
        daqSessionDeleteBackup; % delete the backup file logging the data
end

%clearvars % clear variables
close(gcbf) % close GUI
clear global % clear global variables

% see if you want to run another experiment
answer = questdlg('Start another session?', ...
	'Start another session?', ...
	'Yes','No','Yes');
% Handle response
switch answer
    case 'Yes'
        %close all
        run('Pavlovian2Cue');
    case 'No'
        %close all
end


% --- Executes on button press in treadmillBall.
function treadmillBall_Callback(hObject, eventdata, handles)
% hObject    handle to treadmillBall (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of treadmillBall


% --- Executes on button press in treadmillLinear.
function treadmillLinear_Callback(hObject, eventdata, handles)
% hObject    handle to treadmillLinear (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of treadmillLinear
