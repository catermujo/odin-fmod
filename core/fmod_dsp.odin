package fmod_core

/* ======================================================================================== */
/* FMOD Core API - DSP header file.                                                         */
/* Copyright (c), Firelight Technologies Pty, Ltd. 2004-2023.                               */
/*                                                                                          */
/* Use this header if you are wanting to develop your own DSP plugin to use with FMODs      */
/* dsp system.  With this header you can make your own DSP plugin that FMOD can             */
/* register and use.  See the documentation and examples on how to make a working plugin.   */
/*                                                                                          */
/* For more detail visit:                                                                   */
/* https://fmod.com/docs/2.03/api/plugin-api-dsp.html                                       */
/* =========================================================================================*/


///////////////////////////////////////////////////////////////////////////////////////////////////////
// DSP Constants
//

PLUGIN_SDK_VERSION :: 110
DSP_GETPARAM_VALUESTR_LENGTH :: 32

DSP_Process_Operation :: enum i32 {
    perform,
    query,
}

DSP_Pan_Surround_Flags :: enum i32 {
    default             = 0,
    rotation_not_biased = 1,
}

DSP_Parameter_Type :: enum i32 {
    float,
    int,
    bool,
    data,
}

DSP_Parameter_Float_Mapping_Type :: enum i32 {
    linear,
    auto,
    piecewise_linear,
}

DSP_Parameter_Data_Type :: enum i32 {
    user                = 0,
    overallgain         = -1,
    _3dattributes       = -2,
    sidechain           = -3,
    fft                 = -4,
    _3dattributes_multi = -5,
    attenuation_range   = -6,
    dynamic_response    = -7,
    finite_length       = -8,
}


///////////////////////////////////////////////////////////////////////////////////////////////////////
// DSP Callbacks
//

dsp_create_callback :: #type proc "c" (dsp_state: ^DSP_State) -> Result

dsp_release_callback :: #type proc "c" (dsp_state: ^DSP_State) -> Result

dsp_reset_callback :: #type proc "c" (dsp_state: ^DSP_State) -> Result

dsp_read_callback :: #type proc "c" (
    dsp_state: ^DSP_State,
    inbuffer: ^f32,
    outbuffer: ^f32,
    length: u32,
    inchannels: i32,
    outchannels: ^i32,
) -> Result

dsp_process_callback :: #type proc "c" (
    dsp_state: ^DSP_State,
    length: u32,
    #by_ptr inbufferarray: DSP_Buffer_Array,
    outbufferarray: [^]DSP_Buffer_Array,
    inputsidle: b32,
    op: DSP_Process_Operation,
) -> Result

dsp_setposition_callback :: #type proc "c" (dsp_state: ^DSP_State, pos: u32) -> Result

dsp_shouldiprocess_callback :: #type proc "c" (
    dsp_state: ^DSP_State,
    inputsidle: b32,
    length: u32,
    inmask: ChannelMask,
    inchannels: i32,
    speakermode: SpeakerMode,
) -> Result

dsp_setparam_float_callback :: #type proc "c" (dsp_state: ^DSP_State, index: i32, value: f32) -> Result

dsp_setparam_int_callback :: #type proc "c" (dsp_state: ^DSP_State, index: i32, value: i32) -> Result

dsp_setparam_bool_callback :: #type proc "c" (dsp_state: ^DSP_State, index: i32, value: b32) -> Result

dsp_setparam_data_callback :: #type proc "c" (dsp_state: ^DSP_State, index: i32, data: rawptr, length: u32) -> Result

dsp_getparam_float_callback :: #type proc "c" (
    dsp_state: ^DSP_State,
    index: i32,
    value: ^f32,
    valuestr: [^]u8,
) -> Result

dsp_getparam_int_callback :: #type proc "c" (dsp_state: ^DSP_State, index: i32, value: ^i32, valuestr: [^]u8) -> Result

