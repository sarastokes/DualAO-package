classdef TestRig < symphonyui.core.descriptions.RigDescription


    methods
        function obj = TestRig()
            import symphonyui.builtin.daqs.*;

            daq = NiSimulationDaqController();
            obj.daqController = daq;
            stage = io.github.stage_vss.devices.StageDevice('localhost');
            obj.addDevice(stage);

        end
    end
end