function disconnect(fieldFox)
    fclose(fieldFox);
    delete(fieldFox);
    clear fieldFox;
end