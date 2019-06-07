function varargout = custom(varargin)
% CUSTOM MATLAB code for custom.fig
%      CUSTOM, by itself, creates a new CUSTOM or raises the existing
%      singleton*.
%
%      H = CUSTOM returns the handle to a new CUSTOM or the handle to
%      the existing singleton*.
%
%      CUSTOM('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in CUSTOM.M with the given input arguments.
%
%      CUSTOM('Property','Value',...) creates a new CUSTOM or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before custom_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to custom_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help custom

% Last Modified by GUIDE v2.5 06-Jun-2019 22:07:57

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @custom_OpeningFcn, ...
                   'gui_OutputFcn',  @custom_OutputFcn, ...
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


% --- Executes just before custom is made visible.
function custom_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to custom (see VARARGIN)

% Choose default command line output for custom
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes custom wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = custom_OutputFcn(hObject, eventdata, handles) 
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



function repeattimes_Callback(hObject, eventdata, handles)
% hObject    handle to repeattimes (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of repeattimes as text
%        str2double(get(hObject,'String')) returns contents of repeattimes as a double


% --- Executes during object creation, after setting all properties.
function repeattimes_CreateFcn(hObject, eventdata, handles)
% hObject    handle to repeattimes (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in savepng.
function savepng_Callback(hObject, eventdata, handles)
% hObject    handle to savepng (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of savepng


% --- Executes on button press in savecsv.
function savecsv_Callback(hObject, eventdata, handles)
% hObject    handle to savecsv (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of savecsv


% --- Executes on button press in pushbutton8.
function pushbutton8_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



% --- Executes on button press in start.
function start_Callback(hObject, eventdata, handles)
% hObject    handle to start (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in exportmeassetting.
function exportmeassetting_Callback(hObject, eventdata, handles)
% hObject    handle to exportmeassetting (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in importmeassetting.
function importmeassetting_Callback(hObject, eventdata, handles)
% hObject    handle to importmeassetting (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% --- Executes on button press in quickmaxhold.
function quickmaxhold_Callback(hObject, eventdata, handles)
% hObject    handle to quickmaxhold (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of quickmaxhold


% --- Executes on button press in quickzerospan.
function quickzerospan_Callback(hObject, eventdata, handles)
% hObject    handle to quickzerospan (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of quickzerospan


% --- Executes on button press in autospan.
function autospan_Callback(hObject, eventdata, handles)
% hObject    handle to autospan (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of autospan


% --- Executes on button press in autorbw.
function autorbw_Callback(hObject, eventdata, handles)
% hObject    handle to autorbw (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of autorbw



function repeatinterval_Callback(hObject, eventdata, handles)
% hObject    handle to repeatinterval (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of repeatinterval as text
%        str2double(get(hObject,'String')) returns contents of repeatinterval as a double


% --- Executes during object creation, after setting all properties.
function repeatinterval_CreateFcn(hObject, eventdata, handles)
% hObject    handle to repeatinterval (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in repeatcheck.
function repeatcheck_Callback(hObject, eventdata, handles)
% hObject    handle to repeatcheck (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of repeatcheck




% --- Executes on button press in ontimecheck.
function ontimecheck_Callback(hObject, eventdata, handles)
% hObject    handle to ontimecheck (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of ontimecheck



% --- Executes on selection change in repeatunit.
function repeatunit_Callback(hObject, eventdata, handles)
% hObject    handle to repeatunit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns repeatunit contents as cell array
%        contents{get(hObject,'Value')} returns selected item from repeatunit


% --- Executes during object creation, after setting all properties.
function repeatunit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to repeatunit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function item1_Callback(hObject, eventdata, handles)
% hObject    handle to item1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of item1 as text
%        str2double(get(hObject,'String')) returns contents of item1 as a double


% --- Executes during object creation, after setting all properties.
function item1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to item1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes on button press in clearitem.
function clearitem_Callback(hObject, eventdata, handles)
% hObject    handle to clearitem (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)




% --- Executes on button press in itemselect1.
function itemselect1_Callback(hObject, eventdata, handles)
% hObject    handle to itemselect1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



% --- Executes on button press in additem.
function additem_Callback(hObject, eventdata, handles)
% hObject    handle to additem (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


function ontime_Callback(hObject, eventdata, handles)
% hObject    handle to ontime (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ontime as text
%        str2double(get(hObject,'String')) returns contents of ontime as a double


% --- Executes during object creation, after setting all properties.
function ontime_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ontime (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function itemtime1_Callback(hObject, eventdata, handles)
% hObject    handle to itemtime1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of itemtime1 as text
%        str2double(get(hObject,'String')) returns contents of itemtime1 as a double


% --- Executes during object creation, after setting all properties.
function itemtime1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to itemtime1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in itemunit1.
function itemunit1_Callback(hObject, eventdata, handles)
% hObject    handle to itemunit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns itemunit1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from itemunit1


% --- Executes during object creation, after setting all properties.
function itemunit1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to itemunit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function itemtimes1_Callback(hObject, eventdata, handles)
% hObject    handle to itemtimes1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of itemtimes1 as text
%        str2double(get(hObject,'String')) returns contents of itemtimes1 as a double


% --- Executes during object creation, after setting all properties.
function itemtimes1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to itemtimes1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function savepath_Callback(hObject, eventdata, handles)
% hObject    handle to savepath (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of savepath as text
%        str2double(get(hObject,'String')) returns contents of savepath as a double


% --- Executes during object creation, after setting all properties.
function savepath_CreateFcn(hObject, eventdata, handles)
% hObject    handle to savepath (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in selectpath.
function selectpath_Callback(hObject, eventdata, handles)
% hObject    handle to selectpath (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



function itemtext2_Callback(hObject, eventdata, handles)
% hObject    handle to itemtext2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of itemtext2 as text
%        str2double(get(hObject,'String')) returns contents of itemtext2 as a double


% --- Executes during object creation, after setting all properties.
function itemtext2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to itemtext2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in itemselect2.
function itemselect2_Callback(hObject, eventdata, handles)
% hObject    handle to itemselect2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



function itemtext3_Callback(hObject, eventdata, handles)
% hObject    handle to itemtext3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of itemtext3 as text
%        str2double(get(hObject,'String')) returns contents of itemtext3 as a double


% --- Executes during object creation, after setting all properties.
function itemtext3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to itemtext3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in itemselect3.
function itemselect3_Callback(hObject, eventdata, handles)
% hObject    handle to itemselect3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in savesat.
function savesat_Callback(hObject, eventdata, handles)
% hObject    handle to savesat (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of savesat


function itemtime2_Callback(hObject, eventdata, handles)
% hObject    handle to itemtime2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of itemtime2 as text
%        str2double(get(hObject,'String')) returns contents of itemtime2 as a double


% --- Executes during object creation, after setting all properties.
function itemtime2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to itemtime2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in itemunit2.
function itemunit2_Callback(hObject, eventdata, handles)
% hObject    handle to itemunit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns itemunit2 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from itemunit2


% --- Executes during object creation, after setting all properties.
function itemunit2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to itemunit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function itemtimes2_Callback(hObject, eventdata, handles)
% hObject    handle to itemtimes2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of itemtimes2 as text
%        str2double(get(hObject,'String')) returns contents of itemtimes2 as a double


% --- Executes during object creation, after setting all properties.
function itemtimes2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to itemtimes2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function itemtime3_Callback(hObject, eventdata, handles)
% hObject    handle to itemtime3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of itemtime3 as text
%        str2double(get(hObject,'String')) returns contents of itemtime3 as a double


% --- Executes during object creation, after setting all properties.
function itemtime3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to itemtime3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in itemunit3.
function itemunit3_Callback(hObject, eventdata, handles)
% hObject    handle to itemunit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns itemunit3 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from itemunit3


% --- Executes during object creation, after setting all properties.
function itemunit3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to itemunit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function itemtimes3_Callback(hObject, eventdata, handles)
% hObject    handle to itemtimes3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of itemtimes3 as text
%        str2double(get(hObject,'String')) returns contents of itemtimes3 as a double


% --- Executes during object creation, after setting all properties.
function itemtimes3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to itemtimes3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
