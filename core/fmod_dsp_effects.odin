package fmod_core

/* ============================================================================================================= */
/* FMOD Core API - Built-in effects header file.                                                                 */
/* Copyright (c), Firelight Technologies Pty, Ltd. 2004-2023.                                                    */
/*                                                                                                               */
/* In this header you can find parameter structures for FMOD system registered DSP effects                       */
/* and generators.                                                                                               */
/*                                                                                                               */
/* For more detail visit:                                                                                        */
/* https://fmod.com/docs/2.03/api/core-api-common-dsp-effects.html#fmod_dsp_type                                 */
/* ============================================================================================================= */

DSP_Type :: enum i32 {
    unknown,
    mixer,
    oscillator,
    lowpass,
    itlowpass,
    highpass,
    echo,
    fader,
    flange,
    distortion,
    normalize,
    limiter,
    parameq,
    pitchshift,
    chorus,
    vstplugin,
    winampplugin,
    itecho,
    compressor,
    sfxreverb,
    lowpass_simple,
    delay,
    tremolo,
    ladspaplugin,
    send,
    _return,
    highpass_simple,
    pan,
    three_eq,
    fft,
    loudness_meter,
    envelopefollower,
    convolutionreverb,
    channelmix,
    transceiver,
    objectpan,
    multiband_eq,
    multiband_dynamics,
    max,
}

///////////////////////////////////////////////////////////////////////////////////////////////////////
// FMOD built in effect parameters.
//
// Use DSP::setParameter with these enums for the 'index' parameter.
//

DSP_Oscillator :: enum i32 {
    type,
    rate,
}
DSP_Filter :: enum i32 {
    cutoff,
    resonance,
}
DSP_Lowpass :: distinct DSP_Filter
DSP_ITLowpass :: distinct DSP_Filter
DSP_Highpass :: distinct DSP_Filter

DSP_Echo :: enum i32 {
    delay,
    feedback,
    drylevel,
    wetlevel,
    delaychangemode,
}

DSP_DelayChangeMode_Type :: enum i32 {
    fade,
    lerp,
    none,
}

DSP_Fader :: enum i32 {
    gain,
    overall_gain,
}

DSP_Flange :: enum i32 {
    mix,
    depth,
    rate,
}

DSP_Distortion :: enum i32 {
    level,
}

DSP_Normalize :: enum i32 {
    fadetime,
    threshold,
    maxamp,
}

DSP_Limiter :: enum i32 {
    releasetime,
    ceiling,
    maximizergain,
    mode,
}

DSP_ParamEQ :: enum i32 {
    center,
    bandwidth,
    gain,
}

DSP_Multiband_EQ :: enum i32 {
    a_filter,
    a_frequency,
    a_q,
    a_gain,
    b_filter,
    b_frequency,
    b_q,
    b_gain,
    c_filter,
    c_frequency,
    c_q,
    c_gain,
    d_filter,
    d_frequency,
    d_q,
    d_gain,
    e_filter,
    e_frequency,
    e_q,
    e_gain,
}


DSP_Multiband_EQ_Filter_Type :: enum i32 {
    disabled,
    lowpass_12db,
    lowpass_24db,
    lowpass_48db,
    highpass_12db,
    highpass_24db,
    highpass_48db,
    lowshelf,
    highshelf,
    peaking,
    bandpass,
    notch,
    allpass,
    lowpass_6db,
    highpass_6db,
}


DSP_Multiband_Dynamics :: enum i32 {
    lower_frequency,
    upper_frequency,
    linked,
    use_sidechain,
    a_mode,
    a_gain,
    a_threshold,
    a_ratio,
    a_attack,
    a_release,
    a_gain_makeup,
    a_response_data,
    b_mode,
    b_gain,
    b_threshold,
    b_ratio,
    b_attack,
    b_release,
    b_gain_makeup,
    b_response_data,
    c_mode,
    c_gain,
    c_threshold,
    c_ratio,
    c_attack,
    c_release,
    c_gain_makeup,
    c_response_data,
}

DSP_Multiband_Dynamics_Mode_Type :: enum i32 {
    disabled,
    compress_up,
    compress_down,
    expand_up,
    expand_down,
}

DSP_Pitchshift :: enum i32 {
    pitch,
    fftsize,
    overlap,
    maxchannels,
}


DSP_Chorus :: enum i32 {
    mix,
    rate,
    depth,
}


DSP_ITEcho :: enum i32 {
    wetdrymix,
    feedback,
    leftdelay,
    rightdelay,
    pandelay,
}

DSP_Compressor :: enum i32 {
    threshold,
    ratio,
    attack,
    release,
    gainmakeup,
    usesidechain,
    linked,
}

DSP_SFXReverb :: enum i32 {
    decaytime,
    earlydelay,
    latedelay,
    hfreference,
    hfdecayratio,
    diffusion,
    density,
    lowshelffrequency,
    lowshelfgain,
    highcut,
    earlylatemix,
    wetlevel,
    drylevel,
}

// DSP_LOWPASS_SIMPLE :: enum i32 {
DSP_LOWPASS_SIMPLE_CUTOFF :: 0
// }


DSP_Delay :: enum i32 {
    ch0,
    ch1,
    ch2,
    ch3,
    ch4,
    ch5,
    ch6,
    ch7,
    ch8,
    ch9,
    ch10,
    ch11,
    ch12,
    ch13,
    ch14,
    ch15,
    maxdelay,
}

DSP_Tremolo :: enum i32 {
    frequency,
    depth,
    shape,
    skew,
    duty,
    square,
    phase,
    spread,
}

