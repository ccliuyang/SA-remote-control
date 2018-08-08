function varargout = RemoteSA(varargin)
% RemoteSA MATLAB code for RemoteSA.fig
%      RemoteSA, by itself, creates a new RemoteSA or raises the existing
%      singleton*.
%
%      H = RemoteSA returns the handle to a new RemoteSA or the handle to
%      the existing singleton*.
%
%      RemoteSA('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in RemoteSA.M with the given input arguments.
%
%      RemoteSA('Property','Value',...) creates a new RemoteSA or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the RemoteSA before RemoteSA_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to RemoteSA_OpeningFcn via varargin.
%
%      *See RemoteSA Options on GUIDE's Tools menu.  Choose "RemoteSA allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help RemoteSA

% Last Modified by GUIDE v2.5 26-Jul-2018 19:47:33

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @RemoteSA_OpeningFcn, ...
                   'gui_OutputFcn',  @RemoteSA_OutputFcn, ...
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

% --- Executes just before RemoteSA is made visible.
function RemoteSA_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to RemoteSA (see VARARGIN)

% Choose default command line output for RemoteSA
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

img = imread('starter.png');
axes(handles.axes1);
imshow(img);

% UIWAIT makes RemoteSA wait for user response (see UIRESUME)
% uiwait(handles.figure1);

% --- Outputs from this function are returned to the command line.
function varargout = RemoteSA_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

% --- Executes on button press in connect.
function connect_Callback(hObject, eventdata, handles)
% hObject    handle to connect (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
try
    ip = get(handles.setip,'String');
    global fieldFox;
    fieldFox = connect(ip);
    set(handles.info,'String','连接成功！');
catch
    set(handles.info,'String','连接失败，请检查网络！');
end

% --- Executes on button press in disconnect.
function disconnect_Callback(hObject, eventdata, handles)
% hObject    handle to disconnect (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.screenrefresh,'Value',0);
try
    global fieldFox;
    disconnect(fieldFox);
    set(handles.info,'String','断开成功！');
catch
    set(handles.info,'String','设备已断开，请勿重复操作！');
end

% --- Executes on button press in savescreen.
function savescreen_Callback(hObject, eventdata, handles)
% hObject    handle to savescreen (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
try
    global fieldFox;
    path = get(handles.selectedpath,'String');
    save_screen(fieldFox,path);
    if path
        set(handles.info,'String',['成功保存屏幕到 ',path]);
    else
        set(handles.info,'String','成功保存屏幕到当前目录');
    end
catch
    set(handles.info,'String','设备未连接！');
end

% --- Executes on button press in savedata.
function savedata_Callback(hObject, eventdata, handles)
% hObject    handle to savedata (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
try
    global fieldFox;
    path = get(handles.selectedpath,'String');
    save_data(fieldFox,path);
    if path
        set(handles.info,'String',['成功保存数据到 ',path]);
    else
        set(handles.info,'String','成功保存数据到当前目录');
    end
catch
    set(handles.info,'String','设备未连接！');
end

% --- Executes on button press in screenrefresh.
function screenrefresh_Callback(hObject, eventdata, handles) %#ok<*DEFNU>
% hObject    handle to screenrefresh (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
try
    status = get(hObject,'Value');
    global fieldFox;
    while status == 1
        screenshot(fieldFox);
        axis off;
        screen = imread('temp.png');
        axes(handles.axes1); %#ok<*LAXES>
        imshow(screen);
        pause(0.5);
        status = get(hObject,'Value');
    end
catch
    set(handles.info,'String','设备未连接！');
end

% --- Executes on button press in screenshot.
function screenshot_Callback(hObject, eventdata, handles)
% hObject    handle to screenshot (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
try
    set(handles.screenrefresh,'Value',0);
    global fieldFox;
    screenshot(fieldFox);
    axis off;
    screen = imread('temp.png');
    axes(handles.axes1);
    imshow(screen);
catch
    set(handles.info,'String','设备未连接！');
end

% --- Executes during object creation, after setting all properties.
function axes1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to axes1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: place code in OpeningFcn to populate axes1
axis off;

function setip_Callback(hObject, eventdata, handles)
% hObject    handle to setip (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of setip as text
%        str2double(get(hObject,'String')) returns contents of setip as a double
set(handles.info,'String',['成功修改设备IP为 ',get(hObject,'String'),'！']);

% --- Executes during object creation, after setting all properties.
function setip_CreateFcn(hObject, eventdata, handles)
% hObject    handle to setip (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes on button press in check.
function check_Callback(hObject, eventdata, handles)
% hObject    handle to check (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
try
    global fieldFox;
    fprintf(fieldFox, '*CLS');
    set(handles.info,'String','设备已连接！');
catch
    set(handles.info,'String','设备未连接！');
end

% --- Executes on button press in reboot.
function reboot_Callback(hObject, eventdata, handles)
% hObject    handle to reboot (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
try
    set(handles.screenrefresh,'Value',0);
    global fieldFox;
    fprintf(fieldFox, 'SYST:PWR:SHUT 0');
    set(handles.info,'String','设备正在重启！');
catch
    set(handles.info,'String','设备未连接！');
end

% --- Executes on button press in shutdown.
function shutdown_Callback(hObject, eventdata, handles)
% hObject    handle to shutdown (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
try
    set(handles.screenrefresh,'Value',0);
    global fieldFox;
    fprintf(fieldFox, 'SYST:PWR:SHUT -1');
    set(handles.info,'String','设备已关闭！');
catch
    set(handles.info,'String','设备未连接！');
end

% --- Executes on button press in automeas.
function automeas_Callback(hObject, eventdata, handles)
% hObject    handle to automeas (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
try
    global fieldFox;
    fprintf(fieldFox,'INST "SA"');
    set(handles.screenrefresh,'Value',0);
    automeas;
catch
    set(handles.info,'String','设备未连接！');
end

% --- Executes on button press in GSM.
function GSM_Callback(hObject, eventdata, handles)
% hObject    handle to GSM (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of GSM
set(handles.GSM,'Value',1);
set(handles.CDMA,'Value',0);
set(handles.WCDMA,'Value',0);
set(handles.FDDLTE,'Value',0);
set(handles.TDLTE,'Value',0);
set(handles.WLAN,'Value',0);
load('historys.mat');
n = str2double(get(handles.times,'String'));
t = str2double(get(handles.time,'String'))*60;
if n
    try
        global fieldFox;
        common_config(fieldFox);
        fprintf(fieldFox,'FREQ:STAR 935E6');
        fprintf(fieldFox,'FREQ:STOP 960E6');
        set(handles.result,'String','正在评估GSM网络，请稍等！');
        for i = 1:n
            set(handles.info,'String',['正在进行第',num2str(i),'次测量！']);
            fprintf(fieldFox,'INIT:REST');
            pause(t);
            m1 = dBm2E(max(read_trace(fieldFox,'1')));
            m2 = dBm2E(max(read_trace(fieldFox,'2')));
            screenshot(fieldFox);
            axis off;
            screen = imread('temp.png');
            axes(handles.axes1);
            imshow(screen);
            set(handles.result,'String',['最大辐射值为：',10,'   ',num2str(m1),' V/m',10,'平均辐射值为：',10,'   ',num2str(m2),' V/m']);
            historys{1} = [historys{1};m1,m2];
            save('historys.mat','historys');
        end
        set(handles.info,'String','测量结束！');
    catch
        set(handles.result,'String','设备未连接！');
    end
end
% --- Executes on button press in WLAN.
function WLAN_Callback(hObject, eventdata, handles)
% hObject    handle to WLAN (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of WLAN
set(handles.GSM,'Value',0);
set(handles.CDMA,'Value',0);
set(handles.WCDMA,'Value',0);
set(handles.FDDLTE,'Value',0);
set(handles.TDLTE,'Value',0);
set(handles.WLAN,'Value',1);
load('historys.mat');
n = str2double(get(handles.times,'String'));
t = str2double(get(handles.time,'String'))*60;
if n
    try
        global fieldFox;
        common_config(fieldFox);
        fprintf(fieldFox,'FREQ:STAR 2402E6');
        fprintf(fieldFox,'FREQ:STOP 2422E6');
        set(handles.result,'String','正在评估WLAN网络，请稍等！');
        for i =1:n
            set(handles.info,'String',['正在进行第',num2str(i),'次测量！']);
            fprintf(fieldFox,'INIT:REST');
            pause(t);
            m1 = dBm2E(max(read_trace(fieldFox,'1')));
            m2 = dBm2E(max(read_trace(fieldFox,'2')));
            screenshot(fieldFox);
            axis off;
            screen = imread('temp.png');
            axes(handles.axes1);
            imshow(screen);
            set(handles.result,'String',['最大辐射值为：',10,'   ',num2str(m1),' V/m',10,'平均辐射值为：',10,'   ',num2str(m2),' V/m']);
            historys{6} = [historys{6};m1,m2];
            save('historys.mat','historys');
        end
        set(handles.info,'String','测量结束！');
    catch
        set(handles.result,'String','设备未连接！');
    end
end
% --- Executes on button press in TDLTE.
function TDLTE_Callback(hObject, eventdata, handles)
% hObject    handle to TDLTE (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of TDLTE
set(handles.GSM,'Value',0);
set(handles.CDMA,'Value',0);
set(handles.WCDMA,'Value',0);
set(handles.FDDLTE,'Value',0);
set(handles.TDLTE,'Value',1);
set(handles.WLAN,'Value',0);
load('historys.mat');
n = str2double(get(handles.times,'String'));
t = str2double(get(handles.time,'String'))*60;
if n
    try
        global fieldFox;
        common_config(fieldFox);
        fprintf(fieldFox,'FREQ:STAR 1885E6');
        fprintf(fieldFox,'FREQ:STOP 1905E6');
        set(handles.result,'String','正在评估TD-LTE网络，请稍等！');
        for i = 1:n
            set(handles.info,'String',['正在进行第',num2str(i),'次测量！']);
            fprintf(fieldFox,'INIT:REST');
            pause(t);
            m1 = dBm2E(max(read_trace(fieldFox,'1')));
            m2 = dBm2E(max(read_trace(fieldFox,'2')));
            screenshot(fieldFox);
            axis off;
            screen = imread('temp.png');
            axes(handles.axes1);
            imshow(screen);
            set(handles.result,'String',['最大辐射值为：',10,'   ',num2str(m1),'V/m',10,'平均辐射值为：',10,'   ',num2str(m2),'V/m']);
            historys{5} = [historys{5};m1,m2];
            save('historys.mat','historys');
        end
        set(handles.info,'String','测量结束！');
    catch
        set(handles.result,'String','设备未连接！');
    end
end

% --- Executes on button press in FDDLTE.
function FDDLTE_Callback(hObject, eventdata, handles)
% hObject    handle to FDDLTE (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of FDDLTE
set(handles.GSM,'Value',0);
set(handles.CDMA,'Value',0);
set(handles.WCDMA,'Value',0);
set(handles.FDDLTE,'Value',1);
set(handles.TDLTE,'Value',0);
set(handles.WLAN,'Value',0);
load('historys.mat');
n = str2double(get(handles.times,'String'));
t = str2double(get(handles.time,'String'))*60;
if n
    try
        global fieldFox;
        common_config(fieldFox);
        fprintf(fieldFox,'FREQ:STAR 1840E6');
        fprintf(fieldFox,'FREQ:STOP 1875E6');
        set(handles.result,'String','正在评估FDD-LTE网络，请稍等！');
        for i = 1:n
            set(handles.info,'String',['正在进行第',num2str(i),'次测量！']);
            fprintf(fieldFox,'INIT:REST');
            pause(t);
            m1 = dBm2E(max(read_trace(fieldFox,'1')));
            m2 = dBm2E(max(read_trace(fieldFox,'2')));
            screenshot(fieldFox);
            axis off;
            screen = imread('temp.png');
            axes(handles.axes1);
            imshow(screen);
            set(handles.result,'String',['最大辐射值为：',10,'   ',num2str(m1),' V/m',10,'平均辐射值为：',10,'   ',num2str(m2),' V/m']);
            historys{4} = [historys{4};m1,m2];
            save('historys.mat','historys');
        end
        set(handles.info,'String','测量结束！');
    catch
        set(handles.result,'String','设备未连接！');
    end
end

% --- Executes on button press in WCDMA.
function WCDMA_Callback(hObject, eventdata, handles)
% hObject    handle to WCDMA (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of WCDMA
set(handles.GSM,'Value',0);
set(handles.CDMA,'Value',0);
set(handles.WCDMA,'Value',1);
set(handles.FDDLTE,'Value',0);
set(handles.TDLTE,'Value',0);
set(handles.WLAN,'Value',0);
load('historys.mat');
n = str2double(get(handles.times,'String'));
t = str2double(get(handles.time,'String'))*60;
if n
    try
        global fieldFox;
        common_config(fieldFox);
        fprintf(fieldFox,'FREQ:STAR 2130E6');
        fprintf(fieldFox,'FREQ:STOP 2140E6');
        set(handles.result,'String','正在评估WCDMA网络，请稍等！');
        for i = 1:n
            set(handles.info,'String',['正在进行第',num2str(i),'次测量！']);
            fprintf(fieldFox,'INIT:REST');
            pause(t);
            m1 = dBm2E(max(read_trace(fieldFox,'1')));
            m2 = dBm2E(max(read_trace(fieldFox,'2')));
            screenshot(fieldFox);
            axis off;
            screen = imread('temp.png');
            axes(handles.axes1);
            imshow(screen);
            set(handles.result,'String',['最大辐射值为：',10,'   ',num2str(m1),' V/m',10,'平均辐射值为：',10,'   ',num2str(m2),' V/m']);
            historys{3} = [historys{3};m1,m2];
            save('historys.mat','historys');
        end
        set(handles.info,'String','测量结束！');
    catch
        set(handles.result,'String','设备未连接！');
    end
end

% --- Executes on button press in CDMA.
function CDMA_Callback(hObject, eventdata, handles)
% hObject    handle to CDMA (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of CDMA
set(handles.GSM,'Value',0);
set(handles.CDMA,'Value',1);
set(handles.WCDMA,'Value',0);
set(handles.FDDLTE,'Value',0);
set(handles.TDLTE,'Value',0);
set(handles.WLAN,'Value',0);
load('historys.mat');
n = str2double(get(handles.times,'String'));
t = str2double(get(handles.time,'String'))*60;
if n
    try
        global fieldFox;
        common_config(fieldFox);
        fprintf(fieldFox,'FREQ:STAR 870E6');
        fprintf(fieldFox,'FREQ:STOP 880E6');
        set(handles.result,'String','正在评估CDMA网络，请稍等！');
        for i = 1:n
            set(handles.info,'String',['正在进行第',num2str(i),'次测量！']);
            fprintf(fieldFox,'INIT:REST');
            pause(t);
            m1 = dBm2E(max(read_trace(fieldFox,'1')));
            m2 = dBm2E(max(read_trace(fieldFox,'2')));
            screenshot(fieldFox);
            axis off;
            screen = imread('temp.png');
            axes(handles.axes1);
            imshow(screen);
            set(handles.result,'String',['最大辐射值为：',10,'   ',num2str(m1),'V/m',10,'平均辐射值为：',10,'   ',num2str(m2),'V/m']);
            historys{2} = [historys{2};m1,m2];
            save('historys.mat','historys');
        end
        set(handles.info,'String','测量结束！');
    catch
        set(handles.result,'String','设备未连接！');
    end
end

function result_Callback(hObject, eventdata, handles)
% hObject    handle to result (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of result as text
%        str2double(get(hObject,'String')) returns contents of result as a double


% --- Executes during object creation, after setting all properties.
function result_CreateFcn(hObject, eventdata, handles)
% hObject    handle to result (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes on button press in pathselect.
function pathselect_Callback(hObject, eventdata, handles)
% hObject    handle to pathselect (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
path = uigetdir;
if path
    set(handles.selectedpath,'String',path);
end

function selectedpath_Callback(hObject, eventdata, handles)
% hObject    handle to selectedpath (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of selectedpath as text
%        str2double(get(hObject,'String')) returns contents of selectedpath as a double


% --- Executes during object creation, after setting all properties.
function selectedpath_CreateFcn(hObject, eventdata, handles)
% hObject    handle to selectedpath (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

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
        type = 'BLANk';
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

% --- Executes on button press in history.
function history_Callback(hObject, eventdata, handles)
% hObject    handle to history (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
load('historys.mat');
if get(handles.GSM,'Value')
    i = 1;
    s = 'GSM';
elseif get(handles.CDMA,'Value')
    i = 2;
    s = 'CDMA';
elseif get(handles.WCDMA,'Value')
    i = 3;
    s = 'WCDMA';
elseif get(handles.FDDLTE,'Value')
    i = 4;
    s = 'FDD-LTE';
elseif get(handles.TDLTE,'Value')
    i = 5;
    s = 'TD-LTE';
elseif get(handles.WLAN,'Value')
    i = 6;
    s = 'WLAN';
else
    i = 0;
    set(handles.result,'String','请选择网络！');
end
if i
    try
        plotdata = historys{i};
        m = plotdata(:,1);
        mmax = max(m);
        mmin = min(m);
        a = plotdata(:,2);
        amax = max(a);
        amin = min(a);
        figure;
        plot(m,'ro-');
        hold on;
        plot(a,'bo-');
        title([s,' 基站辐射历史数据']);
        ylabel('E (V/m)');
        legend('最大辐射值','平均辐射值');
        hold off;
        set(handles.result,'String',['最大辐射值范围：',num2str(mmin),'-',num2str(mmax),' V/m',10,'平均辐射值范围：',num2str(amin),'-',num2str(amax),' V/m']);
    catch
        set(handles.result,'String','暂无数据！');
    end
end

% --- Executes on button press in historydel.
function historydel_Callback(hObject, eventdata, handles)
% hObject    handle to historydel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
load('historys.mat');
historys = {[],[],[],[],[],[]};
save('historys.mat','historys');
set(handles.info,'String','数据清除完毕！');

function time_Callback(hObject, eventdata, handles)
% hObject    handle to time (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of time as text
%        str2double(get(hObject,'String')) returns contents of time as a double

% --- Executes during object creation, after setting all properties.
function time_CreateFcn(hObject, eventdata, handles)
% hObject    handle to time (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

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
