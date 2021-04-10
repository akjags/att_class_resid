

function [FisherZ] = FisherRtoZ(r)

FisherZ = 0.5*(log(1+r)-log(1-r));

end