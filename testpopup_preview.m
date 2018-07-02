function varargout = testpopup_preview(varargin)
% TESTPOPUP_PREVIEW MATLAB code for testpopup_preview.fig
%      TESTPOPUP_PREVIEW, by itself, creates a new TESTPOPUP_PREVIEW or raises the existing
%      singleton*.
%
%      H = TESTPOPUP_PREVIEW returns the handle to a new TESTPOPUP_PREVIEW or the handle to
%      the existing singleton*.
%
%      TESTPOPUP_PREVIEW('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in TESTPOPUP_PREVIEW.M with the given input arguments.
%
%      TESTPOPUP_PREVIEW('Property','Value',...) creates a new TESTPOPUP_PREVIEW or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before testpopup_preview_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to testpopup_preview_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help testpopup_preview

% Last Modified by GUIDE v2.5 11-Dec-2013 21:24:32

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @testpopup_preview_OpeningFcn, ...
                   'gui_OutputFcn',  @testpopup_preview_OutputFcn, ...
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


% --- Executes just before testpopup_preview is made visible.
function testpopup_preview_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to testpopup_preview (see VARARGIN)

% Choose default command line output for testpopup_preview
handles.output = hObject;

% Update handles structure

set(hObject, 'Name', '학습생략');

bg=axes('units', 'normalized', 'position',[0 0 1 1]);
uistack(bg,'bottom');
I=imread('./image/background_plain_s.png');
ll=imagesc(I);
set(ll, 'hittest', 'off');
set(bg,'handlevisibility', 'off', 'visible','off');

a=imread('./image/yes.png', 'backgroundcolor', [0.039 0.118 0.039]);
set(handles.btn_yes, 'cdata', a);

a=imread('./image/no.png', 'backgroundcolor', [0.039 0.118 0.039]);
set(handles.btn_no, 'cdata', a);


guidata(hObject, handles);


global answer;

% UIWAIT makes testpopup_preview wait for user response (see UIRESUME)
uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = testpopup_preview_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
global answer;
varargout{1} = answer;
clear global answer;
figure1_CloseRequestFcn(handles.output, eventdata, handles)
%close gcf;


% --- Executes on button press in btn_yes.
function btn_yes_Callback(hObject, eventdata, handles)
% hObject    handle to btn_yes (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global answer;
answer=0;
figure1_CloseRequestFcn(handles.output, eventdata, handles)
%close gcf;


% --- Executes on button press in btn_no.
function btn_no_Callback(hObject, eventdata, handles)
% hObject    handle to btn_no (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global answer;
answer=1;
figure1_CloseRequestFcn(handles.output, eventdata, handles)
%close gcf;


% --- Executes when user attempts to close figure1.
function figure1_CloseRequestFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: delete(hObject) closes the figure
if isequal(get(hObject, 'waitstatus'), 'waiting')
    % The GUI is still in UIWAIT, us UIRESUME
    uiresume(hObject);
else
    % The GUI is no longer waiting, just close it
    delete(hObject);
end
