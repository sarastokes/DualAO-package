
allMonitors = stage.core.Monitor.availableMonitors();
monitor = allMonitors{2};
window = stage.core.Window([1920 1080], true, monitor, 'RefreshRate', 120);
canvas = stage.core.Canvas(window, 'disableDwm', false);

% Create the background
rect = stage.builtin.stimuli.Rectangle();
rect.position = floor([canvas.width, canvas.height] / 2);
rect.size = [canvas.width, canvas.height];
rect.color = [0.5 0.5 0.5];

% Create a crosshair
vBar = stage.builtin.stimuli.Rectangle();
vBar.size = [500 50];
vBar.position = floor([canvas.width, canvas.height] / 2);
vBar.color = [1 0 0];

hBar = stage.builtin.stimuli.Rectangle();
hBar.size = [500 50];
hBar.position = floor([canvas.width, canvas.height] / 2);
hBar.color = [1 0 0];

% Assemble the presentation
presentation = stage.core.Presentation(10);
presentation.addStimulus(rect);
presentation.addStimulus(hBar);
presentation.addStimulus(vBar);

% Play the presentation (and keep stim up indefinitely afterwards)
presentation.play(canvas);