function [sp] = update_seg(lab_image_gpu, sp, params, gpu_helper, option,...
                kernel_find_border, kernel_update_seg_subset)

    for iter = 1:option.nInnerIters
            for xmod3 = 0:2
                for ymod3 = 0:2
                    %find the border pixels
                    [~, sp.border_gpu] = feval(kernel_find_border, sp.seg_gpu, sp.border_gpu, sp.nPts, sp.dimy, sp.dimx, 0);
                    
                    [~, sp.seg_gpu] = feval( kernel_update_seg_subset,...
                        lab_image_gpu, sp.seg_gpu, sp.border_gpu,...
                        params.counts_gpu, gpu_helper.log_count, ...
                        params.mu_i_gpu,  params.mu_s_gpu, ...
                        params.J_i_gpu, params.J_s_gpu, ...
                        params.logdet_Sigma_i_gpu, params.logdet_Sigma_s_gpu,...  
                        sp.nPts, sp.dimy, sp.dimx, xmod3, ymod3, sp.nSps, ...
                        option.calc_cov, option.s_std, option.i_std, option.prior_prob_weight);
                  
                end
            end
    end
    
end
