function varargout = DCTDWT(varargin)
% DCTDWT MATLAB code for DCTDWT.fig
%      DCTDWT, by itself, creates a new DCTDWT or raises the existing
%      singleton*.
%
%      H = DCTDWT returns the handle to a new DCTDWT or the handle to
%      the existing singleton*.
%
%      DCTDWT('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in DCTDWT.M with the given input arguments.
%
%      DCTDWT('Property','Value',...) creates a new DCTDWT or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before DCTDWT_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to DCTDWT_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help DCTDWT

% Last Modified by GUIDE v2.5 01-Jan-2023 15:35:02

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @DCTDWT_OpeningFcn, ...
                   'gui_OutputFcn',  @DCTDWT_OutputFcn, ...
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


% --- Executes just before DCTDWT is made visible.
function DCTDWT_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to DCTDWT (see VARARGIN)

% Choose default command line output for DCTDWT
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes DCTDWT wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = DCTDWT_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in btnanhgoc.
function btnanhgoc_Callback(hObject, eventdata, handles)
global hinhAnh;
axes(handles.axes1)
[tenAnh, duongDanAnh] = uigetfile( ...
                       {'*.jpg;*.png;*.bmp;*.jpeg;*.tif', 'All MATLAB Files (*.jpg, *.png, *.bmp, *.jpeg, *.tif)'; ...
                       '*.*', 'All Files (*.*)'}, ...
                       'Chọn hình ảnh để mở');

link = strcat(duongDanAnh, tenAnh);
hinhAnh = imread(link);
hinhAnh=imresize(hinhAnh,[512,512]);
imshow(hinhAnh);
% hObject    handle to btnanhgoc (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in btnthuyvan.
function btnthuyvan_Callback(hObject, eventdata, handles)
global msg;
axes(handles.axes2)
[tenAnh, duongDanAnh] = uigetfile( ...
                       {'*.jpg;*.png;*.bmp;*.jpeg;*.tif', 'All MATLAB Files (*.jpg, *.png, *.bmp, *.jpeg, *.tif)'; ...
                       '*.*', 'All Files (*.*)'}, ...
                       'Chọn hình ảnh để mở');

link1 = strcat(duongDanAnh, tenAnh);
msg = imread(link1);
imshow(msg);
% hObject    handle to btnthuyvan (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in btndwt.
function btndwt_Callback(hObject, eventdata, handles)
global hinhAnh;
global msg;
global a;
%message=handles.msg;
%cover_object=handles.hinhAnh;
k=10;
[watermrkd_img,PSNR,IF,NCC,recmessage]=dwt(hinhAnh,msg,k);
axes(handles.axes3)
imshow(watermrkd_img);
axes(handles.axes4)
imshow(recmessage);
a=[PSNR,NCC,IF]';
t=handles.uitable1;
set(t,'Data',a)
% hObject    handle to btndwt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in btnback.
function btnback_Callback(hObject, eventdata, handles)
close;
run main.m;
% hObject    handle to btnback(see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in btnnhungtrich.
function btnnhungtrich_Callback(hObject, eventdata, handles)
global msg;
global hinhAnh;
global a;
global recmessage;
k=10;
[watermrkd_img,recmessage,PSNR,IF,NCC1] = dwtdct(hinhAnh,msg,k);
axes(handles.axes5)
imshow(watermrkd_img)
b=[PSNR,NCC1,IF]';
t=handles.uitable1;
set(t,'Data',[a b])
imwrite(watermrkd_img,'anhketquaDCTDWT.png');
% hObject    handle to btnnhungtrich (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes during object creation, after setting all properties.
function axes1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to axes1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
axis off
% Hint: place code in OpeningFcn to populate axes1


% --- Executes during object creation, after setting all properties.
function axes2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to axes2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
axis off
% Hint: place code in OpeningFcn to populate axes2


% --- Executes during object creation, after setting all properties.
function axes3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to axes3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
axis off
% Hint: place code in OpeningFcn to populate axes3


% --- Executes during object creation, after setting all properties.
function axes4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to axes4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
axis off
% Hint: place code in OpeningFcn to populate axes4


% --- Executes during object creation, after setting all properties.
function axes5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to axes5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
axis off
% Hint: place code in OpeningFcn to populate axes5


% --- Executes during object creation, after setting all properties.
function axes6_CreateFcn(hObject, eventdata, handles)
% hObject    handle to axes6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
axis off
% Hint: place code in OpeningFcn to populate axes6


% --- Executes on button press in btnout.
function btnout_Callback(hObject, eventdata, handles)
global recmessage;
axes(handles.axes6)
imshow(recmessage)
% hObject    handle to btnout (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
