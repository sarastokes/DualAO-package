classdef TestPropixxDevice < symphonyui.core.Device

    properties (Access = private, Transient)
        stageClient
        propixxCtrl
    end

    properties
        useFrameTracker = false
    end

    methods
        function obj = TestPropixxDevice(varargin)

            ip = inputParser();
            addParameter(ip, 'host', 'localhost', @ischar);
            addParameter(ip, 'port', 5678, @isnumeric);
            addParameter(ip, 'frameTracker', false, @islogical);
            parse(ip, varargin{:});

            cobj = Symphony.Core.UnitConvertingExternalDevice(...
                ['Propixx@' ip.Results.host], 'VPixx',...
                Symphony.Core.Measurement(0, symphonyui.core.Measurement.UNITLESS));
            obj@symphonyui.core.Device(cobj);
            obj.cobj.MeasurementConversionTarget = symphonyui.core.Measurement.UNITLESS;

            obj.useFrameTracker = ip.Results.frameTracker;

            obj.propixxCtrl = PropixxCtrl(120);

            obj.stageClient = stage.core.network.StageClient();
            obj.stageClient.connect(ip.Results.host, ip.Results.port);

            refreshRate = obj.stageClient.getMonitorRefreshRate();
            obj.addConfigurationSetting('refreshRate', refreshRate, 'isReadOnly', true);

            canvasSize = obj.stageClient.getCanvasSize();
            obj.addConfigurationSetting('canvasSize', canvasSize, 'isReadOnly', true);

            obj.addConfigurationSetting('prerender', false, 'isReadOnly', true);

        end
    end

    methods
        function play(obj, presentation)
            canvasSize = obj.getCanvasSize();
            centerOffset = obj.getCenterOffset();

            background = stage.builtin.stimuli.Rectangle();
            background.size = obj.canvasSize;
            background.position = canvasSize/2 - centerOffset;
            background.color = presentation.backgroundColor;
            presentation.setBackgroundColor(0);
            presentation.insertStimulus(1, background);

            % Do we want a pick off mirror and frame tracker?
            if obj.useFrameTracker
                tracker = stage.builtin.stimuli.Rectangle();
                tracker.size = floor([0.1 * canvasSize(1), canvasSize(2)]);
                tracker.position = [canvasSize(1) - 0.05 * canvasSize(1), canvasSize(2)/2];
                presentation.addStimulus(tracker);

                trackerColor = stage.builtin.controllers.PropertyController(...
                    tracker, 'color', ...
                @(s)mod(s.frame, 2) && double(s.time + (1/s.frameRate) < presentation.duration));
                presentation.addController(trackerColor);
            end

            if obj.getPrerender
                player = stage.builtin.players.PrerenderedPlayer(presentation);
            else
                player = stage.builtin.players.RealtimePlayer(presentation);
            end
            player.setCompositor(stage.builtin.compositors.PatternCompositor());
            obj.stageClient.play(player);
        end

        function setMonitorGammaRamp(obj, r, g, b)
            obj.stageClient.setMonitorGammaRamp(r, g, b);
        end

        function out = getCanvasSize(obj)
            out = obj.getConfigurationSetting('canvasSize');
        end

        function r = getMonitorRefreshRate(obj)
            r = obj.getConfigurationSetting('monitorRefreshRate');
        end

        function tf = getPrerender(obj)
            tf = obj.getConfigurationSetting('prerender');
        end

        function o = getCenterOffset(obj)
            o = obj.getConfigurationSetting('centerOffset');
        end

        function replay(obj)
            obj.stageClient.replay();
        end

        function i = getPlayInfo(obj)
            i = obj.stageClient.getPlayInfo();
        end

        function clearMemory(obj)
           obj.stageClient.clearMemory();
        end

        function v = getConfigurationSetting(obj, name)
            % TODO: This is a faster version of Device.getConfigurationSetting(). It should be moved to Device.

            v = obj.tryCoreWithReturn(@()obj.cobj.Configuration.Item(name));
            v = obj.valueFromPropertyValue(obj.convert(v));
        end

    end

    methods (Static)
        function v = convert(dotNetValue)
            % TODO: Remove when getConfigurationSetting() is removed from this class.

            v = dotNetValue;
            if ~isa(v, 'System.Object')
                return;
            end

            clazz = strtok(class(dotNetValue), '[');
            switch clazz
                case 'System.Int16'
                    v = int16(v);
                case 'System.UInt16'
                    v = uint16(v);
                case 'System.Int32'
                    v = int32(v);
                case 'System.UInt32'
                    v = uint32(v);
                case 'System.Int64'
                    v = int64(v);
                case 'System.UInt64'
                    v = uint64(v);
                case 'System.Single'
                    v = single(v);
                case 'System.Double'
                    v = double(v);
                case 'System.Boolean'
                    v = logical(v);
                case 'System.Byte'
                    v = uint8(v);
                case {'System.Char', 'System.String'}
                    v = char(v);
            end
        end
    end
end
