function varargout = makebasicstudy(varargin)
% MAKEBASICSTUDY MATLAB code for makebasicstudy.fig
%      MAKEBASICSTUDY, by itself, creates a new MAKEBASICSTUDY or raises the existing
%      singleton*.
%
%      H = MAKEBASICSTUDY returns the handle to a new MAKEBASICSTUDY or the handle to
%      the existing singleton*.
%
%      MAKEBASICSTUDY('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in MAKEBASICSTUDY.M with the given input arguments.
%
%      MAKEBASICSTUDY('Property','Value',...) creates a new MAKEBASICSTUDY or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before makebasicstudy_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to makebasicstudy_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help makebasicstudy

% Last Modified by GUIDE v2.5 10-Dec-2013 03:10:10

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @makebasicstudy_OpeningFcn, ...
                   'gui_OutputFcn',  @makebasicstudy_OutputFcn, ...
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


% --- Executes just before makebasicstudy is made visible.
function makebasicstudy_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to makebasicstudy (see VARARGIN)

% Choose default command line output for makebasicstudy
handles.output = hObject;

% Update handles structure

set(hObject, 'Name', '기본학습 설정');

handles.mydata.user_name=varargin{1};



bg=axes('units', 'normalized', 'position',[0 0 1 1]);
uistack(bg,'bottom');
I=imread('./image/background_plain_s.png');
ll=imagesc(I);
set(ll, 'hittest', 'off');
set(bg,'handlevisibility', 'off', 'visible','off');



a=imread('./image/enter.png', 'backgroundcolor', [0.039 0.118 0.039]);
set(handles.btn_confirm, 'cdata', a);

%a=imread('./image/next.png', 'backgroundcolor', [0.039 0.118 0.039]);
set(handles.btn_choice, 'cdata', a);


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


% UIWAIT makes makebasicstudy wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = makebasicstudy_OutputFcn(hObject, eventdata, handles) 
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

% Get Edit Box Number
total_study=str2num(get(handles.edit_totalword,'String'));
oneday_study=str2num(get(handles.edit_oneday,'String'));
totaldays_study=str2num(get(handles.edit_totaldays,'String'));

totalsize=size(handles.mydata.total_word);
totalsize=totalsize(1);

datefill=num2cell(zeros(totalsize,1));

% Word Meaning Importance Date
handles.mydata.total_word=[handles.mydata.total_word datefill];

a=randperm(totalsize);

% Filling Date on Filtered Word List
for i=1:totaldays_study
    for j=1:oneday_study
        if((oneday_study*(i-1)+j)<=total_study)
            handles.mydata.total_word{a(oneday_study*(i-1)+j),4}=i;
        end
    end
end

fpath=strcat('./temp/',handles.mydata.user_name,'_basic.word');
fid=fopen(fpath,'w');

% Save to File
for i=1:totalsize
    if(handles.mydata.total_word{i,4}~=0)
        fprintf(fid,'%s\t%s\t%d\t%d\r\n',handles.mydata.total_word{i,1}, handles.mydata.total_word{i,2}, handles.mydata.total_word{i,3}, handles.mydata.total_word{i,4});
    end
end

fclose(fid);

fid2=fopen(strcat('./temp/', handles.mydata.user_name, '_total.word'),'w');
fclose(fid2);

day=[1;totaldays_study];
fid3=fopen(strcat('./temp/', handles.mydata.user_name, '_basic.day'),'w');
fprintf(fid3,'%d\r\n%d',day(1), day(2));
fclose(fid3);

fid4=fopen(strcat('./temp/', handles.mydata.user_name, '_total.info'),'w');
fclose(fid4);

fid5=fopen(strcat('./temp/', handles.mydata.user_name, '_additional.index'),'w');
fclose(fid5);

guidata(handles.output, handles);
mainmenu(handles.mydata.user_name);
figure1_CloseRequestFcn(handles.output, eventdata, handles);

%handles.mydata.total_word


% --- Executes on button press in btn_reset.
function btn_reset_Callback(hObject, eventdata, handles)
% hObject    handle to btn_reset (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



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
a=str2num(get(hObject,'String'));

if a<3
    msgbox('3 이상의 값을 입력하시오.', '오류', 'warn');
    set(hObject, 'String', '');
else
b=str2num(get(handles.edit_totalword,'String'));

if(isempty(a)==0)
set(handles.edit_totaldays,'String',num2str(ceil(b/a)));
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


% --- Executes on button press in btn_choice.
function btn_choice_Callback(hObject, eventdata, handles)
% hObject    handle to btn_choice (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of btn_choice

val=get(hObject,'Value');
editgroup=[handles.edit_totalword handles.edit_oneday handles.edit_totaldays handles.edit4];

selected_items=get(handles.list_word,'value');
num_items=size(selected_items);
num_items=num_items(2);
list_string=get(handles.list_word,'string');
list_string=list_string(selected_items);
handles.mydata.total_word=[];
text_selected='';

for i=1:num_items
    text_selected=strcat(text_selected,{'   '},list_string{i}); % Show Selected
    list_string{i}=strcat('./WordDB/',list_string{i});
    fid=fopen(list_string{i},'r');
    word_data=textscan(fid,'%s%s%d','delimiter','\t');
    fclose(fid);
    
    handles.mydata.total_word=[handles.mydata.total_word;word_data{1} word_data{2} num2cell(word_data{3})];
end

text_selected{2}='Selected';
word_size=size(handles.mydata.total_word);
word_size=word_size(1);

while(i<=word_size)
    ind_word= strfind(handles.mydata.total_word(1:end/3), handles.mydata.total_word{i,1});
    ind = find(not(cellfun('isempty', ind_word)));
    ind_size=size(ind);
    i=i+1;
    
    if (ind_size(2)~=1)
        j=ind_size(2);
        while(j>1)
            handles.mydata.total_word(ind(j),:)=[];
            word_size=word_size-1;
            j=j-1;
        end
        %for j=ind_size(2):-1:2
        %    handles.mydata.total_word(ind(j),:)=[];
        %    word_size=word_size-1;
        %end
    end
end

total_word_size=size(handles.mydata.total_word);
total_word_size=total_word_size(1);

handles.mydata.maxword=total_word_size;
maxword=strcat('최대 : ',num2str(total_word_size));

set(handles.text_maxword,'String',maxword);
%set(handles.text_selected,'String',text_selected);

nextgroup=[handles.edit_totalword handles.edit_oneday handles.edit_totaldays...
    handles.text3 handles.text4 handles.text5 handles.text_maxword handles.text_instruction2 handles.btn_confirm];



for i=1:9
    set(nextgroup(i), 'visible', 'on');
end

set(hObject, 'Visible', 'off');
set(handles.text_instruction, 'Visible', 'off');
set(handles.list_word, 'Visible', 'off');
set(handles.text_order, 'String', '2. 단어 학습량 지정');





guidata(handles.output, handles);





% --- Executes when user attempts to close figure1.
function figure1_CloseRequestFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: delete(hObject) closes the figure
delete(hObject);
