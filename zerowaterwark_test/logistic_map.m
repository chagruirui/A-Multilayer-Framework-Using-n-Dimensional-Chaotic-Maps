function seq = logistic_map(x0, r, N)
    seq = zeros(1, N);
    seq(1) = x0;
    for i = 2:N
        seq(i) = r * seq(i-1) * (1 - seq(i-1));
    end
end