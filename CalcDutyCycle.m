function varargout = CalcDutyCycle(varargin)
% CALCDUTYCYCLE MATLAB code for CalcDutyCycle.fig
%      CALCDUTYCYCLE, by itself, creates a new CALCDUTYCYCLE or raises the existing
%      singleton*.
%
%      H = CALCDUTYCYCLE returns the handle to a new CALCDUTYCYCLE or the handle to
%      the existing singleton*.
%
%      CALCDUTYCYCLE('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in CALCDUTYCYCLE.M with the given input arguments.
%
%      CALCDUTYCYCLE('Property','Value',...) creates a new CALCDUTYCYCLE or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before CalcDutyCycle_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to CalcDutyCycle_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help CalcDutyCycle

% Last Modified by GUIDE v2.5 06-May-2019 21:56:26

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @CalcDutyCycle_OpeningFcn, ...
                   'gui_OutputFcn',  @CalcDutyCycle_OutputFcn, ...
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


% --- Executes just before CalcDutyCycle is made visible.
function CalcDutyCycle_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to CalcDutyCycle (see VARARGIN)

% Choose default command line output for CalcDutyCycle
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes CalcDutyCycle wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = CalcDutyCycle_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on selection change in zerospan_filelist.
function zerospan_filelist_Callback(hObject, eventdata, handles)
% hObject    handle to zerospan_filelist (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns zerospan_filelist contents as cell array
%        contents{get(hObject,'Value')} returns selected item from zerospan_filelist


% --- Executes during object creation, after setting all properties.
function zerospan_filelist_CreateFcn(hObject, eventdata, handles)
% hObject    handle to zerospan_filelist (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in add_file.
function add_file_Callback(hObject, eventdata, handles)
% hObject    handle to add_file (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[file,path] = uigetfile('*.csv', 'MultiSelect', 'on');
newlist = fullfile(path,file)';
if path
    oldlist = get(handles.zerospan_filelist,'String');
    if size(oldlist)
        list = [oldlist; newlist];
    else
        list = newlist;
    end
    set(handles.zerospan_filelist,'String',list);
end

% --- Executes on button press in delete_selected.
function delete_selected_Callback(hObject, eventdata, handles)
% hObject    handle to delete_selected (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
index = get(handles.zerospan_filelist, 'Value');
list = get(handles.zerospan_filelist,'String');
list(index) = [];
set(handles.zerospan_filelist,'String',list);

% --- Executes on button press in clear_filelist.
function clear_filelist_Callback(hObject, eventdata, handles)
% hObject    handle to clear_filelist (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
list = get(handles.zerospan_filelist,'String');
list(:) = [];
set(handles.zerospan_filelist,'String',list);
