function varargout = word_favorite(varargin)
% WORD_FAVORITE MATLAB code for word_favorite.fig
%      WORD_FAVORITE, by itself, creates a new WORD_FAVORITE or raises the existing
%      singleton*.
%
%      H = WORD_FAVORITE returns the handle to a new WORD_FAVORITE or the handle to
%      the existing singleton*.
%
%      WORD_FAVORITE('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in WORD_FAVORITE.M with the given input arguments.
%
%      WORD_FAVORITE('Property','Value',...) creates a new WORD_FAVORITE or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before word_favorite_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to word_favorite_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help word_favorite

% Last Modified by GUIDE v2.5 09-Dec-2013 16:14:13

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @word_favorite_OpeningFcn, ...
                   'gui_OutputFcn',  @word_favorite_OutputFcn, ...
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


% --- Executes just before word_favorite is made visible.
function word_favorite_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to word_favorite (see VARARGIN)

% Choose default command line output for word_favorite
handles.output = hObject;

% Update handles structure

set(hObject, 'Name', '나만의 단어장');

global tableword;

% BACKGROUND
handles.mydata.bg=axes('units', 'normalized', 'position',[0 0 1 1]);
uistack(handles.mydata.bg,'bottom');
I=imread('./image/background_plain.png');
ll=imagesc(I);
set(ll, 'hittest', 'off');
set(handles.mydata.bg,'handlevisibility', 'off', 'visible','off');
%

a=imread('./image/re1.png', 'backgroundcolor', [0.039 0.118 0.039]);
set(handles.btn_home, 'CDATA', a);



handles.mydata.user_name=varargin{1};
guidata(handles.output, handles);

fid=fopen(strcat('./temp/', handles.mydata.user_name, '_total.word'),'r');
tableword=textscan(fid,'%s%s%d%d%d%d%d%d%d%f%d','delimiter','\t');
tableword=[tableword{1} tableword{2} num2cell(tableword{3}) num2cell(tableword{4}) num2cell(tableword{5}) num2cell(tableword{6}) num2cell(tableword{7}) num2cell(tableword{8}) num2cell(tableword{9}) num2cell(tableword{10}) num2cell(tableword{11})];
fclose(fid);

global word_list_tabletotal;
word_list_tabletotal=tableword;

%
%
% Change Value to Show

tableword_size=size(tableword);
tableword_size=tableword_size(1);

favorite_index=[];

for i=1:tableword_size
    
    tableword{i,12}=i;
    
    if tableword{i,11}==0
        tableword{i,11}='아니오';
    else
        tableword{i,11}='예';
        favorite_index=[favorite_index;i];
    end
end

tableword=tableword(favorite_index, :);
favorite_size=size(tableword);


%favorite_ind=cell2mat(tableword(1:end, 11));
%find(favorite_ind==0);





%
%
%




global t_table_total;

t_table_total = uitable('Parent', handles.output, 'Units', 'Pixels', 'Position', [65 130 810 390]);

set(t_table_total, 'BackgroundColor', [0.039 0.118 0.039]);

if favorite_size(1)~=0
set(t_table_total, 'Data', [tableword(1:end,1),tableword(1:end,2),tableword(1:end,8),tableword(1:end,9),tableword(1:end,10),tableword(1:end,11)]);
end

set(t_table_total, 'ColumnName', {'단어', '뜻', '출제회수', '오답회수', '오답률', '단어장'});
                  
set(t_table_total, 'ColumnWidth', {200 200 97 97 97 100});


set(t_table_total, 'RowName', []);

%set(t_table_total, 'Position', [100 300 702 300]);


foregroundColor = [1 1 1];
set(t_table_total, 'ForegroundColor', foregroundColor);
backgroundColor = [.1 .5 .1; .2 .3 .2];
set(t_table_total, 'BackgroundColor', backgroundColor);


set(t_table_total, 'ColumnEditable', [false false false false false true]);


set(t_table_total, 'ColumnFormat', {[] [] [] [] [] {'예' '아니오'}});
   

set(t_table_total, 'CellEditCallback', @updateFavorite);
set(t_table_total, 'FontSize', 15)

t=timer('TimerFcn', @(x,y)setTable(handles), 'StartDelay', 1);
start(t);

%setTable(handles);


% UIWAIT makes word_favorite wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = word_favorite_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


function setTable(handles)

global t_table_total;

jscrollpane = findjobj(t_table_total);%,'-nomenu','property',{'Width',[150 150 100 100 100]});
jtable = jscrollpane.getViewport.getView;



%jtable.setAutoconvertcellspan(false);
%set(jtable,'AutoConvertCellSpan','off');
% Now turn the JIDE sorting on
jtable.setSortable(true);		% or: set(jtable,'Sortable','on');
jtable.setAutoResort(true);
jtable.setMultiColumnSortable(true);
jtable.setPreserveSelectionsAfterSorting(true);
% get(jtable)

for i=0:5
    column = jtable.getColumnModel().getColumn(i);
    if (i==0||i==1)
        column.setPreferredWidth(200);
    elseif i==5
        column.setPreferredWidth(100);
    else
        column.setPreferredWidth(97);
    end
end



function updateFavorite(o, e)

global word_list_tabletotal tableword;
word_ind=e.Indices(1);

if strcmp(e.NewData, '예')
    word_list_tabletotal{tableword{word_ind,12}, 11}=1;
else
    word_list_tabletotal{tableword{word_ind,12}, 11}=0;
end

    


% --- Executes when user attempts to close figure1.
function figure1_CloseRequestFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: delete(hObject) closes the figure

%global t_table_total word_list_tabletotal;

global word_list_tabletotal;

fid=fopen(strcat('./temp/', handles.mydata.user_name, '_total.word'), 'w');
word_size=size(word_list_tabletotal);
word_size=word_size(1);

for i=1:word_size
    fprintf(fid,'%s\t%s\t%d\t%d\t%d\t%d\t%d\t%d\t%d\t%f\t%d\r\n',word_list_tabletotal{i,1}, word_list_tabletotal{i,2}, word_list_tabletotal{i,3}, word_list_tabletotal{i,4}, word_list_tabletotal{i,5}, word_list_tabletotal{i,6}, word_list_tabletotal{i,7}, word_list_tabletotal{i,8}, word_list_tabletotal{i,9}, word_list_tabletotal{i,10}, word_list_tabletotal{i,11});
end

fclose(fid);

clear global t_table_total;
clear global word_list_tabletotal;

delete(hObject);


% --- Executes during object creation, after setting all properties.
function figure1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes on button press in btn_home.
function btn_home_Callback(hObject, eventdata, handles)
% hObject    handle to btn_home (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

figure1_CloseRequestFcn(handles.output, eventdata, handles);
wordmenu(handles.mydata.user_name);
