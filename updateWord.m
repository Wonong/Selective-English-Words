function updateWord(user_name, word_list)
%UPDATEWORD updateWord(user_name, word_list)    
%   Detailed explanation goes here

%word_list=getWord(user_name, lastpath);
word_size=size(word_list);
word_size=word_size(1);

fpath=strcat('./temp/',user_name, '_total.word');
fid=fopen(fpath,'r+');

if fid==-1
    fid=fopen(fpath,'w');
    
    for i=1:word_size
        fprintf(fid,'%s\t%s\t%d\t%d\t%d\t%d\t%d\t%d\t%d\t%f\t%d\r\n',word_list{i,1}, word_list{i,2}, word_list{i,3}, word_list{i,4}, word_list{i,5}, word_list{i,6}, word_list{i,7}, word_list{i,8}, word_list{i,9}, word_list{i,10}, word_list{i,11});
    end
else
    totalword=textscan(fid,'%s%s%d%d%d%d%d%d%d%f%d','delimiter','\t');
    totalword=[totalword{1} totalword{2} num2cell(totalword{3}) num2cell(totalword{4}) num2cell(totalword{5}) num2cell(totalword{6}) num2cell(totalword{7}) num2cell(totalword{8}) num2cell(totalword{9}) num2cell(totalword{10}) num2cell(totalword{11})];
    
    if isempty(totalword)==1
        for i=1:word_size
            fprintf(fid,'%s\t%s\t%d\t%d\t%d\t%d\t%d\t%d\t%d\t%f\t%d\r\n',word_list{i,1}, word_list{i,2}, word_list{i,3}, word_list{i,4}, word_list{i,5}, word_list{i,6}, word_list{i,7}, word_list{i,8}, word_list{i,9}, word_list{i,9}, word_list{i,11});
        end
    
    else
    
        for i=1:word_size
            totalind=find(strcmp(totalword(1:end,1),word_list(i,1)));
            if (isempty(totalind)==0)
                totalword{totalind,4}=totalword{totalind,4}+word_list{i,4};
                totalword{totalind,5}=totalword{totalind,5}+word_list{i,5};

                if(totalword{totalind,6}==0)
                    totalword{totalind,6}=word_list{i,6};
                end

                if(totalword{totalind,7}==0)
                    totalword{totalind,7}=word_list{i,7};
                end

                totalword{totalind,8}=totalword{totalind,8}+1;
                totalword{totalind,9}=totalword{totalind,9}+word_list{i,9};
                totalword{totalind,10}=double(totalword{totalind,9})/double(totalword{totalind,8});

                if(totalword{totalind,11}==0)
                    totalword{totalind,11}=word_list{i,11};
                end

            else
                totalword=[totalword;word_list(i,1) word_list(i,2) word_list(i,3) word_list(i,4) word_list(i,5) word_list(i,6) word_list(i,7) word_list(i,8) word_list(i,9) word_list(i,9) word_list(i,11)];
            end
        end
    

    total_size=size(totalword);
    total_size=total_size(1);
    
    frewind(fid);
    
    for i=1:total_size
        fprintf(fid,'%s\t%s\t%d\t%d\t%d\t%d\t%d\t%d\t%d\t%f\t%d\r\n',totalword{i,1}, totalword{i,2}, totalword{i,3}, totalword{i,4}, totalword{i,5}, totalword{i,6}, totalword{i,7}, totalword{i,8}, totalword{i,9}, totalword{i,10}, totalword{i,11});
    end
    end
end

fclose(fid);

end

