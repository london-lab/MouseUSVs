function entropy = calculate_entropy(vals)
    vals = vals/sum(vals);
    entropy = 0;
    for val = vals
        entropy = entropy - val * log2(val);
    end
end