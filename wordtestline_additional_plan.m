function varargout = wordtestline_additional_plan(varargin)
% WORDTESTLINE_ADDITIONAL_PLAN MATLAB code for wordtestline_additional_plan.fig
%      WORDTESTLINE_ADDITIONAL_PLAN, by itself, creates a new WORDTESTLINE_ADDITIONAL_PLAN or raises the existing
%      singleton*.
%
%      H = WORDTESTLINE_ADDITIONAL_PLAN returns the handle to a new WORDTESTLINE_ADDITIONAL_PLAN or the handle to
%      the existing singleton*.
%
%      WORDTESTLINE_ADDITIONAL_PLAN('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in WORDTESTLINE_ADDITIONAL_PLAN.M with the given input arguments.
%
%      WORDTESTLINE_ADDITIONAL_PLAN('Property','Value',...) creates a new WORDTESTLINE_ADDITIONAL_PLAN or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before wordtestline_additional_plan_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to wordtestline_additional_plan_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help wordtestline_additional_plan

% Last Modified by GUIDE v2.5 12-Dec-2013 16:17:59

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @wordtestline_additional_plan_OpeningFcn, ...
                   'gui_OutputFcn',  @wordtestline_additional_plan_OutputFcn, ...
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


% --- Executes just before wordtestline_additional_plan is made visible.
function wordtestline_additional_plan_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to wordtestline_additional_plan (see VARARGIN)

% Choose default command line output for wordtestline_additional_plan
handles.output = hObject;

% Update handles structure

set(hObject, 'Name', 'Test(2/3)');

handles.mydata.user_name=varargin{1};
handles.mydata.word_list=varargin{2};
handles.mydata.word_list_original=handles.mydata.word_list;
handles.mydata.point=varargin{3};
handles.mydata.user_additional=varargin{4};

handles.mydata.word_size=size(handles.mydata.word_list);
handles.mydata.word_size=handles.mydata.word_size(1);
handles.mydata.TESTNUM=ceil(handles.mydata.word_size/3);

DISP_NUM=10;
handles.mydata.word_list=handles.mydata.word_list(handles.mydata.TESTNUM+1:handles.mydata.TESTNUM*2, :);
handles.mydata.word_size=size(handles.mydata.word_list);
handles.mydata.word_size=handles.mydata.word_size(1);

handles.mydata.line_data{1}=[];
handles.mydata.line_data{2}=[];

global isdrawon pagesid_linetest_ap totalpages_linetest_ap answers_linetest_ap iscontrol;

totalpages_linetest_ap=ceil(handles.mydata.word_size/DISP_NUM);
pagesid_linetest_ap=1;
answers_linetest_ap=0;

iscontrol=0;

isdrawon=0;

handles.mydata.eng_set=[handles.btn_eng1 handles.btn_eng2 handles.btn_eng3 handles.btn_eng4 handles.btn_eng5 handles.btn_eng6 handles.btn_eng7 handles.btn_eng8 handles.btn_eng9 handles.btn_eng10];
handles.mydata.kor_set=[handles.btn_kor1 handles.btn_kor2 handles.btn_kor3 handles.btn_kor4 handles.btn_kor5 handles.btn_kor6 handles.btn_kor7 handles.btn_kor8 handles.btn_kor9 handles.btn_kor10];

for i=1:1:totalpages_linetest_ap-1
    handles.mydata.eng_rand{i}=randperm(DISP_NUM);
    handles.mydata.kor_rand{i}=randperm(DISP_NUM);
end

if mod(handles.mydata.word_size, DISP_NUM)==0
    handles.mydata.eng_rand{totalpages_linetest_ap}=randperm(10);
    handles.mydata.kor_rand{totalpages_linetest_ap}=randperm(10);
else
    handles.mydata.eng_rand{totalpages_linetest_ap}=randperm(mod(handles.mydata.word_size, DISP_NUM));
    handles.mydata.kor_rand{totalpages_linetest_ap}=randperm(mod(handles.mydata.word_size, DISP_NUM));
end


axes(handles.axes_combo_num);
handles.mydata.combo_num=text('units', 'pixels', 'string', num2str(handles.mydata.point{2}), 'color', [1 1 1], 'fontsize', 30, 'fontweight', 'bold', 'Visible', 'off');
set(handles.axes_combo_num,'handlevisibility', 'off', 'visible','off');



% BACKGROUND
handles.mydata.bg=axes('units', 'normalized', 'position',[0 0 1 1]);
uistack(handles.mydata.bg,'bottom');
I=imread('./image/background_plain_s.png');
ll=imagesc(I);
set(ll, 'hittest', 'off');
set(handles.mydata.bg,'handlevisibility', 'off', 'visible','off');
%

axes(handles.axes1);
axis off;
%

handles.mydata.choice2=imread('./image/choices2_l.png', 'backgroundcolor', [0.941 0.941 0.941]);


[handles.mydata.combo1, a, handles.mydata.combo1_alpha]=imread('./image/combo1.png');
[handles.mydata.combo2, a, handles.mydata.combo2_alpha]=imread('./image/combo2.png');
[handles.mydata.combo3, a, handles.mydata.combo3_alpha]=imread('./image/combo3.png');


global combo_set;

axes(handles.axes_combo1);
handles.mydata.combo1_img=imagesc(handles.mydata.combo1, 'alphadata', handles.mydata.combo1_alpha, 'Visible', 'off', 'hittest', 'off');
set(handles.axes_combo1, 'handlevisibility', 'off', 'Visible','off');

axes(handles.axes_combo2);
handles.mydata.combo2_img=imagesc(handles.mydata.combo2, 'alphadata', handles.mydata.combo2_alpha, 'Visible', 'off', 'hittest', 'off');
set(handles.axes_combo2, 'handlevisibility', 'off', 'Visible','off');

axes(handles.axes_combo3);
handles.mydata.combo3_img=imagesc(handles.mydata.combo3, 'alphadata', handles.mydata.combo3_alpha, 'Visible', 'off', 'hittest', 'off');
set(handles.axes_combo3, 'handlevisibility', 'off', 'Visible','off');

combo_set=[handles.mydata.combo1_img handles.mydata.combo2_img handles.mydata.combo3_img]; 


a=imread('./image/choices.png', 'backgroundcolor', [0.039 0.118 0.039]);

for i=1:10
    set(handles.mydata.eng_set(i), 'cdata', a);
    set(handles.mydata.kor_set(i), 'cdata', a);
end
% % a=imread('./image/example.png', 'backgroundcolor', [0.039 0.118 0.039]);
% set(handles.btn_num2_linetest_ap, 'cdata', a);
% 
% % a=imread('./image/answer.png', 'backgroundcolor', [0.039 0.118 0.039]);
% set(handles.btn_num3, 'cdata', a);
% 
% % a=imread('./image/more.png', 'backgroundcolor', [0.039 0.118 0.039]);
% set(handles.btn_num4, 'cdata', a);


set(handles.text_number, 'String', strcat('1', {'  /  '}, num2str(handles.mydata.TESTNUM)));


guidata(hObject, handles);

setTest(handles);

% UIWAIT makes wordtestline_additional_plan wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = wordtestline_additional_plan_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


function setTest(handles)

global isdrawon pagesid_linetest_ap totalpages_linetest_ap;

DISP_NUM=10;

for i=1:DISP_NUM
        set(handles.mydata.eng_set(i), 'Enable', 'on');
        set(handles.mydata.eng_set(i), 'Visible', 'on');
        set(handles.mydata.kor_set(i), 'Enable', 'on');
        set(handles.mydata.kor_set(i), 'Visible', 'on');
end

if pagesid_linetest_ap==totalpages_linetest_ap
    
    numtodisp=size(handles.mydata.eng_rand{pagesid_linetest_ap});
    numtodisp=numtodisp(2);
    
    for i=1:numtodisp
        set(handles.mydata.eng_set(i), 'Enable', 'on');
        set(handles.mydata.kor_set(i), 'Enable', 'on');
    end        
    

    for i=10:-1:numtodisp+1
        set(handles.mydata.eng_set(i), 'Visible', 'off');
        set(handles.mydata.kor_set(i), 'Visible', 'off');
    end
    
    for i=1:numtodisp
        set(handles.mydata.eng_set(handles.mydata.eng_rand{pagesid_linetest_ap}(i)), 'UserData', DISP_NUM*(pagesid_linetest_ap-1)+i);
        set(handles.mydata.kor_set(handles.mydata.kor_rand{pagesid_linetest_ap}(i)), 'UserData', DISP_NUM*(pagesid_linetest_ap-1)+i);
        
        set(handles.mydata.eng_set(handles.mydata.eng_rand{pagesid_linetest_ap}(i)), 'String', handles.mydata.word_list{DISP_NUM*(pagesid_linetest_ap-1)+i,1});
        set(handles.mydata.kor_set(handles.mydata.kor_rand{pagesid_linetest_ap}(i)), 'String', handles.mydata.word_list{DISP_NUM*(pagesid_linetest_ap-1)+i,2});
    end
    
else
    for i=1:DISP_NUM
        set(handles.mydata.eng_set(i), 'Enable', 'on');
        set(handles.mydata.kor_set(i), 'Enable', 'on');
        
        set(handles.mydata.eng_set(handles.mydata.eng_rand{pagesid_linetest_ap}(i)), 'UserData', DISP_NUM*(pagesid_linetest_ap-1)+i);
        set(handles.mydata.kor_set(handles.mydata.kor_rand{pagesid_linetest_ap}(i)), 'UserData', DISP_NUM*(pagesid_linetest_ap-1)+i);
        
        set(handles.mydata.eng_set(handles.mydata.eng_rand{pagesid_linetest_ap}(i)), 'String', handles.mydata.word_list{DISP_NUM*(pagesid_linetest_ap-1)+i,1});
        set(handles.mydata.kor_set(handles.mydata.kor_rand{pagesid_linetest_ap}(i)), 'String', handles.mydata.word_list{DISP_NUM*(pagesid_linetest_ap-1)+i,2});
    end
end

%handles.mydata.line_data{1}=[];
%handles.mydata.line_data{2}=[];
%guidata(handles.output, handles);


function Control(ans_index, type, btn_num, handles)

global selected_linetest_ap answers_linetest_ap pagesid_linetest_ap totalpages_linetest_ap btn_num2_linetest_ap;% iscontrol;

%set(handles.output, 'WindowButtonMotionFcn', @(x,y,z)figure1_WindowButtonMotionFcn(handles.output,[],handles));
set(handles.tog_func, 'Value', 1);
set(gcbo, 'Enable', 'inactive');
%iscontrol=1;
selected_linetest_ap=0;
numnow=10;

if pagesid_linetest_ap==totalpages_linetest_ap
    numnow=mod(handles.mydata.word_size, 10);
    if numnow==0
        numnow=10;
    end
end

if strcmp(type, 'eng')==1
    
    start_point{1}=[0];
    start_point{2}=[0.05+(10-btn_num)/10];
    set(handles.output, 'WindowButtonMotionFcn', @(x,y,z)figure1_WindowButtonMotionFcn(handles.output, start_point, handles));

    for i=1:numnow
        if(get(handles.mydata.eng_set(i), 'UserData')~=0&&i~=btn_num)
            set(handles.mydata.eng_set(i), 'Enable', 'off');
        end
    end
    
else
    
    start_point{1}=[1];
    start_point{2}=[0.05+(10-btn_num)/10];
    set(handles.output, 'WindowButtonMotionFcn', @(x,y,z)figure1_WindowButtonMotionFcn(handles.output, start_point, handles));

    for i=1:numnow
        if(get(handles.mydata.kor_set(i), 'UserData')~=0&&i~=btn_num)
            set(handles.mydata.kor_set(i), 'Enable', 'off');
        end
    end
    
end

waitfor(handles.tog_func, 'Value', 0);

if ans_index==selected_linetest_ap
    answers_linetest_ap=answers_linetest_ap+1;
    
    % POINT CALCULATE!!!
    handles.mydata.point{2}=handles.mydata.point{2}+1;
    if handles.mydata.point{3}<handles.mydata.point{2}
        handles.mydata.point{3}=handles.mydata.point{2};
    end
    handles.mydata.point{1}=handles.mydata.point{1}+handles.mydata.point{2}*handles.mydata.point{4};
    guidata(handles.output, handles);
    
    
    if strcmp(type, 'eng')==1
        set(handles.mydata.eng_set(btn_num), 'UserData', 0);
        set(handles.mydata.eng_set(btn_num), 'Enable', 'inactive', 'ForegroundColor', [0 0 0], 'CDATA', handles.mydata.choice2);
        set(handles.mydata.kor_set(btn_num2_linetest_ap), 'UserData', 0);
        set(handles.mydata.kor_set(btn_num2_linetest_ap), 'Enable', 'inactive', 'ForegroundColor', [0 0 0], 'CDATA', handles.mydata.choice2);
        line_this{1}=[0;1];
        line_this{2}=[0.05+(10-btn_num)/10;0.05+(10-btn_num2_linetest_ap)/10];
        handles.mydata.line_data{1}=horzcat(handles.mydata.line_data{1}, line_this{1});
        handles.mydata.line_data{2}=horzcat(handles.mydata.line_data{2}, line_this{2});
        
        for i=1:numnow
            if(get(handles.mydata.eng_set(i), 'UserData')~=0&&i~=btn_num)
                set(handles.mydata.eng_set(i), 'Enable', 'inactive');
            end

            if(get(handles.mydata.kor_set(i), 'UserData')~=0&&i~=btn_num2_linetest_ap)
                set(handles.mydata.kor_set(i), 'Enable', 'inactive');
            end
         end
        
    else
        set(handles.mydata.eng_set(btn_num2_linetest_ap), 'UserData', 0);
        set(handles.mydata.eng_set(btn_num2_linetest_ap), 'Enable', 'inactive', 'ForegroundColor', [0 0 0], 'CDATA', handles.mydata.choice2);
        set(handles.mydata.kor_set(btn_num), 'UserData', 0);
        set(handles.mydata.kor_set(btn_num), 'Enable', 'inactive', 'ForegroundColor', [0 0 0], 'CDATA', handles.mydata.choice2);
        line_this{1}=[0;1];
        line_this{2}=[0.05+(10-btn_num2_linetest_ap)/10;0.05+(10-btn_num)/10];
        handles.mydata.line_data{1}=horzcat(handles.mydata.line_data{1}, line_this{1});
        handles.mydata.line_data{2}=horzcat(handles.mydata.line_data{2}, line_this{2});
        
        for i=1:numnow
            if(get(handles.mydata.eng_set(i), 'UserData')~=0&&i~=btn_num2_linetest_ap)
                set(handles.mydata.eng_set(i), 'Enable', 'inactive');
            end

            if(get(handles.mydata.kor_set(i), 'UserData')~=0&&i~=btn_num)
                set(handles.mydata.kor_set(i), 'Enable', 'inactive');
            end
        end
    end
    
    
    
else
    handles.mydata.word_list{ans_index, 9}=1;
    set(gcbo, 'Enable', 'on');
    handles.mydata.point{2}=0;
    guidata(handles.output, handles);
    % Point and Combo and WordNote
end

set(handles.tog_func, 'Value', 0);
set(handles.output, 'WindowButtonMotionFcn', []);
guidata(handles.output, handles);

hold off;
axes(handles.axes1);
cla(handles.axes1);
line(handles.mydata.line_data{1}, handles.mydata.line_data{2}, 'linewidth', 8);
axis off;


if handles.mydata.point{2}>1

for i=1:4
    set(handles.mydata.combo1_img, 'Visible', 'on');
    set(handles.mydata.combo2_img, 'Visible', 'off');
    set(handles.mydata.combo3_img, 'Visible', 'off');
    set(handles.mydata.combo_num, 'String', num2str(handles.mydata.point{2}), 'Visible', 'on', 'Color', [rand(1) rand(1) rand(1)]);
    
    pause(0.05)
    
    set(handles.mydata.combo1_img, 'Visible', 'off');
    set(handles.mydata.combo2_img, 'Visible', 'on');
    set(handles.mydata.combo3_img, 'Visible', 'off');
    set(handles.mydata.combo_num, 'Color', [rand(1) rand(1) rand(1)]);
    
    pause(0.05)
    
    set(handles.mydata.combo1_img, 'Visible', 'off');
    set(handles.mydata.combo2_img, 'Visible', 'off');
    set(handles.mydata.combo3_img, 'Visible', 'on');
    set(handles.mydata.combo_num, 'Color', [rand(1) rand(1) rand(1)]);
    
    pause(0.05)
    
end

end

set(handles.text_number, 'String', strcat(num2str(answers_linetest_ap+1), {'  /  '}, num2str(handles.mydata.TESTNUM)));

set(handles.mydata.combo1_img, 'Visible', 'off');
set(handles.mydata.combo2_img, 'Visible', 'off');
set(handles.mydata.combo3_img, 'Visible', 'off');
set(handles.mydata.combo_num, 'Visible', 'off');


for i=1:numnow
    if(get(handles.mydata.eng_set(i), 'UserData')~=0)
        set(handles.mydata.eng_set(i), 'Enable', 'on');
    end
    
    if(get(handles.mydata.kor_set(i), 'UserData')~=0)
        set(handles.mydata.kor_set(i), 'Enable', 'on');
    end
end


if answers_linetest_ap==numnow
    handles.mydata.word_size;
    answers_linetest_ap=0;
    if pagesid_linetest_ap==totalpages_linetest_ap
        handles.mydata.word_list=[handles.mydata.word_list_original(1:handles.mydata.TESTNUM, :);handles.mydata.word_list;handles.mydata.word_list_original(handles.mydata.TESTNUM*2+1:end, :)];
        guidata(handles.output, handles); 
        delete(handles.output);
        wordtestkor_additional_plan(handles.mydata.user_name, handles.mydata.word_list, handles.mydata.point, handles.mydata.user_additional); 
        % go to another test
        
    else
        pagesid_linetest_ap=pagesid_linetest_ap+1;
        axes(handles.axes1);
        cla(handles.axes1);
        handles.mydata.line_data{1}=[];
        handles.mydata.line_data{2}=[];
        guidata(handles.output, handles);
        setTest(handles);
        
    end
    
end






    
% --- Executes on button press in btn_eng1.
function btn_eng1_Callback(hObject, eventdata, handles)
% hObject    handle to btn_eng1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global selected_linetest_ap btn_num2_linetest_ap;

selected_linetest_ap=get(hObject, 'UserData');
btn_num2_linetest_ap=1;

if (get(handles.tog_func, 'Value')==0)
Control(selected_linetest_ap, 'eng', 1, handles);
else
    set(handles.tog_func, 'Value', 0);
end


% --- Executes on button press in btn_eng2.
function btn_eng2_Callback(hObject, eventdata, handles)
% hObject    handle to btn_eng2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global selected_linetest_ap btn_num2_linetest_ap;

selected_linetest_ap=get(hObject, 'UserData');
btn_num2_linetest_ap=2;

if (get(handles.tog_func, 'Value')==0)
Control(selected_linetest_ap, 'eng', 2, handles);
else
    set(handles.tog_func, 'Value', 0);
end


% --- Executes on button press in btn_eng3.
function btn_eng3_Callback(hObject, eventdata, handles)
% hObject    handle to btn_eng3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global selected_linetest_ap btn_num2_linetest_ap;

selected_linetest_ap=get(hObject, 'UserData');
btn_num2_linetest_ap=3;

if (get(handles.tog_func, 'Value')==0)
Control(selected_linetest_ap, 'eng', 3, handles);
else
    set(handles.tog_func, 'Value', 0);
end


% --- Executes on button press in btn_eng4.
function btn_eng4_Callback(hObject, eventdata, handles)
% hObject    handle to btn_eng4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global selected_linetest_ap btn_num2_linetest_ap;

selected_linetest_ap=get(hObject, 'UserData');
btn_num2_linetest_ap=4;

if (get(handles.tog_func, 'Value')==0)
Control(selected_linetest_ap, 'eng', 4, handles);
else
    set(handles.tog_func, 'Value', 0);
end


% --- Executes on button press in btn_eng5.
function btn_eng5_Callback(hObject, eventdata, handles)
% hObject    handle to btn_eng5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global selected_linetest_ap btn_num2_linetest_ap;

selected_linetest_ap=get(hObject, 'UserData');
btn_num2_linetest_ap=5;

if (get(handles.tog_func, 'Value')==0)
Control(selected_linetest_ap, 'eng', 5, handles);
else
    set(handles.tog_func, 'Value', 0);
end


% --- Executes on button press in btn_eng6.
function btn_eng6_Callback(hObject, eventdata, handles)
% hObject    handle to btn_eng6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global selected_linetest_ap btn_num2_linetest_ap;

selected_linetest_ap=get(hObject, 'UserData');
btn_num2_linetest_ap=6;

if (get(handles.tog_func, 'Value')==0)
Control(selected_linetest_ap, 'eng', 6, handles);
else
    set(handles.tog_func, 'Value', 0);
end


% --- Executes on button press in btn_eng7.
function btn_eng7_Callback(hObject, eventdata, handles)
% hObject    handle to btn_eng7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global selected_linetest_ap btn_num2_linetest_ap;

selected_linetest_ap=get(hObject, 'UserData');
btn_num2_linetest_ap=7;

if (get(handles.tog_func, 'Value')==0)
Control(selected_linetest_ap, 'eng', 7, handles);
else
    set(handles.tog_func, 'Value', 0);
end


% --- Executes on button press in btn_eng8.
function btn_eng8_Callback(hObject, eventdata, handles)
% hObject    handle to btn_eng8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global selected_linetest_ap btn_num2_linetest_ap;

selected_linetest_ap=get(hObject, 'UserData');
btn_num2_linetest_ap=8;

if (get(handles.tog_func, 'Value')==0)
Control(selected_linetest_ap, 'eng', 8, handles);
else
    set(handles.tog_func, 'Value', 0);
end


% --- Executes on button press in btn_eng9.
function btn_eng9_Callback(hObject, eventdata, handles)
% hObject    handle to btn_eng9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global selected_linetest_ap btn_num2_linetest_ap;

selected_linetest_ap=get(hObject, 'UserData');
btn_num2_linetest_ap=9;

if (get(handles.tog_func, 'Value')==0)
Control(selected_linetest_ap, 'eng', 9, handles);
else
    set(handles.tog_func, 'Value', 0);
end


% --- Executes on button press in btn_eng10.
function btn_eng10_Callback(hObject, eventdata, handles)
% hObject    handle to btn_eng10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global selected_linetest_ap btn_num2_linetest_ap;

selected_linetest_ap=get(hObject, 'UserData');
btn_num2_linetest_ap=10;

if (get(handles.tog_func, 'Value')==0)
Control(selected_linetest_ap, 'eng', 10, handles);
else
    set(handles.tog_func, 'Value', 0);
end


% --- Executes on button press in btn_kor1.
function btn_kor1_Callback(hObject, eventdata, handles)
% hObject    handle to btn_kor1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global selected_linetest_ap btn_num2_linetest_ap;

selected_linetest_ap=get(hObject, 'UserData');
btn_num2_linetest_ap=1;

if (get(handles.tog_func, 'Value')==0)
Control(selected_linetest_ap, 'kor', 1, handles);
else
    set(handles.tog_func, 'Value', 0);
end


% --- Executes on button press in btn_kor2.
function btn_kor2_Callback(hObject, eventdata, handles)
% hObject    handle to btn_kor2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global selected_linetest_ap btn_num2_linetest_ap;

selected_linetest_ap=get(hObject, 'UserData');
btn_num2_linetest_ap=2;

if (get(handles.tog_func, 'Value')==0)
Control(selected_linetest_ap, 'kor', 2, handles);
else
    set(handles.tog_func, 'Value', 0);
end


% --- Executes on button press in btn_kor3.
function btn_kor3_Callback(hObject, eventdata, handles)
% hObject    handle to btn_kor3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global selected_linetest_ap btn_num2_linetest_ap;

selected_linetest_ap=get(hObject, 'UserData');
btn_num2_linetest_ap=3;

if (get(handles.tog_func, 'Value')==0)
Control(selected_linetest_ap, 'kor', 3, handles);
else
    set(handles.tog_func, 'Value', 0);
end


% --- Executes on button press in btn_kor4.
function btn_kor4_Callback(hObject, eventdata, handles)
% hObject    handle to btn_kor4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global selected_linetest_ap btn_num2_linetest_ap;

selected_linetest_ap=get(hObject, 'UserData');
btn_num2_linetest_ap=4;

if (get(handles.tog_func, 'Value')==0)
Control(selected_linetest_ap, 'kor', 4, handles);
else
    set(handles.tog_func, 'Value', 0);
end


% --- Executes on button press in btn_kor5.
function btn_kor5_Callback(hObject, eventdata, handles)
% hObject    handle to btn_kor5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global selected_linetest_ap btn_num2_linetest_ap;

selected_linetest_ap=get(hObject, 'UserData');
btn_num2_linetest_ap=5;

if (get(handles.tog_func, 'Value')==0)
Control(selected_linetest_ap, 'kor', 5, handles);
else
    set(handles.tog_func, 'Value', 0);
end


% --- Executes on button press in btn_kor6.
function btn_kor6_Callback(hObject, eventdata, handles)
% hObject    handle to btn_kor6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global selected_linetest_ap btn_num2_linetest_ap;

selected_linetest_ap=get(hObject, 'UserData');
btn_num2_linetest_ap=6;

if (get(handles.tog_func, 'Value')==0)
Control(selected_linetest_ap, 'kor', 6, handles);
else
    set(handles.tog_func, 'Value', 0);
end


% --- Executes on button press in btn_kor7.
function btn_kor7_Callback(hObject, eventdata, handles)
% hObject    handle to btn_kor7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global selected_linetest_ap btn_num2_linetest_ap;

selected_linetest_ap=get(hObject, 'UserData');
btn_num2_linetest_ap=7;

if (get(handles.tog_func, 'Value')==0)
Control(selected_linetest_ap, 'kor', 7, handles);
else
    set(handles.tog_func, 'Value', 0);
end


% --- Executes on button press in btn_kor8.
function btn_kor8_Callback(hObject, eventdata, handles)
% hObject    handle to btn_kor8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global selected_linetest_ap btn_num2_linetest_ap;

selected_linetest_ap=get(hObject, 'UserData');
btn_num2_linetest_ap=8;

if (get(handles.tog_func, 'Value')==0)
Control(selected_linetest_ap, 'kor', 8, handles);
else
    set(handles.tog_func, 'Value', 0);
end


% --- Executes on button press in btn_kor9.
function btn_kor9_Callback(hObject, eventdata, handles)
% hObject    handle to btn_kor9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global selected_linetest_ap btn_num2_linetest_ap;

selected_linetest_ap=get(hObject, 'UserData');
btn_num2_linetest_ap=9;

if (get(handles.tog_func, 'Value')==0)
Control(selected_linetest_ap, 'kor', 9, handles);
else
    set(handles.tog_func, 'Value', 0);
end


% --- Executes on button press in btn_kor10.
function btn_kor10_Callback(hObject, eventdata, handles)
% hObject    handle to btn_kor10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global selected_linetest_ap btn_num2_linetest_ap;

selected_linetest_ap=get(hObject, 'UserData');
btn_num2_linetest_ap=10;

if (get(handles.tog_func, 'Value')==0)
Control(selected_linetest_ap, 'kor', 10, handles);
else
    set(handles.tog_func, 'Value', 0);
end


% --- Executes on button press in btn_test.
function btn_test_Callback(hObject, eventdata, handles)
% hObject    handle to btn_test (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global x y curpos1 curpos2 isdrawon;

if(isdrawon==0)
    isdrawon=1
else
    isdrawon=0;
end

curpos1=[0.1 x];
curpos2=[0.7 y];
axes(handles.axes1);
a=[0.1 x];
b=[0.2 y];
%line(a,b);
%line([0.1 x],[0.2 y]);


% --- Executes on mouse motion over figure - except title and menu.
function figure1_WindowButtonMotionFcn(hObject, start_point, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


%axes(handles.axes1);
[x,y]=gpos(handles.axes1);

%if(get(handles.tog_func, 'Value')==1)
    
plot([start_point{1} x], [start_point{2} y], 'linewidth', 8);
set(handles.axes1,'XLim', [0 1], 'YLim', [0 1]);
hold on;
%line([0.1 0.9],[0.9 0.3])%,[0.5 0.6;0.7 0.8]);
line(handles.mydata.line_data{1}, handles.mydata.line_data{2}, 'linewidth', 8);
axis off;
hold off;
%else
    
%end
%plot(line([0.1 x],[0.2 y]));


% --- Executes on button press in btn_testselected_linetest_ap.
function btn_testselected_linetest_ap_Callback(hObject, eventdata, handles)
% hObject    handle to btn_testselected_linetest_ap (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global selected_linetest_ap;

selected_linetest_ap=selected_linetest_ap+1;


% --- Executes on button press in tog_func.
function tog_func_Callback(hObject, eventdata, handles)
% hObject    handle to tog_func (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of tog_func


% --- Executes on button press in tog_testcallback.
function tog_testcallback_Callback(hObject, eventdata, handles)
% hObject    handle to tog_testcallback (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of tog_testcallback

if(get(hObject, 'Value')==0)
    set(handles.output, 'WindowButtonMotionFcn', []);
else
    set(handles.output, 'WindowButtonMotionFcn', @(x,y,z)figure1_WindowButtonMotionFcn(handles.output,[],handles));
end
