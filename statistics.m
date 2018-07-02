function varargout = statistics(varargin)
% STATISTICS MATLAB code for statistics.fig
%      STATISTICS, by itself, creates a new STATISTICS or raises the existing
%      singleton*.
%
%      H = STATISTICS returns the handle to a new STATISTICS or the handle to
%      the existing singleton*.
%
%      STATISTICS('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in STATISTICS.M with the given input arguments.
%
%      STATISTICS('Property','Value',...) creates a new STATISTICS or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before statistics_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to statistics_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help statistics

% Last Modified by GUIDE v2.5 12-Dec-2013 15:17:22

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @statistics_OpeningFcn, ...
                   'gui_OutputFcn',  @statistics_OutputFcn, ...
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


% --- Executes just before statistics is made visible.
function statistics_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to statistics (see VARARGIN)

% Choose default command line output for statistics
handles.output = hObject;

% Update handles structure

set(hObject, 'Name', 'Statistics');

handles.mydata.user_name=varargin{1};


bg=axes('units', 'normalized', 'position',[0 0 1 1]);
uistack(bg,'bottom');
I=imread('./image/background_plain_s.png');
ll=imagesc(I);
set(ll, 'hittest', 'off');
set(bg,'handlevisibility', 'off', 'visible','off');


a=imread('./image/re1.png', 'backgroundcolor', [0.039 0.118 0.039]);
set(handles.btn_home, 'cdata', a);


set(handles.text_title, 'String', strcat(handles.mydata.user_name, '님의 통계 정보'));
fid=fopen(strcat('./temp/', handles.mydata.user_name, '_total.word'), 'r');
handles.mydata.totalword=textscan(fid,'%s%s%d%d%d%d%d%d%d%f%d','delimiter','\t');
correct_num=handles.mydata.totalword{9};
basic_day=handles.mydata.totalword{6};
max_day=max(basic_day);

handles.mydata.totalword=[handles.mydata.totalword{1} handles.mydata.totalword{2} num2cell(handles.mydata.totalword{3}) num2cell(handles.mydata.totalword{4}) num2cell(handles.mydata.totalword{5}) num2cell(handles.mydata.totalword{6}) num2cell(handles.mydata.totalword{7}) num2cell(handles.mydata.totalword{8}) num2cell(handles.mydata.totalword{9}) num2cell(handles.mydata.totalword{10}) num2cell(handles.mydata.totalword{11})];
fclose(fid);

if isempty(handles.mydata.totalword)==1
    no_user_data=msgbox([{'유저 기록이 없습니다.'} {'메인메뉴로 돌아갑니다.'}], '오류', 'warn');
    %waitfor(no_user_data);
    uiwait(no_user_data);
    delete(hObject);
    mainmenu(handles.mydata.user_name);
    
elseif isempty(max_day)==1 || max_day==0
    no_user_data=msgbox([{'기본학습 기록이 없습니다.'} {'메인메뉴로 돌아갑니다.'}], '오류', 'warn');
    %waitfor(no_user_data);
    uiwait(no_user_data);
    delete(hObject);
    mainmenu(handles.mydata.user_name);

else


total_num=size(correct_num);
total_num=total_num(1);

word_day=[];
word_max=find(basic_day==1);
word_max=size(word_max);
word_max=word_max(1);

for i=1:max_day
    word_day_index=find(basic_day==i);
    
    word_day_size=find(correct_num(word_day_index)==0);
    word_day_size=size(word_day_size);
    word_day_size=word_day_size(1);
    
    word_day=[word_day;ceil(100*word_day_size/word_max)];
end

correct_num=find(correct_num==0);
correct_num=size(correct_num);
correct_num=correct_num(1);
% wrong_num=total_num-correct_num;


set(handles.text_totalword2, 'String', num2str(total_num));
set(handles.text_correct2, 'String', strcat(num2str(ceil(100*correct_num/total_num)), '%'));

fid2=fopen(strcat('./temp/', handles.mydata.user_name, '_total.info'));
handles.mydata.totalinfo=textscan(fid2, '%d');
handles.mydata.totalinfo=handles.mydata.totalinfo{1};
fclose(fid2);

set(handles.text_totalpoint2, 'String', num2str(handles.mydata.totalinfo(1)));
set(handles.text_bestpoint2, 'String', num2str(handles.mydata.totalinfo(2)));
set(handles.text_bestcombo2, 'String', num2str(handles.mydata.totalinfo(3)));

day_axis=[];


for i=1:max_day
day_axis=[day_axis i];
end

axes(handles.axes_statistics);
plot(word_day, 'yo-', 'linewidth', 3, 'markersize', 9);
axis([-Inf inf min(word_day)-5 100.1]);
xlabel('일차','FontSize',12);
ylabel('정답률(%)','FontSize',12);
set(handles.axes_statistics, 'XColor', [1 1 1], 'YColor', [1 1 1], 'Color', [0.039 0.118 0.039], 'XTick', day_axis, 'handlevisibility', 'off');
    
guidata(hObject, handles);
end

% UIWAIT makes statistics wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = statistics_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
%varargout{1} = handles.output;


% --- Executes on button press in btn_home.
function btn_home_Callback(hObject, eventdata, handles)
% hObject    handle to btn_home (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

delete(handles.output);
mainmenu(handles.mydata.user_name);
