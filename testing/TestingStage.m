


allMonitors = stage.core.Monitor.availableMonitors()

monitor = stage.core.Monitor(1);
window = stage.core.Window([1080 1080], false, monitor, 'RefreshRate', 120);

canvas = stage.core.Canvas(window, 'disableDwm', false);

% Create the background (leave some edges to check sizing)
rect = stage.builtin.stimuli.Rectangle();
rect.position = floor([canvas.height, canvas.width] / 2);
rect.size = ceil(0.9 * [canvas.height, canvas.width]);
rect.color = [0.15 0.15 0.15];

% Create a simple spot stimulus
spot = stage.builtin.stimuli.Ellipse();
spot.radiusX = 250;
spot.color = [1 0 0];

% Assemble the presentation
presentation = stage.core.Presentation(10);
presentation.addStimulus(rect);
presentation.addStimulus(spot);

% Play the stimulus
presentation.play(canvas);
