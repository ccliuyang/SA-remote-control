fieldFox = connect('192.168.1.105');
pause(20);
common_config(fieldFox);
fprintf(fieldFox,'FREQ:CENT 2412E6');
fprintf(fieldFox,'FREQ:SPAN 20E6');
for i = 1:144
    fprintf(fieldFox,'INIT:REST');
    pause(360);
    save_data(fieldFox);
    pause(240);
end