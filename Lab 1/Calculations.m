function [ResulatantForces] = Calculations(ForcePos, ForceVec, MomentPos, MomentVec, SupportVecM, SupportVecF, SupportPosM, SupportPosF)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

ForceUnitVec = ForceVec(:,2:4)./((ForceVec(:,2)).^2+(ForceVec(:,3)).^2+(ForceVec(:,4).^2)).^0.5;
ForceMags = ForceVec(:,1);
ForceVector = ForceMags.*ForceUnitVec(:,:);
ForceRadius = ForcePos;
Unitx = [1,0,0];
Unity = [0,1,0];
Unitz = [0,0,1];

if isempty(MomentVec) == [0 0 0 0]
    MomentUnitVec = zeros(1,3);
    MomentMags = 0;
else
    MomentUnitVec = MomentVec(:,2:4)./((MomentVec(:,2)).^2+(MomentVec(:,3)).^2+(MomentVec(:,4).^2)).^0.5;
    MomentMags = MomentVec(:,1);
end

ResultantForceUnitVec = SupportVecF(:,1:3)./((SupportVecF(:,1)).^2+(SupportVecF(:,2)).^2+(SupportVecF(:,3).^2)).^0.5;
ResultantForceRadius = SupportPosF;
RFCrossRU = cross(ResultantForceRadius,ResultantForceUnitVec);

ResultantMomentUnitVec = SupportVecM(:,1:3)./((SupportVecM(:,1)).^2+(SupportVecM(:,2)).^2+(SupportVecM(:,3).^2)).^0.5;
ResultantMomentRadius = SupportPosM;
RMCrossRR = cross(ResultantMomentRadius,ResultantMomentUnitVec);

A = zeros(6,6);
b = zeros(6,1);

b(1) = sum(ForceMags.*ForceUnitVec(:,1)); % Fx; done
b(2) = sum(ForceMags.*ForceUnitVec(:,2)); % Fy; done
b(3) = sum(ForceMags.*ForceUnitVec(:,3)); % Fz; done
b(4) = sum(MomentMags.*MomentUnitVec(:,1)) + dot(Unitx, sum(cross(ForceRadius,ForceVector), 1)); % Mx; 
b(5) = sum(MomentMags.*MomentUnitVec(:,2)) + dot(Unity, sum(cross(ForceRadius, ForceVector), 1)); % My; 
b(6) = sum(MomentMags.*MomentUnitVec(:,3)) + dot(Unitz, sum(cross(ForceRadius, ForceVector), 1)); % Mz; 

A(1, 1:numel(ResultantForceUnitVec)/3) = ResultantForceUnitVec(:,1).';
A(2, 1:numel(ResultantForceUnitVec)/3) = ResultantForceUnitVec(:,2).';
A(3, 1:numel(ResultantForceUnitVec)/3) = ResultantForceUnitVec(:,3).';
i = 1;
j = 1;
while i < numel(RFCrossRU)/3 + 1
    A(4, i) = RFCrossRU(i,1);
    i = i + 1;
end
while i < 7
    A(4,i) = RMCrossRR(j, 1);
    i = i + 1;
    j = j + 1;
end
i = 1;
j = 1;
while i < numel(RFCrossRU)/3 + 1
    A(5, i) = RFCrossRU(i,2);
    i = i + 1;
end
while i < 7
    A(5,i) = RMCrossRR(j, 2);
    i = i + 1;
    j = j + 1;
end
i = 1;
j = 1;
while i < numel(RFCrossRU)/3 + 1
    A(4, i) = RFCrossRU(i,1);
    i = i + 1;
end
while i < 7
    A(4,i) = RMCrossRR(j, 1);
    i = i + 1;
    j = j + 1;
end
i = 1;
j = 1;
while i < numel(RFCrossRU)/3 + 1
    A(6, i) = RFCrossRU(i,3);
    i = i + 1;
end
while i < 7
    A(6,i) = RMCrossRR(j, 3);
    i = i + 1;
    j = j + 1;
end

ResulatantForces = linsolve(A, -b);
end