function save_data(fieldFox,path)
    if nargin == 1
        path = '';
    end
    if size(path,2)
        path = [path,'\'];
    end
    time = get_time;
    fprintf(fieldFox, ['MMEM:STOR:FDAT "',time,'.csv"']);
    fprintf(fieldFox, ['MMEM:DATA? "',time,'.csv"']);
    csv = binblockread(fieldFox,'uint8');
    fread(fieldFox,1);
    fid = fopen([path,time,'.csv'],'w');
    fwrite(fid,csv,'uint8');
    fclose(fid);
    fprintf(fieldFox, ['MMEM:DEL "',time,'.csv"']);