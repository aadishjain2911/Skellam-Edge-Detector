function [ mu_s, var_s] = get_mu_s(patch)
    % Takes a patch of the image as input and gives the statistics of the
    % corresponding skellam distribution
    displacement = 1; 
    direction = 2;
    
    patch_shifted_x = circshift(patch, displacement, direction);
    
    % calculating the derivative for the whole patch
    d_x = patch(:,displacement+1:end) - patch_shifted_x(:,displacement+1:end) ;
        
    % derivative statistics for the patch
    mu_s = mean(d_x(:));
    var_s = var(double(d_x(:)));
end