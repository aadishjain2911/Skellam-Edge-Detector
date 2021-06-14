function [I_A] = get_Ia(u1 ,u2, alpha)
    % Takes the skellam parameters as input and gives the intensity
    % acceptance value as output
    diff = -255:1:255;
    M = 256;
    p = zeros(size(diff));
    
    N = size(u1, 1) ;
    I_A = ones(N, 1) ;
    
    for j = 1:N
        % calculating the noise distribution using the skellam paramaters
        bessel = bsxfun(@besseli,abs(diff),2*sqrt(u1(j)*u2(j)));
        p = exp(-u1(j)-u2(j))*(u1(j)/u2(j)).^(diff/2).*bessel;

        % F is analogous to the cdf of noise distribution
        F = cumsum(p);
        for i = 1:M-1
            if (F(M+i) - F(M-i) < alpha)
                % intensity acceptance denotes the maximum intensity
                % difference with probability of occurrence alpha
                I_A(j) = diff(M+i);
            end
        end
    end
end