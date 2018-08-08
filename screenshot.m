function screenshot(fieldFox)
    fprintf(fieldFox, 'MMEM:STOR:IMAG "temp.png"');
    fprintf(fieldFox, 'MMEM:DATA? "temp.png"');
    img = binblockread(fieldFox,'uint8');
    fread(fieldFox,1);
    fid = fopen('temp.png','w');
    fwrite(fid,img,'uint8');
    fclose(fid);
    fprintf(fieldFox, 'MMEM:DEL "temp.png"');