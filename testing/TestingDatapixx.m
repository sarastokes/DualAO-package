

isOpen = Datapixx('Open');
isReady = Datapixx('IsReady');


systemCmds = {'IsDatapixx', 'IsDatapixx2', 'IsDatapixx3',...
    'IsViewpixx', 'IsViewpixx3D', 'IsPropixxCtrl',...
    'IsPropixx',  'IsTrackpixx'};
tf = zeros(1, numel(systemCmds));
for i = 1:numel(systemCmds)
    tf(i) = Datapixx(systemCmds{i});
    fprintf('%s: %u\n', systemCmds{i}, double(tf(i)));
end


% Query some info
timeStamp0 = datetime('now');
timeStamp = Datapixx('GetTime');
tempFarenheit = Datapixx('GetTempFarenheit');
ramSize = Datapixx('GetRamSize');


isAwake = Datapixx('IsPropixxAwake');
Datapixx('SetPropixxAwake');
Datapixx('SetPropixxSleep');


Datapixx('SetPropixxLedIntensity');
