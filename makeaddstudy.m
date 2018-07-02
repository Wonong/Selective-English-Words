function varargout = makeaddstudy(varargin)
% MAKEADDSTUDY MATLAB code for makeaddstudy.fig
%      MAKEADDSTUDY, by itself, creates a new MAKEADDSTUDY or raises the existing
%      singleton*.
%
%      H = MAKEADDSTUDY returns the handle to a new MAKEADDSTUDY or the handle to
%      the existing singleton*.
%
%      MAKEADDSTUDY('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in MAKEADDSTUDY.M with the given input arguments.
%
%      MAKEADDSTUDY('Property','Value',...) creates a new MAKEADDSTUDY or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before makeaddstudy_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to makeaddstudy_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help makeaddstudy

% Last Modified by GUIDE v2.5 10-Dec-2013 04:52:37

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @makeaddstudy_OpeningFcn, ...
                   'gui_OutputFcn',  @makeaddstudy_OutputFcn, ...
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


% --- Executes just before makeaddstudy is made visible.
function makeaddstudy_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to makeaddstudy (see VARARGIN)

% Choose default command line output for makeaddstudy
handles.output = hObject;

% Update handles structure

set(hObject, 'Name', '조건학습 설정');

handles.mydata.user_name=varargin{1};


bg=axes('units', 'normalized', 'position',[0 0 1 1]);
uistack(bg,'bottom');
I=imread('./image/background_plain_s.png');
ll=imagesc(I);
set(ll, 'hittest', 'off');
set(bg,'handlevisibility', 'off', 'visible','off');

a=imread('./image/enter.png', 'backgroundcolor', [0.039 0.118 0.039]);
set(handles.btn_confirm, 'cdata', a);
set(handles.btn_choice, 'cdata', a);
set(handles.btn_tonext, 'cdata', a);


global isplan group1 group2 group3 group4;
isplan=0;

group1=[handles.text_instruction1 handles.btn_restudy handles.btn_plan];

group2=[handles.text11 handles.list_word handles.btn_choice handles.text_instruction2]; % 단어범위지정 

group3=[handles.slider1 handles.slider2 handles.slider3 handles.text_sliderw handles.text_slideri handles.text_sliders...
    handles.text_instruction3 handles.btn_tonext];

group4=[handles.text_instruction4 handles.text3 handles.text4 handles.text5 handles.text6 handles.edit_totalword handles.edit_totaldays...
     handles.edit_oneday handles.text_maxword handles.btn_confirm handles.edit_profile];


handles.mydata.maxword=0;

% Get Word file list
filelist=dir('./WordDb');
filesize=size(filelist);
filesize=filesize(1);

word_listbox='';

for i=1:filesize
    if isempty(strfind(filelist(i).name, '.word'))==0
        word_listbox=[word_listbox;{filelist(i).name}];
    end
end

set(handles.list_word, 'string', word_listbox);
guidata(handles.output, handles);
% UIWAIT makes makeaddstudy wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = makeaddstudy_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on selection change in list_word.
function list_word_Callback(hObject, eventdata, handles)
% hObject    handle to list_word (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns list_word contents as cell array
%        contents{get(hObject,'Value')} returns selected item from list_word


% --- Executes during object creation, after setting all properties.
function list_word_CreateFcn(hObject, eventdata, handles)
% hObject    handle to list_word (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in btn_confirm.
function btn_confirm_Callback(hObject, eventdata, handles)
% hObject    handle to btn_confirm (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

correct=get(handles.slider1, 'Value');
wrong=100-correct;
important=get(handles.slider2, 'Value');
lessimportant=100-important;
submitted=get(handles.slider3, 'Value');
notsubmitted=100-submitted;

wordsize=str2num(get(handles.edit_totalword, 'String'));


max_w=ceil(wordsize*wrong/100);
max_i=ceil(wordsize*important/100);
max_s=ceil(wordsize*submitted/100);

total_ind=[];
sum_ind=0;
sum_max=max_w+max_i+max_s;
NUMTOSTUDY=sum_max;

additional_w=cell2mat(handles.mydata.additional_word(1:end,5));
additional_i=cell2mat(handles.mydata.additional_word(1:end,3));
additional_s=cell2mat(handles.mydata.additional_word(1:end,4));

num_w=0;
num_i=0;
num_s=0;

%for i=1:handles.mydata.totalword_size
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
%end

MustWord=handles.mydata.additional_word(total_ind,1:3);

additional_size=size(handles.mydata.additional_word);
additional_rand=randperm(additional_size(1));

for i=1:sum_ind
    ind_rand=find(additional_rand==total_ind(i));
    
    if isempty(ind_rand)==0
        additional_rand(ind_rand)=[];
    end
end

MustWord=[MustWord;handles.mydata.additional_word(additional_rand(1:wordsize-sum_ind),1:3)];

total_study=str2num(get(handles.edit_totalword,'String'));
oneday_study=str2num(get(handles.edit_oneday,'String'));
totaldays_study=str2num(get(handles.edit_totaldays,'String'));
totalsize=size(MustWord);
totalsize=totalsize(1);
datefill=num2cell(zeros(totalsize,1));
MustWord=[MustWord datefill];

a=randperm(totalsize);

for i=1:totaldays_study
    for j=1:oneday_study
        if((oneday_study*(i-1)+j)<=total_study)
            MustWord{a(oneday_study*(i-1)+j),4}=i;
        end
    end
end


fid_index=fopen(strcat('./temp/', handles.mydata.user_name, '_additional.index'),'r+');

if fid_index~=-1
    index_make=textscan(fid_index,'%d','delimiter','\n');
    index_make=index_make{1};
else
    fid_index=fopen(strcat('./temp/', handles.mydata.user_name, '_additional.index'),'w');
    index_make=[];
end
    
if isempty(index_make)==1
    index_make=1;
else
    index_make=index_make(end)+1;
end

fprintf(fid_index,'%d\r\n',index_make);

index_make=num2str(index_make);

fpath=strcat('./temp/',handles.mydata.user_name,'_additional',index_make,'.word');
fid=fopen(fpath,'w');

for i=1:totalsize
        fprintf(fid,'%s\t%s\t%d\t%d\r\n',MustWord{i,1}, MustWord{i,2}, MustWord{i,3}, MustWord{i,4});
end

fclose(fid_index);

fclose(fid);

day=[1;totaldays_study];
fid3=fopen(strcat('./temp/', handles.mydata.user_name, '_additional',index_make,'.day'),'w');
fprintf(fid3,'%d\r\n%d',day(1), day(2));
fclose(fid3);


profile_name=get(handles.edit_profile, 'String');
fid_info=fopen(strcat('./temp/', handles.mydata.user_name, '_additional',index_make,'.info'),'w');
fprintf(fid_info,'%s',profile_name);
fclose(fid_info);


fclose all;

guidata(handles.output, handles);

close gcf;
mainmenu(handles.mydata.user_name);






% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in btn_choice.
function btn_choice_Callback(hObject, eventdata, handles)
% hObject    handle to btn_choice (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

selected_items=get(handles.list_word,'value');
num_items=size(selected_items);
num_items=num_items(2);
list_string=get(handles.list_word,'string');
list_string=list_string(selected_items);
handles.mydata.additional_word=[];

for i=1:num_items
    list_string{i}=strcat('./WordDB/',list_string{i});
    fid=fopen(list_string{i},'r');
    word_data=textscan(fid,'%s%s%d','delimiter','\t');
    fclose(fid);
    
    handles.mydata.additional_word=[handles.mydata.additional_word;word_data{1} word_data{2} num2cell(word_data{3})];
end

word_size=size(handles.mydata.additional_word);
word_size=word_size(1);

while(i<=word_size)
    ind_word= strfind(handles.mydata.additional_word(1:end/3), handles.mydata.additional_word{i,1});
    ind = find(not(cellfun('isempty', ind_word)));
    ind_size=size(ind);
    i=i+1;
    
    if (ind_size(2)~=1)
        j=ind_size(2);
        while(j>1)
            handles.mydata.additional_word(ind(j),:)=[];
            word_size=word_size-1;
            j=j-1;
        end
    end
end


additional_word_size=size(handles.mydata.additional_word);
%additional_word_size=additional_word_size(1);

handles.mydata.additional_word=[handles.mydata.additional_word num2cell(zeros(additional_word_size(1),1)) num2cell(zeros(additional_word_size(1),1))];
fid=fopen(strcat('./temp/', handles.mydata.user_name, '_total.word'));

handles.mydata.totalword=textscan(fid,'%s%s%d%d%d%d%d%d%d%f%d','delimiter','\t');
handles.mydata.totalword=[handles.mydata.totalword{1} handles.mydata.totalword{2} num2cell(handles.mydata.totalword{3}) num2cell(handles.mydata.totalword{8}) num2cell(handles.mydata.totalword{10})];
handles.mydata.totalword_size=size(handles.mydata.totalword);
fclose(fid);

i=1;
while(i<=handles.mydata.totalword_size(1))
    ind_totalword= strfind(handles.mydata.additional_word(1:end/5), handles.mydata.totalword{i,1});
    ind_total = find(not(cellfun('isempty', ind_totalword)));
    %ind_total_size=size(ind_total);
   
    
    if(isempty(ind_total)==0)
        handles.mydata.additional_word{ind_total(1),4}=double(handles.mydata.totalword{i,4});
        handles.mydata.additional_word{ind_total(1),5}=handles.mydata.totalword{i,5};
    end
    
    i=i+1;
end

additional_word_size=size(handles.mydata.additional_word);
additional_word_size=additional_word_size(1);

handles.mydata.maxword=additional_word_size;

maxword=strcat('최대 : ',num2str(additional_word_size));
set(handles.text_maxword, 'String', maxword);

global isplan group1 group2 group3 group4;

a=size(group2);

for i=1:a(2)
    set(group2(i), 'Visible', 'off');
end

a=size(group3);

set(handles.text_order, 'String', '3. 단어 조건 지정');
for i=1:a(2)
    set(group3(i), 'Visible', 'on');
end


guidata(handles.output, handles);





% --- Executes on slider movement.
function slider1_Callback(hObject, eventdata, handles)
% hObject    handle to slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function slider1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function slider2_Callback(hObject, eventdata, handles)
% hObject    handle to slider2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function slider2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function slider3_Callback(hObject, eventdata, handles)
% hObject    handle to slider3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function slider3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end



function edit_totalword_Callback(hObject, eventdata, handles)
% hObject    handle to edit_totalword (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_totalword as text
%        str2double(get(hObject,'String')) returns contents of edit_totalword as a double
a=str2num(get(hObject,'String'));

if a<50
    msgbox('50 이상의 값을 입력하시오.', '오류', 'warn');
    set(hObject, 'String', '');
    
       
elseif a > handles.mydata.maxword
    msgbox('최대 개수 이하의 값을 입력하시오.', '오류', 'warn');
    set(hObject, 'String', '');
    
else

b=str2num(get(handles.edit_oneday,'String'));

if(isempty(b)==0)
set(handles.edit_totaldays,'String',num2str(ceil(a/b)));
end

end


% --- Executes during object creation, after setting all properties.
function edit_totalword_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_totalword (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_oneday_Callback(hObject, eventdata, handles)
% hObject    handle to edit_oneday (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_oneday as text
%        str2double(get(hObject,'String')) returns contents of edit_oneday as a double
a=str2num(get(handles.edit_totalword,'String'));
b=str2num(get(hObject,'String'));

if b<3
    msgbox('3 이상의 값을 입력하시오.', '오류', 'warn');
    set(hObject, 'String', '');
else

if(isempty(a)==0)
set(handles.edit_totaldays,'String',num2str(ceil(a/b)));
end
end

% --- Executes during object creation, after setting all properties.
function edit_oneday_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_oneday (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_totaldays_Callback(hObject, eventdata, handles)
% hObject    handle to edit_totaldays (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_totaldays as text
%        str2double(get(hObject,'String')) returns contents of edit_totaldays as a double
a=str2num(get(handles.edit_totalword,'String'));
c=str2num(get(hObject,'String'));

if(isempty(a)==0)
set(handles.edit_oneday,'String',num2str(ceil(a/c)));
end

% --- Executes during object creation, after setting all properties.
function edit_totaldays_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_totaldays (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit4_Callback(hObject, eventdata, handles)
% hObject    handle to edit4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit4 as text
%        str2double(get(hObject,'String')) returns contents of edit4 as a double


% --- Executes during object creation, after setting all properties.
function edit4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in checkbox1.
function checkbox1_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox1



function edit_profile_Callback(hObject, eventdata, handles)
% hObject    handle to edit_profile (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_profile as text
%        str2double(get(hObject,'String')) returns contents of edit_profile as a double


% --- Executes during object creation, after setting all properties.
function edit_profile_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_profile (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in btn_plan.
function btn_plan_Callback(hObject, eventdata, handles)
% hObject    handle to btn_plan (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global isplan;
global group1 group2 group3 group4;

isplan=1;

a=size(group1);

for i=1:a(2)
    set(group1(i), 'Visible', 'off');
end

a=size(group2);

set(handles.text_order, 'String', '2. 단어 범위 지정');
for i=1:a(2)
    set(group2(i), 'Visible', 'on');
end


% --- Executes on button press in btn_restudy.
function btn_restudy_Callback(hObject, eventdata, handles)
% hObject    handle to btn_restudy (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global isplan;
global group1 group2 group3 group4;

isplan=0;

a=size(group1);

for i=1:a(2)
    set(group1(i), 'Visible', 'off');
end

a=size(group3);
set(handles.text_order, 'String', '2. 단어 조건 지정');

for i=1:a(2)
    set(group3(i), 'Visible', 'on');
end


% --- Executes on button press in btn_tonext.
function btn_tonext_Callback(hObject, eventdata, handles)
% hObject    handle to btn_tonext (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global isplan group1 group2 group3 group4;

a=size(group3);

for i=1:a(2)
    set(group3(i), 'Visible', 'off');
end


if isplan==1
    a=size(group4);
    
    
    set(handles.text_order, 'String', '4. 단어 학습량 지정');

    for i=1:a(2)
        set(group4(i), 'Visible', 'on');
    end
    
else
    
    fid_index=fopen(strcat('./temp/', handles.mydata.user_name, '_additional.index'),'r+');

    if fid_index~=-1
        index_make=textscan(fid_index,'%d','delimiter','\n');
        index_make=index_make{1};
    else
        fid_index=fopen(strcat('./temp/', handles.mydata.user_name, '_additional.index'),'w');
        index_make=[];
    end

    if isempty(index_make)==1
        index_make=1;
    else
        index_make=index_make(end)+1;
    end

    fprintf(fid_index,'%d\r\n',index_make);

    index_make=num2str(index_make);

    fpath=strcat('./temp/',handles.mydata.user_name,'_additional',index_make,'.word');
    fid=fopen(fpath,'w');
% 
%     for i=1:totalsize
%             fprintf(fid,'%s\t%s\t%d\t%d\r\n',MustWord{i,1}, MustWord{i,2}, MustWord{i,3}, MustWord{i,4});
%     end

    fclose(fid_index);

    fclose(fid);
    
    correct=get(handles.slider1, 'Value');
    wrong=100-correct;
    important=get(handles.slider2, 'Value');
    lessimportant=100-important;
    submitted=get(handles.slider3, 'Value');
    notsubmitted=100-submitted;

    %day=[1;totaldays_study];
    fid3=fopen(strcat('./temp/', handles.mydata.user_name, '_additional',index_make,'.day'),'w');
    fprintf(fid3,'%d\r\n%d\r\n%d\r\n%d\r\n%d\r\n%d\r\n', 0, 0, 20, wrong, important, submitted);
    fclose(fid3);


    profile_name='RESTUDY';
    fid_info=fopen(strcat('./temp/', handles.mydata.user_name, '_additional',index_make,'.info'),'w');
    fprintf(fid_info,'%s',profile_name);
    fclose(fid_info);


    fclose all;

    guidata(handles.output, handles);
    
    
    close gcf;
    mainmenu(handles.mydata.user_name);
end
