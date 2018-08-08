function save_screen(fieldFox,path)
    if nargin == 1
        path = '';
    end
    if size(path,2)
        path = [path,'\'];
    end
    time = get_time;
    fprintf(fieldFox, ['MMEM:STOR:IMAG "',time,'.png"']);
    fprintf(fieldFox, ['MMEM:DATA? "',time,'.png"']);
    img = binblockread(fieldFox,'uint8');
    fread(fieldFox,1);
    fid = fopen([path,time,'.png'],'w');
    fwrite(fid,img,'uint8');
    fclose(fid);
    fprintf(fieldFox, ['MMEM:DEL "',time,'.png"']);