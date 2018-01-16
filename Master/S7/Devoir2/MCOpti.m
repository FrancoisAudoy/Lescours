function [ Wn ] = MCOpti( Z, b )
%MCOPTI Summary of this function goes here
%   Detailed explanation goes here

nu = 0.1
W = Z\b;
bp = b;
bn = b - nu * ( -2 * (Z * W - bp));
bn = bn.* (bn>0);

i = 1;
while( norm(bp - bn) > 0.001)
    i = i + 1;
    bp = bn;
    W = Z\bn;
    bn = bp - nu *(-2 * (Z * W - bp));
    bn = bn.*(bn>0);
end

Wn = W

end

