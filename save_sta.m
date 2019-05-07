function save_sta(fieldFox,path)
    if nargin == 1
        path = '';
    end
    if size(path,2)
        path = [path,'\'];
    end
    time = get_time;
    fprintf(fieldFox, ['MMEM:STOR:STAT "',time,'.sta"']);
    fprintf(fieldFox, ['MMEM:DATA? "',time,'.sta"']);
    sta = binblockread(fieldFox,'uint8');
    fread(fieldFox,1);
    fid = fopen([path,time,'.sta'],'w');
    fwrite(fid,sta,'uint8');
    fclose(fid);
    fprintf(fieldFox, ['MMEM:DEL "',time,'.sta"']);