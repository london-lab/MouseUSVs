function entropy_rate = calculate_entropy_rate(vals, leaves, Nc)
    vals = vals/sum(vals);
    entropy_rate = 0;
    ind = 1;
    for leaf = leaves
        transitions = vals((ind-1)*Nc + 1 : ind*Nc);
        transitions = transitions / sum(transitions);
        for transition = transitions
            if(transition > 0)
                entropy_rate = entropy_rate - leaf*(transition*log2(transition));
            end
        end
        ind = ind + 1;
    end
end