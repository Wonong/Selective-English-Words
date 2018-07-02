function varargout = mainmenu(varargin)
% MAINMENU MATLAB code for mainmenu.fig
%      MAINMENU, by itself, creates a new MAINMENU or raises the existing
%      singleton*.
%
%      H = MAINMENU returns the handle to a new MAINMENU or the handle to
%      the existing singleton*.
%
%      MAINMENU('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in MAINMENU.M with the given input arguments.
%
%      MAINMENU('Property','Value',...) creates a new MAINMENU or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before mainmenu_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to mainmenu_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help mainmenu

% Last Modified by GUIDE v2.5 10-Dec-2013 02:22:22

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @mainmenu_OpeningFcn, ...
                   'gui_OutputFcn',  @mainmenu_OutputFcn, ...
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


% --- Executes just before mainmenu is made visible.
function mainmenu_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to mainmenu (see VARARGIN)

% Choose default command line output for mainmenu
handles.output = hObject;

% Update handles structure

set(hObject, 'Name', '골라먹는영단어');

handles.mydata.user_name=varargin{1};

bg=axes('units', 'normalized', 'position',[0 0 1 1]);
uistack(bg,'bottom');
I=imread('./image/background.png');
ll=imagesc(I);
set(ll, 'hittest', 'off');
text('units', 'pixels', 'position', [65 550], 'string', [{strcat(handles.mydata.user_name, '님')} {'환영합니다!'}], 'color', [1 1 1], 'fontsize', 18, 'fontweight', 'bold','Interpreter', 'none');
set(bg,'handlevisibility', 'off', 'visible','off');


handles.mydata.basic_day=getDay(handles.mydata.user_name,'_basic.day');

basic_title=[strcat(num2str(handles.mydata.basic_day(1)), {'  /  '}, num2str(handles.mydata.basic_day(2)));'기본 학습'];

set(handles.text_user,'String',handles.mydata.user_name);
set(handles.btn_basic,'String',basic_title);

%set(handles.btn_basic,'ButtonDownFcn',@btn_basic_ButtonDownFcn);

guidata(handles.output, handles);

axes(handles.axes10);
[ia, map, alpha]=imread('./image/name.png');
iaia=imagesc(ia);
set(iaia, 'alphadata', alpha);
set(handles.axes10,'handlevisibility', 'off', 'visible','off');



% IMAGE IMPORT
axes(handles.axes_basic);
[ia, map, alpha]=imread('./image/basic.png');
iaia=imagesc(ia);
set(iaia, 'ButtonDownFcn', @(x,y)btn_basic_Callback(handles.btn_basic, eventdata, handles), 'alphadata', alpha);
set(handles.axes_basic,'handlevisibility', 'off', 'visible','off');

axes(handles.axes_additional);
[ia, map, alpha]=imread('./image/additional.png');
iaia=imagesc(ia);
set(iaia, 'ButtonDownFcn', @(x,y)additional_study(handles), 'alphadata', alpha);
set(handles.axes_additional,'handlevisibility', 'off', 'visible','off');

axes(handles.axes_word);
[ia, map, alpha]=imread('./image/words.png');
iaia=imagesc(ia);
set(iaia, 'ButtonDownFcn', @(x,y)word_study(handles), 'alphadata', alpha);
set(handles.axes_word,'handlevisibility', 'off', 'visible','off');

axes(handles.axes_setting);
[ia, map, alpha]=imread('./image/setting.png');
iaia=imagesc(ia);
set(iaia, 'ButtonDownFcn', @(x,y)setting_study(handles), 'alphadata', alpha);
set(handles.axes_setting,'handlevisibility', 'off', 'visible','off');

axes(handles.axes_game);
[ia, map, alpha]=imread('./image/game.png');
iaia=imagesc(ia);
set(iaia, 'ButtonDownFcn', @(x,y)game_study(handles), 'alphadata', alpha);
set(handles.axes_game,'handlevisibility', 'off', 'visible','off');

axes(handles.axes_exit);
[ia, map, alpha]=imread('./image/end.png');
iaia=imagesc(ia);
set(iaia, 'ButtonDownFcn', @(x,y)exit_study(handles), 'alphadata', alpha);
set(handles.axes_exit,'handlevisibility', 'off', 'visible','off');

isupdated=0;

file_list=dir('./temp');
file_list_size=size(file_list);
file_list_size=file_list_size(1);

for i=1:file_list_size
    if strcmp(file_list(i).name, strcat(handles.mydata.user_name, '_total.word'))==1
        isupdated=1;
        break;
    end
end

if isupdated==0

    fp=ftp('files.lokad.com', 'xlavmfhwprxm@hotmail.com', 'rhdzjavm5');

    cd(fp, strcat('/engword/user_data/', handles.mydata.user_name, '/data'));

    mget(strcat(hanldes.mydata.user_name, '_total.word'),'./temp');
    mget(strcat(hanldes.mydata.user_name, '_total.info'),'./temp');
    mget(strcat(hanldes.mydata.user_name, '_additional.index'),'./temp');
    mget(strcat(hanldes.mydata.user_name, '_basic.word'),'./temp');
    mget(strcat(hanldes.mydata.user_name, '_basic.day'),'./temp');
    
    close(fp)
    clear fp;
end

        

%
%
%




% UIWAIT makes mainmenu wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = mainmenu_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in btn_basic.
function btn_basic_Callback(hObject, eventdata, handles)
% hObject    handle to btn_basic (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%close gcf;
figure1_CloseRequestFcn(handles.output, 0, handles);

basicpreview(handles.mydata.user_name);


% --- Executes on button press in btn_exit.
function btn_exit_Callback(hObject, eventdata, handles)
% hObject    handle to btn_exit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in btn_additional.
function btn_additional_Callback(hObject, eventdata, handles)
% hObject    handle to btn_additional (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in btn_word.
function btn_word_Callback(hObject, eventdata, handles)
% hObject    handle to btn_word (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in btn_setting.
function btn_setting_Callback(hObject, eventdata, handles)
% hObject    handle to btn_setting (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton6.
function pushbutton6_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes during object creation, after setting all properties.
function figure1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


function additional_study(handles)

figure1_CloseRequestFcn(handles.output, 0, handles);

addstudymenu(handles.mydata.user_name);



function word_study(handles)

figure1_CloseRequestFcn(handles.output, 0, handles);

wordmenu(handles.mydata.user_name);


function setting_study(handles)

figure1_CloseRequestFcn(handles.output, 0, handles);

statistics(handles.mydata.user_name);


function game_study(handles)

figure1_CloseRequestFcn(handles.output, 0, handles);

mygame(handles.mydata.user_name);



function exit_study(handles)

figure1_CloseRequestFcn(handles.output, 1, handles);



% --- Executes when user attempts to close figure1.
function figure1_CloseRequestFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: delete(hObject) closes the figure

if eventdata==1

fp=ftp('files.lokad.com', 'xlavmfhwprxm@hotmail.com', 'rhdzjavm5');

cd(fp, strcat('/engword/user_data/', handles.mydata.user_name, '/data'));


mput(fp, strcat('./temp/', handles.mydata.user_name, '_total.word'));
mput(fp, strcat('./temp/', handles.mydata.user_name, '_total.info'));
mput(fp, strcat('./temp/', handles.mydata.user_name, '_additional.index'));
mput(fp, strcat('./temp/', handles.mydata.user_name, '_basic.word'));
mput(fp, strcat('./temp/', handles.mydata.user_name, '_basic.day'));

fid_index=fopen(strcat('./temp/', handles.mydata.user_name, '_additional.index'),'r');

if fid_index~=-1
    index_make=textscan(fid_index,'%d','delimiter','\n');
    index_make=index_make{1};
else
    index_make=[];
end

fclose(fid_index);

index_size=size(index_make);
index_size=index_size(1);

for i=1:index_size
    mput(fp, strcat('./temp/', handles.mydata.user_name, '_additional', num2str(index_make(i)), '.info'));
    mput(fp, strcat('./temp/', handles.mydata.user_name, '_additional', num2str(index_make(i)), '.word'));
    mput(fp, strcat('./temp/', handles.mydata.user_name, '_additional', num2str(index_make(i)), '.day'));
end

close(fp);
clear fp;
fclose all;

end

delete(hObject);
