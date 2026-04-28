
function [data, hdr] = readsac(FILENAME)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%  [data, hdr] = readsac(FILENAME)
%%%
%%%  readsac.m is a MATLAB function that reads a SAC file (given by 
%%%  'filename' (the filename MUST be in single quotes!) and outputs
%%%  a data vector and the header information (hdr).  The header data
%%%  are output in structure format
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if nargin<1 | FILENAME==' ',
    FILENAME=input('Enter the filename: '); 
  while isempty(FILENAME),
    FILENAME=input('Yo!  Enter the filename, fool. '); 
  end
end

data = [];
hdr = [];

fid=fopen(FILENAME,'r','b');  % reads data in big-endian format
% note on UNIX (or Linux?) this should be fid=fopen(FILENAME,'r','l');

if fid== -1,
  msg = ['Error opening this file'];
  disp(msg)
  return
else
  msg = [];
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% SAC headers look like this...
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%      logical  LEVEN,LPSPOL,LOVROK,LCALDA, LUNUSED
%
%      character   KSTNM*8, KEVNM*16
%      character*8 KHOLE,KO,KA,
%     *            KT0,KT1,KT2,
%     *            KT3,KT4,KT5,
%     *            KT6,KT7,KT8,
%     *            KT9,KF,KUSER0,
%     *            KUSER1,KUSER2,KCMPNM,
%     *            KNETWK,KDATRD,KINST
%
%c       open(IUNIT,file=filename,form='unformatted',
%c     +         ACCESS='DIRECT',RECL=NBYTES)        !632 bytes=header length
%
%       read(IUNIT,REC=1) DELTA,DEPMIN,DEPMAX,SCALE,ODELTA,   !float variables
%     +   B,E,O,A,FINTERNAL,T00,T11,T2,T3,T4,T5,T6,T7,T8,T9,F,
%     +   RESP0,RESP1,RESP2,RESP3,RESP4,RESP5,RESP6,RESP7,RESP8,RESP9,
%     +   STLA,STLO,STEL,STDP,EVLA,EVLO,EVEL,EVDP,UNUSED,USER0,USER1,
%     +   USER2,USER3,USER4,USER5,USER6,USER7,USER8,USER9,DIST,AZ,BAZ,
%     +   GCARC,FINTERNAL,FINTERNAL,DEPMEN,CMPAZ,CMPINC,UNUSED,UNUSED,
%     +   UNUSED,UNUSED,UNUSED,UNUSED,UNUSED,UNUSED,UNUSED,UNUSED,UNUSED,
%     +   NZYEAR,NZJDAY,NZHOUR,NZMIN,NZSEC,NZMSEC,NVHDR,      !integer variables
%     +   INTERNAL,INTERNAL,NPTS,INTERNAL,INTERNAL,IUNUSED,
%     +   IUNUSED,IUNUSED,IFTYPE,IDEP,IZTYPE,IUNUSED,IINST,
%     +   ISTREG,IEVREG,IEVTYP,IQUAL,ISYNTH,IUNUSED,IUNUSED,IUNUSED,
%     +   IUNUSED,IUNUSED,IUNUSED,IUNUSED,IUNUSED,IUNUSED,IUNUSED,
%     +          LEVEN,LPSPOL,LOVROK,LCALDA,LUNUSED,       !logical variables
%     +          KSTNM,KEVNM,                              !character variables
%     +          KHOLE,KO,KA,KT0,KT1,KT2,
%     +          KT3,KT4,KT5,KT6,KT7,KT8,
%     +          KT9,KF,KUSER0,
%     +          KUSER1,KUSER2,KCMPNM,
%     +          KNETWK,KDATRD,KINST  		23
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%  since SAC headers have a number of different formats, we list
%%%  them by type here and read them in one at a time.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


    hdreal=fread(fid,[70],'float');	%real*4
    hdint=fread(fid,[35],'long');	%integer data
    hdlog=fread(fid,[5],'uint');	%logical data
    hdchar=fread(fid,[192],'uchar');	%character data

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%  If we chose to set the DISPLAY flag to 1, we now display  
%%%  a selection of information from the header
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

hdr = struct([]);
hdr(1).DELTA = hdreal(1);
hdr(1).DEPMIN = hdreal(2);
hdr(1).DEPMAX = hdreal(3);
hdr(1).SCALE = hdreal(4);
hdr(1).ODELTA = hdreal(5);
hdr(1).BEG = hdreal(6);
hdr(1).END = hdreal(7);
hdr(1).ORG = hdreal(8);
hdr(1).ARR = hdreal(9);
hdr(1).INTERNAL1 = hdreal(10);
hdr(1).T0 = hdreal(11);
hdr(1).T1 = hdreal(12);
hdr(1).T2 = hdreal(13);
hdr(1).T3 = hdreal(14);
hdr(1).T4 = hdreal(15);
hdr(1).T5 = hdreal(16);
hdr(1).T6 = hdreal(17);
hdr(1).T7 = hdreal(18);
hdr(1).T8 = hdreal(19);
hdr(1).T9 = hdreal(20);
hdr(1).F = hdreal(21);
hdr(1).RESP0 = hdreal(22);
hdr(1).RESP1 = hdreal(23);
hdr(1).RESP2 = hdreal(24);
hdr(1).RESP3 = hdreal(25);
hdr(1).RESP4 = hdreal(26);
hdr(1).RESP5 = hdreal(27);
hdr(1).RESP6 = hdreal(28);
hdr(1).RESP7 = hdreal(29);
hdr(1).RESP8 = hdreal(30);
hdr(1).RESP9 = hdreal(31);
hdr(1).STLA = hdreal(32);
hdr(1).STLO = hdreal(33);
hdr(1).STEL = hdreal(34);
hdr(1).STDP = hdreal(35);
hdr(1).EVAL = hdreal(36);
hdr(1).EVLO = hdreal(37);
hdr(1).EVEL = hdreal(38);
hdr(1).EVDP = hdreal(39);

hdr(1).MAG = hdreal(40);
hdr(1).USER0 = hdreal(41);
hdr(1).USER1 = hdreal(42);
hdr(1).USER2 = hdreal(43);
hdr(1).USER3 = hdreal(44);
hdr(1).USER4 = hdreal(45);
hdr(1).USER5 = hdreal(46);
hdr(1).USER6 = hdreal(47);
hdr(1).USER7 = hdreal(48);
hdr(1).USER8 = hdreal(49);
hdr(1).USER9 = hdreal(50);
hdr(1).DIST = hdreal(51);
hdr(1).AZ = hdreal(52);
hdr(1).BAZ = hdreal(53);
hdr(1).GCARC = hdreal(54);
hdr(1).INTERNAL2 = hdreal(55);
hdr(1).INTERNAL3 = hdreal(56);
hdr(1).DEPMEN = hdreal(57);
hdr(1).CMPAZ = hdreal(58);
hdr(1).CMPINC = hdreal(59);
hdr(1).XMIN = hdreal(60);
hdr(1).XMAX = hdreal(61);
hdr(1).YMIN = hdreal(62);
hdr(1).YMAX = hdreal(63);
hdr(1).UNUSED1 = hdreal(64);
hdr(1).UNUSED2 = hdreal(65);
hdr(1).UNUSED3 = hdreal(66);
hdr(1).UNUSED4 = hdreal(67);
hdr(1).UNUSED5 = hdreal(68);
hdr(1).UNUSED6 = hdreal(69);
hdr(1).UNUSED7 = hdreal(70);

hdr(1).NZYEAR = hdint(1);
hdr(1).NZJDAY = hdint(2);
hdr(1).NZHOUR = hdint(3);
hdr(1).NZMIN = hdint(4);
hdr(1).NZSEC = hdint(5);
hdr(1).NZMSEC = hdint(6);
hdr(1).NVHDR = hdint(7);
hdr(1).NORID = hdint(8);
hdr(1).NEVID = hdint(9);
hdr(1).NPTS = hdint(10);
hdr(1).INTERNAL4 = hdint(11);
hdr(1).NWFID = hdint(12);
hdr(1).NXSIZE = hdint(13);
hdr(1).NYSIZE = hdint(14);
hdr(1).UNUSED8 = hdint(15);
hdr(1).IFTYPE = hdint(16);
hdr(1).IDEP = hdint(17);
hdr(1).IZTYPE = hdint(18);
hdr(1).UNUSED9 = hdint(19);
hdr(1).IINST = hdint(20);
hdr(1).ISTREG = hdint(21);
hdr(1).IEVREG = hdint(22);
hdr(1).IEVTYP = hdint(23);
hdr(1).IQUAL = hdint(24);
hdr(1).ISYNTH = hdint(25);
hdr(1).IMAGTYP = hdint(26);
hdr(1).IMAGSRC = hdint(27);
hdr(1).UNUSED10 = hdint(28);
hdr(1).UNUSED11 = hdint(29);
hdr(1).UNUSED12 = hdint(30);
hdr(1).UNUSED13 = hdint(31);
hdr(1).UNUSED14 = hdint(32);
hdr(1).UNUSED15 = hdint(33);
hdr(1).UNUSED16 = hdint(34);
hdr(1).UNUSED16 = hdint(35);

hdr(1).LEVEN = hdlog(1);
hdr(1).LPSPOL = hdlog(2);
hdr(1).LOVROK = hdlog(3);
hdr(1).LCALDA = hdlog(4);
hdr(1).UNUSED17 = hdlog(5);

hdr(1).KSTNM = setstr(hdchar(1:8));
hdr(1).KEVNM = setstr(hdchar(9:24));
hdr(1).KHOLE = setstr(hdchar(25:32));
hdr(1).K0 = setstr(hdchar(33:40));
hdr(1).KA = setstr(hdchar(41:48));
hdr(1).KT0 = setstr(hdchar(48:56));
hdr(1).KT1 = setstr(hdchar(57:64));
hdr(1).KT2 = setstr(hdchar(65:72));
hdr(1).KT3 = setstr(hdchar(73:80));
hdr(1).KT4 = setstr(hdchar(81:88));
hdr(1).KT5 = setstr(hdchar(89:96));
hdr(1).KT6 = setstr(hdchar(97:104));
hdr(1).KT7 = setstr(hdchar(105:112));
hdr(1).KT8 = setstr(hdchar(113:120));
hdr(1).KT9 = setstr(hdchar(121:128));
hdr(1).KF = setstr(hdchar(129:136));
hdr(1).KUSER0 = setstr(hdchar(137:144));
hdr(1).KUSER1 = setstr(hdchar(145:152));
hdr(1).KUSER2 = setstr(hdchar(153:160));
hdr(1).KCMPNM = setstr(hdchar(161:168));
hdr(1).KNETWK = setstr(hdchar(169:176));
hdr(1).KDATRD = setstr(hdchar(177:184));
hdr(1).KINST = setstr(hdchar(185:192));

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%  Now we pull out the data 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

data = fread(fid, 'float');

%%%  don't forget to close the file!.

fclose(fid);

end

varargout{1} = msg;
varargout{2} = data;
varargout{3} = hdr;
