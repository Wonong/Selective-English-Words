function varargout = mygame(varargin)
% MYGAME MATLAB code for mygame.fig
%      MYGAME, by itself, creates a new MYGAME or raises the existing
%      singleton*.
%
%      H = MYGAME returns the handle to a new MYGAME or the handle to
%      the existing singleton*.
%
%      MYGAME('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in MYGAME.M with the given input arguments.
%
%      MYGAME('Property','Value',...) creates a new MYGAME or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before mygame_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to mygame_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help mygame

% Last Modified by GUIDE v2.5 13-Dec-2013 13:48:32

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @mygame_OpeningFcn, ...
                   'gui_OutputFcn',  @mygame_OutputFcn, ...
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


% --- Executes just before mygame is made visible.
function mygame_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to mygame (see VARARGIN)

% Choose default command line output for mygame
handles.output = hObject;

% Update handles structure

set(hObject, 'Name', 'Game');

global lineset;
global lineposset;
global textset;
global objset;
global word_ind;
global gamepoint gamecombo maxcombo;
global correctind;
global wordcount;
global wordlistset;
global gamelife;
global ansnum;
global word_size;
global exitprogram;

exitprogram=0;

ansnum=0;

gamelife=10;

wordlistset=[handles.text_wordlist1 handles.text_wordlist2 handles.text_wordlist3 handles.text_wordlist4];

wordcount=0;
correctind=[];
textset=[];

gamepoint=0;
gamecombo=0;
maxcombo=0;

word_ind=0;


lineset=[0 0 0 0];
lineposset=[[0 360 120 50];[0 270 120 50];[0 180 120 50];[0 90 120 50]];
objset=[0 0 0 0];

handles.mydata.user_name_original=varargin{1};
handles.mydata.user_name='forgame';
handles.mydata.NUMTOSOLVE=10;
handles.mydata.SPEED=3;
handles.mydata.TIME=90;


%%%%% READ WORD LIST %%%%%
handles.mydata.word_list = getWord(handles.mydata.user_name,'_basic.word');
word_size = size(handles.mydata.word_list);
word_size=word_size(1);
num1 = randperm(word_size);

handles.mydata.word_list=handles.mydata.word_list(num1, :);
%%%%%%%%%%%%%%%%%%%%%%%%%%



[handles.mydata.bullet1, a, handles.mydata.bullet2]=imread('./image/bullet.png');


%%%%% BACKGROUND %%%%%
bg=axes('units', 'normalized', 'position',[0 0 1 1]);
uistack(bg,'bottom');
I=imread('./image/background_plain_s.png');
ll=imagesc(I);
set(ll, 'hittest', 'off');
set(bg,'handlevisibility', 'off', 'visible','off');


axes(handles.axes_base);
b=imread('./image/kingdom.png', 'backgroundcolor', [0.039 0.118 0.039]);
bb=imagesc(b);
set(bb, 'hittest', 'off');
set(handles.axes_base,'handlevisibility', 'off', 'visible','off');

%%%%%%%%%%%%%%%%%%%%%%


%%%%% IMAGE %%%%%
c=imread('./image/re1.png', 'backgroundcolor', [0.039 0.118 0.039]);
set(handles.btn_home, 'cdata', c);
%%%%%%%%%%%%%%%%%


%%%%% LOAD USER HIGHSCORE %%%%%
fid=fopen(strcat('./temp/', handles.mydata.user_name_original, '_game.info'), 'r+');


if fid~=-1
    handles.mydata.gameinfo=textscan(fid, '%d');
    handles.mydata.gameinfo=handles.mydata.gameinfo{1};
    frewind(fid);
else
    fid=fopen(strcat('./temp/', handles.mydata.user_name_original, '_game.info'), 'r+');
    handles.mydata.gameinfo=[];
end

if isempty(handles.mydata.gameinfo)==1
    handles.mydata.gameinfo(1)=0;
    handles.mydata.gameinfo(2)=0;
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

set(handles.text_score2, 'String', num2str(handles.mydata.gameinfo(1)));
set(handles.text_combo2, 'String', num2str(handles.mydata.gameinfo(2)));



disp_solve=strcat(num2str(ansnum), {'  /  '}, num2str(handles.mydata.NUMTOSOLVE));

set(handles.text_solve, 'String', disp_solve);




handles.mydata.allobj=[handles.btn_lifeup, handles.edit_answer];
allobj_size=size(handles.mydata.allobj);

for i=1:allobj_size(2)
    set(handles.mydata.allobj(i), 'Enable', 'off')
end

guidata(hObject, handles);

% UIWAIT makes mygame wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = mygame_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



function edit_answer_Callback(hObject, eventdata, handles)
% hObject    handle to edit_answer (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_answer as text
%        str2double(get(hObject,'String')) returns contents of edit_answer as a double

global lineset;
global word_ind;
global correctind;
global textset;

% word_disp=1:word_ind;
% correctsize=size(correctind);
% 
% for i=1:correctsize(1)
%     a=find(word_disp, correctind(i));
%     word_disp(a)=[];
% end

answer=get(hObject, 'String');

for i=1:4
    if lineset(i)~=0
        if strcmp(answer, handles.mydata.word_list{lineset(i), 2})==1
            Correct(i, handles);
            break;
        end
    end
end

set(hObject, 'String', '');



% --- Executes during object creation, after setting all properties.
function edit_answer_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_answer (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



% --- Executes on button press in btn_lifeup.
function btn_lifeup_Callback(hObject, eventdata, handles)
% hObject    handle to btn_lifeup (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global gamelife;
global gamepoint;

if gamepoint > 2000
    gamepoint=gamepoint-2000;
    gamelife=gamelife+1;
end

set(handles.text_gamelife, 'String', num2str(gamelife));
set(handles.text_score2, 'String', num2str(gamepoint));
uicontrol(handles.edit_answer);






function Control(handles)

global word_ind;
global gamepoint gamecombo maxcombo;
global wordlistset;
global ansnum;
global gamelife;
global lineset lineposset objset;
global exitprogram;

gameend=0;
lvlup=0;

word_disp=randperm(word_ind+4);

for i=1:4
    set(wordlistset(i), 'String', handles.mydata.word_list{word_disp(i), 2});
end
    
    

while(1)
    CreateLines(handles);
    WordCheck(0, handles);
    CheckLines(handles);
    MoveLines(handles);
    
%     if exitprogram==1
%         break;
%     end
    
    pause(0.03);
    
    
    if ( ansnum >= handles.mydata.NUMTOSOLVE )
        lvlup=1;
        break;
    elseif ( gamelife < 1 )
        gameend=1;
        break;
    end
end

if gamelife==-1
else

%%%%%%%%%% GAME END! DELETE REMAINING OBJECTS %%%%%%%%%%


for i=1:4
    if lineset(i)~=0
        delete(objset(i));
        lineset(i)=0;
        lineposset(i, :)=[0 450-90*i 120 50];
        objset(i)=0;
    end
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%% CALCULATE MAX SCORE %%%%%%%%%%
fid=fopen(strcat('./temp/', handles.mydata.user_name_original, '_game.info'), 'w');

if handles.mydata.gameinfo(1) < gamepoint
    handles.mydata.gameinfo(1)=gamepoint;
end

if handles.mydata.gameinfo(2) < maxcombo
    handles.mydata.gameinfo(2)=maxcombo;
end

fprintf(fid, '%d\r\n', handles.mydata.gameinfo);
fclose(fid);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%%%%%%%%% TURN OFF SOME OBJECTS %%%%%%%%%%
handles.mydata.allobj=[handles.btn_lifeup, handles.edit_answer];
allobj_size=size(handles.mydata.allobj);

for i=1:allobj_size(2)
    set(handles.mydata.allobj(i), 'Enable', 'off')
end
set(handles.btn_start, 'Enable', 'on');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if gameend==1
    gameend=0;
    set(handles.text_gameover, 'Visible', 'on');
    pause(2.0);
    set(handles.text_gameover, 'Visible', 'off');
    ansnum=0;
    set(handles.text_level, 'String',  '1');

elseif lvlup==1
    lvlup=0;
    curlvl=str2num(get(handles.text_level, 'String'));
    set(handles.text_level, 'String',  num2str(curlvl+1));
    handles.mydata.SPEED=handles.mydata.SPEED+ceil(1.5*(curlvl+1));
    handles.mydata.NUMTOSOLVE=handles.mydata.NUMTOSOLVE+2*curlvl;
    handles.mydata.TIME=handles.mydata.TIME-ceil(5*(curlvl+1));
    ansnum=0;
end

set(handles.text_score1, 'String', '최고 점수');
set(handles.text_score2, 'String', num2str(handles.mydata.gameinfo(1)));
set(handles.text_combo1, 'String', '최고 콤보');
set(handles.text_combo2, 'String', num2str(handles.mydata.gameinfo(2)));

disp_solve=strcat(num2str(ansnum), {'  /  '}, num2str(handles.mydata.NUMTOSOLVE));
set(handles.text_solve, 'String', disp_solve);
set(handles.btn_home, 'Visible', 'on');
guidata(handles.output, handles);
end







function CreateLines(handles)

global lineset;
global lineposset;
global textset;
global objset;
global word_ind;


for i=1:4
    if (lineset(i)==0&&rand(1)>0.9)
        word_ind=word_ind+1;
        if length(handles.mydata.word_list{word_ind, 1}) > 3
            objset(i)=axes('Units', 'Pixels', 'Position', [0 450-90*i 150 50]); %90+5*(length(handles.mydata.word_list{word_ind, 1})-9) 50]);
            axes(objset(i));
            a=handles.mydata.bullet1;
            imresize(a, [150 50]);
            imagesc(a, 'alphadata', handles.mydata.bullet2);
        else
            objset(i)=axes('Units', 'Pixels', 'Position', [0 450-90*i 90 50]);
            axes(objset(i));
            imagesc(handles.mydata.bullet1, 'alphadata', handles.mydata.bullet2);
        end
        
        textset(i)=text(18, 25, handles.mydata.word_list{word_ind, 1},'FontWeight','bold');
        set(objset(i), 'handlevisibility', 'off', 'visible','off');
        lineset(i)=word_ind;
    end
end


function MoveLines(handles)

global lineset;
global lineposset;
global objset;
global word_ind;


for i=1:4
    if (lineset(i)~=0)
        lineposset(i, 1)=lineposset(i, 1)+handles.mydata.SPEED*rand(1)*rand(1);
        set(objset(i), 'Position', [lineposset(i, 1) lineposset(i, 2) lineposset(i, 3) lineposset(i, 4)]);
    end
end


function CheckLines(handles)

global lineset;
global lineposset;
global objset;
global word_ind;


for i=1:4
    if (lineset(i)~=0)
        
        if lineposset(i, 1)+lineposset(i, 3) > 750
            Wrong(i, handles);
        end
    end
end


function Wrong(i, handles)
    
global lineset;
global lineposset;
global objset;
global word_ind;
global gamepoint gamecombo;
global gamelife;
global correctind;

gamelife=gamelife-1;

delete(objset(i));
correctind=[correctind;lineset(i)];
lineset(i)=0;
objset(i)=0;
lineposset(i, :)=[0 450-90*i 120 50];

gamecombo=0;
set(handles.text_combo2, 'String', num2str(gamecombo));
set(handles.text_gamelife, 'String', num2str(gamelife));




function Correct(i, handles)
    
global lineset;
global lineposset;
global objset;
global word_ind;
global gamepoint gamecombo maxcombo;
global correctind;
global ansnum;

delete(objset(i));
correctind=[correctind;lineset(i)];
lineset(i)=0;
objset(i)=0;
lineposset(i, :)=[0 450-90*i 120 50];

gamepoint=gamepoint+200*(gamecombo+1);
gamecombo=gamecombo+1;

if maxcombo < gamecombo
    maxcombo=gamecombo;
end

ansnum=ansnum+1;
set(handles.text_score2, 'String', num2str(gamepoint));
set(handles.text_combo2, 'String', num2str(gamecombo));

disp_solve=strcat(num2str(ansnum), {'  /  '}, num2str(handles.mydata.NUMTOSOLVE));

set(handles.text_solve, 'String', disp_solve);

WordCheck(1, handles);
   
    

function WordCheck(answer, handles)

global wordcount;
global word_ind;
global correctind;
global wordlistset;
global word_size;


wordcount=wordcount+1;
    
if answer==1
    
    wordcount=0;
    
    correctsize=size(correctind);
    word_disp=randperm(word_ind+4);

    for i=1:correctsize(1)
        a=find(word_disp==correctind(i));
        word_disp(a)=[];
    end
    
    word_disp_size=size(word_disp);
        
    if word_disp_size(2) >= 4
        for i=1:4
            set(wordlistset(i), 'String', handles.mydata.word_list{word_disp(i), 2})
        end
        
    else
        for i=1:word_disp_size(2)
            set(wordlistset(i), 'String', handles.mydata.word_list{word_disp(i), 2})
        end
        
        for i=word_disp_size(2)+1:4
            set(wordlistset(i), 'String', handles.mydata.word_list{ceil(rand(1)*word_size), 2})
        end
    end

elseif wordcount > handles.mydata.TIME
    
    wordcount=0;

    correctsize=size(correctind);
    word_disp=randperm(word_ind+4);

    for i=1:correctsize(1)
        a=find(word_disp==correctind(i));
        word_disp(a)=[];
    end
    
    word_disp_size=size(word_disp);
    
    if word_disp_size(2) >= 4
        for i=1:4
            set(wordlistset(i), 'String', handles.mydata.word_list{word_disp(i), 2})
        end
        
    else
        for i=1:word_disp_size(2)
            set(wordlistset(i), 'String', handles.mydata.word_list{word_disp(i), 2})
        end
        
        for i=word_disp_size(2)+1:4
            set(wordlistset(i), 'String', handles.mydata.word_list{ceil(rand(1)*word_size), 2})
        end
    end
end
    
    


% --- Executes on button press in btn_start.
function btn_start_Callback(hObject, eventdata, handles)
% hObject    handle to btn_start (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

set(handles.text_score1, 'String', '현재 점수');
set(handles.text_score2, 'String', '0');
set(handles.text_combo1, 'String', '현재 콤보');
set(handles.text_combo2, 'String', '0');


disp_solve=strcat('0', {'  /  '}, num2str(handles.mydata.NUMTOSOLVE));
set(handles.text_solve, 'String', disp_solve);

handles.mydata.allobj=[handles.btn_lifeup, handles.edit_answer];
allobj_size=size(handles.mydata.allobj);

for i=1:allobj_size(2)
    set(handles.mydata.allobj(i), 'Enable', 'on');
end

set(handles.btn_home, 'Visible', 'off');

set(hObject, 'Enable', 'off');

uicontrol(handles.edit_answer);
Control(handles);


% --- Executes on button press in btn_home.
function btn_home_Callback(hObject, eventdata, handles)
% hObject    handle to btn_home (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

figure1_CloseRequestFcn(handles.output, [], handles);


% --- Executes when user attempts to close figure1.
function figure1_CloseRequestFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: delete(hObject) closes the figure

global gamelife;

gamelife=-1;

pause(0.05);

mainmenu(handles.mydata.user_name_original);

delete(hObject);
