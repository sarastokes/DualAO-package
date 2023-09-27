
In order of priority and programming effort/QoL benefit ratio. Italics show things that are less essential but might as well at some point.

>**VPixxModule**
- CenterOffset
- StimulusSize (subset of canvasSize which is 2.5x2.5 degrees)
- Voltages
- External shutter?
- *Spectra and powers*

>**MotorModule**: Interface to motors. A simplified version of the APT control.
- TopticaPosition
- MustangPosition
- FluorescenceZ
- FluorescenceY
- FluorescenceX
- ReflectanceZ
- ReflectanceY
- ReflectanceX
- *Reflectance Pinhole (for documentation only)*
- *Fluorescence Pinhole (for documentation)*

>**PMTModule**
- ReflectanceShutter (checkbox)
- ReflectanceGain (slider and textbox)
- ReflectanceOffset (editbox)
- FluorescenceShutter (checkbox)
- FluorescenceManualControl (checkbox)
- FluorescenceGain (slider and textbox)
- FluorescenceOffset (editbox)
- *Optimization values and biases (for documentation and reference)*

>**ScannerModule**: Interface to galvo/reso scanner control
- FieldOfView (sliders and dropdown for common values)
- LineScan (checkbox)
- Info: draw from latest scanner calibration to give microns/pixel and size
- Stabilization (checkbox)
- *Save reference image (button)*
- *Load reference image (button)*

> **PowerModule**: Light safety

It would be nice to record the morning power measurements and draw on FOV to display light safety information... This would require REL Calculator capability (have been wanting to refactor anyway). A tracker of how much light budget has been used based on when shutters are open and what the FOVs are would be awesome.

> **AOModule**: Interface to commonly used controls for TsunamiWave
- Defocus slider
- Close loop checkbox
- Freeze mirror
- *Other infrequently used controls?*


#### Need to resolve
- Workflow for whether/how we listening for changes from the SLO software and TsunamiWave. We don't want things to get out of sync if user moves back to original UIs

#### Misc add-ons that would be nice but not mission critical
- Quick font control to make sure UI is visible when on the other side of the system.
- User-specific settings because relevant windows vary between imaging approaches