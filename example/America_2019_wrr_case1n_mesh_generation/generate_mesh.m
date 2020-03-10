clear all
close all


dx=5;
dy=-0.2;
x_ay=0:dx:200;
y_ay=0:dy:-5.2;
nx=length(x_ay);
ny=length(y_ay);

nex=length(x_ay)-1;
ney=length(y_ay)-1;

[x_nod_mtx,y_nod_mtx]=meshgrid(x_ay,y_ay);

keynodes            = zeros(size(x_nod_mtx,1),size(x_nod_mtx,2)+1);
keynodes(:,2:end-1) = (x_nod_mtx(:,1:end-1)+x_nod_mtx(:,2:end))/2;
keynodes(:,1)       = x_nod_mtx(:,1);
keynodes(:,end)     = x_nod_mtx(:,end);
dx_cell_mtx       = diff(keynodes,1,2); % check inbuilding function diff

keynodes            = zeros(size(y_nod_mtx,1)+1,size(y_nod_mtx,2));
keynodes(2:end-1,:) = (y_nod_mtx(1:end-1,:)+y_nod_mtx(2:end,:))/2;
keynodes(1,:)       = y_nod_mtx(1,:);
keynodes(end,:)     = y_nod_mtx(end,:);
dy_cell_mtx=diff(keynodes,1,1); % check inbuilding function diff


nn=nx*ny;
ne=(nx-1)*(ny-1);
sequence='yxz';

%dataset 14
ii=(1:nn)';
x=x_nod_mtx(:);
y=y_nod_mtx(:);







inp=inpObj('read_from_file','no');   % setup a empty inpObj

% dataset 1
inp.title1='title 1 Americal_2020_WRR';
inp.title2='title 2 input generated by sutralab';

% dataset 2a
%'SUTRA VERSION 2.2 SOLUTE TRANSPORT'
%'2D REGULAR MESH' 105 4001

inp.vermin='2.2';  % note this should be a string not a number;
inp.simula='SOLUTE'; 


% dataset 2b
 %        2d mesh          ==>   ktype(1) = 2
 %        3d mesh          ==>   ktype(1) = 3
 %        irregular mesh   ==>   ktype(2) = 0
 %        layered mesh     ==>   ktype(2) = 1
 %        regular mesh     ==>   ktype(2) = 2
 %        blockwise mesh   ==>   ktype(2) = 3

inp.ktype(1)=1;  % 2D mesh
inp.mshtyp{1}='2D';
inp.mshtyp{2}='REGULAR';

inp.nn1=0
inp.nn2=0


% ##  DATASET 3:  Simulation Control Numbers
inp.nn=nn;
inp.ne=
inp.npbc=
inp.nubc=0;
inp.nsop=
inp.nsou=0;
inp.nobs=0;


%%##  DATASET 4:  Simulation Mode Options

inp.cunsat='UNSATURATED';
inp.cssflo='TRANSIENT FLOW';
inp.csstra='TRANSIENT TRANSPORT';
inp.cread='COLD' ;
inp.istore=9999;


%%##  DATASET 5:  Numerical Control Parameters
inp.up=0;
inp.gnup=0.01;
inp.gnuu=0.01;


%  DATASET 6:  Temporal Control and Solution Cycling Data
%  
inp.nsch=1;
inp.npcyc=1;
inp.nucyc=1




%DATASET 6:  Temporal Control and Solution Cycling Data

inp.schnam='TIME_STEPS';
inp.schtyp='TIME CYCLE';
inp.creft='ELAPSED';
inp.scalt=1800;
inp.ntmax=87600;
inp.timei=0;
inp.timel=1.e99;
inp.timec=1.;
inp.ntcyc=9999;
inp.tcmult=1;
inp.tcmin=1.e-20;
inp.tcmax=1.e99;



%##  DATASET 7:  ITERATION AND MATRIX SOLVER CONTROLS
%##  [ITRMAX]        [RPMAX]        [RUMAX]
inp.itrmax=100;
inp.rpmax=5e-2;
inp.rumax=5e-2;
% ##  [CSOLVP]  [ITRMXP]         [TOLP]
inp.csolvp='ORTHOMIN' ;
inp.itrmxp=10000;
inp.tolp=1e-12;

%##  [CSOLVU]  [ITRMXU]         [TOLU]
inp.csolvu='ORTHOMIN';
inp.ITRMXU=1000;
inp.TOLU=1e-12;


%##  DATASET 8:  Output Controls and Options
%## [NPRINT]  [CNODAL]  [CELMNT]  [CINCID]  [CPANDS]  [CVEL]  [CCORT] [CBUDG]   [CSCRN]  [CPAUSE]
%   2920        'N'        'N'        'N'        'Y'     'Y'        'Y'    'Y'      'Y' 'Y' 'Data Set 8A'


nprint=2920;  
cnodal='N'; 
inp.celmnt='N';
inp.cincid='N';
inp.cpands='Y';
inp.cvel='Y';
inp.ccort='N';
inp.cbudg='Y';
inp.cscrn='Y';
inp.cpause='Y';



