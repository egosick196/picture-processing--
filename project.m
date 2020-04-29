clear; clc;

%% ��ȡROI
[zheng, color] = tilt_corrc('.\pic\7.jpg');  %zheng�ǻҶ�ͼ��color�ǲ�ɫͼ
[ mark ] = MSERmain( zheng );
marked = uint8(mark);
[cout, gray_cut, color_cut] = roiRowcut(marked, color);
[seg_num, color_seg] = roicut( cout, gray_cut, color_cut );

%% ���ղ������иʶ��
sequ_num = 0;
sequence = {seg_num};
parfor i = 1 : seg_num
    rgb = lightcomp(color_seg{1, i});
    pic = mythre(rgb);
    [row_num, line_cut] = rowcut(pic);
    [total_num, final_cut] = refine_wordcut(row_num, line_cut);
    sequence = [sequence, final_cut];
    sequ_num = sequ_num + total_num;
end
%matched = GISTmatch( total_num );
