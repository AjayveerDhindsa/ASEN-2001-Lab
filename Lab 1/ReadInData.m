function [ForcePos, ForceVec, MomentPos, MomentVec, SupportVecM, SupportVecF, SupportPosM, SupportPosF] = ReadInData(filename)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
fileID = fopen(filename);
Line = fgetl(fileID); 

PoundCounter = 0; 
SupportCounter = 0;
SupportFCounter = 0;
i = 1;
ForcePos = [];
ForceVec = [];
MomentPos = []; 
MomentVec = [];
SupportPos = [];
SupportVecM = [];
SupportVecF = [];
SupportPosM = [];
SupportPosF = [];

while ischar(Line)
    if Line(1) == '#'
        PoundCounter = PoundCounter + 1;
    else
        if PoundCounter == 3
            Line = str2num(Line); 
            ForcePos=[ForcePos; Line];
        elseif PoundCounter == 5
            Line = str2num(Line);
            ForceVec=[ForceVec; Line];
        elseif PoundCounter == 7
            Line = str2num(Line);
            MomentPos=[MomentPos; Line];
        elseif PoundCounter == 9
            Line = str2num(Line);
            MomentVec=[MomentVec; Line];
        elseif PoundCounter == 11
            Line = str2num(Line);
            SupportPos=[SupportPos; Line];
            SupportCounter = SupportCounter + 1;
        elseif PoundCounter == 13
            if Line(1) == 'F'
                Line = str2num(Line(2:length(Line)));
                SupportVecF = [SupportVecF; Line];
                SupportFCounter = SupportFCounter +1;
            else
                Line = str2num(Line(2:length(Line)));
                SupportVecM = [SupportVecM; Line];
            end
        end
    end
    
    Line = fgetl(fileID);
end
while i <= SupportFCounter
    SupportPosF = [SupportPosF; SupportPos(i, :)];
    i = i + 1;
end
while i <= SupportCounter
    SupportPosM = [SupportPosM; SupportPos(i, :)];
    i = i + 1;
end
if isempty(SupportPosM)
    SupportPosM = zeros(1,3);
    SupportVecM = zeros(1,3);
end
fclose(fileID);
end