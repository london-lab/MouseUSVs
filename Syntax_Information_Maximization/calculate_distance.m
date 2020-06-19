function result_distance = calculate_distance(first_el, second_el)
%     result_distance = gpu_calculate_distance(first_el, second_el);
    result_distance = pdist2( first_el, second_el, 'cosine');
end