function [Result_Common, count] = ObtainCommon (Result_A_1, Result_A_2)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
ShapeCount = 1400;
[m1 n1] = size(Result_A_1);
[m2 n2] = size(Result_A_2);

% initialization
accumulator = zeros (m1, ShapeCount);

% accumulation
for i = 1 : n1
    accumulator(Result_A_1(i)) = accumulator(Result_A_1(i)) + 1;
    accumulator(Result_A_2(i)) = accumulator(Result_A_2(i)) + 1;
end

% obtain common indexes
counter = 1;
Result_Common = zeros (m1, n1);
for j = 1 : ShapeCount
    if (accumulator(j) >= 2)
        index = find (Result_A_1 == j);
        Result_Common(index) = j;
        counter = counter + 1;
    end
end



count = counter;
end

