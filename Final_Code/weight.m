function [weight] = weight(density,joints,connectivity,mass_joint)
%WEIGHT [weight] = weight(1.214,joints,connectivity,8.36)
mass = zeros(length(joints),1);
for i = 1:length(joints)
    [a,b] = find (connectivity == i);
    for j = 1:length(a)
        id1 = connectivity(a(j),b(j));
        if b(j)==1
            id2 = connectivity(a(j),2);
        elseif b(j)==2
            id2 = connectivity(a(j),1);
        end
        len = (1/2)*((joints(id1,1)-joints(id2,1))^2+(joints(id1,2)-joints(id2,2))^2+(joints(id1,3)-joints(id2,3))^2)^(1/2);
    mass(i) = mass(i) + len;
    end
end

mass = density .* mass;
mass = mass + mass_joint;
weight = -9.81 .* mass;
%weight = -386.220681 .* mass;
                   
end
