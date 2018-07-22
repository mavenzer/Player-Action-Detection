function result = Modified_LBP(IM)
% The function computes the Modified LBP for an image
% according to the method described in "Multi-Resolution
% Local Binary Patterns or Image Classification" by Peng Liang, 
% Shao-Fa Li and Jiang-Wei. It takes the image as the input and
% for each pixel of the image it takes the  difference of the neighbouring
% pixels which are opposite to each other. It consideres 8 neighbouring
% pixels for the central pixel. 


CROPPED_IM = IM(2:end-1,2:end-1);

% The neighbour matrices are seperated 
G0_IM = IM(2:end-1,3:end);
G1_IM = IM(3:end,3:end);
G2_IM = IM(3:end,2:end-1);
G3_IM = IM(3:end,1:end-2);
G4_IM = IM(2:end-1,1:end-2);
G5_IM = IM(1:end-2,1:end-2);
G6_IM = IM(1:end-2,2:end-1);
G7_IM = IM(1:end-2,3:end);



% The difference between the neighbours is found out
D1 = G0_IM >= G4_IM;
D2 = G1_IM >= G5_IM;
D3 = G2_IM >= G6_IM;
D4 = G3_IM >= G7_IM;
D5 = (G0_IM + G1_IM + G2_IM + G3_IM + G4_IM + G5_IM + G6_IM + G7_IM)/8 >= CROPPED_IM;


% The final map is computed
map = D1 + 2.*D2 + 4.*D3 + 8.*D4 + 16.*D5;


neighbour = 8;
nbins = 2^((neighbour/2)+1);
result=hist(map(:),0:(nbins-1));

% normalize
result = result/(eps+sum(result));
end
