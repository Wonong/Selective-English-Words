function varargout = wordmenu(varargin)
% WORDMENU MATLAB code for wordmenu.fig
%      WORDMENU, by itself, creates a new WORDMENU or raises the existing
%      singleton*.
%
%      H = WORDMENU returns the handle to a new WORDMENU or the handle to
%      the existing singleton*.
%
%      WORDMENU('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in WORDMENU.M with the given input arguments.
%
%      WORDMENU('Property','Value',...) creates a new WORDMENU or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before wordmenu_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to wordmenu_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help wordmenu

% Last Modified by GUIDE v2.5 09-Dec-2013 15:46:28

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @wordmenu_OpeningFcn, ...
                   'gui_OutputFcn',  @wordmenu_OutputFcn, ...
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


% --- Executes just before wordmenu is made visible.
function wordmenu_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to wordmenu (see VARARGIN)

% Choose default command line output for wordmenu
handles.output = hObject;

% Update handles structure

set(hObject, 'Name', '단어 메뉴');

handles.mydata.user_name=varargin{1};

% BACKGROUND
handles.mydata.bg=axes('units', 'normalized', 'position',[0 0 1 1]);
uistack(handles.mydata.bg,'bottom');
I=imread('./image/background_plain_s.png');
ll=imagesc(I);
set(ll, 'hittest', 'off');
set(handles.mydata.bg,'handlevisibility', 'off', 'visible','off');
%

c=imread('./image/re1.png', 'backgroundcolor', [0.039 0.118 0.039]);
set(handles.btn_home, 'cdata', c);

guidata(hObject, handles);

% UIWAIT makes wordmenu wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = wordmenu_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in btn_home.
function btn_home_Callback(hObject, eventdata, handles)
% hObject    handle to btn_home (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

close gcf;
mainmenu(handles.mydata.user_name);

% --- Executes on button press in btn_total.
function btn_total_Callback(hObject, eventdata, handles)
% hObject    handle to btn_total (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

close gcf;
word_total(handles.mydata.user_name);


% --- Executes on button press in btn_wrong.
function btn_wrong_Callback(hObject, eventdata, handles)
% hObject    handle to btn_wrong (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

close gcf;
word_incorrect(handles.mydata.user_name);


% --- Executes on button press in btn_favorite.
function btn_favorite_Callback(hObject, eventdata, handles)
% hObject    handle to btn_favorite (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

close gcf;
word_favorite(handles.mydata.user_name);
