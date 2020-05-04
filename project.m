clear; clc;

%% ��ȡROI
[zheng, color] = tilt_corrc('.\pic\12.jpg');  %zheng�ǻҶ�ͼ��color�ǲ�ɫͼ
[ mark ] = MSERmain( zheng );
marked = uint8(mark);
[cout, gray_cut, color_cut] = roiRowcut(marked, color);
[seg_num, color_seg] = roicut( cout, gray_cut, color_cut );

%% ���ղ������и�
sequ_num = 0;
sequence = {};
parfor i = 1 : seg_num
    rgb = lightcomp(color_seg{1, i});
    pic = mythre(rgb);
    [row_num, row_cut] = rowcut(pic);
    [word_num, word_cut] = refine_wordcut(row_num, row_cut);
    [num, cut] = mser_wordcut(word_num, word_cut);
    
    sequence = [sequence, cut];
    sequ_num = sequ_num + num;
end

%% ƥ��ʶ��
[ shape_num, shaped ] = myshape( sequ_num, sequence );
matched = GISTmatch( shape_num, shaped );
ean_checked = codecheck(matched);

if ean_checked == 0
   
end