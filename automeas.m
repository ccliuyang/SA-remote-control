function varargout = automeas(varargin)
% AUTOMEAS MATLAB code for automeas.fig
%      AUTOMEAS, by itself, creates a new AUTOMEAS or raises the existing
%      singleton*.
%
%      H = AUTOMEAS returns the handle to a new AUTOMEAS or the handle to
%      the existing singleton*.
%
%      AUTOMEAS('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in AUTOMEAS.M with the given input arguments.
%
%      AUTOMEAS('Property','Value',...) creates a new AUTOMEAS or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before automeas_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to automeas_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help automeas

% Last Modified by GUIDE v2.5 26-Jul-2018 09:58:54

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @automeas_OpeningFcn, ...
                   'gui_OutputFcn',  @automeas_OutputFcn, ...
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


% --- Executes just before automeas is made visible.
function automeas_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to automeas (see VARARGIN)

% Choose default command line output for automeas
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes automeas wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = automeas_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

function times_Callback(hObject, eventdata, handles)
% hObject    handle to times (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of times as text
%        str2double(get(hObject,'String')) returns contents of times as a double


% --- Executes during object creation, after setting all properties.
function times_CreateFcn(hObject, eventdata, handles)
% hObject    handle to times (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function continued_Callback(hObject, eventdata, handles)
% hObject    handle to continued (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of continued as text
%        str2double(get(hObject,'String')) returns contents of continued as a double

% --- Executes during object creation, after setting all properties.
function continued_CreateFcn(hObject, eventdata, handles)
% hObject    handle to continued (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function interval_Callback(hObject, eventdata, handles)
% hObject    handle to interval (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of interval as text
%        str2double(get(hObject,'String')) returns contents of interval as a double

% --- Executes during object creation, after setting all properties.
function interval_CreateFcn(hObject, eventdata, handles)
% hObject    handle to interval (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in screen.
function screen_Callback(hObject, eventdata, handles)
% hObject    handle to screen (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of screen


% --- Executes on button press in data.
function data_Callback(hObject, eventdata, handles)
% hObject    handle to data (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of data


% --- Executes on button press in select.
function select_Callback(hObject, eventdata, handles)
% hObject    handle to select (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
path = uigetdir;
if path
    set(handles.selected,'String',path);
end

function selected_Callback(hObject, eventdata, handles)
% hObject    handle to selected (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of selected as text
%        str2double(get(hObject,'String')) returns contents of selected as a double

% --- Executes during object creation, after setting all properties.
function selected_CreateFcn(hObject, eventdata, handles)
% hObject    handle to selected (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in setting.
function setting_Callback(hObject, eventdata, handles)
% hObject    handle to setting (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
settings;

% --- Executes on button press in start.
function start_Callback(hObject, eventdata, handles)
% hObject    handle to start (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global fieldFox;
n = str2double(get(handles.times,'String'));
meastime = str2double(get(handles.continued,'String'));
waitime = str2double(get(handles.interval,'String'));
screensave = get(handles.screen,'Value');
datasave = get(handles.data,'Value');
path = get(handles.selected,'String');
for i = 1:n
    set(handles.info,'String',['正在进行第',num2str(i),'次测量！']);
    fprintf(fieldFox,'INIT:REST');
    pause(meastime);
    if screensave
        save_screen(fieldFox,path);
    end
    if datasave
        save_data(fieldFox,path);
    end
    if i < n
        pause(waitime);
    end
end
set(handles.info,'String','自动测量结束！');


% --- Executes on button press in savesetting.
function savesetting_Callback(hObject, eventdata, handles)
% hObject    handle to savesetting (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
s = {};
s{1} = get(handles.times,'String');
s{2} = get(handles.continued,'String');
s{3} = get(handles.interval,'String');
s{4} = get(handles.screen,'Value');
s{5} = get(handles.data,'Value');
s{6} = get(handles.selected,'String');
[file,path] = uiputfile('*.mat');
save([path,file],'s');

% --- Executes on button press in loadsetting.
function loadsetting_Callback(hObject, eventdata, handles)
% hObject    handle to loadsetting (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[file,path] = uigetfile('*.mat');
settingsstruct = load([path,file]);
settingscell = struct2cell(settingsstruct);
s = settingscell{1};
set(handles.times,'String',s{1});
set(handles.continued,'String',s{2});
set(handles.interval,'String',s{3});
set(handles.screen,'Value',s{4});
set(handles.data,'Value',s{5});
set(handles.selected,'String',s{6});