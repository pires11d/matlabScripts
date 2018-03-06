%  File: dss046.m
%
   function [uxx]=dss046(xl,xu,n,u,ux,nl,nu)
%
%  Function dss046 computes a sixth-order approximation of a
%  second-order derivative, with or without the normal derivative
%  at the boundary.
%
%  Argument list
%
%     xl      Left value of the spatial independent variable (input)
%
%     xu      Right value of the spatial independent variable (input)
%
%     n       Number of spatial grid points, including the end
%             points (input)
%
%     u       One-dimensional array of the dependent variable to be
%             differentiated (input)
%
%     ux      One-dimensional array of the first derivative of u.
%             The end values of ux, ux(1) and ux(n), are used in
%             Neumann boundary conditions at x = xl and x = xu,
%             depending on the arguments nl and nu (see the de-
%             scription of nl and nu below)
%
%     uxx     One-dimensional array of the second derivative of u
%             (output)
%
%     nl      Integer index for the type of boundary condition at
%             x = xl (input).  The allowable values are
%
%                1 - Dirichlet boundary condition at x = xl
%                    (ux(1) is not used)
%
%                2 - Neumann boundary condition at x = xl
%                    (ux(1) is used)
%
%     nu      Integer index for the type of boundary condition at
%             x = xu (input).  The allowable values are
%
%                1 - Dirichlet boundary condition at x = xu
%                    (ux(n) is not used)
%
%                2 - Neumann boundary condition at x = xu
%                    (ux(n) is used)
%
%  The following sixth-order, eight-point approximations for a
%  second derivative can be used at the boundaries of a spatial
%  domain.  These approximations have the features
%
%     (1)  Only interior and boundary points are used (i.e., no
%          fictitious points are used)
%
%     (2)  The normal derivative at the boundary is included as part
%          of the approximation for the second derivative
%
%     (3)  Approximations for the boundary conditions are not used.
%
%  Weighting coefficients for finite difference approximations, computed
%  by an algorithm of B. Fornberg (1), are used in the following approxi-
%  mations.  The combination of these coefficients to give the second
%  derivative approximations at the boundaries in x, including the first
%  derivative, was suggested by Professor Fornberg.
%
%  (1)  Fornberg, B., Fast Generation of Weights in Finite Difference
%       Formulas, In Recent Developments in Numerical Methods and
%       Software for ODEs/DAEs/PDEs, G. Byrne and W. E. Schiesser (eds), 
%       World Scientific, River Edge, NJ, 1992
%
%  Grid spacing
   dx=(xu-xl)/(n-1);
   rdxs=1.0/dx^2;
%
%  uxx at the left boundary
%
%     Without ux
         if nl==1
         uxx(1)=rdxs*...
               (  5.211111111111110*u(1)...
                -22.300000000000000*u(2)...
                +43.950000000000000*u(3)...
                -52.722222222222200*u(4)...
                +41.000000000000000*u(5)...
                -20.100000000000000*u(6)...
                 +5.661111111111110*u(7)...
                 -0.700000000000000*u(8));
%
%     With ux
         elseif nl==2
         uxx(1)=rdxs*...
               ( -7.493888888888860*u(1)...
                +12.000000000000000*u(2)...
                 -7.499999999999940*u(3)...
                 +4.444444444444570*u(4)...
                 -1.874999999999960*u(5)...
                 +0.479999999999979*u(6)...
                 -0.055555555555568*u(7)...
                 -4.900000000000000*ux(1)*dx);
         end
%
%  uxx at the right boundary
%
%     Without ux
         if nu==1
         uxx(n)=rdxs*...
               (  5.211111111111110*u(n  )...
                -22.300000000000000*u(n-1)...
                +43.950000000000000*u(n-2)...
                -52.722222222222200*u(n-3)...
                +41.000000000000000*u(n-4)...
                -20.100000000000000*u(n-5)...
                 +5.661111111111110*u(n-6)...
                 -0.700000000000000*u(n-7));
%
%     With ux
         elseif nu==2
         uxx(n)=rdxs*...
               ( -7.493888888888860*u(n  )...
                +12.000000000000000*u(n-1)...
                 -7.499999999999940*u(n-2)...
                 +4.444444444444570*u(n-3)...
                 -1.874999999999960*u(n-4)...
                 +0.479999999999979*u(n-5)...
                 -0.055555555555568*u(n-6)...
                 +4.900000000000000*ux(n)*dx);
         end
%
%  uxx at the interior grid points
%
%     i = 2
         uxx(2)=rdxs*...
               (  0.700000000000000*u(1)...
                 -0.388888888888889*u(2)...
                 -2.700000000000000*u(3)...
                 +4.750000000000000*u(4)...
                 -3.722222222222220*u(5)...
                 +1.800000000000000*u(6)...
                 -0.500000000000000*u(7)...
                 +0.061111111111111*u(8));
%
%     i = 3
          uxx(3)=rdxs*...
               ( -0.061111111111111*u(1)...
                 +1.188888888888890*u(2)...
                 -2.100000000000000*u(3)...
                 +0.722222222222223*u(4)...
                 +0.472222222222222*u(5)...
                 -0.300000000000000*u(6)...
                 +0.088888888888889*u(7)...
                 -0.011111111111111*u(8));
%
%     i = n-1
         uxx(n-1)=rdxs*...
               (  0.700000000000000*u(n)...
                 -0.388888888888889*u(n-1)...
                 -2.700000000000000*u(n-2)...
                 +4.750000000000000*u(n-3)...
                 -3.722222222222220*u(n-4)...
                 +1.800000000000000*u(n-5)...
                 -0.500000000000000*u(n-6)...
                 +0.061111111111111*u(n-7));
%
%     i = n-2
         uxx(n-2)=rdxs*...
               ( -0.061111111111111*u(n  )...
                 +1.188888888888890*u(n-1)...
                 -2.100000000000000*u(n-2)...
                 +0.722222222222223*u(n-3)...
                 +0.472222222222222*u(n-4)...
                 -0.300000000000000*u(n-5)...
                 +0.088888888888889*u(n-6)...
                 -0.011111111111111*u(n-7));
%
%     i = 4, 5, ..., n-3
         for i=4:n-3
         uxx(i)=rdxs*...
               (  0.011111111111111*u(i-3)...
                 -0.150000000000000*u(i-2)...
                 +1.500000000000000*u(i-1)...
                 -2.722222222222220*u(i  )...
                 +1.500000000000000*u(i+1)...
                 -0.150000000000000*u(i+2)...
                 +0.011111111111111*u(i+3));
         end
