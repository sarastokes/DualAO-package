# DualAO-package

Work-in-progress development of Symphony/Stage compatibility with AO systems.

Starting with new Dual AO which really needs help with stimuli. Communication and synchronization is required between to separate adaptive optics arms:
- Scanning laser Ophthalmoscope (SLO): reflectance and fluorescence imaging w/ online eyetracking
- Flood: visual stimulus presentation with ProPixx

To Do List:
- DAQ/communication for "high level" control of experimental devices (stimuli, frame monitor, etc) separate from the FPGA pipeline
- Synchronize stimulus start/stop on Flood with data acquision on SLO
- Need to adjust standard Symphony protocol runs to provide the option to control when next Epoch is presented in case we need to adjust AO, FOV, pupil, stabilization, etc

Directly controlled by Symphony/Stage:
- Propixx
- Future possibilities: Frame monitor, power meter, neutral density filter wheel

Indirectly control through servers:
- SLO software. Definitely want start/stop acquisition and isStarted. Full setup would include laser powers, external shutters, PMT gains, FOV
- AO software (defocus, close/open loop, reset)
- Thorlabs motors (PMT Z, PMT Y, PMT X and source position). Potential to delegate full control to Symphony pending Keith's development.

More in planning folder.