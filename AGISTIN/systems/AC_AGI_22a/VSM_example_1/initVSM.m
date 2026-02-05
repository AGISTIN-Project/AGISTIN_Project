function VSM = initVSM
VSM.Ta  = 10;   % Ta    Time required to spin up in [s]
VSM.kpf = 10;   % kpf = deltaP/deltaf  in  [pu/pu]       (reasonable: 2.5)
VSM.kdf = 0.2;  % kdf = deltaPhi/deltaf in [rad/(rad/s)]
VSM.f0  = 50;   % f0  = nominal frequency  [Hz]
VSM.ku  = 0.1;  % ku  = deltaU/deltaQ  in  [pu/pu]
VSM.Tu  = 1;    % time constant of Q/U-loop (AVR equivalent Time Constant)
end
