 
      function [ux]=dss002(xl,xu,n,u)
%...
%...  FUNCTION DSS002 COMPUTES THE FIRST DERIVATIVE, U , OF A
%...                                                  X
%...  VARIABLE U OVER THE SPATIAL DOMAIN XL LE X LE XU
%...
%...  ARGUMENT LIST
%...
%...     XL      LOWER BOUNDARY VALUE OF X (INPUT)
%...
%...     XU      UPPER BOUNDARY VALUE OF X (INPUT)
%...
%...     N       NUMBER OF GRID POINTS IN THE X DOMAIN INCLUDING THE
%...             BOUNDARY POINTS (INPUT)
%...
%...     U       ONE-DIMENSIONAL ARRAY CONTAINING THE VALUES OF U AT
%...             THE N GRID POINT POINTS FOR WHICH THE DERIVATIVE IS
%...             TO BE COMPUTED (INPUT)
%...
%...     UX      ONE-DIMENSIONAL ARRAY CONTAINING THE NUMERICAL
%...             VALUES OF THE DERIVATIVES OF U AT THE N GRID POINTS
%...             (OUTPUT)
%...
%...  THE WEIGHTING COEFFICIENTS CAN BE SUMMARIZED AS
%...
%...          -3   4  -1
%...
%...     1/2  -1   0   1
%...
%...           1  -4   3
%...
%...  WHICH ARE THE COEFFICIENTS REPORTED BY BICKLEY FOR N = 2, M =
%...  1, P = 0, 1, 2 (BICKLEY, W. G., FORMULAE FOR NUMERICAL DIFFER-
%...  ENTIATION, MATH. GAZ., VOL. 25, 1941).
%...
%...  COMPUTE THE SPATIAL INCREMENT
      dx=(xu-xl)/(n-1);
      r2fdx=1./(2.*dx);
      nm1=n-1;
%...
%...  LEFT END POINT.  THE FOLLOWING CODING HAS BEEN FORMATTED
%     SO THAT THE NUMERICAL WEIGHTING COEFFICIENTS CAN BE MORE
%...  EASILY ASSOCIATED WITH THE BICKLEY MATRIX LISTED ABOVE)
      ux(1)=r2fdx*...
      (     -3.   *u(  1)     +4.   *u(  2)     -1.   *u(  3));
%...
%...  INTERIOR POINTS
      for i=2:nm1
      ux(i)=r2fdx*...
      (     -1.   *u(i-1)     +0.   *u(  i)     +1.   *u(i+1));
      end
%...
%...  RIGHT END POINT
      ux(n)=r2fdx*...
      (      1.   *u(n-2)     -4.   *u(n-1)     +3.   *u(  n));
