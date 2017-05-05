function ac = accuracy(class,te_index)
    temp = class-te_index;
    len = size(te_index,2);
    correct = length(find(temp==0));
    ac = correct / len;
end