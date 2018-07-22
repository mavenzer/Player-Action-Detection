function M2 =  hist_fine2coarseMapping(n_1,n_2,sigma)
% this function creates a matrix that maps the fine histogram to a coarse one
%
% The folowing input arguments should be passed to the function
% n_1 = 36;   %length histogram of fine orientation grids
% n_2 = 10;   %length histogram of coarse orientation grids
% sigma = 10;  % variance of gaussian Membership function
% 
% Usage:
% M2 =  hist_fine2coarseMapping(36,10,2);
% coarseHistogram = M2*fineHistogram;

x = 1:n_1;
center = round(n_1/2);
mf = evalmf(x, [sigma,center], 'gaussmf');
% mf = evalmf(x, mf2mf([sigma,center],'gaussmf','trimf'), 'trimf');
% mf = evalmf(x, mf2mf([sigma,center],'gaussmf','trapmf'), 'trapmf');
% mf = evalmf(x, mf2mf([sigma,center],'gaussmf','gbellmf'), 'gbellmf');

mf1 = circshift(mf',center);
M1 = [];
for i = 1:n_1
    M1 = [M1, mf1];
    mf1 = circshift(mf1, 1);
end

M2 = M1(round(linspace(1,n_1,n_2)),:);
end
