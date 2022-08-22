%三维插值%
%可以处理comsol导出的三维数据
%并输出矢量pdf
clear;close all; clc;  tic;            %计时
FileName = 'RadialFre1J3D.txt';
Data = load(FileName);
surf1x = Data(:,1);
surf1y = Data(:,2);
surf1z = Data(:,3);
NormJ =  Data(:,4);

%插值数量 x ，y
lsx=linspace(min(surf1x),max(surf1x),20);
lsy=linspace(min(surf1y),max(surf1y),20);
lsz=linspace(min(surf1z),max(surf1z),20);
[xq,yq,zq] = meshgrid(lsx, lsy,lsz);
vq = griddata(surf1x,surf1y,surf1z,NormJ,xq,yq,zq,'linear');

h = slice(xq,yq,zq,vq,lsx(1),lsy(1),lsz(end));
set(h,'FaceColor','interp',...
    'EdgeColor','none');

box on
colormap(jet)
colorbar
set(gcf,'unit','centimeters','position',[12 5 20 15]);
outputpic('Pic','aaa')
toc

function setaxis()
%setaxis();%自己设置的图窗大小格式
xlim([-300,300]);ylim([-8,0]);
box on;
set(gcf,'unit','centimeters','position',[12 5 30 8])%图窗大小
%要0.8倍的 9*18 mm大小， 设置12为了 横坐标轴加色带  后面归一化
set(gca,'Position',[0.1 0.1 0.8 0.8])%图窗里面的图
%色带
colorbar('Position',[0.91,0.1,0.02,0.8]);
end

function outputpic(Path, PicName)
% 输入（路径，文件名）--都是（字符）
if ~isfolder(Path) %如果没有路径，就创建一个
    mkdir(Path)
end
% 输出 使用渲染器'-painters'，输出路径  输出格式,
print('-painters',[Path,'\',PicName],'-dpdf');
end
