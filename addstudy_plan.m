function varargout = addstudy_plan(varargin)
% ADDSTUDY_PLAN MATLAB code for addstudy_plan.fig
%      ADDSTUDY_PLAN, by itself, creates a new ADDSTUDY_PLAN or raises the existing
%      singleton*.
%
%      H = ADDSTUDY_PLAN returns the handle to a new ADDSTUDY_PLAN or the handle to
%      the existing singleton*.
%
%      ADDSTUDY_PLAN('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in ADDSTUDY_PLAN.M with the given input arguments.
%
%      ADDSTUDY_PLAN('Property','Value',...) creates a new ADDSTUDY_PLAN or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before addstudy_plan_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to addstudy_plan_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help addstudy_plan

% Last Modified by GUIDE v2.5 12-Dec-2013 15:41:42

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @addstudy_plan_OpeningFcn, ...
                   'gui_OutputFcn',  @addstudy_plan_OutputFcn, ...
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


% --- Executes just before addstudy_plan is made visible.
function addstudy_plan_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to addstudy_plan (see VARARGIN)

% Choose default command line output for addstudy_plan
handles.output = hObject;

% Update handles structure
%guidata(handles.output, handles);

set(hObject, 'Name', 'Word Preview');

% BACKGROUND
handles.mydata.bg=axes('units', 'normalized', 'position',[0 0 1 1]);
uistack(handles.mydata.bg,'bottom');
I=imread('./image/background_plain.png');
ll=imagesc(I);
set(ll, 'hittest', 'off');
%text('units', 'pixels', 'position', [10 320], 'string', 'hi', 'color', [1 1 1], 'fontsize', 18, 'fontweight', 'bold','Interpreter', 'none');
set(handles.mydata.bg,'handlevisibility', 'off', 'visible','off');
%

global pagesid_preview;

pagesid_preview=1;
handles.mydata.DISP_NUM=20;

handles.mydata.user_name=varargin{1};
handles.mydata.user_additional=varargin{2};

day=getDay(handles.mydata.user_additional,'.day');
set(handles.text_day, 'String', strcat(num2str(day(1)), {' / '}, strcat(num2str(day(2)), 'ÀÏÂ÷')));

%fid=fopen(strcat('./temp/',handles.mydata.user_name, '_basic.handles.mydata.word'),'r');
%handles.mydata.word_list=textscan(fid,'%s%s%d%d','delimiter','\t');
%word_num=handles.mydata.word_list{4};
%handles.mydata.word_list=[handles.mydata.word_list{1} handles.mydata.word_list{2} num2cell(handles.mydata.word_list{3}) num2cell(handles.mydata.word_list{4})];



% Read Basic handles.mydata.word
handles.mydata.word_list=getWord(handles.mydata.user_additional, '.word');
word_num=cell2mat(handles.mydata.word_list(1:end,7));
day_index=find(word_num==day(1));
handles.mydata.word_list=handles.mydata.word_list(day_index,:);

word_size=size(handles.mydata.word_list);
word_size=word_size(1);
pages=ceil(word_size/handles.mydata.DISP_NUM);
handles.mydata.totalpages=pages;

if(pages~=1)
for i=1:pages-1
    handles.mydata.word{i}=handles.mydata.word_list(1+handles.mydata.DISP_NUM*(i-1):handles.mydata.DISP_NUM*i,1:2);
end

handles.mydata.word{pages}=handles.mydata.word_list(handles.mydata.DISP_NUM*i+1:word_size,1:2);

else
    handles.mydata.word{pages}=handles.mydata.word_list(1:end, 1:2);
end


% IMAGE %

axes(handles.axes_prev);
[ia, map, alpha]=imread('./image/before.png');
iaia=imagesc(ia);
set(iaia, 'ButtonDownFcn', @(x,y)btn_prev_Callback(handles.btn_prev, eventdata, handles), 'alphadata', alpha);
set(handles.axes_prev,'handlevisibility', 'off', 'visible','off');

axes(handles.axes_next);
[ia, map, alpha]=imread('./image/next.png');
iaia=imagesc(ia);
set(iaia, 'ButtonDownFcn', @(x,y)btn_next_Callback(handles.btn_next, eventdata, handles), 'alphadata', alpha);
set(handles.axes_next,'handlevisibility', 'off', 'visible','off');

% % %

a=imread('./image/re1.png', 'backgroundcolor', [0.039 0.118 0.039]);
set(handles.btn_home, 'cdata', a);

a=imread('./image/skip.png', 'backgroundcolor', [0.039 0.118 0.039]);
set(handles.btn_test, 'cdata', a);

guidata(handles.output, handles);
Display_word(handles);

% UIWAIT makes addstudy_plan wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = addstudy_plan_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in btn_next.
function btn_next_Callback(hObject, eventdata, handles)
% hObject    handle to btn_next (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global pagesid_preview;

if(pagesid_preview<handles.mydata.totalpages)
    pagesid_preview=pagesid_preview+1;
    guidata(handles.output, handles);
    Display_word(handles);
    
else
    delete(handles.output);
    addstudy_basic_plan(handles.mydata.user_name, handles.mydata.word_list, handles.mydata.user_additional);
end


function Display_word(handles)

global pagesid_preview;

%axes(handles.mydata.bg);
%text('units', 'pixels', 'position', [10 20], 'string', handles.mydata.word{pagesid_preview}(1:end,1), 'color', [1 1 1], 'fontsize', 18, 'fontweight', 'bold','Interpreter', 'none');
set(handles.text_word,'String',handles.mydata.word{pagesid_preview}(1:end,1));
set(handles.text_meaning,'String',handles.mydata.word{pagesid_preview}(1:end,2));
%pagesid_preview=pagesid_preview+1;
%guidata(handles.output, handles);
%set(handles.text_word, 'UserData', 0)

%get(handles.text_word, 'UserData')
%a=getappdata(handles.output, 'UsedByGUIData_m')
%a.mydata.pagesid
%b=a.mydata
%b.pagesid
%c=guidata(handles.output, b)
%getappdata(handles.output, 'UsedByGUIData_m')


% --- Executes on button press in btn_prev.
function btn_prev_Callback(hObject, eventdata, handles)
% hObject    handle to btn_prev (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global pagesid_preview;

if(pagesid_preview>1)
    pagesid_preview=pagesid_preview-1;
    guidata(handles.output, handles);
    Display_word(handles);
    
else
    
end


% --- Executes on button press in btn_test.
function btn_test_Callback(hObject, eventdata, handles)
% hObject    handle to btn_test (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

a=testpopup_preview;

if(a==0)
    close gcf;
    wordtesteng_additional_plan(handles.mydata.user_name, handles.mydata.word_list, handles.mydata.user_additional);
end


% --- Executes on button press in btn_home.
function btn_home_Callback(hObject, eventdata, handles)
% hObject    handle to btn_home (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

close gcf;
mainmenu(handles.mydata.user_name);
