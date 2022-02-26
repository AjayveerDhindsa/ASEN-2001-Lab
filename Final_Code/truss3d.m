%function truss3d(inputfile,outputfile)
% function truss2d(inputfile,outputfile)
%
% Analysis of 3-D statically determinate truss
%
% Input:  inputfile  - name of input file
%         outputfile - name of output file
%
% Author: Kurt Maute for ASEN 2001, Sept 21 2011
clear 
clc
inputfile = 'd2.inp';
outputfile = 'd2.out';
% read input file
[joints,connectivity,reacjoints,reacvecs,loadjoints,loadvecs]=readinput3d(inputfile);

% compute forces in bars and reactions
[barforces,reacforces]=forceanalysis3d(joints,connectivity,reacjoints,reacvecs);

% write outputfile
writeoutput3d(outputfile,inputfile,barforces,reacforces,joints,connectivity,reacjoints,reacvecs,loadjoints,loadvecs);

% plot truss (used in Lab 2)
joints3D=zeros(size(joints,1),3);
joints3D(:,1:3)=joints;
plottruss(joints3D,connectivity,barforces,reacjoints,3*[0.025,0.04,0.05],[0 0 1 1])

%end
