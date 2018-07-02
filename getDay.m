function day = getDay(user_name, lastpath)
%GETDAY function day = getDay(user_name, lastpath)
%   Detailed explanation goes here

fid=fopen(strcat('./temp/', user_name, lastpath),'r');
day=textscan(fid,'%d');
day=day{1};
fclose(fid);

end

