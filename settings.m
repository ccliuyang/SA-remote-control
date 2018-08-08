function varargout = settings(varargin)
% SETTINGS MATLAB code for settings.fig
%      SETTINGS, by itself, creates a new SETTINGS or raises the existing
%      singleton*.
%
%      H = SETTINGS returns the handle to a new SETTINGS or the handle to
%      the existing singleton*.
%
%      SETTINGS('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in SETTINGS.M with the given input arguments.
%
%      SETTINGS('Property','Value',...) creates a new SETTINGS or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before settings_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to settings_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help settings

% Last Modified by GUIDE v2.5 25-Jul-2018 22:44:26

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @settings_OpeningFcn, ...
                   'gui_OutputFcn',  @settings_OutputFcn, ...
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


% --- Executes just before settings is made visible.
function settings_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to settings (see VARARGIN)

% Choose default command line output for settings
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes settings wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = settings_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


function rbw_Callback(hObject, eventdata, handles)
% hObject    handle to rbw (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of rbw as text
%        str2double(get(hObject,'String')) returns contents of rbw as a double
try
    global fieldFox;
    value = get(hObject,'String');
    if value
        fprintf(fieldFox,['BAND ',value,'e3']);
    else
        fprintf(fieldFox,'BAND?');
        value = str2double(strtrim(fscanf(fieldFox)))/1e3;
        set(hObject,'String',num2str(value));
    end
catch
    set(handles.info,'String','设备未连接！');
end

% --- Executes during object creation, after setting all properties.
function rbw_CreateFcn(hObject, eventdata, handles)
% hObject    handle to rbw (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function vbw_Callback(hObject, eventdata, handles)
% hObject    handle to vbw (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of vbw as text
%        str2double(get(hObject,'String')) returns contents of vbw as a double
try
    global fieldFox;
    value = get(hObject,'String');
    if value
        fprintf(fieldFox,['BAND:VID ',value,'e3']);
    else
        fprintf(fieldFox,'BAND:VID?');
        value = str2double(strtrim(fscanf(fieldFox)))/1e3;
        set(hObject,'String',num2str(value));
    end
catch
    set(handles.info,'String','设备未连接！');
end

% --- Executes during object creation, after setting all properties.
function vbw_CreateFcn(hObject, eventdata, handles)
% hObject    handle to vbw (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function stopfreq_Callback(hObject, eventdata, handles)
% hObject    handle to stopfreq (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of stopfreq as text
%        str2double(get(hObject,'String')) returns contents of stopfreq as a double
try
    global fieldFox;
    value = get(hObject,'String');
    if value
        fprintf(fieldFox,['FREQ:STOP ',value,'E6']);
    else
        fprintf(fieldFox,'FREQ:STOP?');
        value = str2double(strtrim(fscanf(fieldFox)))/1e6;
        set(hObject,'String',num2str(value));
    end
catch
    set(handles.info,'String','设备未连接！');
end

% --- Executes during object creation, after setting all properties.
function stopfreq_CreateFcn(hObject, eventdata, handles)
% hObject    handle to stopfreq (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function startfreq_Callback(hObject, eventdata, handles)
% hObject    handle to startfreq (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of startfreq as text
%        str2double(get(hObject,'String')) returns contents of startfreq as a double
try
    global fieldFox;
    value = get(hObject,'String');
    if value
        fprintf(fieldFox,['FREQ:STAR ',value,'E6']);
    else
        fprintf(fieldFox,'FREQ:STAR?');
        value = str2double(strtrim(fscanf(fieldFox)))/1e6;
        set(hObject,'String',num2str(value));
    end
catch
    set(handles.info,'String','设备未连接！');
end

% --- Executes during object creation, after setting all properties.
function startfreq_CreateFcn(hObject, eventdata, handles)
% hObject    handle to startfreq (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function span_Callback(hObject, eventdata, handles)
% hObject    handle to span (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of span as text
%        str2double(get(hObject,'String')) returns contents of span as a double
try
    global fieldFox;
    value = get(hObject,'String');
    if value
        fprintf(fieldFox,['FREQ:SPAN ',value,'E6']);
    else
        fprintf(fieldFox,'FREQ:SPAN?');
        value = str2double(strtrim(fscanf(fieldFox)))/1e6;
        set(hObject,'String',num2str(value));
    end
catch
    set(handles.info,'String','设备未连接！');
end

% --- Executes during object creation, after setting all properties.
function span_CreateFcn(hObject, eventdata, handles)
% hObject    handle to span (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function centerfreq_Callback(hObject, eventdata, handles)
% hObject    handle to centerfreq (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of centerfreq as text
%        str2double(get(hObject,'String')) returns contents of centerfreq as a double
try
    global fieldFox;
    value = get(hObject,'String');
    if value
        fprintf(fieldFox,['FREQ:CENT ',value,'E6']);
    else
        fprintf(fieldFox,'FREQ:CENT?');
        value = str2double(strtrim(fscanf(fieldFox)))/1e6;
        set(hObject,'String',num2str(value));
    end
catch
    set(handles.info,'String','设备未连接！');
end

% --- Executes during object creation, after setting all properties.
function centerfreq_CreateFcn(hObject, eventdata, handles)
% hObject    handle to centerfreq (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function reference_Callback(hObject, eventdata, handles)
% hObject    handle to reference (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of reference as text
%        str2double(get(hObject,'String')) returns contents of reference as a double
try
    global fieldFox;
    value = get(hObject,'String');
    if value
        fprintf(fieldFox,['DISP:WIND:TRAC1:Y:RLEV ',value]);
    else
        fprintf(fieldFox,'DISP:WIND:TRAC1:Y:RLEV?');
        value = num2str(str2double(strtrim(fscanf(fieldFox))));
        set(hObject,'String',value);
    end
catch
    set(handles.info,'String','设备未连接！');
end

% --- Executes during object creation, after setting all properties.
function reference_CreateFcn(hObject, eventdata, handles)
% hObject    handle to reference (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function atten_Callback(hObject, eventdata, handles)
% hObject    handle to atten (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of atten as text
%        str2double(get(hObject,'String')) returns contents of atten as a double
try
    global fieldFox;
    value = get(hObject,'String');
    if value
        fprintf(fieldFox,['POW:ATT ',value]);
    else
        fprintf(fieldFox,'POW:ATT?');
        value = strtrim(fscanf(fieldFox));
        set(hObject,'String',value);
    end
catch
    set(handles.info,'String','设备未连接！');
end

% --- Executes during object creation, after setting all properties.
function atten_CreateFcn(hObject, eventdata, handles)
% hObject    handle to atten (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function sweeppoints_Callback(hObject, eventdata, handles)
% hObject    handle to sweeppoints (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of sweeppoints as text
%        str2double(get(hObject,'String')) returns contents of sweeppoints as a double
try
    global fieldFox;
    value = get(hObject,'String');
    if value
        fprintf(fieldFox,['SWE:POIN ',value]);
    else
        fprintf(fieldFox,'SWE:POIN?');
        value = strtrim(fscanf(fieldFox));
        set(hObject,'String',value);
    end
catch
    set(handles.info,'String','设备未连接！');
end

% --- Executes during object creation, after setting all properties.
function sweeppoints_CreateFcn(hObject, eventdata, handles)
% hObject    handle to sweeppoints (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes on selection change in traceselect.
function traceselect_Callback(hObject, eventdata, handles)
% hObject    handle to traceselect (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns traceselect contents as cell array
%        contents{get(hObject,'Value')} returns selected item from traceselect
try
    array = cellstr(get(hObject,'String'));
    index = get(hObject,'Value');
    trace = strtrim(array{index});
    set(hObject,'UserData',trace);
    global fieldFox;
    fprintf(fieldFox,[trace,':TYPE?']);
    type = strtrim(fscanf(fieldFox));
    if strcmp(type,'CLRW')
        set(handles.tracetype,'Value',1);
    elseif strcmp(type,'MAXH')
        set(handles.tracetype,'Value',2);
    elseif strcmp(type,'MINH')
        set(handles.tracetype,'Value',3);
    elseif strcmp(type,'AVG')
        set(handles.tracetype,'Value',4);
    elseif strcmp(type,'BLAN')
        set(handles.tracetype,'Value',5);
    end
catch
    set(handles.info,'String','设备未连接！');
end

% --- Executes during object creation, after setting all properties.
function traceselect_CreateFcn(hObject, eventdata, handles)
% hObject    handle to traceselect (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes on selection change in tracetype.
function tracetype_Callback(hObject, eventdata, handles)
% hObject    handle to tracetype (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns tracetype contents as cell array
%        contents{get(hObject,'Value')} returns selected item from tracetype
try
    array = cellstr(get(hObject,'String'));
    index = get(hObject,'Value');
    type = strtrim(array{index});
    if strcmp(type,'Clear Write')
        type = 'CLRW';
    elseif strcmp(type,'Max Hold')
        type = 'MAXH';
    elseif strcmp(type,'Min Hold')
        type = 'MINH';
    elseif strcmp(type,'Average')
        type = 'AVG';
    elseif strcmp(type,'Blank')
        type = 'BLAN';
    end
    trace = get(handles.traceselect,'UserData');
    global fieldFox;
    fprintf(fieldFox,[trace,':TYPE ',type]);
catch
    set(handles.info,'String','设备未连接！');
end

% --- Executes during object creation, after setting all properties.
function tracetype_CreateFcn(hObject, eventdata, handles)
% hObject    handle to tracetype (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes on button press in voltavg.
function voltavg_Callback(hObject, eventdata, handles)
% hObject    handle to voltavg (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of voltavg
try
    set(handles.voltavg,'Value',1);
    set(handles.poweravg,'Value',0);
    set(handles.logavg,'Value',0);
    global fieldFox;
    fprintf(fieldFox,'AVER:TYPE VOLT');
catch
    set(handles.info,'String','设备未连接！');
end

% --- Executes on button press in poweravg.
function poweravg_Callback(hObject, eventdata, handles)
% hObject    handle to poweravg (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of poweravg
try
    set(handles.voltavg,'Value',0);
    set(handles.poweravg,'Value',1);
    set(handles.logavg,'Value',0);
    global fieldFox;
    fprintf(fieldFox,'AVER:TYPE POW');
catch
    set(handles.info,'String','设备未连接！');
end

% --- Executes on button press in logavg.
function logavg_Callback(hObject, eventdata, handles)
% hObject    handle to logavg (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of logavg
try
    set(handles.voltavg,'Value',0);
    set(handles.poweravg,'Value',0);
    set(handles.logavg,'Value',1);
    global fieldFox;
    fprintf(fieldFox,'AVER:TYPE LOG');
catch
    set(handles.info,'String','设备未连接！');
end

function avgcount_Callback(hObject, eventdata, handles)
% hObject    handle to avgcount (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of avgcount as text
%        str2double(get(hObject,'String')) returns contents of avgcount as a double
try
    global fieldFox;
    value = get(hObject,'String');
    if value
        fprintf(fieldFox,['AVER:COUN ',value]);
    else
        fprintf(fieldFox,'AVER:COUN?');
        value = strtrim(fscanf(fieldFox));
        set(hObject,'String',value);
    end
catch
    set(handles.info,'String','设备未连接！');
end

% --- Executes during object creation, after setting all properties.
function avgcount_CreateFcn(hObject, eventdata, handles)
% hObject    handle to avgcount (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes on button press in restartcount.
function restartcount_Callback(hObject, eventdata, handles)
% hObject    handle to restartcount (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
try
    global fieldFox;
    fprintf(fieldFox,'INIT:REST');
catch
    set(handles.info,'String','设备未连接！');
end

% --- Executes on button press in savesetting.
function savesetting_Callback(hObject, eventdata, handles)
% hObject    handle to savesetting (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
settings = {};
settings{1} = get(handles.centerfreq,'String');
settings{2} = get(handles.span,'String');
settings{3} = get(handles.startfreq,'String');
settings{4} = get(handles.stopfreq,'String');
settings{5} = get(handles.rbw,'String');
settings{6} = get(handles.vbw,'String');
settings{7} = get(handles.reference,'String');
settings{8} = get(handles.atten,'String');
settings{9} = get(handles.sweeppoints,'String');
settings{10} = 1; 
set(handles.traceselect,'Value',1);
traceselect_Callback(handles.traceselect, eventdata, handles);
settings{11} = get(handles.tracetype,'Value');
settings{12} = 2; 
set(handles.traceselect,'Value',2);
traceselect_Callback(handles.traceselect, eventdata, handles);
settings{13} = get(handles.tracetype,'Value');
settings{14} = 3; 
set(handles.traceselect,'Value',3);
traceselect_Callback(handles.traceselect, eventdata, handles);
settings{15} = get(handles.tracetype,'Value');
settings{16} = 4; 
set(handles.traceselect,'Value',4);
traceselect_Callback(handles.traceselect, eventdata, handles);
settings{17} = get(handles.tracetype,'Value');
settings{18} = get(handles.poweravg,'Value');
settings{19} = get(handles.logavg,'Value');
settings{20} = get(handles.voltavg,'Value');
settings{21} = get(handles.avgcount,'String');
[file,path] = uiputfile('*.mat');
save([path,file],'settings');

% --- Executes on button press in loadsetting.
function loadsetting_Callback(hObject, eventdata, handles)
% hObject    handle to loadsetting (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[file,path] = uigetfile('*.mat');
settingsstruct = load([path,file]);
settingscell = struct2cell(settingsstruct);
s = settingscell{1};
set(handles.centerfreq,'String',s{1});
centerfreq_Callback(handles.centerfreq, eventdata, handles);
set(handles.span,'String',s{2});
span_Callback(handles.span, eventdata, handles);
set(handles.startfreq,'String',s{3});
startfreq_Callback(handles.startfreq, eventdata, handles);
set(handles.stopfreq,'String',s{4});
stopfreq_Callback(handles.stopfreq, eventdata, handles);
set(handles.rbw,'String',s{5});
rbw_Callback(handles.rbw, eventdata, handles);
set(handles.vbw,'String',s{6});
vbw_Callback(handles.vbw, eventdata, handles);
set(handles.reference,'String',s{7});
reference_Callback(handles.reference, eventdata, handles);
set(handles.atten,'String',s{8});
atten_Callback(handles.atten, eventdata, handles);
set(handles.sweeppoints,'String',s{9});
sweeppoints_Callback(handles.sweeppoints, eventdata, handles);
set(handles.traceselect,'Value',s{10});
traceselect_Callback(handles.traceselect, eventdata, handles);
set(handles.tracetype,'Value',s{11});
tracetype_Callback(handles.tracetype, eventdata, handles);
set(handles.traceselect,'Value',s{12});
traceselect_Callback(handles.traceselect, eventdata, handles);
set(handles.tracetype,'Value',s{13});
tracetype_Callback(handles.tracetype, eventdata, handles);
set(handles.traceselect,'Value',s{14});
traceselect_Callback(handles.traceselect, eventdata, handles);
set(handles.tracetype,'Value',s{15});
tracetype_Callback(handles.tracetype, eventdata, handles);
set(handles.traceselect,'Value',s{16});
traceselect_Callback(handles.traceselect, eventdata, handles);
set(handles.tracetype,'Value',s{17});
tracetype_Callback(handles.tracetype, eventdata, handles);
if s{18}
    poweravg_Callback(handles.poweravg, eventdata, handles);
elseif s{19}
    logavg_Callback(handles.logavg, eventdata, handles);
elseif s{20}
    voltavg_Callback(handles.voltavg, eventdata, handles);
end
set(handles.avgcount,'String',s{21});
avgcount_Callback(handles.avgcount, eventdata, handles);