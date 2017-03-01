clear all;
T = 1;
k = 9;

t = [0:0.01:1];
% phi = @(t) sin(t)*-pi/T*(2*(t-T/2)).^k;
% dphi = @(t) -pi/T*k*2*(2*(t-T/2)).^(k-1);
% ddphi = @(t) -pi/T*k*(k-1)*2*2*(2*(t-T/2)).^(k-2);

phi_over_t = zeros(length(t),1);
for i=1:length(phi_over_t)
    [phi_over_t(i),~,~] = motion(t(i));
end
figure; plot(t,phi_over_t)

