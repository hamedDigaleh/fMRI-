function varargout = plot_histogram(varargin)
% PLOT_HISTOGRAM MATLAB code for plot_histogram.fig
%      PLOT_HISTOGRAM, by itself, creates a new PLOT_HISTOGRAM or raises the existing
%      singleton*.
%
%      H = PLOT_HISTOGRAM returns the handle to a new PLOT_HISTOGRAM or the handle to
%      the existing singleton*.
%
%      PLOT_HISTOGRAM('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in PLOT_HISTOGRAM.M with the given input arguments.
%
%      PLOT_HISTOGRAM('Property','Value',...) creates a new PLOT_HISTOGRAM or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before plot_histogram_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to plot_histogram_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help plot_histogram

% Last Modified by GUIDE v2.5 29-Dec-2015 22:55:03

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @plot_histogram_OpeningFcn, ...
                   'gui_OutputFcn',  @plot_histogram_OutputFcn, ...
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


% --- Executes just before plot_histogram is made visible.
function plot_histogram_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to plot_histogram (see VARARGIN)

% Choose default command line output for plot_histogram
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes plot_histogram wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = plot_histogram_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



function case_number_Callback(hObject, eventdata, handles)
% hObject    handle to case_number (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of case_number as text
%        str2double(get(hObject,'String')) returns contents of case_number as a double


% --- Executes during object creation, after setting all properties.
function case_number_CreateFcn(hObject, eventdata, handles)
% hObject    handle to case_number (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function plot_histogram_IC_num_Callback(hObject, eventdata, handles)
% hObject    handle to plot_histogram_IC_num (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of plot_histogram_IC_num as text
%        str2double(get(hObject,'String')) returns contents of plot_histogram_IC_num as a double


% --- Executes during object creation, after setting all properties.
function plot_histogram_IC_num_CreateFcn(hObject, eventdata, handles)
% hObject    handle to plot_histogram_IC_num (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[histogram, pathname] = uigetfile('*.mat', 'Select the histogram matrix');
if isequal(histogram,0)
   disp('User selected Cancel')
else
   disp(['User selected ', fullfile(pathname, histogram)])
end
load(histogram);
str=get(handles.plot_histogram_IC_num,'String');
plot_histogram_IC_num = str2num(str);

str=get(handles.case_number,'String');
case_number = str2num(str);

y=Histogram_ICs_allImages(plot_histogram_IC_num,:,case_number);
handles.histogram_axis=plot(y);

