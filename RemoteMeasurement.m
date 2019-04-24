function varargout = RemoteMeasurement(varargin)
% RemoteMeasurement MATLAB code for RemoteMeasurement.fig
%      RemoteMeasurement, by itself, creates a new RemoteMeasurement or raises the existing
%      singleton*.
%
%      H = RemoteMeasurement returns the handle to a new RemoteMeasurement or the handle to
%      the existing singleton*.
%
%      RemoteMeasurement('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in RemoteMeasurement.M with the given input arguments.
%
%      RemoteMeasurement('Property','Value',...) creates a new RemoteMeasurement or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the RemoteMeasurement before RemoteMeasurement_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to RemoteMeasurement_OpeningFcn via varargin.
%
%      *See RemoteMeasurement Options on GUIDE's Tools menu.  Choose "RemoteMeasurement allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help RemoteMeasurement

% Last Modified by GUIDE v2.5 20-Apr-2019 17:08:01

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @RemoteMeasurement_OpeningFcn, ...
                   'gui_OutputFcn',  @RemoteMeasurement_OutputFcn, ...
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

% --- Executes just before RemoteMeasurement is made visible.
function RemoteMeasurement_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to RemoteMeasurement (see VARARGIN)

% Choose default command line output for RemoteMeasurement
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

img = imread('starter.png');
axes(handles.axes1);
imshow(img);

% UIWAIT makes RemoteMeasurement wait for user response (see UIRESUME)
% uiwait(handles.figure1);

% --- Outputs from this function are returned to the command line.
function varargout = RemoteMeasurement_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
javaFrame = get(gcf,'JavaFrame');
set(javaFrame,'Maximized',1); 
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
try
    global fieldFox;
    choice = questdlg('是否关闭设备？','关闭对话框','是','否','否');
    if strcmp(choice, '是')
        fprintf(fieldFox, 'SYST:PWR:SHUT:DLY 5');
    end
    disconnect(fieldFox);
    set(handles.info,'String','断开成功！');
catch
    set(handles.info,'String','设备未连接！');
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

% --- Executes on button press in screenshot.
function screenshot_Callback(hObject, eventdata, handles)
% hObject    handle to screenshot (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
try
    %global fieldFox;
    %screenshot(fieldFox);
    axis off;
    axes(handles.axes1);
    imshow('temp.png');
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

% --- Executes on button press in automeas.
function automeas_Callback(hObject, eventdata, handles)
% hObject    handle to automeas (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
try
    global fieldFox;
    fprintf(fieldFox,'INST "SA"');
    automeas;
catch
    set(handles.info,'String','设备未连接！');
end

% --- Executes on button press in pathselect.
function pathselect_Callback(hObject, eventdata, handles)
% hObject    handle to pathselect (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[file,path] = uigetfile('*.mat');
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

% --- Executes on button press in saveall.
function saveall_Callback(hObject, eventdata, handles)
% hObject    handle to saveall (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
try
    global fieldFox;
    path = get(handles.selectedpath,'String');
    save_data(fieldFox,path);
    save_screen(fieldFox,path);
    if path
        set(handles.info,'String',['成功保存到 ',path]);
    else
        set(handles.info,'String','成功保存到当前目录');
    end
catch
    set(handles.info,'String','设备未连接！');
end

% --- Executes on button press in settings.
function settings_Callback(hObject, eventdata, handles)
% hObject    handle to settings (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
try
    %global fieldFox;
    %fprintf(fieldFox,'INST "SA"');
    custom;
catch
    set(handles.info,'String','设备未连接！');
end

% --- Executes on button press in FDDLTEhistory.
function FDDLTEhistory_Callback(hObject, eventdata, handles)
% hObject    handle to FDDLTEhistory (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
try
    load('history.mat');
    plotdata = history{4};
    m = plotdata(:,1);
    mmax = roundn(max(m),-4);
    mmin = roundn(min(m),-4);
    a = plotdata(:,2);
    amax = roundn(max(a),-4);
    amin = roundn(min(a),-4);
    figure;
    plot(m,'ro-');
    hold on;
    plot(a,'bo-');
    title('FDD-LTE 电磁辐射历史数据');
    ylabel('E (V/m)');
    legend('最大辐射值','平均辐射值');
    hold off;
    set(handles.FDDLTEresult,'String',['最大辐射值范围：',num2str(mmin),'-',num2str(mmax),' V/m',10,'平均辐射值范围：',num2str(amin),'-',num2str(amax),' V/m']);
catch
    set(handles.FDDLTEresult,'String','暂无数据！');
end

function FDDLTEresult_Callback(hObject, eventdata, handles)
% hObject    handle to FDDLTEresult (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of FDDLTEresult as text
%        str2double(get(hObject,'String')) returns contents of FDDLTEresult as a double

% --- Executes during object creation, after setting all properties.
function FDDLTEresult_CreateFcn(hObject, eventdata, handles)
% hObject    handle to FDDLTEresult (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes on button press in FDDLTEstart.
function FDDLTEstart_Callback(hObject, eventdata, handles)
% hObject    handle to FDDLTEstart (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
tstring = get(handles.FDDLTEtime,'String');
meastime = str2double(tstring)*60;
n = str2double(get(handles.FDDLTEtimes,'String'));
waitime  = str2double(get(handles.FDDLTEinterval,'String'))*60;
load('history.mat');
if tstring
    try
        global fieldFox;
        common_config(fieldFox);
        fprintf(fieldFox,'FREQ:STAR 1840E6');
        fprintf(fieldFox,'FREQ:STOP 1875E6');
        set(handles.GSMresult,'String','');
        set(handles.CDMAresult,'String','');
        set(handles.WCDMAresult,'String','');
        set(handles.FDDLTEresult,'String','正在测量FDD-LTE网络，请稍等！');
        set(handles.TDLTEresult,'String','');
        set(handles.WLANresult,'String','');
        for i = 1:n
            set(handles.info,'String',['正在进行第',num2str(i),'次测量！']);
            fprintf(fieldFox,'INIT:REST');
            pause(meastime);
            maximum = dBm2E(max(read_trace(fieldFox,'1')));
            avg = dBm2E(max(read_trace(fieldFox,'2')));
            screenshot(fieldFox);
            axis off;
            screen = imread('temp.png');
            axes(handles.axes1);
            imshow(screen);
            set(handles.FDDLTEresult,'String',['最大辐射值为：',num2str(maximum),'V/m',10,'平均辐射值为：',num2str(avg),'V/m']);
            history{4} = [history{4};maximum,avg];
            if i < n
                pause(waitime);
            end
        end
        save('history.mat','history');
        set(handles.info,'String','FDD-LTE 基站电磁辐射测量结束！');
    catch
        set(handles.FDDLTEresult,'String','设备未连接！');
    end
else
    set(handles.FDDLTEresult,'String','请输入测量时间！');
end

function FDDLTEtime_Callback(hObject, eventdata, handles)
% hObject    handle to FDDLTEtime (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of FDDLTEtime as text
%        str2double(get(hObject,'String')) returns contents of FDDLTEtime as a double

% --- Executes during object creation, after setting all properties.
function FDDLTEtime_CreateFcn(hObject, eventdata, handles)
% hObject    handle to FDDLTEtime (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes on button press in FDDLTEhistorydel.
function FDDLTEhistorydel_Callback(hObject, eventdata, handles)
% hObject    handle to FDDLTEhistorydel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
load('history.mat');
history{4} = [];
save('history.mat','history');
set(handles.info,'String','FDD-LTE历史数据清除完毕！');

function FDDLTEtimes_Callback(hObject, eventdata, handles)
% hObject    handle to FDDLTEtimes (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of FDDLTEtimes as text
%        str2double(get(hObject,'String')) returns contents of FDDLTEtimes as a double

% --- Executes during object creation, after setting all properties.
function FDDLTEtimes_CreateFcn(hObject, eventdata, handles)
% hObject    handle to FDDLTEtimes (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function FDDLTEinterval_Callback(hObject, eventdata, handles)
% hObject    handle to FDDLTEinterval (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of FDDLTEinterval as text
%        str2double(get(hObject,'String')) returns contents of FDDLTEinterval as a double

% --- Executes during object creation, after setting all properties.
function FDDLTEinterval_CreateFcn(hObject, eventdata, handles)
% hObject    handle to FDDLTEinterval (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes on button press in GSMhistory.
function GSMhistory_Callback(hObject, eventdata, handles)
% hObject    handle to GSMhistory (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
try
    load('history.mat');
    plotdata = history{1};
    m = plotdata(:,1);
    mmax = roundn(max(m),-4);
    mmin = roundn(min(m),-4);
    a = plotdata(:,2);
    amax = roundn(max(a),-4);
    amin = roundn(min(a),-4);
    %axis off;
    %axes(handles.axes1);
    figure;
    plot(m,'ro-');
    hold on;
    plot(a,'bo-');
    title('GSM 电磁辐射历史数据');
    ylabel('E (V/m)');
    legend('最大辐射值','平均辐射值');
    hold off;
    set(handles.GSMresult,'String',['最大辐射值范围：',num2str(mmin),'-',num2str(mmax),' V/m',10,'平均辐射值范围：',num2str(amin),'-',num2str(amax),' V/m']);
catch
    set(handles.GSMresult,'String','暂无数据！');
end

function GSMresult_Callback(hObject, eventdata, handles)
% hObject    handle to GSMresult (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of GSMresult as text
%        str2double(get(hObject,'String')) returns contents of GSMresult as a double

% --- Executes during object creation, after setting all properties.
function GSMresult_CreateFcn(hObject, eventdata, handles)
% hObject    handle to GSMresult (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes on button press in GSMstart.
function GSMstart_Callback(hObject, eventdata, handles)
% hObject    handle to GSMstart (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
tstring = get(handles.GSMtime,'String');
meastime = str2double(tstring)*60;
n = str2double(get(handles.GSMtimes,'String'));
waitime  = str2double(get(handles.GSMinterval,'String'))*60;
load('history.mat');
if tstring
    try
        global fieldFox;
        common_config(fieldFox);
        fprintf(fieldFox,'FREQ:STAR 1840E6');
        fprintf(fieldFox,'FREQ:STOP 1875E6');
        set(handles.GSMresult,'String','正在测量GSM网络，请稍等！');
        set(handles.CDMAresult,'String','');
        set(handles.WCDMAresult,'String','');
        set(handles.FDDLTEresult,'String','');
        set(handles.TDLTEresult,'String','');
        set(handles.WLANresult,'String','');
        for i = 1:n
            set(handles.info,'String',['正在进行第',num2str(i),'次测量！']);
            fprintf(fieldFox,'INIT:REST');
            pause(meastime);
            maximum = dBm2E(max(read_trace(fieldFox,'1')));
            avg = dBm2E(max(read_trace(fieldFox,'2')));
            screenshot(fieldFox);
            axis off;
            screen = imread('temp.png');
            axes(handles.axes1);
            imshow(screen);
            set(handles.GSMresult,'String',['最大辐射值为：',num2str(maximum),'V/m',10,'平均辐射值为：',num2str(avg),'V/m']);
            history{1} = [history{1};maximum,avg];
            if i < n
                pause(waitime);
            end
        end
        save('history.mat','history');
        set(handles.info,'String','GSM 基站电磁辐射测量结束！');
    catch
        set(handles.GSMresult,'String','设备未连接！');
    end
else
    set(handles.GSMresult,'String','请输入测量时间！');
end

function GSMtime_Callback(hObject, eventdata, handles)
% hObject    handle to GSMtime (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of GSMtime as text
%        str2double(get(hObject,'String')) returns contents of GSMtime as a double

% --- Executes during object creation, after setting all properties.
function GSMtime_CreateFcn(hObject, eventdata, handles)
% hObject    handle to GSMtime (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes on button press in GSMhistorydel.
function GSMhistorydel_Callback(hObject, eventdata, handles)
% hObject    handle to GSMhistorydel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
load('history.mat');
history{1} = [];
save('history.mat','history');
set(handles.info,'String','GSM历史数据清除完毕！');

function GSMtimes_Callback(hObject, eventdata, handles)
% hObject    handle to GSMtimes (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of GSMtimes as text
%        str2double(get(hObject,'String')) returns contents of GSMtimes as a double

% --- Executes during object creation, after setting all properties.
function GSMtimes_CreateFcn(hObject, eventdata, handles)
% hObject    handle to GSMtimes (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function GSMinterval_Callback(hObject, eventdata, handles)
% hObject    handle to GSMinterval (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of GSMinterval as text
%        str2double(get(hObject,'String')) returns contents of GSMinterval as a double

% --- Executes during object creation, after setting all properties.
function GSMinterval_CreateFcn(hObject, eventdata, handles)
% hObject    handle to GSMinterval (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes on button press in CDMAhistory.
function CDMAhistory_Callback(hObject, eventdata, handles)
% hObject    handle to CDMAhistory (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
try
    load('history.mat');
    plotdata = history{2};
    m = plotdata(:,1);
    mmax = roundn(max(m),-4);
    mmin = roundn(min(m),-4);
    a = plotdata(:,2);
    amax = roundn(max(a),-4);
    amin = roundn(min(a),-4);
    axis off;
    axes(handles.axes1);
    imshow('white.png');
    axes(handles.axes2);
    plot(m,'ro-');
    hold on;
    plot(a,'bo-');
    title('CDMA 电磁辐射历史数据');
    ylabel('E (V/m)');
    legend('最大辐射值','平均辐射值');
    hold off;
    set(handles.CDMAresult,'String',['最大辐射值范围：',num2str(mmin),'-',num2str(mmax),' V/m',10,'平均辐射值范围：',num2str(amin),'-',num2str(amax),' V/m']);
catch
    set(handles.CDMAresult,'String','暂无数据！');
end

function CDMAresult_Callback(hObject, eventdata, handles)
% hObject    handle to CDMAresult (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of CDMAresult as text
%        str2double(get(hObject,'String')) returns contents of CDMAresult as a double

% --- Executes during object creation, after setting all properties.
function CDMAresult_CreateFcn(hObject, eventdata, handles)
% hObject    handle to CDMAresult (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes on button press in CDMAstart.
function CDMAstart_Callback(hObject, eventdata, handles)
% hObject    handle to CDMAstart (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
tstring = get(handles.CDMAtime,'String');
meastime = str2double(tstring)*60;
n = str2double(get(handles.CDMAtimes,'String'));
waitime  = str2double(get(handles.CDMAinterval,'String'))*60;
load('history.mat');
if tstring
    try
        global fieldFox;
        common_config(fieldFox);
        fprintf(fieldFox,'FREQ:STAR 870E6');
        fprintf(fieldFox,'FREQ:STOP 880E6');
        set(handles.GSMresult,'String','');
        set(handles.CDMAresult,'String','正在测量CDMA网络，请稍等！');
        set(handles.WCDMAresult,'String','');
        set(handles.FDDLTEresult,'String','');
        set(handles.TDLTEresult,'String','');
        set(handles.WLANresult,'String','');
        for i = 1:n
            set(handles.info,'String',['正在进行第',num2str(i),'次测量！']);
            fprintf(fieldFox,'INIT:REST');
            pause(meastime);
            maximum = dBm2E(max(read_trace(fieldFox,'1')));
            avg = dBm2E(max(read_trace(fieldFox,'2')));
            screenshot(fieldFox);
            axis off;
            screen = imread('temp.png');
            axes(handles.axes1);
            imshow(screen);
            set(handles.CDMAresult,'String',['最大辐射值为：',num2str(maximum),'V/m',10,'平均辐射值为：',num2str(avg),'V/m']);
            history{2} = [history{2};maximum,avg];
            if i < n
                pause(waitime);
            end
        end
        save('history.mat','history');
        set(handles.info,'String','CDMA 基站电磁辐射测量结束！');
    catch
        set(handles.CDMAresult,'String','设备未连接！');
    end
else
    set(handles.CDMAresult,'String','请输入测量时间！');
end

function CDMAtime_Callback(hObject, eventdata, handles)
% hObject    handle to CDMAtime (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of CDMAtime as text
%        str2double(get(hObject,'String')) returns contents of CDMAtime as a double

% --- Executes during object creation, after setting all properties.
function CDMAtime_CreateFcn(hObject, eventdata, handles)
% hObject    handle to CDMAtime (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes on button press in CDMAhistorydel.
function CDMAhistorydel_Callback(hObject, eventdata, handles)
% hObject    handle to CDMAhistorydel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
load('history.mat');
history{2} = [];
save('history.mat','history');
set(handles.info,'String','CDMA历史数据清除完毕！');

function CDMAtimes_Callback(hObject, eventdata, handles)
% hObject    handle to CDMAtimes (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of CDMAtimes as text
%        str2double(get(hObject,'String')) returns contents of CDMAtimes as a double

% --- Executes during object creation, after setting all properties.
function CDMAtimes_CreateFcn(hObject, eventdata, handles)
% hObject    handle to CDMAtimes (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function CDMAinterval_Callback(hObject, eventdata, handles)
% hObject    handle to CDMAinterval (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of CDMAinterval as text
%        str2double(get(hObject,'String')) returns contents of CDMAinterval as a double

% --- Executes during object creation, after setting all properties.
function CDMAinterval_CreateFcn(hObject, eventdata, handles)
% hObject    handle to CDMAinterval (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes on button press in WCDMAhistory.
function WCDMAhistory_Callback(hObject, eventdata, handles)
% hObject    handle to WCDMAhistory (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
try
    load('history.mat');
    plotdata = history{3};
    m = plotdata(:,1);
    mmax = roundn(max(m),-4);
    mmin = roundn(min(m),-4);
    a = plotdata(:,2);
    amax = roundn(max(a),-4);
    amin = roundn(min(a),-4);
    figure;
    plot(m,'ro-');
    hold on;
    plot(a,'bo-');
    title('WCDMA 电磁辐射历史数据');
    ylabel('E (V/m)');
    legend('最大辐射值','平均辐射值');
    hold off;
    set(handles.WCDMAresult,'String',['最大辐射值范围：',num2str(mmin),'-',num2str(mmax),' V/m',10,'平均辐射值范围：',num2str(amin),'-',num2str(amax),' V/m']);
catch
    set(handles.WCDMAresult,'String','暂无数据！');
end

function WCDMAresult_Callback(hObject, eventdata, handles)
% hObject    handle to WCDMAresult (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of WCDMAresult as text
%        str2double(get(hObject,'String')) returns contents of WCDMAresult as a double

% --- Executes during object creation, after setting all properties.
function WCDMAresult_CreateFcn(hObject, eventdata, handles)
% hObject    handle to WCDMAresult (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes on button press in WCDMAstart.
function WCDMAstart_Callback(hObject, eventdata, handles)
% hObject    handle to WCDMAstart (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
tstring = get(handles.WCDMAtime,'String');
meastime = str2double(tstring)*60;
n = str2double(get(handles.WCDMAtimes,'String'));
waitime  = str2double(get(handles.WCDMAinterval,'String'))*60;
load('history.mat');
if tstring
    try
        global fieldFox;
        common_config(fieldFox);
        fprintf(fieldFox,'FREQ:STAR 2130E6');
        fprintf(fieldFox,'FREQ:STOP 2140E6');
        set(handles.GSMresult,'String','');
        set(handles.CDMAresult,'String','');
        set(handles.WCDMAresult,'String','正在测量WCDMA网络，请稍等！');
        set(handles.FDDLTEresult,'String','');
        set(handles.TDLTEresult,'String','');
        set(handles.WLANresult,'String','');
        for i = 1:n
            set(handles.info,'String',['正在进行第',num2str(i),'次测量！']);
            fprintf(fieldFox,'INIT:REST');
            pause(meastime);
            maximum = dBm2E(max(read_trace(fieldFox,'1')));
            avg = dBm2E(max(read_trace(fieldFox,'2')));
            screenshot(fieldFox);
            axis off;
            screen = imread('temp.png');
            axes(handles.axes1);
            imshow(screen);
            set(handles.WCDMAresult,'String',['最大辐射值为：',num2str(maximum),'V/m',10,'平均辐射值为：',num2str(avg),'V/m']);
            history{3} = [history{3};maximum,avg];
            if i < n
                pause(waitime);
            end
        end
        save('history.mat','history');
        set(handles.info,'String','WCDMA 基站电磁辐射测量结束！');
    catch
        set(handles.WCDMAresult,'String','设备未连接！');
    end
else
    set(handles.WCDMAresult,'String','请输入测量时间！');
end

function WCDMAtime_Callback(hObject, eventdata, handles)
% hObject    handle to WCDMAtime (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of WCDMAtime as text
%        str2double(get(hObject,'String')) returns contents of WCDMAtime as a double

% --- Executes during object creation, after setting all properties.
function WCDMAtime_CreateFcn(hObject, eventdata, handles)
% hObject    handle to WCDMAtime (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes on button press in WCDMAhistorydel.
function WCDMAhistorydel_Callback(hObject, eventdata, handles)
% hObject    handle to WCDMAhistorydel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
load('history.mat');
history{3} = [];
save('history.mat','history');
set(handles.info,'String','WCDMA历史数据清除完毕！');

function WCDMAtimes_Callback(hObject, eventdata, handles)
% hObject    handle to WCDMAtimes (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of WCDMAtimes as text
%        str2double(get(hObject,'String')) returns contents of WCDMAtimes as a double

% --- Executes during object creation, after setting all properties.
function WCDMAtimes_CreateFcn(hObject, eventdata, handles)
% hObject    handle to WCDMAtimes (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function WCDMAinterval_Callback(hObject, eventdata, handles)
% hObject    handle to WCDMAinterval (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of WCDMAinterval as text
%        str2double(get(hObject,'String')) returns contents of WCDMAinterval as a double

% --- Executes during object creation, after setting all properties.
function WCDMAinterval_CreateFcn(hObject, eventdata, handles)
% hObject    handle to WCDMAinterval (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes on button press in TDLTEhistory.
function TDLTEhistory_Callback(hObject, eventdata, handles)
% hObject    handle to TDLTEhistory (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
try
    load('history.mat');
    plotdata = history{5};
    m = plotdata(:,1);
    mmax = roundn(max(m),-4);
    mmin = roundn(min(m),-4);
    a = plotdata(:,2);
    amax = roundn(max(a),-4);
    amin = roundn(min(a),-4);
    figure;
    plot(m,'ro-');
    hold on;
    plot(a,'bo-');
    title('TD-LTE 电磁辐射历史数据');
    ylabel('E (V/m)');
    legend('最大辐射值','平均辐射值');
    hold off;
    set(handles.TDLTEresult,'String',['最大辐射值范围：',num2str(mmin),'-',num2str(mmax),' V/m',10,'平均辐射值范围：',num2str(amin),'-',num2str(amax),' V/m']);
catch
    set(handles.TDLTEresult,'String','暂无数据！');
end

function TDLTEresult_Callback(hObject, eventdata, handles)
% hObject    handle to TDLTEresult (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of TDLTEresult as text
%        str2double(get(hObject,'String')) returns contents of TDLTEresult as a double

% --- Executes during object creation, after setting all properties.
function TDLTEresult_CreateFcn(hObject, eventdata, handles)
% hObject    handle to TDLTEresult (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes on button press in TDLTEstart.
function TDLTEstart_Callback(hObject, eventdata, handles)
% hObject    handle to TDLTEstart (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
tstring = get(handles.TDLTEtime,'String');
meastime = str2double(tstring)*60;
n = str2double(get(handles.TDLTEtimes,'String'));
waitime  = str2double(get(handles.TDLTEinterval,'String'))*60;
load('history.mat');
if tstring
    try
        global fieldFox;
        common_config(fieldFox);
        fprintf(fieldFox,'FREQ:STAR 1885E6');
        fprintf(fieldFox,'FREQ:STOP 1905E6');
        set(handles.GSMresult,'String','');
        set(handles.CDMAresult,'String','');
        set(handles.WCDMAresult,'String','');
        set(handles.FDDLTEresult,'String','');
        set(handles.TDLTEresult,'String','正在测量TD-LTE网络，请稍等！');
        set(handles.WLANresult,'String','');
        for i = 1:n
            set(handles.info,'String',['正在进行第',num2str(i),'次测量！']);
            fprintf(fieldFox,'INIT:REST');
            pause(meastime);
            maximum = dBm2E(max(read_trace(fieldFox,'1')));
            avg = dBm2E(max(read_trace(fieldFox,'2')));
            screenshot(fieldFox);
            axis off;
            screen = imread('temp.png');
            axes(handles.axes1);
            imshow(screen);
            set(handles.TDLTEresult,'String',['最大辐射值为：',num2str(maximum),'V/m',10,'平均辐射值为：',num2str(avg),'V/m']);
            history{5} = [history{5};maximum,avg];
            if i < n
                pause(waitime);
            end
        end
        save('history.mat','history');
        set(handles.info,'String','TD-LTE 基站电磁辐射测量结束！');
    catch
        set(handles.TDLTEresult,'String','设备未连接！');
    end
else
    set(handles.TDLTEresult,'String','请输入测量时间！');
end

function TDLTEtime_Callback(hObject, eventdata, handles)
% hObject    handle to TDLTEtime (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of TDLTEtime as text
%        str2double(get(hObject,'String')) returns contents of TDLTEtime as a double

% --- Executes during object creation, after setting all properties.
function TDLTEtime_CreateFcn(hObject, eventdata, handles)
% hObject    handle to TDLTEtime (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes on button press in TDLTEhistorydel.
function TDLTEhistorydel_Callback(hObject, eventdata, handles)
% hObject    handle to TDLTEhistorydel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
load('history.mat');
history{5} = [];
save('history.mat','history');
set(handles.info,'String','TD-LTE历史数据清除完毕！');

function TDLTEtimes_Callback(hObject, eventdata, handles)
% hObject    handle to TDLTEtimes (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of TDLTEtimes as text
%        str2double(get(hObject,'String')) returns contents of TDLTEtimes as a double

% --- Executes during object creation, after setting all properties.
function TDLTEtimes_CreateFcn(hObject, eventdata, handles)
% hObject    handle to TDLTEtimes (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function TDLTEinterval_Callback(hObject, eventdata, handles)
% hObject    handle to TDLTEinterval (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of TDLTEinterval as text
%        str2double(get(hObject,'String')) returns contents of TDLTEinterval as a double

% --- Executes during object creation, after setting all properties.
function TDLTEinterval_CreateFcn(hObject, eventdata, handles)
% hObject    handle to TDLTEinterval (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes on button press in WLANhistory.
function WLANhistory_Callback(hObject, eventdata, handles)
% hObject    handle to WLANhistory (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
try
    load('history.mat');
    plotdata = history{6};
    m = plotdata(:,1);
    mmax = roundn(max(m),-4);
    mmin = roundn(min(m),-4);
    a = plotdata(:,2);
    amax = roundn(max(a),-4);
    amin = roundn(min(a),-4);
    figure;
    plot(m,'ro-');
    hold on;
    plot(a,'bo-');
    title('WLAN 电磁辐射历史数据');
    ylabel('E (V/m)');
    legend('最大辐射值','平均辐射值');
    hold off;
    set(handles.WLANresult,'String',['最大辐射值范围：',num2str(mmin),'-',num2str(mmax),' V/m',10,'平均辐射值范围：',num2str(amin),'-',num2str(amax),' V/m']);
catch
    set(handles.WLANresult,'String','暂无数据！');
end

function WLANresult_Callback(hObject, eventdata, handles)
% hObject    handle to WLANresult (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of WLANresult as text
%        str2double(get(hObject,'String')) returns contents of WLANresult as a double

% --- Executes during object creation, after setting all properties.
function WLANresult_CreateFcn(hObject, eventdata, handles)
% hObject    handle to WLANresult (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes on button press in WLANstart.
function WLANstart_Callback(hObject, eventdata, handles)
% hObject    handle to WLANstart (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
tstring = get(handles.WLANtime,'String');
meastime = str2double(tstring)*60;
n = str2double(get(handles.WLANtimes,'String'));
waitime  = str2double(get(handles.WLANinterval,'String'))*60;
load('history.mat');
if tstring
    try
        global fieldFox;
        common_config(fieldFox);
        fprintf(fieldFox,'FREQ:STAR 2402E6');
        fprintf(fieldFox,'FREQ:STOP 2422E6');
        set(handles.GSMresult,'String','');
        set(handles.CDMAresult,'String','');
        set(handles.WCDMAresult,'String','');
        set(handles.FDDLTEresult,'String','');
        set(handles.TDLTEresult,'String','');
        set(handles.WLANresult,'String','正在测量WLAN网络，请稍等！');
        for i = 1:n
            set(handles.info,'String',['正在进行第',num2str(i),'次测量！']);
            fprintf(fieldFox,'INIT:REST');
            pause(meastime);
            maximum = dBm2E(max(read_trace(fieldFox,'1')));
            avg = dBm2E(max(read_trace(fieldFox,'2')));
            screenshot(fieldFox);
            axis off;
            screen = imread('temp.png');
            axes(handles.axes1);
            imshow(screen);
            set(handles.WLANresult,'String',['最大辐射值为：',num2str(maximum),'V/m',10,'平均辐射值为：',num2str(avg),'V/m']);
            history{6} = [history{6};maximum,avg];
            if i < n
                pause(waitime);
            end
        end
        save('history.mat','history');
        set(handles.info,'String','WLAN 电磁辐射测量结束！');
    catch
        set(handles.WLANresult,'String','设备未连接！');
    end
else
    set(handles.WLANresult,'String','请输入测量时间！');
end

function WLANtime_Callback(hObject, eventdata, handles)
% hObject    handle to WLANtime (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of WLANtime as text
%        str2double(get(hObject,'String')) returns contents of WLANtime as a double

% --- Executes during object creation, after setting all properties.
function WLANtime_CreateFcn(hObject, eventdata, handles)
% hObject    handle to WLANtime (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes on button press in WLANhistorydel.
function WLANhistorydel_Callback(hObject, eventdata, handles)
% hObject    handle to WLANhistorydel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
load('history.mat');
history{6} = [];
save('history.mat','history');
set(handles.info,'String','WLAN历史数据清除完毕！');

function WLANtimes_Callback(hObject, eventdata, handles)
% hObject    handle to WLANtimes (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of WLANtimes as text
%        str2double(get(hObject,'String')) returns contents of WLANtimes as a double

% --- Executes during object creation, after setting all properties.
function WLANtimes_CreateFcn(hObject, eventdata, handles)
% hObject    handle to WLANtimes (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function WLANinterval_Callback(hObject, eventdata, handles)
% hObject    handle to WLANinterval (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of WLANinterval as text
%        str2double(get(hObject,'String')) returns contents of WLANinterval as a double

% --- Executes during object creation, after setting all properties.
function WLANinterval_CreateFcn(hObject, eventdata, handles)
% hObject    handle to WLANinterval (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in togglebutton3.
function start_toggle_Callback(hObject, eventdata, handles)
% hObject    handle to togglebutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of togglebutton3
handles.myTimer=timer('TimerFcn',@measure,'Period',1,'ExecutionMode','fixedRate');
if get(hObject, 'Value')
    set(hObject, 'String', '中止测量');
    stop(handles.myTimer);
    fprintf(fieldFox, '*CLS');
    fprintf(fieldFox, 'FREQ:SPAN:FULL');
else
    set(hObject, 'String', '开始测量');
    start(handles.myTimer);
end

function measure()
    auto_meas;


% --- Executes on button press in pushbutton56.
function pushbutton56_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton56 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton57.
function pushbutton57_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton57 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes during object creation, after setting all properties.
function axes2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to axes2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: place code in OpeningFcn to populate axes2
