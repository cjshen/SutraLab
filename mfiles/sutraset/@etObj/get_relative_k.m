function [kr,sw]=get_relative_k(o,varargin)
  [psim,  varargin] = getProp(varargin,'psim',-[0.1:0.1:1,2:1:10,20:10:100,200:100:1000,2000:1000:50000]);
  [nreg,  varargin] = getProp(varargin,'nreg',1);
  if nreg==1
    [kr,sw]=RelativeK_VanGenuchten1980(psim,-o.aa1,o.vn1,o.swres1);
    elseif nreg==2
    [kr,sw]=RelativeK_VanGenuchten1980(psim,-o.aa2,o.vn2,o.swres2);
  end

end % function