dsp_getparam_bool_callback :: #type proc "c" (dsp_state: ^DSP_State, index: i32, value: b32, valuestr: [^]u8) -> Result

dsp_getparam_data_callback :: #type proc "c" (
    dsp_state: ^DSP_State,
    index: i32,
    data: ^rawptr,
    length: ^u32,
    valuestr: [^]u8,
) -> Result

dsp_system_register_callback :: #type proc "c" (dsp_state: ^DSP_State) -> Result

dsp_system_deregister_callback :: #type proc "c" (dsp_state: ^DSP_State) -> Result

dsp_system_mix_callback :: #type proc "c" (dsp_state: ^DSP_State, stage: i32) -> Result


///////////////////////////////////////////////////////////////////////////////////////////////////////
// DSP Functions
//


dsp_alloc_func :: #type proc "c" (size: u32, type: Memory_Type, sourcestr: cstring) -> rawptr

dsp_realloc_func :: #type proc "c" (ptr: rawptr, size: u32, type: Memory_Type, sourcestr: cstring) -> rawptr

dsp_free_func :: #type proc "c" (ptr: rawptr, type: Memory_Type, sourcestr: cstring)

dsp_log_func :: #type proc "c" (
    level: Debug_Flags,
    file: cstring,
    line: i32,
    function: cstring,
    str: cstring,
    #c_vararg args: ..any,
)

dsp_getsamplerate_func :: #type proc "c" (dsp_state: ^DSP_State, rate: ^i32) -> Result
dsp_getblocksize_func :: #type proc "c" (dsp_state: ^DSP_State, blocksize: ^u32) -> Result

dsp_getspeakermode_func :: #type proc "c" (
    dsp_state: ^DSP_State,
    speakermode_mixer: ^SpeakerMode,
    speakermode_output: ^SpeakerMode,
) -> Result

dsp_getclock_func :: #type proc "c" (dsp_state: ^DSP_State, clock: ^uint, offset: ^u32, length: ^u32) -> Result

dsp_getlistenerattributes_func :: #type proc "c" (
    dsp_state: ^DSP_State,
    numlisteners: ^i32,
    attributes: ^_3D_Attributes,
) -> Result

dsp_getuserdata_func :: #type proc "c" (dsp_state: ^DSP_State, userdata: ^rawptr) -> Result

dsp_dft_fftreal_func :: #type proc "c" (
    dsp_state: ^DSP_State,
    size: i32,
    #by_ptr signal: f32,
    dft: ^Complex,
    #by_ptr window: f32,
    signalhop: i32,
) -> Result

dsp_dft_ifftreal_func :: #type proc "c" (
    dsp_state: ^DSP_State,
    size: i32,
    #by_ptr dft: Complex,
    signal: ^f32,
    #by_ptr window: f32,
    signalhop: i32,
) -> Result

dsp_pan_summonomatrix_func :: #type proc "c" (
    dsp_state: ^DSP_State,
    sourceSpeakerMode: SpeakerMode,
    lowFrequencyGain: f32,
    overallGain: f32,
    _matrix: ^f32,
) -> Result

dsp_pan_sumstereomatrix_func :: #type proc "c" (
    dsp_state: ^DSP_State,
    sourceSpeakerMode: SpeakerMode,
    pan: f32,
    lowFrequencyGain: f32,
    overallGain: f32,
    matrixHop: i32,
    _matrix: ^f32,
) -> Result

dsp_pan_sumsurroundmatrix_func :: #type proc "c" (
    dsp_state: ^DSP_State,
    sourceSpeakerMode: SpeakerMode,
    targetSpeakerMode: SpeakerMode,
    direction: f32,
    extent: f32,
    rotation: f32,
    lowFrequencyGain: f32,
    overallGain: f32,
    matrixHop: i32,
    _matrix: ^f32,
    flags: DSP_Pan_Surround_Flags,
) -> Result

