function E = dBm2E(dBm)
    P_W = 10.^(-3+dBm/10);
    U_V = sqrt(P_W*50);
    U_dBuV = 20*log10(U_V*10^6);
    E_dBuVpm = U_dBuV + 28 + 3;
    E = 10.^(-6+E_dBuVpm/20);
end