function varargout = basicstudy(varargin)
% BASICSTUDY MATLAB code for basicstudy.fig
%      BASICSTUDY, by itself, creates a new BASICSTUDY or raises the existing
%      singleton*.
%
%      H = BASICSTUDY returns the handle to a new BASICSTUDY or the handle to
%      the existing singleton*.
%
%      BASICSTUDY('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in BASICSTUDY.M with the given input arguments.
%
%      BASICSTUDY('Property','Value',...) creates a new BASICSTUDY or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before basicstudy_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to basicstudy_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help basicstudy

% Last Modified by GUIDE v2.5 06-Dec-2013 19:24:37

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @basicstudy_OpeningFcn, ...
                   'gui_OutputFcn',  @basicstudy_OutputFcn, ...
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


% --- Executes just before basicstudy is made visible.
function basicstudy_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to basicstudy (see VARARGIN)

% Choose default command line output for basicstudy
%handles.output = hObject;

% Update handles structure
handles.output = hObject;
%guidata(handles.output, handles);

set(hObject, 'Name', 'Word Study');

global word_ind_basicstudy;

handles.mydata.FRAME_DELAY=0.05;
handles.mydata.FRAME_NUM=15;

handles.mydata.word_list=varargin{2};
handles.mydata.user_name=varargin{1};
word_ind_basicstudy=1;
handles.mydata.word_size=size(handles.mydata.word_list);
handles.mydata.word_size=handles.mydata.word_size(1);


% BACKGROUND
handles.mydata.bg=axes('units', 'normalized', 'position',[0 0 1 1]);
uistack(handles.mydata.bg,'bottom');
I=imread('./image/background_plain.png');
ll=imagesc(I);
set(ll, 'hittest', 'off');
set(handles.mydata.bg,'handlevisibility', 'off', 'visible','off');
%


a=imread('./image/before.png', 'backgroundcolor', [0.039 0.118 0.039]);
set(handles.btn_prev, 'cdata', a);

a=imread('./image/next.png', 'backgroundcolor', [0.039 0.118 0.039]);
set(handles.btn_next, 'cdata', a);

a=imread('./image/auto2.png', 'backgroundcolor', [0.039 0.118 0.039]);
set(handles.tog_auto, 'cdata', a);

a=imread('./image/more.png', 'backgroundcolor', [0.039 0.118 0.039]);
set(handles.tog_more, 'cdata', a);

a=imread('./image/bookmark2.png', 'backgroundcolor', [0.039 0.118 0.039]);
set(handles.tog_favorite, 'cdata', a);

handles.mydata.tog_more_on=imread('./image/more2.png', 'backgroundcolor', [0.039 0.118 0.039]);
handles.mydata.tog_more_off=imread('./image/more.png', 'backgroundcolor', [0.039 0.118 0.039]);
handles.mydata.tog_auto_on=imread('./image/auto2.png', 'backgroundcolor', [0.039 0.118 0.039]);
handles.mydata.tog_auto_off=imread('./image/auto.png', 'backgroundcolor', [0.039 0.118 0.039]);
handles.mydata.tog_favorite_on=imread('./image/bookmark.png', 'backgroundcolor', [0.039 0.118 0.039]);
handles.mydata.tog_favorite_off=imread('./image/bookmark2.png', 'backgroundcolor', [0.039 0.118 0.039]);


%%%%

guidata(handles.output, handles);

handles.mydata.t=timer('TimerFcn',@(x,y)Control(handles),'StartDelay',1, 'TasksToExecute', 1);
start(handles.mydata.t);

% UIWAIT makes basicstudy wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = basicstudy_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in btn_prev.
function btn_prev_Callback(hObject, eventdata, handles)
% hObject    handle to btn_prev (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global word_ind_basicstudy;

if get(handles.tog_more,'Value')==1
    delete(handles.mydata.btn_exit);
    handles.mydata.word_web.delete;
    set(handles.tog_more,'Value',0);
end

%set(handles.text_eng,'String','');

if(word_ind_basicstudy~=1)
    word_ind_basicstudy=word_ind_basicstudy-1;
    
else
    % do nothing
end

guidata(handles.output, handles);


% --- Executes on button press in btn_next.
function btn_next_Callback(hObject, eventdata, handles)
% hObject    handle to btn_next (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%set(handles.text_eng,'string','tomato')

global word_ind_basicstudy;

if get(handles.tog_more,'Value')==1
    delete(handles.mydata.btn_exit);
    handles.mydata.word_web.delete;
    set(handles.tog_more,'Value',0);
    set(handles.tog_more, 'CDATA', handles.mydata.tog_more_off);
    guidata(handles.output, handles);
end

%set(handles.text_eng,'String','');

word_ind_basicstudy=word_ind_basicstudy+1;
guidata(handles.output, handles);

% --- Executes on button press in tog_auto.
function tog_auto_Callback(hObject, eventdata, handles)
% hObject    handle to tog_auto (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of tog_auto

if get(hObject, 'Value')==1
    set(handles.tog_auto, 'CDATA', handles.mydata.tog_auto_on);
    
else
    set(handles.tog_auto, 'CDATA', handles.mydata.tog_auto_off);
end


function btn_more_exit(handles)

set(handles.tog_more,'Value',0);
set(handles.tog_more, 'CDATA', handles.mydata.tog_more_off);
delete(handles.mydata.btn_exit);
handles.mydata.word_web.delete;
guidata(handles.output, handles);


% --- Executes on button press in tog_more.
function tog_more_Callback(hObject, eventdata, handles)
% hObject    handle to tog_more (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of tog_more

global word_ind_basicstudy;

if(get(hObject,'Value')==1)
set(handles.tog_more, 'CDATA', handles.mydata.tog_more_on);
word_more=strcat('http://alldic.nate.com/search/endic_sd.html?q=',handles.mydata.word_list{word_ind_basicstudy,1});
handles.mydata.word_web = actxcontrol('Shell.Explorer.2',[540 130 500 500]);
Navigate(handles.mydata.word_web,word_more);

handles.mydata.btn_exit=uicontrol('Style','pushbutton','String','X','Units','pixels','Position',[870 580 50 50]);
set(handles.mydata.btn_exit,'CallBack',@(x,y)btn_more_exit(handles));

else
    set(handles.tog_more, 'CDATA', handles.mydata.tog_more_off);
    btn_more_exit(handles);
end

guidata(handles.output, handles);


function Control(handles)

global word_ind_basicstudy;

while (word_ind_basicstudy<=handles.mydata.word_size)
    
    word_now=word_ind_basicstudy;
    waitfor(handles.tog_more, 'Value', 0);
    
    if word_ind_basicstudy>handles.mydata.word_size
        break;
    end
    
    Display_Word(handles);
    
    if get(handles.tog_more, 'Value')==0
        Check_Status(word_now, handles);
    end
end

if (word_ind_basicstudy > handles.mydata.word_size)
    a=testpopup;
    %handles.mydata.word_list
    temp=getappdata(handles.output, 'UsedByGUIData_m');
    %handles.mydata.word_list=temp.mydata.word_list;
    if(a==0)
        figure1_CloseRequestFcn(handles.output, [], handles);
        wordtesteng(handles.mydata.user_name, temp.mydata.word_list);
    else
        word_ind_basicstudy=1;
        %guidata(handles.output, handles);
        Control(handles);
    end
    
end

%guidata(handles.output, handles);
%go to test popup


function Check_Status(word_now, handles)

global word_ind_basicstudy;

if (word_now==word_ind_basicstudy)
    
    if get(handles.tog_auto, 'Value')==1
            word_ind_basicstudy=word_ind_basicstudy+1;
    end
    
end

%guidata(handles.output, handles);

   
function Display_Word(handles)

global word_ind_basicstudy;

word_eng=handles.mydata.word_list{word_ind_basicstudy,1};
word_kor=handles.mydata.word_list{word_ind_basicstudy,2};
temp=getappdata(handles.output, 'UsedByGUIData_m');
word_favorite=temp.mydata.word_list{word_ind_basicstudy,11};%handles.mydata.word_list{word_ind_basicstudy,11};
word_now=word_ind_basicstudy;

top_index=strcat(num2str(word_ind_basicstudy), {'  /  '}, num2str(handles.mydata.word_size));
set(handles.text_index,'String',top_index);

if word_favorite==1
    set(handles.tog_favorite, 'Value', 1);
    set(handles.tog_favorite, 'CDATA', handles.mydata.tog_favorite_on);
else
    set(handles.tog_favorite, 'Value', 0);
    set(handles.tog_favorite, 'CDATA', handles.mydata.tog_favorite_off);
end

if(word_now~=word_ind_basicstudy||get(handles.tog_more, 'Value')==1)
    return;
end
set(handles.text_eng, 'String', word_eng);

drawnow;
tts(word_eng);

%Pause_Fcn(word_now, handles);
Pause_Eng(word_now, handles);
%stop(t);
%delete(t);


if(word_now~=word_ind_basicstudy||get(handles.tog_more, 'Value')==1)
    return;
end
set(handles.text_eng, 'String', '');

Pause_Empty(word_now, handles);


if(word_now~=word_ind_basicstudy||get(handles.tog_more, 'Value')==1)
    return;
end

set(handles.text_eng, 'String', [{''}, {word_kor}]);

Pause_Fcn(word_now, handles);


if(word_now~=word_ind_basicstudy||get(handles.tog_more, 'Value')==1)
    return;
end
set(handles.text_eng, 'String', '');

Pause_Empty(word_now, handles);


if(word_now~=word_ind_basicstudy||get(handles.tog_more, 'Value')==1)
    return;
end
set(handles.text_eng, 'String', word_eng);
drawnow;
tts(word_eng);
Pause_Eng(word_now, handles);
%Pause_Fcn(word_now, handles);


if(word_now~=word_ind_basicstudy||get(handles.tog_more, 'Value')==1)
    return;
end
set(handles.text_eng, 'String', '');

Pause_Empty(word_now, handles);


if(word_now~=word_ind_basicstudy||get(handles.tog_more, 'Value')==1)
    return;
end

set(handles.text_eng, 'String', [{word_eng}, {word_kor}]);

Pause_Fcn(word_now, handles);


if(word_now~=word_ind_basicstudy||get(handles.tog_more, 'Value')==1)
    return;
end
set(handles.text_eng, 'String', '');

Pause_Empty(word_now, handles);



function Pause_Fcn(word_now,handles)

global word_ind_basicstudy;

for i=1:handles.mydata.FRAME_NUM
    if(word_now~=word_ind_basicstudy||get(handles.tog_more, 'Value')==1)
        break;
    end
    pause(handles.mydata.FRAME_DELAY);
end


function Pause_Eng(word_now,handles)

global word_ind_basicstudy;

for i=1:ceil(handles.mydata.FRAME_NUM/10)
    if(word_now~=word_ind_basicstudy||get(handles.tog_more, 'Value')==1)
        break;
    end
    pause(handles.mydata.FRAME_DELAY);
end


function Pause_Empty(word_now,handles)

global word_ind_basicstudy;

for i=1:ceil(3*handles.mydata.FRAME_NUM/5)
    if(word_now~=word_ind_basicstudy||get(handles.tog_more, 'Value')==1)
        break;
    end
    pause(handles.mydata.FRAME_DELAY);
end


% --- Executes when user attempts to close figure1.
function figure1_CloseRequestFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: delete(hObject) closes the figure

if get(handles.tog_more,'Value')==1
    set(handles.tog_more,'Value',0);
    try
    handles.mydata.word_web.delete;
    catch
    end
end

try
stop(handles.mydata.t);
delete(handles.mydata.t);
guidata(hObject, handles);
catch
end

delete(hObject);


% --- Executes on button press in tog_favorite.
function tog_favorite_Callback(hObject, eventdata, handles)
% hObject    handle to tog_favorite (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of tog_favorite

%word_favorite=handles.mydata.word_list{word_ind_basicstudy,11};

%if word_favorite==1
%    set(hObject, 'Value', 1);
%else
%    set(hObject, 'Value', 0);
%end

global word_ind_basicstudy;

if get(hObject, 'Value') == 1
    handles.mydata.word_list{word_ind_basicstudy,11}=1;
    set(handles.tog_favorite, 'CDATA', handles.mydata.tog_favorite_on);
else
    handles.mydata.word_list{word_ind_basicstudy,11}=0;
    set(handles.tog_favorite, 'CDATA', handles.mydata.tog_favorite_off);
end

guidata(handles.output, handles);


% --- Executes on button press in btn_test.
function btn_test_Callback(hObject, eventdata, handles)
% hObject    handle to btn_test (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global word_ind_basicstudy;

word_ind_basicstudy=handles.mydata.word_size;


% --- Executes during object creation, after setting all properties.
function figure1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