%## [NCOLPR]    [NCOL]
%     -1000  'N'  'X'  'Y'  'P'  'U'  'S'  '-' 
%## [LCOLPR]    [LCOL]
%     1000 'E'  'X'  'Y'  'VX' 'VY' '-' 
%## [NOBCYC]    [INOB]
%
%##  [NBCFPR]  [NBCSPR]  [NBCPPR]  [NBCUPR]  [CINACT]
%     1000         1000       1000      1000       'Y'
%##
%##  DATASET 9:  Fluid Properties
%##     [COMPFL]           [CW]       [SIGMAW]        [RHOW0]       [URHOW0]        [DRWDU]        [VISC0]
%         0.0                1.         3.890D-10         1.0E+3             0.     7.0224E+02         1.0E-3
%##
%##  DATASET 10:  Solid Matrix Properties
%##     [COMPMA]           [CS]       [SIGMAS]         [RHOS]
%         0.0             0.             0.             1.
%##
%##  DATASET 11:  Adsorption Parameters




inp.ncolpr=-2920;
inp.ncol= 'N'  'X'  'Y'  'P'  'U'  'S'  '-';

inp.lcolpr=2920;
inp.lcol= 'E'  'X'  'Y'  'VX' 'VY' '-';



%##     
inp.compfl=0;           
inp.cw=1.;       
inp.sigmaw=1e-9;        
inp.rhow0=1000;       
inp.urhow0=0;        
inp.drwdu=700;        
inp.visc0=0.001;


%##     
COMPMA=0;
CS=0;
SIGMAS=0;         
RHOS=2600;   %solid density of sodium chloride

%##  DATASET 11:  Adsorption Parameters
%##     [ADSMOD]         [CHI1]         [CHI2]
%#'NONE'
%'FREUNDLICH' 1.D-47 0.05  #less rigid

inp.adsmod='FREUNDLICH';
inp.chi1=1.D-47;
inp.chi2=0.05 ;



%##
%##  DATASET 12:  Production of Energy or Solute Mass
%##     [PRODF0]       [PRODS0]       [PRODF1]       [PRODS1]
%0.             0.             0.             0.
inp.prodf0=0;
inp.prods0=0;
inp.prodf1=0;
inp.prods1=0;


%##
%##  DATASET 13:  Orientation of Coordinates to Gravity
%##      [GRAVX]        [GRAVY]        [GRAVZ]
%0.           -9.81          0.
inp.gravx=0;
inp.gravy=-9.81;
inp.gravz=0;

%##  DATASET 14:  NODEWISE DATA
%%##                              [SCALX] [SCALY] [SCALZ] [PORFAC]
inp.scalx=1.;
inp.scaly=1.;
inp.scalz=1.;
inp.porfac=1.;

%##      [II]    [NRE    G(II)]  [X(II)] [Y(II)] [Z(II)] [POR(II)]
inp.ii=(1:nn)';
inp.nreg=zeros(nn,1)+2;
inp.x=x;
inp.y=y;
inp.z=zeros(nn,1)+1.0;
inp.por=zeros(nn,1)+0.24;


%##              [PMAXFA]        [PMINFA]        [ANG1FA]        [ALMAXF]        [ALMINF]        [ATMAXF]        [ATMINF]
%'ELEMENT'               1.0000000D+00   1.0000000D+00   1.0000000D+00   2 2 2 2
%##     [L]      [NREG(L)]       [PMAX(L)]       [PMIN(L)]       [ANGLE1(L)]     [ALMAX(L)]      [ALMIN(L)]      [ATMAX(L)]      [ATMIN(L)]
inp.pmaxfa=1.;
inp.pminfa=1.;
inp.ang1fa=1.;
inp.almaxf=2.;
inp.alminf=2.;
inp.atmaxf=2.;
inp.atminf=2.;
inp.l=(1:ne)';
inp.lreg=zeros(ne,1)+2;
inp.pmax=zeros(ne,1)+1.16e-11;
inp.pmin=zeros(ne,1)+1.16e-11;
inp.angle1=zeros(ne,1);
inp.almax=zeros(ne,1)+0.1;
inp.almin=zeros(ne,1)+0.1;
inp.atmax=zeros(ne,1)+0.01;
inp.atmin=zeros(ne,1)+0.01;


%##
%##  DATASET     22:  Ele        ment Incid      ence Data
%##    [LL]      [IIN(1)]        [IIN(2)]        [IIN(3)]        [IIN(4)]

node_index_mtx=reshape(ii,ny,nx);  %note node_index_mtx(52)=52
ne_mtx=reshape(l,ney,nex);
idx=1;
for j=1:nex
    for i=1:ney
        iin1(idx)=node_index_mtx(i,j);
        iin2(idx)=node_index_mtx(i+1,j);
        iin3(idx)=node_index_mtx(i+1,j+1);
        iin4(idx)=node_index_mtx(i,j+1);
        idx=idx+1;
    end
end


