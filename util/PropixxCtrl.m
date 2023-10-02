classdef PropixxCtrl < handle
% Wrapper for Datapixx interface
% Up to 12 bits of RGB intensity, Up to 480 Hz refresh rate with color and
% 1440 Hz grayscale.

    properties (SetAccess = private)
        refreshRate
        dlpSequenceProgram          DlpSequenceProgram
    end

    properties (Constant)
        NATIVE_RESOLUTION = [1920 1080]
        MIN_PATTERN_BIT_DEPTH = 1
        MAX_PATTERN_BIT_DEPTH = 8
    end

    methods
        function obj = PropixxCtrl(refreshRate)
            obj.refreshRate = refreshRate;
        end

        function delete(obj)
            obj.disconnect();
        end

        function connect(obj)
            if ~Datapixx('IsReady')
                Datapixx('Open');
            end
            if ~Datapixx('IsPropixxAwake')
                Datapixx('SetPropixxAwake');
            elseif ~Datapixx('IsReady')
                error('Failed to connect to the Datapixx');
            end
            if ~Datapixx('IsPropixxAwake')
                error('Failed to wake up the Datapixx');
            end
        end

        function disconnect(obj)
            Datapixx('Close');
            assert(~Datapixx('IsReady'), 'Failed to disconnect from the Datapixx');
        end
    end

    methods
        function setDlpSequenceProgram(obj, programID)
            % For more documentation:
            %   Datapixx SetPropixxDlpSequenceProgram?

            arguments
                obj
                programID   (1,1)   DlpSequenceProgram
            end

            Datapixx('SetPropixxDlpSequenceProgram', double(programID));
            obj.dlpSequenceProgram = programID;
        end
    end
end