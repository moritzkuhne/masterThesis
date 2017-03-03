%Hier die DGL nochmal das System als Vektoren eingeben, weil die numerische
%Integration Vektoren brauch

function dy = rigid(t,y)
dy = zeros(2,1);    % a column vector
dy(1) = y(1)-y(2)-y(1)^3;
dy(2) = y(2)+y(1)-y(2)^3;
end