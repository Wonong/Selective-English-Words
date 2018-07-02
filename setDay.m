function setDay(user_name, lastpath, value)
%SETDAY Summary of this function goes here
%   Detailed explanation goes here

fid=fopen(strcat('./temp/', user_name, lastpath),'r+');
day=textscan(fid,'%d');
fclose(fid);

day=day{1};
day(1)=day(1)+value;

fid=fopen(strcat('./temp/', user_name, lastpath),'w');
fprintf(fid,'%d\r\n%d',day(1), day(2));
fclose(fid);

end

