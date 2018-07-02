function word_list = getWord(user_name, lastpath)
%GETWORD getWord(user_name, lastpath)
%   Detailed explanation goes here

fid=fopen(strcat('./temp/', user_name, lastpath),'r');
word_list=textscan(fid,'%s%s%d%d','delimiter','\t');
%word_list=[word_list{1} word_list{2} num2cell(word_list{3}) num2cell(word_list{4})];
fclose(fid);

if isempty(strfind(user_name, '_additional'))==1
    fid2=fopen(strcat('./temp/', user_name, '_total.word'),'r');
else
    index=strfind(user_name, '_additional');
    fid2=fopen(strcat('./temp/', user_name(1:index-1), '_total.word'),'r');
end
total_word=textscan(fid2,'%s%s%d%d%d%d%d%d%d%f%d','delimiter','\t');
total_word=[total_word{1} total_word{2} num2cell(total_word{3}) num2cell(total_word{4}) num2cell(total_word{5}) num2cell(total_word{6}) num2cell(total_word{7}) num2cell(total_word{8}) num2cell(total_word{9}) num2cell(total_word{10}) num2cell(total_word{11})]; 
fclose(fid2);

word_size=size(word_list{1});
word_size=word_size(1);

if(isempty(strfind(lastpath,'_basic'))==0)
    word_list=[word_list{1} word_list{2} num2cell(word_list{3}) num2cell(ones(word_size,1)) num2cell(zeros(word_size,1)) num2cell(word_list{4}) num2cell(zeros(word_size,1)) num2cell(ones(word_size,1)) num2cell(zeros(word_size,1)) num2cell(zeros(word_size,1)) num2cell(zeros(word_size,1))];

else
    word_list=[word_list{1} word_list{2} num2cell(word_list{3}) num2cell(zeros(word_size,1)) num2cell(ones(word_size,1)) num2cell(zeros(word_size,1)) num2cell(word_list{4}) num2cell(ones(word_size,1)) num2cell(zeros(word_size,1)) num2cell(zeros(word_size,1)) num2cell(zeros(word_size,1))];
end


for i=1:word_size
    ind_word= strfind(total_word(1:end,1), word_list{i,1});
    ind = find(not(cellfun('isempty', ind_word)));
    
    if(isempty(ind)==0)
        word_list{i,11}=total_word{ind,11};
    end
end

end