dsp_pan_summonotosurroundmatrix_func :: #type proc "c" (
    dsp_state: ^DSP_State,
    targetSpeakerMode: SpeakerMode,
    direction: f32,
    extent: f32,
    lowFrequencyGain: f32,
    overallGain: f32,
    matrixHop: i32,
    _matrix: ^f32,
) -> Result

dsp_pan_sumstereotosurroundmatrix_func :: #type proc "c" (
    dsp_state: ^DSP_State,
    targetSpeakerMode: SpeakerMode,
    direction: f32,
    extent: f32,
    rotation: f32,
    lowFrequencyGain: f32,
    overallGain: f32,
    matrixHop: i32,
    _matrix: ^f32,
) -> Result

dsp_pan_getrolloffgain_func :: #type proc "c" (
    dsp_state: ^DSP_State,
    rolloff: DSP_Pan_3D_Rolloff_Type,
    distance: f32,
    mindistance: f32,
    maxdistance: f32,
    gain: ^f32,
) -> Result


///////////////////////////////////////////////////////////////////////////////////////////////////////
// DSP Structures
//

DSP_Buffer_Array :: struct {
    numbuffers:        i32,
    buffernumchannels: ^i32,
    bufferchannelmask: ^ChannelMask,
    buffers:           ^^f32,
    speakermode:       SpeakerMode,
}

Complex :: struct {
    real: f32,
    imag: f32,
}

DSP_Parameter_Float_Mapping_Piecewise_Linear :: struct {
    numpoints:        i32,
    pointparamvalues: ^f32,
    pointpositions:   ^f32,
}

DSP_Parameter_Float_Mapping :: struct {
    _type:                  DSP_Parameter_Float_Mapping_Type,
    piecewiselinearmapping: DSP_Parameter_Float_Mapping_Piecewise_Linear,
}

DSP_Parameter_Desc_Float :: struct {
    min:        f32,
    max:        f32,
    defaultval: f32,
    mapping:    DSP_Parameter_Float_Mapping,
}

DSP_Parameter_Desc_Int :: struct {
    min:        i32,
    max:        i32,
    defaultval: i32,
    goestoinf:  b32,
    valuenames: [^]cstring,
}

DSP_Parameter_Desc_Bool :: struct {
    defaultval: b32,
    valuenames: [^]cstring,
}

DSP_Parameter_Desc_Data :: struct {
    datatype: i32,
}

DSP_Parameter_Desc :: struct {
    type:        DSP_Parameter_Type,
    name:        [16]u8,
    label:       [16]u8,
    description: cstring,
    using data:  struct #raw_union {
        floatdesc: DSP_Parameter_Desc_Float,
        intdesc:   DSP_Parameter_Desc_Int,
        booldesc:  DSP_Parameter_Desc_Bool,
        datadesc:  DSP_Parameter_Desc_Data,
    },
}

DSP_Parameter_OverallGain :: struct {
    linear_gain:          f32,
    linear_gain_additive: f32,
}

DSP_Parameter_3DAttributes :: struct {
    relative: _3D_Attributes,
    absolute: _3D_Attributes,
}

DSP_Parameter_3DAttributes_Multi :: struct {
    numlisteners: i32,
    relative:     [MAX_LISTENERS]_3D_Attributes,
    weight:       [MAX_LISTENERS]f32,
    absolute:     _3D_Attributes,
}

DSP_Parameter_Attenuation_Range :: struct {
    min: f32,
    max: f32,
}

DSP_Parameter_Sidechain :: struct {
    sidechainenable: b32,
}

DSP_Parameter_FFT :: struct {
    length:      i32,
    numchannels: i32,
    spectrum:    [32]^f32,
}

