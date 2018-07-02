function varargout = wordtestresult_additional(varargin)
% WORDTESTRESULT_ADDITIONAL MATLAB code for wordtestresult_additional.fig
%      WORDTESTRESULT_ADDITIONAL, by itself, creates a new WORDTESTRESULT_ADDITIONAL or raises the existing
%      singleton*.
%
%      H = WORDTESTRESULT_ADDITIONAL returns the handle to a new WORDTESTRESULT_ADDITIONAL or the handle to
%      the existing singleton*.
%
%      WORDTESTRESULT_ADDITIONAL('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in WORDTESTRESULT_ADDITIONAL.M with the given input arguments.
%
%      WORDTESTRESULT_ADDITIONAL('Property','Value',...) creates a new WORDTESTRESULT_ADDITIONAL or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before wordtestresult_additional_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to wordtestresult_additional_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help wordtestresult_additional

% Last Modified by GUIDE v2.5 12-Dec-2013 16:23:31

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @wordtestresult_additional_OpeningFcn, ...
                   'gui_OutputFcn',  @wordtestresult_additional_OutputFcn, ...
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


% --- Executes just before wordtestresult_additional is made visible.
function wordtestresult_additional_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to wordtestresult_additional (see VARARGIN)

% Choose default command line output for wordtestresult_additional
handles.output = hObject;

% Update handles structure

set(hObject, 'Name', 'Result');

handles.mydata.user_name=varargin{1};
handles.mydata.word_list=varargin{2};
handles.mydata.user_additional=varargin{4};
guidata(hObject, handles);
day=getDay(handles.mydata.user_additional, '.day');

totalnum=size(handles.mydata.word_list);
totalnum=totalnum(1);
wrongind=cell2mat(handles.mydata.word_list(1:end, 9));
wrongind=find(wrongind==1);
wrongnum=size(wrongind);
wrongnum=wrongnum(1);

handles.mydata.point=varargin{3};
handles.mydata.point{1}=handles.mydata.point{1}+ceil(handles.mydata.point{5}*(totalnum-wrongnum)/totalnum);
handles.mydata.pointtotal=num2str(handles.mydata.point{1});
handles.mydata.pointtotal=strcat(handles.mydata.pointtotal,'점');

set(handles.text_smallscore, 'String', handles.mydata.pointtotal);
set(handles.text_maxcombo2, 'String', num2str(handles.mydata.point{3}));
set(handles.text_correct2, 'String', num2str(totalnum-wrongnum));
set(handles.text_wrong2, 'String', num2str(wrongnum));


% Wrong Word Show

handles.mydata.pagesid=1;
handles.mydata.DISP_NUM=20;

handles.mydata.wrongdisp=handles.mydata.word_list(wrongind, 1:2);
handles.mydata.wrongsize=size(handles.mydata.wrongdisp);
handles.mydata.wrongsize=handles.mydata.wrongsize(1);

pages=ceil(handles.mydata.wrongsize/handles.mydata.DISP_NUM);
handles.mydata.totalpages=pages;

if(pages>1)
    for i=1:pages-1
        handles.mydata.word{i}=handles.mydata.wrongdisp(1+handles.mydata.DISP_NUM*(i-1):handles.mydata.DISP_NUM*i,1:2);
    end

    handles.mydata.word{pages}=handles.mydata.wrongdisp(handles.mydata.DISP_NUM*i+1:end,1:2);
    
elseif(pages==0)
    handles.mydata.word{1}=[{'틀린 단어가'} {'없습니다'}];
    handles.mydata.totalpages=1;

else
    handles.mydata.word{pages}=handles.mydata.wrongdisp(1:end, 1:2);
end



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

b=imread('./image/next.png', 'backgroundcolor', [0.039 0.118 0.039]);
set(handles.btn_next, 'cdata', b);

c=imread('./image/re1.png', 'backgroundcolor', [0.039 0.118 0.039]);
set(handles.btn_home, 'cdata', c);

axes(handles.axes_wrong);
[ia, map, alpha]=imread('./image/incorrect.png');
handles.mydata.iaia=imagesc(ia);
set(handles.mydata.iaia, 'alphadata', alpha, 'visible', 'off');
set(handles.axes_wrong,'handlevisibility', 'off', 'visible','off');

%%%%


handles.mydata.sets=[handles.text_smallscore handles.text_maxcombo handles.text_maxcombo2 handles.text_correct handles.text_correct2...
    handles.text_wrong handles.text_wrong2 handles.text_eng handles.text_kor handles.btn_prev handles.btn_next handles.mydata.iaia handles.btn_home];


guidata(handles.output, handles);
Display_word(handles);

%
%
%

guidata(hObject, handles);

t=timer('TimerFcn', @(x,y)showScore(handles), 'StartDelay' ,1);
start(t);

% UIWAIT makes wordtestresult_additional wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = wordtestresult_additional_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


function showScore(handles)

set(handles.text_score, 'String', handles.mydata.pointtotal);
FONT_SIZE=100;

for i=1:20
    set(handles.text_score, 'ForegroundColor', [rand(1) rand(1) rand(1)]);
    set(handles.text_score, 'FontSize', FONT_SIZE-i);
    pause(0.03);
end

for i=1:20
    set(handles.text_score, 'ForegroundColor', [rand(1) rand(1) rand(1)]);
    set(handles.text_score, 'FontSize', FONT_SIZE-20+i);
    pause(0.03);
end

for i=1:20
    set(handles.text_score, 'ForegroundColor', [rand(1) rand(1) rand(1)]);
    set(handles.text_score, 'FontSize', FONT_SIZE-i);
    pause(0.03);
end

for i=1:20
    set(handles.text_score, 'ForegroundColor', [rand(1) rand(1) rand(1)]);
    set(handles.text_score, 'FontSize', FONT_SIZE-20+i);
    pause(0.03);
end

set(handles.text_score, 'ForegroundColor', [1 1 1]);

pause(0.7);

set(handles.text_score, 'Visible', 'off');

pause(0.7);


for i=1:10
    set(handles.text_score, 'ForegroundColor', [rand(1) rand(1) rand(1)]);
    set(handles.text_score, 'FontSize', FONT_SIZE-i);
    pause(0.03);
end

for i=1:10
    set(handles.text_score, 'ForegroundColor', [rand(1) rand(1) rand(1)]);
    set(handles.text_score, 'FontSize', FONT_SIZE-10+i);
    pause(0.03);
end

for i=1:10
    set(handles.text_score, 'ForegroundColor', [rand(1) rand(1) rand(1)]);
    set(handles.text_score, 'FontSize', FONT_SIZE-i);
    pause(0.03);
end

for i=1:10
    set(handles.text_score, 'ForegroundColor', [rand(1) rand(1) rand(1)]);
    set(handles.text_score, 'FontSize', FONT_SIZE-10+i);
    pause(0.03);
end

set(handles.text_score, 'Visible', 'off');

sets_size=size(handles.mydata.sets);

for i=1:sets_size(2)
    set(handles.mydata.sets(i), 'Visible', 'on');
end




function Display_word(handles)

set(handles.text_eng,'String',handles.mydata.word{handles.mydata.pagesid}(1:end,1));
set(handles.text_kor,'String',handles.mydata.word{handles.mydata.pagesid}(1:end,2));


% --- Executes on button press in btn_prev.
function btn_prev_Callback(hObject, eventdata, handles)
% hObject    handle to btn_prev (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

if(handles.mydata.pagesid>1)
    handles.mydata.pagesid=handles.mydata.pagesid-1;
    guidata(handles.output, handles);
    Display_word(handles);
    
else
    
end


% --- Executes on button press in btn_next.
function btn_next_Callback(hObject, eventdata, handles)
% hObject    handle to btn_next (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

if(handles.mydata.pagesid<handles.mydata.totalpages)
    handles.mydata.pagesid=handles.mydata.pagesid+1;
    guidata(handles.output, handles);
    Display_word(handles);
    
else
end


% --- Executes when user attempts to close figure1.
function figure1_CloseRequestFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: delete(hObject) closes the figure

updateWord(handles.mydata.user_name, handles.mydata.word_list);
day=getDay(handles.mydata.user_additional,'.day');

if(day(1)==day(2))
    %do something
else
    setDay(handles.mydata.user_additional,'.day',1);
end

fid=fopen(strcat('./temp/', handles.mydata.user_name, '_total.info'), 'r+');
totalinfo=textscan(fid, '%d');
totalinfo=totalinfo{1};
frewind(fid);

if isempty(totalinfo)==1
    totalinfo(1)=0;
    totalinfo(2)=0;
    totalinfo(3)=0;
end


totalinfo(1)=totalinfo(1)+handles.mydata.point{1};

if totalinfo(2) < handles.mydata.point{1}
    totalinfo(2)=handles.mydata.point{1};
end

if totalinfo(3) < handles.mydata.point{3}
    totalinfo(3)=handles.mydata.point{3};
end

fprintf(fid, '%d\r\n', totalinfo);
fclose(fid);


delete(hObject);


% --- Executes on button press in btn_home.
function btn_home_Callback(hObject, eventdata, handles)
% hObject    handle to btn_home (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

figure1_CloseRequestFcn(handles.output, [], handles);
mainmenu(handles.mydata.user_name);
