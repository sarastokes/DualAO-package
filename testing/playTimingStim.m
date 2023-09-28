

% Set the preTime and tailTime to 0 to have the stimulus stay on
% indefinitely after the run. Also comment 
preTime = 1; 
stimTime = 3;  % Change this to modulate stimulus time. 
tailTime = 1;
allMonitors = stage.core.Monitor.availableMonitors();

monitor = allMonitors{2};
window = stage.core.Window([1920 1080], true, monitor, 'RefreshRate', 120);

canvas = stage.core.Canvas(window, 'disableDwm', false);

% Create the background (leave some edges to check sizing)
rect = stage.builtin.stimuli.Rectangle();
rect.position = floor([canvas.width, canvas.height] / 2);
rect.size = ceil(0.9 * [canvas.width, canvas.height]);
rect.color = [0.5 0.5 0.5];

% Create a simple spot stimulus
bar = stage.builtin.stimuli.Rectangle();
bar.size = [250 50];
bar.position = floor([canvas.width, canvas.height] / 2);
bar.color = [1 0 0];

spotVisible = stage.builtin.controllers.PropertyController(bar, 'visible', ...
    @(state)state.time >= preTime && state.time < (preTime + stimTime));

% Assemble the presentation
presentation = stage.core.Presentation(preTime+stimTime+tailTime);
presentation.addStimulus(rect);
presentation.addStimulus(bar);
presentation.addController(spotVisible);

% Play the stimulus
presentation.play(canvas);
