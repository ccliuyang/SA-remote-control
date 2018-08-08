function fieldFox = connect(ip)
    if nargin == 0
        ip = '192.168.1.105';
    end
    instrreset;
    oldobjs = instrfind;
    if (~isempty(oldobjs))
        fclose(oldobjs);
        delete(oldobjs);
    end
    clear oldobjs;
    %fieldFox = visa('agilent', 'TCPIP0::192.168.1.105::inst0::INSTR');
    fieldFox = tcpip(ip,5025);
    set(fieldFox,'InputBufferSize', 640000);
    set(fieldFox,'OutputBufferSize', 640000);
    fopen(fieldFox);
    fprintf(fieldFox, '*CLS');
    fprintf(fieldFox,'INST "SA"');
end