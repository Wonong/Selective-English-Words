function varargout = addstudymenu(varargin)
% ADDSTUDYMENU MATLAB code for addstudymenu.fig
%      ADDSTUDYMENU, by itself, creates a new ADDSTUDYMENU or raises the existing
%      singleton*.
%
%      H = ADDSTUDYMENU returns the handle to a new ADDSTUDYMENU or the handle to
%      the existing singleton*.
%
%      ADDSTUDYMENU('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in ADDSTUDYMENU.M with the given input arguments.
%
%      ADDSTUDYMENU('Property','Value',...) creates a new ADDSTUDYMENU or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before addstudymenu_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to addstudymenu_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help addstudymenu

% Last Modified by GUIDE v2.5 09-Dec-2013 22:35:13

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @addstudymenu_OpeningFcn, ...
                   'gui_OutputFcn',  @addstudymenu_OutputFcn, ...
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


% --- Executes just before addstudymenu is made visible.
function addstudymenu_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to addstudymenu (see VARARGIN)

% Choose default command line output for addstudymenu
handles.output = hObject;

% Update handles structure

set(hObject, 'Name', '조건학습');

handles.mydata.user_name=varargin{1};

% BACKGROUND
handles.mydata.bg=axes('units', 'normalized', 'position',[0 0 1 1]);
uistack(handles.mydata.bg,'bottom');
I=imread('./image/background_plain_s.png');
ll=imagesc(I);
set(ll, 'hittest', 'off');
set(handles.mydata.bg,'handlevisibility', 'off', 'visible','off');
%


a=imread('./image/re1.png', 'backgroundcolor', [0.039 0.118 0.039]);
set(handles.btn_home, 'cdata', a);

a=imread('./image/add.png', 'backgroundcolor', [0.039 0.118 0.039]);
set(handles.btn_add, 'cdata', a);

a=imread('./image/del.png', 'backgroundcolor', [0.039 0.118 0.039]);
set(handles.btn_remove, 'cdata', a);



global additional_list;

additional_list=[];

fid_index=fopen(strcat('./temp/', handles.mydata.user_name, '_additional.index'),'r');

if fid_index~=-1
    index_make=textscan(fid_index,'%d','delimiter','\n');
    index_make=index_make{1};
else
    index_make=[];
end

fclose(fid_index);

additional_list{4}=index_make;

index_size=size(index_make);
index_size=index_size(1);

if index_make==0
    additional_list{1}=[];
    additional_list{2}=[];
    additional_list{3}=[];
    
else

for i=1:index_size
    fid=fopen(strcat('./temp/', handles.mydata.user_name, '_additional', num2str(index_make(i)), '.info'),'r');
    profile_name=textscan(fid, '%s', 'delimiter', '\n');
    profile_name=profile_name{1};
    additional_list{1}=[additional_list{1};profile_name];
    fclose(fid);
    
    fid2=fopen(strcat('./temp/', handles.mydata.user_name, '_additional', num2str(index_make(i)), '.day'),'r');
    additional_day=textscan(fid, '%d','delimiter', '\n');
    additional_day=additional_day{1};
    additional_day_size=size(additional_day);
    fclose(fid2);
    
    if additional_day_size(1)==6
        additional_list{2}=[additional_list{2};{'일회성'}];
        additional_list{3}=[additional_list{3};num2str(additional_day(2))];
        
    else
        additional_list{2}=[additional_list{2};{'지속성'}];
        additional_list{3}=[additional_list{3};strcat(num2str(additional_day(1)), {'  /  '}, num2str(additional_day(2)))];
    end
end

end


global t_addstudymenu;

t_addstudymenu = uitable('Parent', handles.output, 'Units', 'Pixels', 'Position', [80 220 780 320]);

set(t_addstudymenu, 'Data', [additional_list{1},additional_list{2},additional_list{3}]);

set(t_addstudymenu, 'ColumnName', {'프로필명', '지속성', '실행회수'});
                  
set(t_addstudymenu, 'ColumnWidth', {430 155 163});

%set(t_addstudymenu, 'Position', [100 300 702 300]);


foregroundColor = [1 1 1];
set(t_addstudymenu, 'ForegroundColor', foregroundColor);
backgroundColor = [.1 .5 .1; .2 .3 .2];
set(t_addstudymenu, 'BackgroundColor', backgroundColor);
set(t_addstudymenu, 'FontSize', 15);
guidata(hObject, handles);

t=timer('TimerFcn', @(x,y)setTable, 'StartDelay', 1);
start(t);

% UIWAIT makes addstudymenu wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = addstudymenu_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in btn_start.
function btn_start_Callback(hObject, eventdata, handles)
% hObject    handle to btn_start (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global additional_list hJTable;

selected=hJTable.getSelectedRow+1;

if selected==0
    % do nothing
else

%additional_list{2}(selected)
if strcmp(additional_list{2}{selected}, '지속성')==1
    delete(handles.output);
    addstudy_plan(handles.mydata.user_name, strcat(handles.mydata.user_name, '_additional', num2str(additional_list{4}(selected))));
else
    
    try
    NUMTOSTUDY=getDay(handles.mydata.user_name, strcat('_additional', num2str(additional_list{4}(selected)), '.day'));
    
    wrong=NUMTOSTUDY(4);
    important=NUMTOSTUDY(5);
    submitted=NUMTOSTUDY(6);
    NUMTOSTUDY=NUMTOSTUDY(3);
        
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
    
    
    MustWord=[MustWord;handles.mydata.totalword(additional_rand(1:NUMTOSTUDY-MustWord_size),:)] ;
    
    
    if handles.mydata.totalword_size < 80
        msgbox([{'기본 학습을 더 하고 나서'} {'복습을 하십시오.'}],'오류', 'warn');
    else
    
    delete(handles.output);
    addstudy_restudy(handles.mydata.user_name, MustWord, strcat(handles.mydata.user_name, '_additional', num2str(additional_list{4}(selected))));
    end
    
    %go to additional preview with MustWord -> same with basic study
    
    %fclose(fid);
    catch
        msgbox([{'기본 학습을 더 하고 나서'} {'복습을 하십시오.'}],'오류', 'warn');
    end
end
end



% --- Executes on button press in btn_home.
function btn_home_Callback(hObject, eventdata, handles)
% hObject    handle to btn_home (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

delete(handles.output);
mainmenu(handles.mydata.user_name);


% --- Executes on button press in btn_add.
function btn_add_Callback(hObject, eventdata, handles)
% hObject    handle to btn_add (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

close gcf;
makeaddstudy(handles.mydata.user_name);


% --- Executes on button press in btn_remove.
function btn_remove_Callback(hObject, eventdata, handles)
% hObject    handle to btn_remove (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global additional_list hJTable t_addstudymenu;

selected=hJTable.getSelectedRow+1;

if selected==0
    % do nothing

else

fid_index=fopen(strcat('./temp/', handles.mydata.user_name, '_additional.index'),'r');

index_removed=textscan(fid_index,'%d','delimiter','\n');
index_removed=index_removed{1};

fclose(fid_index);


index_removed(index_removed==additional_list{4}(selected))=[];

fid_index2=fopen(strcat('./temp/', handles.mydata.user_name, '_additional.index'),'w');
delete(strcat('./temp/', handles.mydata.user_name, '_additional', num2str(additional_list{4}(selected)), '.day'));
delete(strcat('./temp/', handles.mydata.user_name, '_additional', num2str(additional_list{4}(selected)), '.info'));

if strcmp(additional_list{2}(selected), '지속성')==1
    delete(strcat('./temp/', handles.mydata.user_name, '_additional', num2str(additional_list{4}(selected)), '.word'));
end

if isempty(index_removed)==0
fprintf(fid_index2, '%d\r\n', index_removed);
end

fclose(fid_index2);



% RELOAD WORD DATA!

additional_list=[];

fid_index=fopen(strcat('./temp/', handles.mydata.user_name, '_additional.index'),'r');

if fid_index~=-1
    index_make=textscan(fid_index,'%d','delimiter','\n');
    index_make=index_make{1};
else
    index_make=[];
end

fclose(fid_index);

if index_make==0
    additional_list{1}=[];
    additional_list{2}=[];
    additional_list{3}=[];
    
else
    
additional_list{4}=index_make;


index_size=size(index_make);
index_size=index_size(1);

for i=1:index_size
    fid=fopen(strcat('./temp/', handles.mydata.user_name, '_additional', num2str(index_make(i)), '.info'),'r');
    profile_name=textscan(fid, '%s', 'delimiter', '\n');
    profile_name=profile_name{1};
    additional_list{1}=[additional_list{1};profile_name];
    fclose(fid);
    
    fid2=fopen(strcat('./temp/', handles.mydata.user_name, '_additional', num2str(index_make(i)), '.day'),'r');
    additional_day=textscan(fid, '%d','delimiter', '\n');
    additional_day=additional_day{1};
    additional_day_size=size(additional_day);
    fclose(fid2);
    
    if additional_day_size(1)==6
        additional_list{2}=[additional_list{2};{'일회성'}];
        additional_list{3}=[additional_list{3};num2str(additional_day(2))];
        
    else
        additional_list{2}=[additional_list{2};{'지속성'}];
        additional_list{3}=[additional_list{3};strcat(num2str(additional_day(1)), {'  /  '}, num2str(additional_day(2)))];
    end
end

end

set(t_addstudymenu, 'Data', [additional_list{1},additional_list{2},additional_list{3}]);
end


function setTable

global t_addstudymenu hJTable;

hJScroll = findjobj(t_addstudymenu); % findjobj is from file exchange
hJTable = hJScroll.getViewport.getView; % get the table component within the scroll object
hJTable.setNonContiguousCellSelection(false);
hJTable.setColumnSelectionAllowed(false);
hJTable.setRowSelectionAllowed(true);
hJTable.setMultiColumnSortable(false);
hJTable.setSelectionMode(0);