DSP_Send :: enum i32 {
    returnid,
    level,
}

DSP_Return :: enum i32 {
    id,
    input_speaker_mode,
}

// DSP_HIGHPASS_SIMPLE :: enum i32 {
DSP_HIGHPASS_SIMPLE_CUTOFF :: 0
// }


DSP_Pan_2D_Stereo_Mode_Type :: enum i32 {
    distributed,
    discrete,
}

DSP_Pan_Mode_Type :: enum i32 {
    mono,
    stereo,
    surround,
}

DSP_Pan_3D_Rolloff_Type :: enum i32 {
    linearsquared,
    linear,
    inverse,
    inversetapered,
    custom,
}

DSP_Pan_3D_Extent_Mode_Type :: enum i32 {
    auto,
    user,
    off,
}


DSP_Pan :: enum i32 {
    mode,
    _2d_stereo_position,
    _2d_direction,
    _2d_extent,
    _2d_rotation,
    _2d_lfe_level,
    _2d_stereo_mode,
    _2d_stereo_separation,
    _2d_stereo_axis,
    enabled_speakers,
    _3d_position,
    _3d_rolloff,
    _3d_min_distance,
    _3d_max_distance,
    _3d_extent_mode,
    _3d_sound_size,
    _3d_min_extent,
    _3d_pan_blend,
    lfe_upmix_enabled,
    overall_gain,
    surround_speaker_mode,
    _2d_height_blend,
    attenuation_range,
    override_range,
}


DSP_Three_EQ_CrossoverSlope_Type :: enum i32 {
    _12db,
    _24db,
    _48db,
}


DSP_Three_EQ :: enum i32 {
    lowgain,
    midgain,
    highgain,
    lowcrossover,
    highcrossover,
    crossoverslope,
}

DSP_FFT_Window_Type :: enum i32 {
    rect,
    triangle,
    hamming,
    hanning,
    blackman,
    blackmanharris,
}

DSP_FFT_Downmix_Type :: enum i32 {
    none,
    mono,
}

DSP_FFT :: enum i32 {
    windowsize,
    window,
    band_start_freq,
    band_stop_freq,
    spectrumdata,
    rms,
    // previously dominant_freq
    spectral_centroid,
    immediate_mode,
    downmix,
    channel,
}

DSP_Loudness_Meter :: enum i32 {
    state,
    weighting,
    info,
}

DSP_Loudness_Meter_State_Type :: enum i32 {
    reset_integrated = -3,
    reset_maxpeak    = -2,
    reset_all        = -1,
    paused           = 0,
    analyzing        = 1,
}

DSP_LOUDNESS_METER_HISTOGRAM_SAMPLES :: 66
DSP_Loudness_Meter_Info_Type :: struct {
    momentaryloudness:      f32,
    shorttermloudness:      f32,
    integratedloudness:     f32,
    loudness10thpercentile: f32,
    loudness95thpercentile: f32,
    loudnesshistogram:      [DSP_LOUDNESS_METER_HISTOGRAM_SAMPLES]f32,
    maxtruepeak:            f32,
    maxmomentaryloudness:   f32,
}

DSP_Loudness_Meter_Weighting_Type :: struct {
    channelweight: [32]f32,
}


DSP_EnvelopeFollower :: enum i32 {
    attack,
    release,
    envelope,
    usesidechain,
}

DSP_Convolution_Reverb :: enum i32 {
    ir,
    wet,
    dry,
    linked,
}

DSP_ChannelMix_Output :: enum i32 {
    default,
    allmono,
    allstereo,
    allquad,
    all5point1,
    all7point1,
    alllfe,
    all7point1point4,
}

DSP_ChannelMix :: enum i32 {
    outputgrouping,
    gain_ch0,
    gain_ch1,
    gain_ch2,
    gain_ch3,
    gain_ch4,
    gain_ch5,
    gain_ch6,
    gain_ch7,
    gain_ch8,
    gain_ch9,
    gain_ch10,
    gain_ch11,
    gain_ch12,
    gain_ch13,
    gain_ch14,
    gain_ch15,
    gain_ch16,
    gain_ch17,
    gain_ch18,
    gain_ch19,
    gain_ch20,
    gain_ch21,
    gain_ch22,
    gain_ch23,
    gain_ch24,
    gain_ch25,
    gain_ch26,
    gain_ch27,
    gain_ch28,
    gain_ch29,
    gain_ch30,
    gain_ch31,
    output_ch0,
    output_ch1,
    output_ch2,
    output_ch3,
    output_ch4,
    output_ch5,
    output_ch6,
    output_ch7,
    output_ch8,
    output_ch9,
    output_ch10,
    output_ch11,
    output_ch12,
    output_ch13,
    output_ch14,
    output_ch15,
    output_ch16,
    output_ch17,
    output_ch18,
    output_ch19,
    output_ch20,
    output_ch21,
    output_ch22,
    output_ch23,
    output_ch24,
    output_ch25,
    output_ch26,
    output_ch27,
    output_ch28,
    output_ch29,
    output_ch30,
    output_ch31,
}

DSP_Transceiver_SpeakerMode :: enum i32 {
    auto = -1,
    mono = 0,
    stereo,
    surround,
}


DSP_Transceiver :: enum i32 {
    transmit,
    gain,
    channel,
    transmitspeakermode,
}


DSP_ObjectPan :: enum i32 {
    _3d_position,
    _3d_rolloff,
    _3d_min_distance,
    _3d_max_distance,
    _3d_extent_mode,
    _3d_sound_size,
    _3d_min_extent,
    overall_gain,
    outputgain,
    attenuation_range,
    override_range,
}
