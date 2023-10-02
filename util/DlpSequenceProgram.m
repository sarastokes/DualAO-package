classdef DlpSequenceProgram < double

    enumeration
        NORMAL          (0)         % Default
        RB3D            (1)
        QUAD4X          (2)
        PRG240          (3)
        RGB180          (4)
        QUAD12X         (5)
        RGB             (6)
        RGB2            (7)
        GREY3X          (9)
        GREY720         (10)
    end

    methods
        function out = getFrameSize(obj)
            switch obj
                case DlpSequenceProgram.NORMAL
                    out = [1920 1080 3];
                case DlpSequenceProgram.QUAD4X
                    out = [960 540 3];   % from [1920 1080 3]
                case DlpSequenceProgram.QUAD12X
                    out = [960 540 1];   % from [1920 1080 3]
                case DlpSequenceProgram.GREY720
                    out = [1280 720 1];  % from [1280 720 3]
            end
        end
    end
    methods (Static)
        function obj = init(input)
            if isnumeric(input)
                obj = DlpSequencePrograms(input);
            else
                obj = DlpSequencePrograms.(upper(input));
            end
        end
    end
end