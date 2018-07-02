function varargout = start(varargin)
%START M-file for start.fig
%      START, by itself, creates a new START or raises the existing
%      singleton*.
%
%      H = START returns the handle to a new START or the handle to
%      the existing singleton*.
%
%      START('Property','Value',...) creates a new START using the
%      given property value pairs. Unrecognized properties are passed via
%      varargin to start_OpeningFcn.  This calling syntax produces a
%      warning when there is an existing singleton*.
%
%      START('CALLBACK') and START('CALLBACK',hObject,...) call the
%      local function named CALLBACK in START.M with the given input
%      arguments.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help start

% Last Modified by GUIDE v2.5 10-Dec-2013 01:05:34

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @start_OpeningFcn, ...
                   'gui_OutputFcn',  @start_OutputFcn, ...
                   'gui_LayoutFcn',  [], ...
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


% --- Executes just before start is made visible.
function start_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   unrecognized PropertyName/PropertyValue pairs from the
%            command line (see VARARGIN)

% Choose default command line output for start
handles.output = hObject;

set(hObject, 'Name', 'Login');

% Update handles structure

% BACKGROUND
handles.mydata.bg=axes('units', 'normalized', 'position',[0 0 1 1]);
uistack(handles.mydata.bg,'bottom');
I=imread('./image/background_plain_s.png');
ll=imagesc(I);
set(ll, 'hittest', 'off');
set(handles.mydata.bg,'handlevisibility', 'off', 'visible','off');
%

a=imread('./image/login.png', 'backgroundcolor', [0.039 0.118 0.039]);
set(handles.btn_login, 'cdata', a);

a=imread('./image/new.png', 'backgroundcolor', [0.039 0.118 0.039]);
set(handles.btn_newacc, 'cdata', a);



global fp;

fp=ftp('files.lokad.com', 'xlavmfhwprxm@hotmail.com', 'rhdzjavm5');

guidata(hObject, handles);

% UIWAIT makes start wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = start_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



function edit_id_Callback(hObject, eventdata, handles)
% hObject    handle to edit_id (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_id as text
%        str2double(get(hObject,'String')) returns contents of edit_id as a double


% --- Executes during object creation, after setting all properties.
function edit_id_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_id (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_pw_Callback(hObject, eventdata, handles)
% hObject    handle to edit_pw (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_pw as text
%        str2double(get(hObject,'String')) returns contents of edit_pw as a double


% --- Executes during object creation, after setting all properties.
function edit_pw_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_pw (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in btn_login.
function btn_login_Callback(hObject, eventdata, handles)
% hObject    handle to btn_login (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global fp islogin;

isupdated=0;

fp=ftp('files.lokad.com', 'xlavmfhwprxm@hotmail.com', 'rhdzjavm5');

islogin=0;
isboasted=0;
isfirst=1;

id=get(handles.edit_id,'String');
pw=get(handles.edit_pw,'String');

id_list=dir(fp, '/engword/user_data/');
id_list_size=size(id_list);
id_list_size=id_list_size(1);

idpath=strcat('/engword/user_data/',id,'/');
pwfull=strcat('pw-',pw);

for i=1:id_list_size
    
    if strcmp(id_list(i).name, id)==1
        
        info_list=dir(fp, idpath);
        info_list_size=size(info_list);
        info_list_size=info_list_size(1);
        
        for j=1:info_list_size
            
            if strcmp(info_list(j).name, pwfull)==1
                
                islogin=1;
                break;
                
            end
            
        end
        
        break;
    end
    
end

if islogin==1
    
    isfirst=1;
    isboasted=0;
    
    data_list=dir(fp, strcat(idpath, 'data/'));
    data_list_size=size(data_list);
    data_list_size=data_list_size(1);
    
    cd(fp, strcat(idpath, 'data/'));
    
    for i=1:data_list_size
        
        if strcmp(data_list(i).name, strcat(id, '_boasted.dat'))==1
            isboasted=1;
            delete(strcat(idpath, 'data/', id, '_boasted.dat'));
        end
        
        if strcmp(data_list(i).name, strcat(id, '_total.word'))==1
            isfirst=0;
            
            file_list=dir('./temp');
            file_list_size=size(file_list);
            file_list_size=file_list_size(1);

            for i=1:file_list_size
                if strcmp(file_list(i).name, strcat(id, '_total.word'))==1
                    isupdated=1;
                    break;
                end
            end
            
            if isupdated==0

                mget(fp, strcat(id, '_total.word'),'./temp');
                mget(fp, strcat(id, '_total.info'),'./temp');
                mget(fp, strcat(id, '_additional.index'),'./temp');
                mget(fp, strcat(id, '_basic.word'),'./temp');
                mget(fp, strcat(id, '_basic.day'),'./temp');
                
                
            %%%%% ADDITIONAL STUDY %%%%%
            
                fid_index=fopen(strcat('./temp/', id, '_additional.index'),'r');
                if fid_index~=-1
                    index_make=textscan(fid_index,'%d','delimiter','\n');
                    index_make=index_make{1};
                else
                    index_make=[];
                end

                fclose(fid_index);

                index_size=size(index_make);
                index_size=index_size(1);
                
                if isempty(index_make)==0

                for ii=1:index_size
                    mget(fp, strcat(id, '_additional', num2str(index_make(ii)), '.info'),'./temp');
                    mget(fp, strcat(id, '_additional', num2str(index_make(ii)), '.word'),'./temp');
                    mget(fp, strcat(id, '_additional', num2str(index_make(ii)), '.day'),'./temp');
                end
                end
                %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                
            end
        end
    end
end

close(fp);

if islogin==1&&isfirst==1
    close gcf;
    makebasicstudy(id);
    
    if isboasted==1
        msgbox('누군가가 당신을 앞질렀습니다! 분발하세요!', '자랑하기');
    end
    
elseif islogin==1&&isfirst==0
    close gcf;
    mainmenu(id);
    
    if isboasted==1
        msgbox('누군가가 당신을 앞질렀습니다! 분발하세요!', '자랑하기');
    end
else
    msgbox('로그인에 실패하였습니다.', '로그인 실패', 'warn');
end


% --- Executes on button press in btn_newacc.
function btn_newacc_Callback(hObject, eventdata, handles)
% hObject    handle to btn_newacc (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global fp;

issameid=0;

id=get(handles.edit_id,'String');
pw=get(handles.edit_pw,'String');

idpath=strcat('/engword/user_data/',id,'/');
pwfull=strcat('pw-',pw);

fp=ftp('files.lokad.com', 'xlavmfhwprxm@hotmail.com', 'rhdzjavm5');

id_list=dir(fp, '/engword/user_data/');
id_list_size=size(id_list);
id_list_size=id_list_size(1);

for i=1:id_list_size
    
    if strcmp(id_list(i).name, id)==1
        
        issameid=1;
        msgbox('이미 존재하는 계정입니다', '계정생성', 'warn');
        
        break;
    end    
end

if issameid==0
    
    cd(fp, '/engword/user_data/');
    mkdir(fp, id);
    cd(fp, idpath);
    mkdir(fp, pwfull);
    mkdir(fp, 'data');
    msgbox('계정이 생성되었습니다.', '계정생성', 'help');
    
end

close(fp);


% --- Executes when user attempts to close figure1.
function figure1_CloseRequestFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: delete(hObject) closes the figure

global fp;

close(fp);
clear global fp;

delete(hObject);
