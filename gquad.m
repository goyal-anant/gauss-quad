function I = gquad(f,x_1,x_N)
    %this method works fine when the integral limits follows |x_N - x_1| = 1
    %to find the nodes i.e. x_i
    %assuming N point GQ
    N = 8;
    syms x
    LegPol  = legendreP(N,x);
    nodes   = vpasolve(LegPol == 0);
    
    %to get the function to be integrated and the limits
    %f = @(x) x;
    %x_1 = 0;
    %x_N = 1;
    
    %to find L_i(x) i.e. lagrange polynomial
    L = (x^0) * ones(N,1);
    for i = 1 : N
        for j = 1 : N
            if i ~= j
                L(i) = L(i) * ((x - nodes(j))/(nodes(i) - nodes(j)));
            end
        end
    end
    
    %to find the weights i.e. w_i = \int_{x_1}^{x_N} L_i(x) dx
    for i = 1 : N
        w(i) = integral(matlabFunction(L(i)), x_1, x_N);
    end
    
    %to find the integral
    I = 0;
    for i = 1 : N
        I = I + (f(nodes(i)) * w(i));
    end
end
