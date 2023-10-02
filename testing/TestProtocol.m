classdef TestProtocol < symphonyui.core.Protocol

    properties
        preTime = 5000
        stimTime = 30000
        tailTime = 10000
        spotIntensity = 1.0
        spotDiameter = 300
        backgroundIntensity = 0.5
        numberOfAverages = uint16(1)
        interpulseInterval = 0
    end

    properties (Hidden, SetAccess = private)
        waitingForHardwareToStart
    end

    methods
        function didSetRig(obj)
            didSetRig@symphonyui.core.Protocol(obj);
        end

        function p = getPreview(obj, panel)
            if isempty(obj.rig.getDevices('Stage'))
                p = [];
                return;
            end
            p = io.github.stage_vss.previews.StagePreview(panel, @()obj.createPresentation(), ...
                'windowSize', obj.rig.getDevice('Stage').getCanvasSize());
        end

        function prepareRun(obj)
            prepareRun@symphonyui.core.Protocol(obj);
        end

        function p = createPresentation(obj)
            device = obj.rig.getDevice('Stage');
            canvasSize = device.getCanvasSize();

            p = stage.core.Presentation((obj.preTime + obj.stimTime + obj.tailTime) * 1e-3);
            p.setBackgroundColor(obj.backgroundIntensity);

            spot = stage.builtin.stimuli.Ellipse();
            spot.color = obj.spotIntensity;
            spot.radiusX = obj.spotDiameter;
            spot.radiusY = obj.spotDiameter;
            spot.position = canvasSize/2;
            p.addStimulus(spot);

            spotVisible = stage.builtin.controllers.PropertyController(spot, 'visible', ...
                @(state)state.time >= obj.preTime * 1e-3 && state.time < (obj.preTime + obj.stimTime) * 1e-3);
            p.addController(spotVisible);
        end

        function prepareEpoch(obj, epoch)
            prepareEpoch@symphonyui.core.Protocol(obj);

            obj.waitingForHardwareToStart = true;
            epoch.shouldWaitForTrigger = false;
        end

        function controllerDidStartHardware(obj)
            controllerDidStartHardware@symphonyui.core.Protocol(obj);

            if obj.waitingForHardwareToStart
                obj.waitingForHardwareToStart = false;
                % Error wrapping (from sa_labs StageProtocol with thanks)
                try
                    p = obj.createPresentation();
                catch ME
                    disp(getReport(ME));
                    rethrow(ME);
                end
                if obj.numEpochsPrepared == 1
                    obj.rig.getDevice('Stage').play(p);
                else
                    obj.rig.getDevice('Stage').replay();
                end
            end
        end

        function completeEpoch(obj, epoch)
            completeEpoch@symphonyui.core.Protocol(obj, epoch)

            epoch.addParameter('test', sprintf('This was epoch %u', obj.numEpochsCompleted));
        end

        function completeRun(obj)
            completeRun@symphonyui.core.Protocol(obj);

            obj.rig.getDevice('Stage').clearMemory();
        end

        function tf = shouldContinuePreparingEpochs(obj)
            tf = obj.numEpochsPrepared < obj.numberOfAverages;
        end

        function tf = shouldContinueRun(obj)
            tf = obj.numEpochsCompleted < obj.numberOfAverages;
        end

        function [tf, msg] = isValid(obj)
            [tf, msg] = isValid@symphonyui.core.Protocol(obj);

            if tf
                tf = ~isempty(obj.rig.getDevice('Stage'));
                msg = 'No stage';
            end
        end
    end
end