DSP_Description :: struct {
    pluginsdkversion:  u32,
    name:              [32]u8,
    version:           u32,
    numinputbuffers:   i32,
    numoutputbuffers:  i32,
    create:            dsp_create_callback,
    release:           dsp_release_callback,
    reset:             dsp_reset_callback,
    read:              dsp_read_callback,
    process:           dsp_process_callback,
    setposition:       dsp_setposition_callback,
    numparameters:     i32,
    paramdesc:         ^^DSP_Parameter_Desc,
    setparameterfloat: dsp_setparam_float_callback,
    setparameterint:   dsp_setparam_int_callback,
    setparameterbool:  dsp_setparam_bool_callback,
    setparameterdata:  dsp_setparam_data_callback,
    getparameterfloat: dsp_getparam_float_callback,
    getparameterint:   dsp_getparam_int_callback,
    getparameterbool:  dsp_getparam_bool_callback,
    getparameterdata:  dsp_getparam_data_callback,
    shouldiprocess:    dsp_shouldiprocess_callback,
    userdata:          rawptr,
    sys_register:      dsp_system_register_callback,
    sys_deregister:    dsp_system_deregister_callback,
    sys_mix:           dsp_system_mix_callback,
}

DSP_State_DFT_Functions :: struct {
    fftreal:        dsp_dft_fftreal_func,
    inversefftreal: dsp_dft_ifftreal_func,
}

DSP_State_PAN_Functions :: struct {
    summonomatrix:             dsp_pan_summonomatrix_func,
    sumstereomatrix:           dsp_pan_sumstereomatrix_func,
    sumsurroundmatrix:         dsp_pan_sumsurroundmatrix_func,
    summonotosurroundmatrix:   dsp_pan_summonotosurroundmatrix_func,
    sumstereotosurroundmatrix: dsp_pan_sumstereotosurroundmatrix_func,
    getrolloffgain:            dsp_pan_getrolloffgain_func,
}

DSP_State_Functions :: struct {
    alloc:                 dsp_alloc_func,
    realloc:               dsp_realloc_func,
    free:                  dsp_free_func,
    getsamplerate:         dsp_getsamplerate_func,
    getblocksize:          dsp_getblocksize_func,
    dft:                   ^DSP_State_DFT_Functions,
    pan:                   ^DSP_State_PAN_Functions,
    getspeakermode:        dsp_getspeakermode_func,
    getclock:              dsp_getclock_func,
    getlistenerattributes: dsp_getlistenerattributes_func,
    log:                   dsp_log_func,
    getuserdata:           dsp_getuserdata_func,
}

DSP_State :: struct {
    instance:           rawptr,
    plugindata:         rawptr,
    channelmask:        ChannelMask,
    source_speakermode: SpeakerMode,
    sidechaindata:      ^f32,
    sidechainchannels:  i32,
    functions:          [^]DSP_State_Functions,
    systemobject:       i32,
}

DSP_Metering_Info :: struct {
    numsamples:  i32,
    peaklevel:   [32]f32,
    rmslevel:    [32]f32,
    numchannels: i16,
}


///////////////////////////////////////////////////////////////////////////////////////////////////////
// DSP Macros
//

