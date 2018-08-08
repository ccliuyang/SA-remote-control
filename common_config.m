function common_config(fieldFox)
    fprintf(fieldFox,'DISP:WIND:TRAC1:Y:RLEV -10');
    fprintf(fieldFox,'POW:ATT 0');
    fprintf(fieldFox,'BAND:AUTO 1');
    fprintf(fieldFox,'BAND:VID:AUTO 1');
    fprintf(fieldFox,'AVER:TYPE POW');
    fprintf(fieldFox,'AVER:COUN 10000');
    fprintf(fieldFox,'TRAC1:TYPE MAXH');
    fprintf(fieldFox,'TRAC2:TYPE AVG');
end