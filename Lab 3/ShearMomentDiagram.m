%% ASEN 2001 - Lab 3 Group 6
% Ajay Dhindsa
%
%
%
%% Housekeeping
clear;
clc;
close all
E_F = 0.035483*10^9 ; % Pa Foam
E_W = 3.2953*10^9 ; % Pa Wood
%% Read-in Data
original_data = readtable('ASEN_2001_Lab_3_Test_Data.xls');
LabGroup = table2array(original_data(1:21,1));
NumData = table2array(original_data(1:21,2:5));

original_data(7,:) = [];  % Group 07 - Bad Data - No Breaking
original_data(10,:) = []; % Group 11 - Bad Data - No Comment
original_data(22:33,:) = []; % Getting rid of unncessary comments at bottom


BendFailure = contains(original_data.CommentOnFailure,{'Bending','bending'});
ShearFailure = contains(original_data.CommentOnFailure,{'Shear','shear','perpendicular'});

BendData = NumData(BendFailure,:);
ShearData = NumData(ShearFailure,:);
%% Moment and Shear Calculations
BarLength = 36/39.37; % in to m
FoamLength = (3/4)/39.37;
MaxBendLength = BarLength - 2 * BendData(:,2); % meter
MaxShearLength = BarLength - 2 * ShearData(:,2); % meter
WoodLength = (1/32)/39.37;
CSWidth = 4/39.37;
CSBendDataWidth = BendData(:,3);
CSShearDataWidth = ShearData(:,3);


%[BendFail_ShearDiagram, BendFail_MaxShear, BendFail_MomentDiagram] = diagram(BendData);
%[ShearFail_ShearDiagram, ShearFail_MaxShear, ShearFail_MomentDiagram] = diagram(ShearData);
BendFail_ShearDiagram = {};

for i = 1:length(MaxBendLength)
    syms x
    BendFail_ShearDiagram{i} = piecewise(0 < x < BendData(i,2), BendData(i,1)/2, BendData(i,2) < x < BendData(i,2) + MaxBendLength(i), 0 , MaxBendLength(i) + BendData(i,2) < x < BarLength, -BendData(i,1)/2);
    BendFail_MaxShearFail(i) = double(max(abs(subs(cell2sym(BendFail_ShearDiagram(i)),linspace(0,BarLength,1000)))));
    BendFail_MomentDiagram(i) = piecewise(0 < x < BendData(i,2), BendData(i,1)/2 * x, BendData(i,2) < x < MaxBendLength(i) + BendData(i,2), BendData(i,2) * BendData(i,1)/2, MaxBendLength(i) + BendData(i,2) < x < BarLength, (-BendData(i,1)/2 * (x - BarLength)));
end

ShearFail_ShearDiagram = {};

for i = 1:length(MaxShearLength)
    syms x
    ShearFail_ShearDiagram{i} = piecewise(0 < x < ShearData(i,2), ShearData(i,1)/2, ShearData(i,2) < x < ShearData(i,2) + MaxShearLength(i), 0 , MaxShearLength(i) + ShearData(i,2) < x < BarLength, -ShearData(i,1)/2);
    ShearFail_MaxShearFail(i) = double(max(abs(subs(cell2sym(ShearFail_ShearDiagram(i)),linspace(0,BarLength,1000)))));
    ShearFail_MomentDiagram(i) = piecewise(0 < x < ShearData(i,2), ShearData(i,1)/2 * x, ShearData(i,2) < x < MaxShearLength(i) + ShearData(i,2), ShearData(i,2) * ShearData(i,1)/2, MaxShearLength(i) + ShearData(i,2) < x < BarLength, (-ShearData(i,1)/2 * (x - BarLength)));
end
%% Plots
figure(1);
fplot(BendFail_MomentDiagram, [0, 1])
title('Moment Diagrams for Bending Failure')
xlabel('Distance (m)')
ylabel('Force (N)')
grid minor

figure(2)
fplot(BendFail_ShearDiagram, [0, 1])
title('Shear Diagrams for Bending Failure')
xlabel('Distance (m)')
ylabel('Force (N)')
grid minor

figure(3)
fplot(ShearFail_MomentDiagram, [0, 1])
title('Moment Diagrams for Shear Failure')
xlabel('Distance (m)')
ylabel('Force (N)')
grid minor

figure(4)
fplot(ShearFail_ShearDiagram, [0, 1])
title('Shear Diagrams for Shear Failure')
xlabel('Distance (m)')
ylabel('Force (N)')
grid minor