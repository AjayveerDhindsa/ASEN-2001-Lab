% main function

clear; 
clc;

%% Read in the Data
%[ForcePos, ForceVec, MomentPos, MomentVec, SupportVecM, SupportVecF, SupportPosM, SupportPosF]=ReadInData('Lab1_Input.txt');
[ForcePos, ForceVec, MomentPos, MomentVec, SupportVecM, SupportVecF, SupportPosM, SupportPosF]=ReadInData('4.11_Test_File.txt');
%% Calculations
ResultantForces = Calculations(ForcePos, ForceVec, MomentPos, MomentVec, SupportVecM, SupportVecF, SupportPosM, SupportPosF);

%% Output the Data
%OutputData(ResultantForces);  