classdef inpObj
  properties
    % the following list are associated with property defination
    % http://stackoverflow.com/questions/7192048/can-i-assign-types-to-class-properties-in-matlab
    % http://undocumentedmatlab.com/blog/setting-class-property-types
    
    % now only key data are stored in inpObj, other non-relevant data will all be 
    % wiped out 

    % if one wish to convert from class to truct due to reasons like jasn file 
    %   one can use a=struct(inpObj)

    % varagin stores all the input parameters
    varargin@cell;
    
    %   inp should later be removed now it is here for storing all strings extracted
    %     from the file
    inp

    % NOTICE TO DEVELOPERS:
    %   please make sure that all decleared varables here are in accordance with 
    %    Original SUTRA code for the convinence of 1. better understanding of the 
    %    original code (input are in indat1 and indat2) and 2. make code consistent
    %   A comment can be made after the name declaration 


    % ---------------  DATASET 2B variable declaration--------------------
    %   matlab stats that, string array should be declared as cells
    %    mshtyp   = char(2,10)   
    %   http://stackoverflow.com/questions/7100841/create-an-array-of-strings

    mshtyp@cell=repmat({''},2,1)     % mesh type
    nn1  % -- number of node in the first direction
    nn2  % -- number of node in the second direction
    nn3  % -- number of node in the third direction
    %   DATASET 3
    nn   % -- number of node 
    ne   % -- number of element
    npbc 
    nubc 
    nsop 
    nsou 
    nobs 
    %   dataset1       = repmat({''},1,2);
    %    e             = char(23);
    %    e@char(20)
    % ---------------  DATASET 8A variable declaration--------------------
    nprint  
    cnodal  
    celmnt  
    cincid  
    cpands    
    cvel   
    ccort    
    cbudg   
    cscrn  
    cpause
    % ---------------  DATASET 8B variable declaration--------------------
    ncolpr

    % ---------------  DATASET 8C variable declaration--------------------
    lcolpr

    % ---------------  DATASET 8D variable declaration--------------------
    nbcfpr
    nbcspr
    nbcppr
    nbcupr
    cinact

    % ---------------  DATASET 9  variable declaration--------------------
    compfl           
    cw       
    sigmaw
    rhow0
    urhow0
    drwdu 
    visc0 
    dvidu

    % ---------------  DATASET 10 variable declaration--------------------
    compma
    cs
    sigmas
    rhos

    % ---------------  DATASET 11 variable declaration--------------------
    adsmod
    chi1
    chi2

    % ---------------  DATASET 12 variable declaration--------------------
    prodf0
    prods0
    prodf1
    prods1


    % examples to declear cells and structs in properties
    %    dtst@cell=repmat({''},22,1)
    %    dtst{1}@cell=repmat({''},2,1)   % how to do this
    %    dtst{2}@cell=repmat({''},2,1)
    %    dtst1@cell=repmat({''},2,1)
    %    dtst2@cell=repmat({''},2,1)
    %    dtst8@cell=repmat({''},4,1)
    %    dtst9@char
    e=char(14)   %  this is working now but the 14 means have 14 strings
    %    f=char(2,4)   %  this is working now but the 14 means have 14 strings
    g=cell(2,4)   %  this is working now but the 14 means have 14 strings
    %    h{1}=repmat({''},2,1)
    %    h{2}=repmat({''},2,1)
    %            'dtst1'   ,{'title1';'title2'},...
    nnv
  end
  
  
  properties (Access=protected)
  c ,d
  end

  properties (Dependent=true)
  % these values are only called when input are changed
  %   a, b, c ,d, e,
  %nns
  end

  methods    % seems that all functions in methods needs to be called.
    function o=inpObj(varargin)
      % inpObj constructor
      caller=dbstack('-completenames'); caller=caller.name;
      o.varargin        = varargin;
      [fname, varargin] = getNext(varargin,'char','');
      [read,  varargin] = getProp(varargin,'operation',[]);

      % ---------------       DATASET 1    -------------------------
      fn=fopen([fname,'.INP']);
      if fn==-1 
        fprintf(1,'Trying to open %s .inp\n',fname);
        fn=fopen([fname,'.inp']);
        if fn==-1
          fprintf('%s: file nod found!!\n',caller,fname);
          return
        end
      end
      o.inp.dataset1a=getNextLine(fn,'criterion','without','keyword','#');
      o.inp.dataset1b=getNextLine(fn,'criterion','without','keyword','#');
      % ---------------       DATASET 2A   -------------------------
      o.inp.dataset2a=getNextLine(fn,'criterion','without','keyword','#');
      % ---------------       DATASET 2B   -------------------------
      o.inp.dataset2b=getNextLine(fn,'criterion','without','keyword','#');
      % remove single quote
      strprc      = regexprep(o.inp.dataset2b,'''','');
      tmp         = textscan(strprc,'%s %s %s %f %f');
      o.mshtyp(1) = tmp{1};
      o.mshtyp(2) = tmp{2};
      o.nn1       = tmp{4};
      o.nn2       = tmp{5};
      % ---------------       DATASET 3    -------------------------
      o.inp.dataset3 = getNextLine(fn,'criterion','without','keyword','#');
      str            = textscan(o.inp.dataset3,'%f %f %f %f %f %f %f');
      o.nn           = str{1};
      o.ne           = str{2};
      o.npbc         = str{3};
      o.nubc         = str{4};
      o.nsop         = str{5};
      o.nsou         = str{6};
      o.nobs         = str{7};
      
      % ---------------       DATASET 4    -------------------------
      o.inp.dataset4=getNextLine(fn,'criterion','without','keyword','#');
      
      
      % ---------------       DATASET 5    -------------------------
      o.inp.dataset5 = getNextLine(fn,'criterion','without','keyword','#');
      
      
      % ---------------       DATASET 6    -------------------------
      o.inp.dataset6 = getNextLine(fn,'criterion','without','keyword','#');
      o.inp.dataset6 = getNextLine(fn,'criterion','without','keyword','#');
      o.inp.dataset6 = getNextLine(fn,'criterion','without','keyword','#');
      
      % ---------------       DATASET 7A   -------------------------
      o.inp.dataset7a = getNextLine(fn,'criterion','without','keyword','#');
      
      % ---------------       DATASET 7B   -------------------------
      o.inp.dataset7b = getNextLine(fn,'criterion','without','keyword','#');
      
      % ---------------       DATASET 7C   -------------------------
      o.inp.dataset7c = getNextLine(fn,'criterion','without','keyword','#');
      
      % ---------------       DATASET 8A   -------------------------
      o.inp.dataset8a = getNextLine(fn,'criterion','without','keyword','#');
      strprc          = regexprep(o.inp.dataset8a,'''','');
      str             = textscan(strprc,'%f %s %s %s %s %s %s %s %s %s');
      o.nprint        = str{1} ;
      o.cnodal        = str{2}{1};
      o.celmnt        = str{3}{1};
      o.cincid        = str{4}{1};
      o.cpands        = str{5}{1};
      o.cvel          = str{6}{1};
      o.ccort         = str{7}{1};
      o.cbudg         = str{8}{1};
      o.cscrn         = str{9}{1};
      o.cpause        = str{10}{1};
      % ---------------       DATASET 8B   -------------------------
      o.inp.dataset8b = getNextLine(fn,'criterion','without','keyword','#');
      strprc          = regexprep(o.inp.dataset8b,'''','');
      str             = textscan(strprc,'%f %s %s %s ');
      ncolpr=str{1};
      % ---------------       DATASET 8C   -------------------------
      o.inp.dataset8c = getNextLine(fn,'criterion','without','keyword','#');
      strprc          = regexprep(o.inp.dataset8c,'''','');
      str             = textscan(strprc,'%f %s %s %s ');
      lcolpr=str{1};

      % ---------------       DATASET 8D   -------------------------
      o.inp.dataset8d = getNextLine(fn,'criterion','without','keyword','#');
      strprc          = regexprep(o.inp.dataset8d,'''','');
      str             = textscan(strprc,'%f %f %f %f %s');
      o.nbcfpr        = str{1};
      o.nbcspr        = str{2};
      o.nbcppr        = str{3};
      o.nbcupr        = str{4};
      o.cinact        = str{5}{1};
      
      % ---------------       DATASET 9    -------------------------
      o.inp.dataset9  = getNextLine(fn,'criterion','without','keyword','#');
      
      % ---------------       DATASET 10   -------------------------
      o.inp.dataset10 = getNextLine(fn,'criterion','without','keyword','#');
      
      % ---------------       DATASET 11   -------------------------
      o.inp.dataset11 = getNextLine(fn,'criterion','without','keyword','#');
      
      % ---------------       DATASET 12   -------------------------
      o.inp.dataset12 = getNextLine(fn,'criterion','without','keyword','#');
      
      % ---------------       DATASET 13   -------------------------
      o.inp.dataset13 = getNextLine(fn,'criterion','without','keyword','#');

      end % Function constructor

       function nnv=get.nnv(o)
         % it is working the same time as others, which is not a procedural way.
	 % everytime when o.a is changing, nnv is changing.
         nnv=o.a+1; 
       end
%  a endless loop
%       function nns=get.nns(b), 
%         % it is working the same time as others, which is not a procedural way.
%	 % everytime when o.a is changing, nnv is changing.
%         nns=b; 
%       end
%       function nnv=set.nnv(x), nnv=1; end
%       function o=set.nns(o,10), o.nns=10; end
   end  % end methods


   methods(Static)
     function nns = nnns(o),
       % it is working the same time as others, which is not a procedural way.
       % everytime when o.a is changing, nnv is changing.
       nns.nns = o.a+7;
     end % function
   end % methods (static)
end % classdef
