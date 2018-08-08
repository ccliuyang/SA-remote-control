function time = get_time
    clear month second;
    m = num2str(month(now));
    if size(m,2) == 1
        m = ['0',m];
    end
    s = num2str(round(second(now)));
    if size(s,2) == 1
        s = ['0',s];
    end
    time = [num2str(year(now)),m,num2str(day(now)),num2str(hour(now)),num2str(minute(now)),s];
end