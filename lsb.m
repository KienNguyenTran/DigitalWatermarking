function varargout = lsb(varargin)
% LSB MATLAB code for lsb.fig
%      LSB, by itself, creates a new LSB or raises the existing
%      singleton*.
%
%      H = LSB returns the handle to a new LSB or the handle to
%      the existing singleton*.
%
%      LSB('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in LSB.M with the given input arguments.
%
%      LSB('Property','Value',...) creates a new LSB or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before lsb_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to lsb_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help lsb

% Last Modified by GUIDE v2.5 31-Dec-2022 14:59:32

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @lsb_OpeningFcn, ...
                   'gui_OutputFcn',  @lsb_OutputFcn, ...
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


% --- Executes just before lsb is made visible.
function lsb_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to lsb (see VARARGIN)

% Choose default command line output for lsb
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes lsb wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = lsb_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in backbtn.
function backbtn_Callback(hObject, eventdata, handles)
close;
run main.m;
% hObject    handle to backbtn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in openpicbtn.
function openpicbtn_Callback(hObject, eventdata, handles)
global link;
axes(handles.axes1)
[tenAnh, duongDanAnh] = uigetfile( ...
                       {'*.jpg;*.png;*.bmp;*.jpeg;*.tif', 'All MATLAB Files (*.jpg, *.png, *.bmp, *.jpeg, *.tif)'; ...
                       '*.*', 'All Files (*.*)'}, ...
                       'Chọn hình ảnh để mở');

link = strcat(duongDanAnh, tenAnh);
hinhAnh = imread(link);
imshow(hinhAnh);
% hObject    handle to openpicbtn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in nhungbtn.
function nhungbtn_Callback(hObject, eventdata, handles)
global link;
global sizeT1;
global h;
axes(handles.axes2)
M=imread(link);
T=get(handles.msgin,"string");
T1 = reshape (dec2bin(T,8).'-'0',1,[]);
sizeT1 = size(T1,2);
w = size(M,1);
h = size(M,2);
%Nhúng tin
j=1;
k=1;
M1=M;
if (sizeT1>w*h)
    msgbox("Không đủ dung lượng để nhúng tin","Error","error");
else
    for i=1:sizeT1
        if(k>h)
            j=j+1;
            k=1;
        end
        LSB1= mod(M(j,k),2);
        if (T1(i)~=LSB1)&&(LSB1==1)
            M1(j,k)=M(j,k)-1;
        else
            if (T1(i)~=LSB1)&&(LSB1==0)
                  M1(j,k)=M(j,k)+1;
            end
        end
        k= k+1;
    end
    imwrite(M1,'anhketquaLSB.png');
    imshow('anhketquaLSB.png');
end
msgbox("Quá trình nhúng thông tin vào ảnh thành công.","Success");

% hObject    handle to nhungbtn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in outbtn.
function outbtn_Callback(hObject, eventdata, handles)
global sizeT1;
global h;
M2 = imread('anhketquaLSB.png');
m2 = 1:sizeT1; %Thong diep can trich xuat (1 -> sizeT1)
j = 1;
k = 1;
for i = 1:sizeT1
    if (k>h)
        j=j+1;
        k=1;
    end
        m2(i)= mod(M2(j,k),2);
        k=k+1;
        
end
msgbox("Trích xuất thông điệp từ hình ảnh thành công","Success");
str = char(bin2dec(reshape(char(m2+'0'),8,[]).'));
set(handles.msgout,'string',str);


% hObject    handle to outbtn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



function msgin_Callback(hObject, eventdata, handles)
% hObject    handle to msgin (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of msgin as text
%        str2double(get(hObject,'String')) returns contents of msgin as a double


% --- Executes during object creation, after setting all properties.
function msgin_CreateFcn(hObject, eventdata, handles)
% hObject    handle to msgin (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


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
