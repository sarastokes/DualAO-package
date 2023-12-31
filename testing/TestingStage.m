


allMonitors = stage.core.Monitor.availableMonitors();

monitor = allMonitors{2};
window = stage.core.Window([1920 1080], true, monitor, 'RefreshRate', 120);

canvas = stage.core.Canvas(window, 'disableDwm', false);

% Create the background (leave some edges to check sizing)
rect = stage.builtin.stimuli.Rectangle();
rect.position = floor([canvas.width, canvas.height] / 2);
rect.size = ceil(0.9 * [canvas.width, canvas.height]);
rect.color = [0.15 0.15 0.15];

% Create a simple spot stimulus
bar = stage.builtin.stimuli.Rectangle();
bar.size = [250 50];
bar.color = [1 0 0];
bar.position = floor([canvas.width, canvas.height] / 2);

orientationController = stage.builtin.controllers.PropertyController(bar, ...
    'orientation', @(state)state.time * 180);

            spotVisible = stage.builtin.controllers.PropertyController(spot, 'visible', ...
                @(state)state.time >= preTime * 1e-3 && state.time < (preTime + stimTime) * 1e-3);

% Assemble the presentation
presentation = stage.core.Presentation(preTime+stimTime+tailTime);
presentation.addStimulus(rect);
presentation.addStimulus(bar);
presentation.addController(orientationController);

% Play the stimulus
presentation.play(canvas);

clear all