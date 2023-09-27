

**Devices**
- Actual devices (directly control via Symphony)
  - **Propixx**
  - **FrameMonitor** (no class needed)
  - **PowerMeter** (in future, not currently in design)
- Psuedo devices (low-level software middleman, the value added will be single cohesive UI, user-friendly matlab scripting and easy persistence of relevant parameters)
  - **Mustang** (shutter (auto/manual), intensity, manual ctrl)
  - **Toptica** (shutter (auto/manual), intensity, auto shutter)
  - **ReflectanceChannel**: technically multiple devices but could be reasonable to combine since we aren't directly controlling them in Symphony, the PMT (internal shutter, gain, offset), external shutter (on/off, auto/manual) and the motors (X, Y, Z)
  - **Fluorescence Source/PMT**: same as above but with source position motor
  - **EyeTracker**: control of steering mirrors (stabilization on/off, ref image), potentially read in stabilization data after epoch from file so we can get all the data in a single location
  - **AO loop**: technically 2 devices, DM and WFS plus TsunamiWave (defocus, open/close loop, reset DM)

**Sources**
- Primate
  - Eye (axial length etc)
    - Region (reference to HRA or just name as we've been doing)
      - Cell (image from click control?)
- ModelEye

**EpochGroups**
- Physiology
- Anatomy (no Stage)
- Psychophysics

**Rigs**
- TwoChannelDualAOWithStage (does psychophysics need a separate one?)
- TwoChannelDualAO (no visual stimuli)
- OneChannelDualAO
- TwoChannelDualAOWithOptogenetics
- Probably something for psychophysics but unclear what the requirements are