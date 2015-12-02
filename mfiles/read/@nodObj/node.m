function node=node(o,varargin)
% function o=x_idx(o,varargin)
  [inputnumber,  varargin] = getProp(varargin,'steps',1);
  [mtx_bol,  varargin] = getWord(varargin,'mtx');
  
  node=o.data(inputnumber).terms{o.n_idx};
  if mtx_bol, opt=convert_2_mtx(o,opt); end
