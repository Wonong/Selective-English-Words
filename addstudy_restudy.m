function varargout = addstudy_restudy(varargin)
% ADDSTUDY_RESTUDY MATLAB code for addstudy_restudy.fig
%      ADDSTUDY_RESTUDY, by itself, creates a new ADDSTUDY_RESTUDY or raises the existing
%      singleton*.
%
%      H = ADDSTUDY_RESTUDY returns the handle to a new ADDSTUDY_RESTUDY or the handle to
%      the existing singleton*.
%
%      ADDSTUDY_RESTUDY('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in ADDSTUDY_RESTUDY.M with the given input arguments.
%
%      ADDSTUDY_RESTUDY('Property','Value',...) creates a new ADDSTUDY_RESTUDY or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before addstudy_restudy_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to addstudy_restudy_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help addstudy_restudy

% Last Modified by GUIDE v2.5 12-Dec-2013 20:08:49

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @addstudy_restudy_OpeningFcn, ...
                   'gui_OutputFcn',  @addstudy_restudy_OutputFcn, ...
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


% --- Executes just before addstudy_restudy is made visible.
function addstudy_restudy_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to addstudy_restudy (see VARARGIN)

% Choose default command line output for addstudy_restudy
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
handles.mydata.word_list=varargin{2};
handles.mydata.user_additional=varargin{3};

% day=getDay(handles.mydata.user_additional,'.day');
% set(handles.text_day, 'String', strcat(num2str(day(1)), {' / '}, strcat(num2str(day(2)), 'ÀÏÂ÷')));

%fid=fopen(strcat('./temp/',handles.mydata.user_name, '_basic.handles.mydata.word'),'r');
%handles.mydata.word_list=textscan(fid,'%s%s%d%d','delimiter','\t');
%word_num=handles.mydata.word_list{4};
%handles.mydata.word_list=[handles.mydata.word_list{1} handles.mydata.word_list{2} num2cell(handles.mydata.word_list{3}) num2cell(handles.mydata.word_list{4})];



% Read Basic handles.mydata.word
% handles.mydata.word_list=getWord(handles.mydata.user_additional, '.word');
% word_num=cell2mat(handles.mydata.word_list(1:end,7));
% day_index=find(word_num==day(1));
% handles.mydata.word_list=handles.mydata.word_list(day_index,:);

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

a=imread('./image/refresh.png', 'backgroundcolor', [0.039 0.118 0.039]);
set(handles.btn_refresh, 'cdata', a);

guidata(handles.output, handles);
Display_word(handles);

% UIWAIT makes addstudy_restudy wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = addstudy_restudy_OutputFcn(hObject, eventdata, handles) 
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
    wordtesteng_additional_re(handles.mydata.user_name, handles.mydata.word_list, handles.mydata.user_additional);
end


% --- Executes on button press in btn_home.
function btn_home_Callback(hObject, eventdata, handles)
% hObject    handle to btn_home (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

close gcf;
mainmenu(handles.mydata.user_name);


% --- Executes on button press in btn_refresh.
function btn_refresh_Callback(hObject, eventdata, handles)
% hObject    handle to btn_refresh (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

   NUMTOSTUDY=getDay(handles.mydata.user_additional, '.day');

    wrong=ceil(rand(1)*100);%NUMTOSTUDY(4);
    important=0;%NUMTOSTUDY(5);
    submitted=100;%NUMTOSTUDY(6);
    NUMTOSTUDY=NUMTOSTUDY(3);

if rand(1)>0.5
    
    fid=fopen(strcat('./temp/', handles.mydata.user_name, '_total.word'));
    handles.mydata.totalword=textscan(fid,'%s%s%d%d%d%d%d%d%d%f%d','delimiter','\t');
    handles.mydata.totalword=[handles.mydata.totalword{1} handles.mydata.totalword{2} num2cell(handles.mydata.totalword{3}) num2cell(handles.mydata.totalword{4}) num2cell(handles.mydata.totalword{5}) num2cell(handles.mydata.totalword{6}) num2cell(handles.mydata.totalword{7}) num2cell(handles.mydata.totalword{8}) num2cell(handles.mydata.totalword{9}) num2cell(handles.mydata.totalword{10}) num2cell(handles.mydata.totalword{11})];
    handles.mydata.totalword_size=size(handles.mydata.totalword);
    handles.mydata.totalword_size=handles.mydata.totalword_size(1);
    fclose(fid);
    
    thisrand=randperm(handles.mydata.totalword_size);
    
    MustWord=handles.mydata.totalword(thisrand(1:NUMTOSTUDY),:);
    delete(handles.output);
    addstudy_restudy(handles.mydata.user_name, MustWord, handles.mydata.user_additional);

    
else

 

    max_w=ceil(NUMTOSTUDY*wrong/100);
    max_i=ceil(NUMTOSTUDY*important/100);
    max_s=ceil(NUMTOSTUDY*submitted/100);
    sum_max=NUMTOSTUDY;%max_w+max_i+max_s;
    sum_ind=0;

    fid=fopen(strcat('./temp/', handles.mydata.user_name, '_total.word'));
    handles.mydata.totalword=textscan(fid,'%s%s%d%d%d%d%d%d%d%f%d','delimiter','\t');
    handles.mydata.totalword=[handles.mydata.totalword{1} handles.mydata.totalword{2} num2cell(handles.mydata.totalword{3}) num2cell(handles.mydata.totalword{4}) num2cell(handles.mydata.totalword{5}) num2cell(handles.mydata.totalword{6}) num2cell(handles.mydata.totalword{7}) num2cell(handles.mydata.totalword{8}) num2cell(handles.mydata.totalword{9}) num2cell(handles.mydata.totalword{10}) num2cell(handles.mydata.totalword{11})];
    handles.mydata.totalword_size=size(handles.mydata.totalword);
    handles.mydata.totalword_size=handles.mydata.totalword_size(1);
    fclose(fid);

    additional_w=cell2mat(handles.mydata.totalword(1:end,9));
    additional_i=cell2mat(handles.mydata.totalword(1:end,3));
    additional_s=cell2mat(handles.mydata.totalword(1:end,8));

    num_w=0;
    num_i=0;
    num_s=0;
    total_ind=[];

    temp_ind=find(additional_w~=0);

    if ( isempty(temp_ind)==0 && num_w < max_w && sum_ind < sum_max  )
        total_ind_size=size(total_ind);
        temp_ind_size=size(temp_ind);
        temp_ind_size=temp_ind_size(1);

        if(total_ind_size(1)==0 && temp_ind_size < NUMTOSTUDY)
            total_ind=[total_ind;temp_ind];
            num_w=num_w+temp_ind_size;
            sum_ind=sum_ind+temp_ind_size;

        elseif(total_ind_size(1)==0 && temp_ind_size > NUMTOSTUDY)
            temprand=randperm(NUMTOSTUDY);
            total_ind=[total_ind;temp_ind(temprand)];

        else
            for j=1:total_ind_size(1)
                a_temp_ind=find(temp_ind==total_ind(j));
                if( isempty(a_temp_ind)==1 )
                    total_ind=[total_ind;temp_ind(a_temp_ind)];
                    num_w=num_w+1;
                    sum_ind=sum_ind+1;
                end
            end
        end
    end

    temp_ind=find(additional_i>=2);

    if ( isempty(temp_ind)==0 && num_i < max_i && sum_ind < sum_max )
        total_ind_size=size(total_ind);
        temp_ind_size=size(temp_ind);
        temp_ind_size=temp_ind_size(1);

        if(total_ind_size(1)==0 && temp_ind_size < NUMTOSTUDY)
            total_ind=[total_ind;temp_ind];
            num_i=num_i+temp_ind_size;
            sum_ind=sum_ind+temp_ind_size;

        elseif(total_ind_size(1)==0 && temp_ind_size > NUMTOSTUDY)
            temprand=randperm(NUMTOSTUDY);
            total_ind=[total_ind;temp_ind(temprand)];

        else
            for j=1:total_ind_size(1)
                a_temp_ind=find(temp_ind==total_ind(j));
                if( isempty(a_temp_ind)==1 )
                    total_ind=[total_ind;temp_ind(a_temp_ind)];
                    num_i=num_i+1;
                    sum_ind=sum_ind+1;
                end
            end
        end
    end


    temp_ind=find(additional_s~=0);

    if ( isempty(temp_ind)==0 && num_s < max_s && sum_ind < sum_max )
        total_ind_size=size(total_ind);
        temp_ind_size=size(temp_ind);
        temp_ind_size=temp_ind_size(1);

        if(total_ind_size(1)==0 && temp_ind_size < NUMTOSTUDY)
            total_ind=[total_ind;temp_ind];
            num_s=num_s+temp_ind_size;
            sum_ind=sum_ind+temp_ind_size;

        elseif(total_ind_size(1)==0 && temp_ind_size > NUMTOSTUDY)
            temprand=randperm(NUMTOSTUDY);
            total_ind=[total_ind;temp_ind(temprand)];

        else
            for j=1:total_ind_size(1)
                a_temp_ind=find(temp_ind==total_ind(j));
                if( isempty(a_temp_ind)==1 )
                    total_ind=[total_ind;temp_ind(a_temp_ind)];
                    num_s=num_s+1;
                    sum_ind=sum_ind+1;
                end
            end
        end
    end


     MustWord=handles.mydata.totalword(total_ind,1:3);
    MustWord_size=size(MustWord);
    MustWord_size=MustWord_size(1);
    MustWord=[handles.mydata.totalword(total_ind,1:3) num2cell(double(zeros(MustWord_size,1))) num2cell(double(ones(MustWord_size,1))) num2cell(double(zeros(MustWord_size,1)))...
        num2cell(double(zeros(MustWord_size,1))) num2cell(double(ones(MustWord_size,1))) num2cell(double(zeros(MustWord_size,1))) num2cell(double(zeros(MustWord_size,1))) handles.mydata.totalword(total_ind,11)];

    additional_size=size(handles.mydata.totalword);
    additional_rand=randperm(additional_size(1));

    for i=1:sum_ind
        ind_rand=find(additional_rand==total_ind(i));

        if isempty(ind_rand)==0
            additional_rand(ind_rand)=[];
        end
    end


    MustWord=[MustWord;handles.mydata.totalword(additional_rand(1:NUMTOSTUDY-MustWord_size),:)];

    delete(handles.output);
    addstudy_restudy(handles.mydata.user_name, MustWord, handles.mydata.user_additional);

end