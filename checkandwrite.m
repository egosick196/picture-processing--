%function [] = checkandwrite(matched)

load('.\data\following.mat'); load('.\data\category.mat');
timearray = clock; this = timearray(1, 1);
last = this - 1; before = last - 1;
str1 = [num2str(this), num2str(last), num2str(before)];
str2 = reshape(str2num(str1'),[],3)';

start1 = strfind(matched, str2(1, :));  %ȷ�������ֵ������ʼλ��
flag1 = length(start1);
start2 = strfind(matched, str2(2, :));
flag2 = length(start2);
start3 = strfind(matched, str2(3, :));
flag3 = length(start3);

start = [start1, start2, start3];
flag = flag1 + flag2 + flag3;
isemerge = strings(1, flag);
inter = flag1 + flag2;

for i = 1 : flag 
    if matched(1, start(1, i) + 4) == 0  %��������ֵ���ĸ�ʽ���·��Ƿ�0
        produ = matched(1, start(1, i) : start(1, i) + 7);  %�ָ����ֵĺϲ�
        date0(1, 1) = 1000 * produ(1, 1) + 100 * produ(1, 2) + 10 * produ(1, 3) + produ(1, 4);
        date0(1, 2) = 10 * produ(1, 5) + produ(1, 6);
        date0(1, 3) = 10 * produ(1, 7) + produ(1, 8);
    else
        produ = matched(1, start(1, i) : start(1, i) + 6);
        date0(1, 1) = 1000 * produ(1, 1) + 100 * produ(1, 2) + 10 * produ(1, 3) + produ(1, 4);
        date0(1, 2) = produ(1, 6);
        date0(1, 3) = 10 * produ(1, 7) + produ(1, 8);
    end

    dayprod = datetime(date0);  %��������
    dayexpire = dayprod + calmonths(category{following, 3}) + caldays(category{following, 4});  %��������
    Now = timearray(1, 1 : 3); 
    
    daynow = datetime(Now);  %��������
    due = duration(dayexpire - daynow,'Format','d');  %������Ϊֹʣ��ʱ��

    if due > category{following, 5}  %�Ƿ���Ҫ�������
        isemerge(1, i) = 'yes';
    else
        isemerge(1, i) = 'no';
    end
end

[shunxu, index] = sort(start);
msg = isemerge(index);

uiwait(msgbox('Operation Completed','�����','modal'));