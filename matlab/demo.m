%% user inputs here
nPixels_in_square_side = 15;
i_std = 20;
img_name = fullfile('image', '2.jpg');

disp(img_name);

image = imread(img_name);

%% initialize
addpath('gpu');
addpath('ptx');
disp('initialize superpixels...')
[dimy, dimx, ~] = size(image);
[sp, params, gpu_helper, option] = init_sp(dimx, dimy, nPixels_in_square_side, i_std);

disp(strcat('dimx: ', num2str(dimx)));
disp(strcat('dimy: ', num2str(dimy)));
disp(strcat('i_std: ', num2str(i_std)));
disp(strcat('nPixels_in_square_side: ', num2str(nPixels_in_square_side)));
disp(strcat('number of superpixels: ', num2str(sp.nSps)));


% load the cuda kernels
[kernel_lab_to_rgb, kernel_rgb_to_lab, kernel_find_border,...
    kernel_clear_fields, kernel_sum_by_label, kernel_calculate_mu_and_sigma,...
    kernel_clear_fields2, kernel_sum_by_label2, kernel_calculate_mu,...
    kernel_update_seg_subset, kernel_get_cartoon]...
        = load_all_kernels(sp.nSps, sp.threads_per_block, sp.block, sp.grid);

% init image   
image_gpu = gpuArray(double(image));
image_gpu = reshape(permute(image_gpu,[3,1,2]), [] ,1);
lab_image_gpu = feval(kernel_rgb_to_lab,image_gpu,sp.nPts);

disp('start segmentation ...')
tic;
%% calculate superpixels
for i = 1 : option.nEMIters
    % update superpixel params
    [sp, params] = update_param(lab_image_gpu, option,params, gpu_helper,...
                                    sp,...
                                    kernel_clear_fields, kernel_sum_by_label,kernel_calculate_mu_and_sigma, ...
                                    kernel_clear_fields2, kernel_sum_by_label2, kernel_calculate_mu);
    
    % update pixel segmentation    
    sp = update_seg(lab_image_gpu, sp, params, gpu_helper, option,...
                         kernel_find_border, kernel_update_seg_subset);             
end

[~, sp.border_gpu] = feval(kernel_find_border, sp.seg_gpu, sp.border_gpu, sp.nPts, dimy, dimx, 1);

disp('finish segmentation'); 
toc;
%% save results
% you could do gather(gpu_var) to get the value of cpu variable
% get image_border
image_border = get_img_border (sp, image);
image_border_filename = fullfile('image', 'result','image_border.png');
imwrite(image_border, image_border_filename);
disp(strcat(['saved ', image_border_filename]));

% get image_overlaid
image_overlaid = get_img_overlaid(sp, params,kernel_lab_to_rgb,kernel_get_cartoon);
image_overlaid_filename = fullfile('image', 'result','image_overlaid.png');
imwrite(image_overlaid, image_overlaid_filename);
disp(strcat(['saved ', image_overlaid_filename]));

% display
figure(1)
clf
subplot(131)
imshow(image)
subplot(132)
imshow(image_border)
subplot(133)
imshow(image_overlaid)


