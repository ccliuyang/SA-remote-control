function time = get_time
    clear month second;
    m = num2str(month(now));
    if size(m,2) == 1
        m = ['0',m];
    end
    d = num2str(day(now));
    if size(d,2) == 1
        d = ['0',d];
    end
    h = num2str(hour(now));
    if size(h,2) == 1
        h = ['0',h];
    end
    min = num2str(minute(now));
    if size(min,2) == 1
        min = ['0',min];
    end
    s = num2str(round(second(now)));
    if size(s,2) == 1
        s = ['0',s];
    end
    time = [num2str(year(now)),m,d,h,min,s];
end