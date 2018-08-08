function trace = read_trace(fieldFox,t)
    fprintf(fieldFox,'SWE:POIN?');
    n = str2double(fscanf(fieldFox));
    fprintf(fieldFox,['TRAC',t,':DATA?']);
    trace = strsplit(fscanf(fieldFox),',');
    for i = 1:n
        trace{i} = str2double(trace{i});
    end
    trace = cell2mat(trace);
end