function result_distance = gpu_calculate_distance(first_el, second_el)
    gpu_first_el = gpuArray(first_el);
    gpu_second_el = gpuArray(second_el);
    gpu_result_distance = pdist2( gpu_first_el, gpu_second_el, 'cosine');
    result_distance = gather(gpu_result_distance);
end