/*
#define DSP_INIT_PARAMDESC_FLOAT(_paramstruct, _name, _label, _description, _min, _max, _defaultval) \
    memset(&(_paramstruct), 0, sizeof(_paramstruct)), \
    (_paramstruct).type         = DSP_PARAMETER_TYPE_FLOAT, \
    strncpy((_paramstruct).name,  _name,  15), \
    strncpy((_paramstruct).label, _label, 15), \
    (_paramstruct).description  = _description, \
    (_paramstruct).floatdesc.min          = _min, \
    (_paramstruct).floatdesc.max          = _max, \
    (_paramstruct).floatdesc.defaultval   = _defaultval, \
    (_paramstruct).floatdesc.mapping.type = DSP_PARAMETER_FLOAT_MAPPING_TYPE_AUTO,

#define DSP_INIT_PARAMDESC_FLOAT_WITH_MAPPING(_paramstruct, _name, _label, _description, _defaultval, _values, _positions), \
    memset(&(_paramstruct), 0, sizeof(_paramstruct)), \
    (_paramstruct).type         = DSP_PARAMETER_TYPE_FLOAT, \
    strncpy((_paramstruct).name,  _name , 15), \
    strncpy((_paramstruct).label, _label, 15), \
    (_paramstruct).description  = _description, \
    (_paramstruct).floatdesc.min          = _values[0], \
    (_paramstruct).floatdesc.max          = _values[sizeof(_values) / sizeof(f32) - 1], \
    (_paramstruct).floatdesc.defaultval   = _defaultval, \
    (_paramstruct).floatdesc.mapping.type = DSP_PARAMETER_FLOAT_MAPPING_TYPE_PIECEWISE_LINEAR, \
    (_paramstruct).floatdesc.mapping.piecewiselinearmapping.numpoints = sizeof(_values) / sizeof(f32), \
    (_paramstruct).floatdesc.mapping.piecewiselinearmapping.pointparamvalues = _values, \
    (_paramstruct).floatdesc.mapping.piecewiselinearmapping.pointpositions = _positions,

#define DSP_INIT_PARAMDESC_INT(_paramstruct, _name, _label, _description, _min, _max, _defaultval, _goestoinf, _valuenames) \
    memset(&(_paramstruct), 0, sizeof(_paramstruct)), \
    (_paramstruct).type         = DSP_PARAMETER_TYPE_INT, \
    strncpy((_paramstruct).name,  _name , 15), \
    strncpy((_paramstruct).label, _label, 15), \
    (_paramstruct).description  = _description, \
    (_paramstruct).intdesc.min          = _min, \
    (_paramstruct).intdesc.max          = _max, \
    (_paramstruct).intdesc.defaultval   = _defaultval, \
    (_paramstruct).intdesc.goestoinf    = _goestoinf, \
    (_paramstruct).intdesc.valuenames   = _valuenames,

#define DSP_INIT_PARAMDESC_INT_ENUMERATED(_paramstruct, _name, _label, _description, _defaultval, _valuenames) \
    memset(&(_paramstruct), 0, sizeof(_paramstruct)), \
    (_paramstruct).type         = DSP_PARAMETER_TYPE_INT, \
    strncpy((_paramstruct).name,  _name , 15), \
    strncpy((_paramstruct).label, _label, 15), \
    (_paramstruct).description  = _description, \
    (_paramstruct).intdesc.min          = 0, \
    (_paramstruct).intdesc.max          = sizeof(_valuenames) / sizeof(u8*) - 1, \
    (_paramstruct).intdesc.defaultval   = _defaultval, \
    (_paramstruct).intdesc.goestoinf    = false, \
    (_paramstruct).intdesc.valuenames   = _valuenames,

#define DSP_INIT_PARAMDESC_BOOL(_paramstruct, _name, _label, _description, _defaultval, _valuenames) \
    memset(&(_paramstruct), 0, sizeof(_paramstruct)), \
    (_paramstruct).type         = DSP_PARAMETER_TYPE_BOOL, \
    strncpy((_paramstruct).name,  _name , 15), \
    strncpy((_paramstruct).label, _label, 15), \
    (_paramstruct).description  = _description, \
    (_paramstruct).booldesc.defaultval   = _defaultval, \
    (_paramstruct).booldesc.valuenames   = _valuenames,

#define DSP_INIT_PARAMDESC_DATA(_paramstruct, _name, _label, _description, _datatype) \
    memset(&(_paramstruct), 0, sizeof(_paramstruct)), \
    (_paramstruct).type         = DSP_PARAMETER_TYPE_DATA, \
    strncpy((_paramstruct).name,  _name , 15), \
    strncpy((_paramstruct).label, _label, 15), \
    (_paramstruct).description  = _description, \
    (_paramstruct).datadesc.datatype     = _datatype,

#define DSP_ALLOC(_state, _size) \
    (_state)->functions->alloc(_size, MEMORY_NORMAL, __FILE__)
#define DSP_REALLOC(_state, _ptr, _size) \
    (_state)->functions->realloc(_ptr, _size, MEMORY_NORMAL, __FILE__)
#define DSP_FREE(_state, _ptr) \
    (_state)->functions->free(_ptr, MEMORY_NORMAL, __FILE__)
#define DSP_LOG(_state, _level, _location, _format, #c_vararg args: ..any) \
    (_state)->functions->log(_level, __FILE__, __LINE__, _location, _format, __VA_ARGS__)
#define DSP_GETSAMPLERATE(_state, _rate) \
    (_state)->functions->getsamplerate(_state, _rate)
#define DSP_GETBLOCKSIZE(_state, _blocksize) \
    (_state)->functions->getblocksize(_state, _blocksize)
#define DSP_GETSpeakerMode(_state, _speakermodemix, _speakermodeout) \
    (_state)->functions->getspeakermode(_state, _speakermodemix, _speakermodeout)
#define DSP_GETCLOCK(_state, _clock, _offset, _length) \
    (_state)->functions->getclock(_state, _clock, _offset, _length)
#define DSP_GETLISTENERATTRIBUTES(_state, _numlisteners, _attributes) \
    (_state)->functions->getlistenerattributes(_state, _numlisteners, _attributes)
#define DSP_GETUSERDATA(_state, _userdata) \
    (_state)->functions->getuserdata(_state, _userdata)
#define DSP_DFT_FFTREAL(_state, _size, _signal, _dft, _window, _signalhop) \
    (_state)->functions->dft->fftreal(_state, _size, _signal, _dft, _window, _signalhop)
#define DSP_DFT_IFFTREAL(_state, _size, _dft, _signal, _window, _signalhop) \
    (_state)->functions->dft->inversefftreal(_state, _size, _dft, _signal, _window, _signalhop)
#define DSP_PAN_SUMMONOMATRIX(_state, _sourcespeakermode, _lowfrequencygain, _overallgain, _matrix) \
    (_state)->functions->pan->summonomatrix(_state, _sourcespeakermode, _lowfrequencygain, _overallgain, _matrix)
#define DSP_PAN_SUMSTEREOMATRIX(_state, _sourcespeakermode, _pan, _lowfrequencygain, _overallgain, _matrixhop, _matrix) \
    (_state)->functions->pan->sumstereomatrix(_state, _sourcespeakermode, _pan, _lowfrequencygain, _overallgain, _matrixhop, _matrix)
#define DSP_PAN_SUMSURROUNDMATRIX(_state, _sourcespeakermode, _targetspeakermode, _direction, _extent, _rotation, _lowfrequencygain, _overallgain, _matrixhop, _matrix, _flags) \
    (_state)->functions->pan->sumsurroundmatrix(_state, _sourcespeakermode, _targetspeakermode, _direction, _extent, _rotation, _lowfrequencygain, _overallgain, _matrixhop, _matrix, _flags)
#define DSP_PAN_SUMMONOTOSURROUNDMATRIX(_state, _targetspeakermode, _direction, _extent, _lowfrequencygain, _overallgain, _matrixhop, _matrix) \
    (_state)->functions->pan->summonotosurroundmatrix(_state, _targetspeakermode, _direction, _extent, _lowfrequencygain, _overallgain, _matrixhop, _matrix)
#define DSP_PAN_SUMSTEREOTOSURROUNDMATRIX(_state, _targetspeakermode, _direction, _extent, _rotation, _lowfrequencygain, _overallgain, matrixhop, _matrix) \
    (_state)->functions->pan->sumstereotosurroundmatrix(_state, _targetspeakermode, _direction, _extent, _rotation, _lowfrequencygain, _overallgain, matrixhop, _matrix)
#define DSP_PAN_GETROLLOFFGAIN(_state, _rolloff, _distance, _mindistance, _maxdistance, _gain) \
    (_state)->functions->pan->getrolloffgain(_state, _rolloff, _distance, _mindistance, _maxdistance, _gain)

#endif

*/
