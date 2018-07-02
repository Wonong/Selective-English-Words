function varargout = wordtesteng_additional_re(varargin)
% WORDTESTENG_ADDITIONAL_RE MATLAB code for wordtesteng_additional_re.fig
%      WORDTESTENG_ADDITIONAL_RE, by itself, creates a new WORDTESTENG_ADDITIONAL_RE or raises the existing
%      singleton*.
%
%      H = WORDTESTENG_ADDITIONAL_RE returns the handle to a new WORDTESTENG_ADDITIONAL_RE or the handle to
%      the existing singleton*.
%
%      WORDTESTENG_ADDITIONAL_RE('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in WORDTESTENG_ADDITIONAL_RE.M with the given input arguments.
%
%      WORDTESTENG_ADDITIONAL_RE('Property','Value',...) creates a new WORDTESTENG_ADDITIONAL_RE or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before wordtesteng_additional_re_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to wordtesteng_additional_re_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help wordtesteng_additional_re

% Last Modified by GUIDE v2.5 12-Dec-2013 19:36:23

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @wordtesteng_additional_re_OpeningFcn, ...
                   'gui_OutputFcn',  @wordtesteng_additional_re_OutputFcn, ...
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


% --- Executes just before wordtesteng_additional_re is made visible.
function wordtesteng_additional_re_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to wordtesteng_additional_re (see VARARGIN)

% Choose default command line output for wordtesteng_additional_re
handles.output = hObject;

% Update handles structure

set(hObject, 'Name', 'Test(1/3)');

global word_ind_engtest_ap;

% srand
c=clock;
RandStream('mcg16807','Seed', sum(c));

handles.mydata.point{1}=0;
handles.mydata.point{2}=0;
handles.mydata.point{3}=0;
handles.mydata.point{4}=100;
handles.mydata.point{5}=5000;

handles.mydata.word_list=varargin{2};
handles.mydata.word_list_original=handles.mydata.word_list;
handles.mydata.user_name=varargin{1};
handles.mydata.user_additional=varargin{3};

word_ind_engtest_ap=1;
handles.mydata.word_size=size(handles.mydata.word_list);
handles.mydata.word_size=handles.mydata.word_size(1);

handles.mydata.TESTNUM=ceil(handles.mydata.word_size/3);

handles.mydata.word_list=handles.mydata.word_list(1:handles.mydata.TESTNUM, :);
handles.mydata.word_size=size(handles.mydata.word_list);
handles.mydata.word_size=handles.mydata.word_size(1);
handles.mydata.ans_size=handles.mydata.word_size*3;


% Read Word Data for ans_data
fid=fopen(strcat('./temp/', handles.mydata.user_name, '_basic.word'),'r');
ans_data=textscan(fid,'%s%s%d%d','delimiter','\t');
ans_data=[ans_data{1} ans_data{2} num2cell(ans_data{3}) num2cell(ans_data{4})];
fclose(fid);
%

ans_data_size=size(ans_data);
ans_data_size=ans_data_size(1);

ans_samelist=[];

for i=1:ans_data_size
    for j=1:handles.mydata.word_size
        if strcmp(ans_data{i, 1}, handles.mydata.word_list{j, 1})==1
            ans_samelist=[ans_samelist;i]
        end
    end
end

ans_data(ans_samelist, :)=[];


size_ans_ind=size(ans_data);
size_ans_ind=size_ans_ind(1);

ans_rand=randperm(size_ans_ind);

handles.mydata.ans_list=[];

for i=1:handles.mydata.ans_size
    handles.mydata.ans_list=[handles.mydata.ans_list;ans_data(ans_rand(i),1) ans_data(ans_rand(i),2)];
end


% BACKGROUND
handles.mydata.bg=axes('units', 'normalized', 'position',[0 0 1 1]);
uistack(handles.mydata.bg,'bottom');
I=imread('./image/background_plain_s.png');
ll=imagesc(I);
set(ll, 'hittest', 'off');
set(handles.mydata.bg,'handlevisibility', 'off', 'visible','off');
%

% IMAGE %


handles.mydata.choice=imread('./image/choices_l.png', 'backgroundcolor', [0.039 0.118 0.039]);
handles.mydata.choice2=imread('./image/choices2_l.png', 'backgroundcolor', [0.039 0.118 0.039]);
set(handles.btn_num1, 'cdata', handles.mydata.choice);

% a=imread('./image/example.png', 'backgroundcolor', [0.039 0.118 0.039]);
set(handles.btn_num2, 'cdata', handles.mydata.choice);

% a=imread('./image/answer.png', 'backgroundcolor', [0.039 0.118 0.039]);
set(handles.btn_num3, 'cdata', handles.mydata.choice);

% a=imread('./image/more.png', 'backgroundcolor', [0.039 0.118 0.039]);
set(handles.btn_num4, 'cdata', handles.mydata.choice);

[handles.mydata.correct1, a, handles.mydata.correct1_alpha]=imread('./image/word_correct.png');
[handles.mydata.correct2, a, handles.mydata.correct2_alpha]=imread('./image/word_correct2.png');
[handles.mydata.incorrect1, a, handles.mydata.incorrect1_alpha]=imread('./image/word_incorrect.png');
[handles.mydata.incorrect2, a, handles.mydata.incorrect2_alpha]=imread('./image/word_incorrect2.png');

[handles.mydata.combo1, a, handles.mydata.combo1_alpha]=imread('./image/combo1.png');
[handles.mydata.combo2, a, handles.mydata.combo2_alpha]=imread('./image/combo2.png');
[handles.mydata.combo3, a, handles.mydata.combo3_alpha]=imread('./image/combo3.png');

global correct_set_engtest_ap incorrect_set_engtest_ap combo_set_engtest_ap;

axes(handles.axes_correct1);
handles.mydata.correct_img1=imagesc(handles.mydata.correct1, 'alphadata', handles.mydata.correct1_alpha, 'Visible', 'off', 'hittest', 'off');
set(handles.axes_correct1, 'handlevisibility', 'off', 'Visible','off');

axes(handles.axes_correct2);
handles.mydata.correct_img2=imagesc(handles.mydata.correct2, 'alphadata', handles.mydata.correct2_alpha, 'Visible', 'off', 'hittest', 'off');
set(handles.axes_correct2, 'handlevisibility', 'off', 'Visible','off');

axes(handles.axes_incorrect1);
handles.mydata.incorrect_img1=imagesc(handles.mydata.incorrect1, 'alphadata', handles.mydata.incorrect1_alpha, 'Visible', 'off', 'hittest', 'off');
set(handles.axes_incorrect1, 'handlevisibility', 'off', 'Visible','off');

axes(handles.axes_incorrect2);
handles.mydata.incorrect_img2=imagesc(handles.mydata.incorrect2, 'alphadata', handles.mydata.incorrect2_alpha, 'Visible', 'off', 'hittest', 'off');
set(handles.axes_incorrect2, 'handlevisibility', 'off', 'Visible','off');

axes(handles.axes_combo1);
handles.mydata.combo1_img=imagesc(handles.mydata.combo1, 'alphadata', handles.mydata.combo1_alpha, 'Visible', 'off', 'hittest', 'off');
set(handles.axes_combo1, 'handlevisibility', 'off', 'Visible','off');

axes(handles.axes_combo2);
handles.mydata.combo2_img=imagesc(handles.mydata.combo2, 'alphadata', handles.mydata.combo2_alpha, 'Visible', 'off', 'hittest', 'off');
set(handles.axes_combo2, 'handlevisibility', 'off', 'Visible','off');

axes(handles.axes_combo3);
handles.mydata.combo3_img=imagesc(handles.mydata.combo3, 'alphadata', handles.mydata.combo3_alpha, 'Visible', 'off', 'hittest', 'off');
set(handles.axes_combo3, 'handlevisibility', 'off', 'Visible','off');

    
axes(handles.axes_combo_num);
handles.mydata.combo_num=text('units', 'pixels', 'string', num2str(handles.mydata.point{2}), 'color', [1 1 1], 'fontsize', 30, 'fontweight', 'bold', 'Visible', 'off');
set(handles.axes_combo_num,'handlevisibility', 'off', 'visible','off');


% axes(handles.axes_correct2)
% handles.mydata.correct_img2=imagesc(handles.mydata.correct2);
% set(handles.mydata.correct_img2, 'alphadata', handles.mydata.correct2_alpha, 'Visible', 'off', 'hittest', 'off');
% set(handles.axes_correct2, 'handlevisibility', 'off', 'Visible','off');
% 
% 
%  handles.mydata.incorrect_img1=imagesc(handles.mydata.incorrect1);
%  set(handles.mydata.incorrect_img1, 'alphadata', handles.mydata.incorrect1_alpha, 'Visible', 'off', 'hittest', 'off');
%  handles.mydata.incorrect_img2=imagesc(handles.mydata.incorrect2);
%  set(handles.mydata.incorrect_img2, 'alphadata', handles.mydata.incorrect2_alpha, 'Visible', 'off', 'hittest', 'off');
% set(handles.axes_correct1, 'handlevisibility', 'off', 'Visible','off');
% set(handles.axes_correct1, 'Visible','off');
% 
correct_set_engtest_ap=[handles.mydata.correct_img1 handles.mydata.correct_img2];
incorrect_set_engtest_ap=[handles.mydata.incorrect_img1 handles.mydata.incorrect_img2];
combo_set_engtest_ap=[handles.mydata.combo1_img handles.mydata.combo2_img handles.mydata.combo3_img]; 


guidata(handles.output, handles);
Test(handles);
%handles.mydata.t=timer('TimerFcn',@(x,y)Test(handles),'StartDelay',1, 'TasksToExecute', 1);
%start(handles.mydata.t);


% UIWAIT makes wordtesteng_additional_re wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = wordtesteng_additional_re_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in btn_num1.
function btn_num1_Callback(hObject, eventdata, handles)
% hObject    handle to btn_num1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in btn_num2.
function btn_num2_Callback(hObject, eventdata, handles)
% hObject    handle to btn_num2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in btn_num3.
function btn_num3_Callback(hObject, eventdata, handles)
% hObject    handle to btn_num3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in btn_num4.
function btn_num4_Callback(hObject, eventdata, handles)
% hObject    handle to btn_num4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


function Test(handles)

global word_ind_engtest_ap ans_num_engtest_ap;

text_top=strcat(num2str(word_ind_engtest_ap), {'  /  '}, num2str(handles.mydata.word_size));
set(handles.text_eng, 'String', handles.mydata.word_list(word_ind_engtest_ap));
set(handles.text_index, 'String', text_top);

ans_ind=randperm(handles.mydata.ans_size);%ans_ind=ceil(rand(1,3)*handles.mydata.ans_size);
selected=[handles.mydata.word_list(word_ind_engtest_ap,2) handles.mydata.ans_list(ans_ind(1),2) handles.mydata.ans_list(ans_ind(2),2) handles.mydata.ans_list(ans_ind(3),2)];
btn_ind=randperm(4);
btn_num=[handles.btn_num1 handles.btn_num2 handles.btn_num3 handles.btn_num4];


for i=1:4
    set(btn_num(i), 'cdata', handles.mydata.choice, 'Visible', 'on');
    set(btn_num(i), 'cdata', handles.mydata.choice, 'Enable', 'on');
    
    if(strcmp(selected{btn_ind(i)},handles.mydata.word_list{word_ind_engtest_ap,2})==1)
        set(btn_num(i),'CallBack',@(x,y)Correct(handles));
        ans_num_engtest_ap=i;
        
    else
        set(btn_num(i),'CallBack',@(x,y)Wrong(handles));
    end
    
    set(btn_num(i),'String',selected(btn_ind(i)));
end

% For Test : 
word_ind_engtest_ap=word_ind_engtest_ap+1;

guidata(handles.output, handles);


function Correct(handles)

global word_ind_engtest_ap ans_num_engtest_ap correct_set_engtest_ap incorrect_set_engtest_ap combo_set_engtest_ap;

btn_num=[handles.btn_num1 handles.btn_num2 handles.btn_num3 handles.btn_num4];

for i=1:4
    if(i~=ans_num_engtest_ap)
        set(btn_num(i), 'Visible', 'off');
    else
        set(btn_num(i), 'Enable', 'inactive', 'cdata', handles.mydata.choice2);
    end
end



% POINT CALCULATE!!!
handles.mydata.point{2}=handles.mydata.point{2}+1;
if handles.mydata.point{3}<handles.mydata.point{2}
    handles.mydata.point{3}=handles.mydata.point{2};
end
handles.mydata.point{1}=handles.mydata.point{1}+handles.mydata.point{2}*handles.mydata.point{4};
guidata(handles.output, handles);

%word_ind_engtest_ap=word_ind_engtest_ap+1;
 
if handles.mydata.point{2}>1

    for i=1:6

        set(handles.mydata.correct_img1, 'Visible', 'on');
        set(handles.mydata.correct_img2, 'Visible', 'off');
        set(handles.mydata.combo1_img, 'Visible', 'on');
        set(handles.mydata.combo2_img, 'Visible', 'off');
        set(handles.mydata.combo3_img, 'Visible', 'off');
        set(handles.mydata.combo_num, 'String', num2str(handles.mydata.point{2}), 'Visible', 'on', 'Color', [rand(1) rand(1) rand(1)]);
        
        pause(0.05);

        set(handles.mydata.correct_img1, 'Visible', 'off');
        set(handles.mydata.correct_img2, 'Visible', 'on');
        set(handles.mydata.combo1_img, 'Visible', 'off');
        set(handles.mydata.combo2_img, 'Visible', 'on');
        set(handles.mydata.combo3_img, 'Visible', 'off');
        set(handles.mydata.combo_num, 'Color', [rand(1) rand(1) rand(1)]);
        
        pause(0.05);
        
        set(handles.mydata.correct_img1, 'Visible', 'on');
        set(handles.mydata.correct_img2, 'Visible', 'off');
        set(handles.mydata.combo1_img, 'Visible', 'off');
        set(handles.mydata.combo2_img, 'Visible', 'off');
        set(handles.mydata.combo3_img, 'Visible', 'on');
        set(handles.mydata.combo_num, 'Color', [rand(1) rand(1) rand(1)]);
        
        pause(0.05);
        
        set(handles.mydata.correct_img1, 'Visible', 'off');
        set(handles.mydata.correct_img2, 'Visible', 'on');
        set(handles.mydata.combo1_img, 'Visible', 'on');
        set(handles.mydata.combo2_img, 'Visible', 'off');
        set(handles.mydata.combo3_img, 'Visible', 'off');
        set(handles.mydata.combo_num, 'Color', [rand(1) rand(1) rand(1)]);

        pause(0.05);

        set(handles.mydata.correct_img1, 'Visible', 'on');
        set(handles.mydata.correct_img2, 'Visible', 'off');
        set(handles.mydata.combo1_img, 'Visible', 'off');
        set(handles.mydata.combo2_img, 'Visible', 'on');
        set(handles.mydata.combo3_img, 'Visible', 'off');
        set(handles.mydata.combo_num, 'Color', [rand(1) rand(1) rand(1)]);

        pause(0.05);
        
        set(handles.mydata.correct_img1, 'Visible', 'off');
        set(handles.mydata.correct_img2, 'Visible', 'on');
        set(handles.mydata.combo1_img, 'Visible', 'off');
        set(handles.mydata.combo2_img, 'Visible', 'off');
        set(handles.mydata.combo3_img, 'Visible', 'on');
        set(handles.mydata.combo_num, 'Color', [rand(1) rand(1) rand(1)]);
        
        pause(0.05);

    end
else
    for i=1:20
    
    set(handles.mydata.correct_img1, 'Visible', 'on');
    set(handles.mydata.correct_img2, 'Visible', 'off');

    pause(0.05);
   
    set(handles.mydata.correct_img1, 'Visible', 'off');
    set(handles.mydata.correct_img2, 'Visible', 'on');
    
    pause(0.05)
    end
end
    

set(correct_set_engtest_ap(1), 'Visible', 'off');
set(correct_set_engtest_ap(2), 'Visible', 'off');
set(combo_set_engtest_ap(3), 'Visible', 'off');
set(handles.mydata.combo_num, 'Visible', 'off');

if(word_ind_engtest_ap==handles.mydata.word_size+1)
    %go to result
    handles.mydata.word_list=[handles.mydata.word_list;handles.mydata.word_list_original(handles.mydata.TESTNUM+1:end, :)];
    guidata(handles.output, handles);
    
    figure1_CloseRequestFcn(handles.output, [], handles);
    wordtestline_additional_re(handles.mydata.user_name, handles.mydata.word_list, handles.mydata.point, handles.mydata.user_additional);
    %wordtestresult(handles.mydata.user_name, handles.mydata.word_list, handles.mydata.point);
else
    Test(handles);
end

function Wrong(handles)

global word_ind_engtest_ap ans_num_engtest_ap correct_set_engtest_ap incorrect_set_engtest_ap;

%try
%    stop(t);
%    delete(t);
%catch
%end

btn_num=[handles.btn_num1 handles.btn_num2 handles.btn_num3 handles.btn_num4];


for i=1:4
    if(i~=ans_num_engtest_ap)
        set(btn_num(i), 'Visible', 'off');
    else
        set(btn_num(i), 'Enable', 'inactive', 'cdata', handles.mydata.choice2);
    end
end


for i=1:20
    set(incorrect_set_engtest_ap(1), 'Visible', 'on');
    set(incorrect_set_engtest_ap(2), 'Visible', 'off');

    pause(0.05);
   
    set(incorrect_set_engtest_ap(1), 'Visible', 'off');
    set(incorrect_set_engtest_ap(2), 'Visible', 'on');
    
    pause(0.05)
end

set(incorrect_set_engtest_ap(1), 'Visible', 'off');
set(incorrect_set_engtest_ap(2), 'Visible', 'off');


% POINT CALCULATE!!!
handles.mydata.point{2}=0;
guidata(handles.output, handles);


%word_ind_engtest_ap=word_ind_engtest_ap+1;
%handles.mydata.point=handles.mydata.point-ceil(100/handles.mydata.word_size);
handles.mydata.word_list{word_ind_engtest_ap-1, 9}=handles.mydata.word_list{word_ind_engtest_ap-1, 9}+1;

guidata(handles.output, handles);

if(word_ind_engtest_ap==handles.mydata.word_size+1)
    %go to result
    handles.mydata.word_list=[handles.mydata.word_list;handles.mydata.word_list_original(handles.mydata.TESTNUM+1:end, :)];
    guidata(handles.output, handles);
    
    figure1_CloseRequestFcn(handles.output, [], handles);
    wordtestline_additional_re(handles.mydata.user_name, handles.mydata.word_list, handles.mydata.point, handles.mydata.user_additional);
    %wordtestresult(handles.mydata.user_name, handles.mydata.word_list, handles.mydata.point);

else
    Test(handles);
end

%t=timer('TimerFcn',@(x,y)Test(handles),'StartDelay',1.5);
%start(t);
        


% --- Executes on button press in btn_test.
function btn_test_Callback(hObject, eventdata, handles)
% hObject    handle to btn_test (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Test(handles);


% --- Executes when user attempts to close figure1.
function figure1_CloseRequestFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: delete(hObject) closes the figure

try
stop(handles.mydata.t);
delete(handles.mydata.t);
catch
end
delete(hObject);


% --- Executes on button press in btn_last.
function btn_last_Callback(hObject, eventdata, handles)
% hObject    handle to btn_last (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global word_ind_engtest_ap;

word_ind_engtest_ap=handles.mydata.word_size;
guidata(handles.output, handles);
Test(handles);


% --- Executes during object creation, after setting all properties.
function figure1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
