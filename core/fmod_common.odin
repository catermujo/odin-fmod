package fmod_core

/* ======================================================================================== */
/* FMOD Core API - Common C/C++ header file.                                                */
/* Copyright (c), Firelight Technologies Pty, Ltd. 2004-2023.                               */
/*                                                                                          */
/* This header is included by fmod.hpp (C++ interface) and fmod.h (C interface)             */
/*                                                                                          */
/* For more detail visit:                                                                   */
/* https://fmod.com/docs/2.02/api/core-api-common.html                                      */
/* ======================================================================================== */


///////////////////////////////////////////////////////////////////////////////////////////////////////
// FMOD constants
//

VERSION: u32 : 0x00020311 /* 0xaaaabbcc -> aaaa = product version, bb = major version, cc = minor version.*/


///////////////////////////////////////////////////////////////////////////////////////////////////////
// FMOD core types
//

System :: struct {}
Sound :: struct {}
ChannelControl :: struct {}
Channel :: struct {}
ChannelGroup :: struct {}
SoundGroup :: struct {}
Reverb3D :: struct {}
DSP :: struct {}
DSPConnection :: struct {}
Polygon :: struct {}
Geometry :: struct {}
SyncPoint :: struct {}


///////////////////////////////////////////////////////////////////////////////////////////////////////
// FMOD constants
//

Debug_Flag :: enum u8 {
    level_error,
    level_warning,
    level_log,
    type_memory = 8,
    type_file,
    type_codec,
    type_trace,
    display_timestamps = 16,
    display_linenumbers,
    display_thread,
}
Debug_Flags :: bit_set[Debug_Flag;u32]
Debug_Flags_NONE: Debug_Flags : {}

_Memory_Type :: enum u8 {
    stream_file,
    stream_decode,
    sampledata,
    dsp_buffer,
    plugin,
    persistent = 25,
}
Memory_Type :: bit_set[_Memory_Type;u32]
MEMORY_NORMAL: Memory_Type : {}
MEMORY_ALL: Memory_Type : ~{}

Init_Flag :: enum u8 {
    // normal ,
    stream_from_update,
    mix_from_update,
    _3d_righthanded,
    clip_output,
    channel_lowpass = 8,
    channel_distancefilter,
    profile_enable = 16,
    vol0_becomes_virtual,
    geometry_useclosest,
    prefer_dolby_downmix,
    thread_unsafe = 20,
    profile_meter_all,
    memory_tracking,
}
Init_Flags :: bit_set[Init_Flag;u32]

_Driver_State :: enum u8 {
    connected,
    default,
}
Driver_State :: bit_set[_Driver_State;u32]

_TimeUnit :: enum u8 {
    ms,
    pcm,
    pcmbytes,
    rawbytes,
    pcmfraction,
    modorder = 8,
    modrow,
    modpattern,
}
TimeUnit :: bit_set[_TimeUnit;u32]

System_Callback_Type :: enum u8 {
    devicelistchanged,
    devicelost,
    memoryallocationfailed,
    threadcreated,
    baddspconnection,
    premix,
    postmix,
    error,
    midmix,
    threaddestroyed,
    preupdate,
    postupdate,
    recordlistchanged,
    bufferednomix,
    devicereinitialize,
    outputunderrun,
    recordpositionchanged,
}
System_Callback_Types :: bit_set[System_Callback_Type;u32]
System_Callback_ALL :: 0xFFFFFFFF

_Mode :: enum u8 {
    // default ,
    loop_off,
    loop_normal,
    loop_bidi,
    _2d,
    _3d,
    createstream = 7,
    createsample,
    createcompressedsample,
    openuser,
    openmemory,
    openraw,
    openonly,
    accuratetime,
    mpegsearch,
    nonblocking,
    unique,
    _3d_headrelative,
    _3d_worldrelative,
    _3d_inverserolloff,
    _3d_linearrolloff,
    _3d_linearsquarerolloff,
    _3d_inversetaperedrolloff,
    ignoretags = 25,
    _3d_customrolloff,
    lowmem,
    openmemory_point = 28,
    _3d_ignoregeometry = 30,
    virtual_playfromstart,
}
Mode :: bit_set[_Mode;u32]

_ChannelMask :: enum u8 {
    front_left,
    front_right,
    front_center,
    low_frequency,
    surround_left,
    surround_right,
    back_left,
    back_right,
    back_center,
}
ChannelMask :: bit_set[_ChannelMask;u32]
CHANNELMASK_MONO: ChannelMask : {.front_left}
CHANNELMASK_STEREO: ChannelMask : {.front_right} | CHANNELMASK_MONO
CHANNELMASK_LRC: ChannelMask : {.front_center} | CHANNELMASK_STEREO
CHANNELMASK_QUAD: ChannelMask : {.surround_left, .surround_right} | CHANNELMASK_STEREO
CHANNELMASK_SURROUND: ChannelMask : CHANNELMASK_LRC | CHANNELMASK_QUAD
CHANNELMASK_5POINT1: ChannelMask : {.low_frequency} | CHANNELMASK_SURROUND
CHANNELMASK_5POINT1_REARS: ChannelMask : {.low_frequency, .back_left, .back_right} | CHANNELMASK_LRC
CHANNELMASK_7POINT0: ChannelMask : {.back_left, .back_right} | CHANNELMASK_SURROUND
CHANNELMASK_7POINT1: ChannelMask : {.low_frequency} | CHANNELMASK_7POINT0

Port_Index :: distinct uint
PORT_INDEX_NONE: Port_Index : ~{}
PORT_INDEX_FLAG_VR_CONTROLLER: Port_Index : 0x1000000000000000

Thread_Priority :: distinct i32
/* Platform specific priority range */
THREAD_PRIORITY_PLATFORM_MIN: Thread_Priority : (-32 * 1024)
THREAD_PRIORITY_PLATFORM_MAX: Thread_Priority : (32 * 1024)
/* Platform agnostic priorities, maps internally to platform specific value */
THREAD_PRIORITY_DEFAULT: Thread_Priority : (THREAD_PRIORITY_PLATFORM_MIN - 1)
THREAD_PRIORITY_LOW: Thread_Priority : (THREAD_PRIORITY_PLATFORM_MIN - 2)
THREAD_PRIORITY_MEDIUM: Thread_Priority : (THREAD_PRIORITY_PLATFORM_MIN - 3)
THREAD_PRIORITY_HIGH: Thread_Priority : (THREAD_PRIORITY_PLATFORM_MIN - 4)
THREAD_PRIORITY_VERY_HIGH: Thread_Priority : (THREAD_PRIORITY_PLATFORM_MIN - 5)
THREAD_PRIORITY_EXTREME: Thread_Priority : (THREAD_PRIORITY_PLATFORM_MIN - 6)
THREAD_PRIORITY_CRITICAL: Thread_Priority : (THREAD_PRIORITY_PLATFORM_MIN - 7)
/* Thread defaults */
THREAD_PRIORITY_MIXER: Thread_Priority : THREAD_PRIORITY_EXTREME
THREAD_PRIORITY_FEEDER: Thread_Priority : THREAD_PRIORITY_CRITICAL
THREAD_PRIORITY_STREAM: Thread_Priority : THREAD_PRIORITY_VERY_HIGH
THREAD_PRIORITY_FILE: Thread_Priority : THREAD_PRIORITY_HIGH
THREAD_PRIORITY_NONBLOCKING: Thread_Priority : THREAD_PRIORITY_HIGH
THREAD_PRIORITY_RECORD: Thread_Priority : THREAD_PRIORITY_HIGH
THREAD_PRIORITY_GEOMETRY: Thread_Priority : THREAD_PRIORITY_LOW
THREAD_PRIORITY_PROFILER: Thread_Priority : THREAD_PRIORITY_MEDIUM
THREAD_PRIORITY_STUDIO_UPDATE: Thread_Priority : THREAD_PRIORITY_MEDIUM
THREAD_PRIORITY_STUDIO_LOAD_BANK: Thread_Priority : THREAD_PRIORITY_MEDIUM
THREAD_PRIORITY_STUDIO_LOAD_SAMPLE: Thread_Priority : THREAD_PRIORITY_MEDIUM
THREAD_PRIORITY_CONVOLUTION1: Thread_Priority : THREAD_PRIORITY_VERY_HIGH
THREAD_PRIORITY_CONVOLUTION2: Thread_Priority : THREAD_PRIORITY_VERY_HIGH

Thread_Stack_Size :: distinct u32
THREAD_STACK_SIZE_DEFAULT: Thread_Stack_Size : 0
THREAD_STACK_SIZE_MIXER: Thread_Stack_Size : (80 * 1024)
THREAD_STACK_SIZE_FEEDER: Thread_Stack_Size : (16 * 1024)
THREAD_STACK_SIZE_STREAM: Thread_Stack_Size : (96 * 1024)
THREAD_STACK_SIZE_FILE: Thread_Stack_Size : (64 * 1024)
THREAD_STACK_SIZE_NONBLOCKING: Thread_Stack_Size : (112 * 1024)
THREAD_STACK_SIZE_RECORD: Thread_Stack_Size : (16 * 1024)
THREAD_STACK_SIZE_GEOMETRY: Thread_Stack_Size : (48 * 1024)
THREAD_STACK_SIZE_PROFILER: Thread_Stack_Size : (128 * 1024)
THREAD_STACK_SIZE_STUDIO_UPDATE: Thread_Stack_Size : (96 * 1024)
THREAD_STACK_SIZE_STUDIO_LOAD_BANK: Thread_Stack_Size : (96 * 1024)
THREAD_STACK_SIZE_STUDIO_LOAD_SAMPLE: Thread_Stack_Size : (96 * 1024)
THREAD_STACK_SIZE_CONVOLUTION1: Thread_Stack_Size : (16 * 1024)
THREAD_STACK_SIZE_CONVOLUTION2: Thread_Stack_Size : (16 * 1024)

Thread_Affinity :: distinct int
/* Platform agnostic thread groupings */
THREAD_AFFINITY_GROUP_DEFAULT: Thread_Affinity : 0x4000000000000000
THREAD_AFFINITY_GROUP_A: Thread_Affinity : 0x4000000000000001
THREAD_AFFINITY_GROUP_B: Thread_Affinity : 0x4000000000000002
THREAD_AFFINITY_GROUP_C: Thread_Affinity : 0x4000000000000003
/* Thread defaults */
THREAD_AFFINITY_MIXER: Thread_Affinity : THREAD_AFFINITY_GROUP_A
THREAD_AFFINITY_FEEDER: Thread_Affinity : THREAD_AFFINITY_GROUP_C
THREAD_AFFINITY_STREAM: Thread_Affinity : THREAD_AFFINITY_GROUP_C
THREAD_AFFINITY_FILE: Thread_Affinity : THREAD_AFFINITY_GROUP_C
THREAD_AFFINITY_NONBLOCKING: Thread_Affinity : THREAD_AFFINITY_GROUP_C
THREAD_AFFINITY_RECORD: Thread_Affinity : THREAD_AFFINITY_GROUP_C
THREAD_AFFINITY_GEOMETRY: Thread_Affinity : THREAD_AFFINITY_GROUP_C
THREAD_AFFINITY_PROFILER: Thread_Affinity : THREAD_AFFINITY_GROUP_C
THREAD_AFFINITY_STUDIO_UPDATE: Thread_Affinity : THREAD_AFFINITY_GROUP_B
THREAD_AFFINITY_STUDIO_LOAD_BANK: Thread_Affinity : THREAD_AFFINITY_GROUP_C
THREAD_AFFINITY_STUDIO_LOAD_SAMPLE: Thread_Affinity : THREAD_AFFINITY_GROUP_C
THREAD_AFFINITY_CONVOLUTION1: Thread_Affinity : THREAD_AFFINITY_GROUP_C
THREAD_AFFINITY_CONVOLUTION2: Thread_Affinity : THREAD_AFFINITY_GROUP_C
/* Core mask, valid up to 1 << 62 */
THREAD_AFFINITY_CORE_ALL: Thread_Affinity : 0
THREAD_AFFINITY_CORE_0: Thread_Affinity : (1 << 0)
THREAD_AFFINITY_CORE_1: Thread_Affinity : (1 << 1)
THREAD_AFFINITY_CORE_2: Thread_Affinity : (1 << 2)
THREAD_AFFINITY_CORE_3: Thread_Affinity : (1 << 3)
THREAD_AFFINITY_CORE_4: Thread_Affinity : (1 << 4)
THREAD_AFFINITY_CORE_5: Thread_Affinity : (1 << 5)
THREAD_AFFINITY_CORE_6: Thread_Affinity : (1 << 6)
THREAD_AFFINITY_CORE_7: Thread_Affinity : (1 << 7)
THREAD_AFFINITY_CORE_8: Thread_Affinity : (1 << 8)
THREAD_AFFINITY_CORE_9: Thread_Affinity : (1 << 9)
THREAD_AFFINITY_CORE_10: Thread_Affinity : (1 << 10)
THREAD_AFFINITY_CORE_11: Thread_Affinity : (1 << 11)
THREAD_AFFINITY_CORE_12: Thread_Affinity : (1 << 12)
THREAD_AFFINITY_CORE_13: Thread_Affinity : (1 << 13)
THREAD_AFFINITY_CORE_14: Thread_Affinity : (1 << 14)
THREAD_AFFINITY_CORE_15: Thread_Affinity : (1 << 15)

/* Preset for Reverb_Properties */
PRESET_OFF: Reverb_Properties : {1000, 7, 11, 5000, 100, 100, 100, 250, 0, 20, 96, -80.0}
PRESET_GENERIC: Reverb_Properties : {1500, 7, 11, 5000, 83, 100, 100, 250, 0, 14500, 96, -8.0}
PRESET_PADDEDCELL: Reverb_Properties : {170, 1, 2, 5000, 10, 100, 100, 250, 0, 160, 84, -7.8}
PRESET_ROOM: Reverb_Properties : {400, 2, 3, 5000, 83, 100, 100, 250, 0, 6050, 88, -9.4}
PRESET_BATHROOM: Reverb_Properties : {1500, 7, 11, 5000, 54, 100, 60, 250, 0, 2900, 83, 0.5}
PRESET_LIVINGROOM: Reverb_Properties : {500, 3, 4, 5000, 10, 100, 100, 250, 0, 160, 58, -19.0}
PRESET_STONEROOM: Reverb_Properties : {2300, 12, 17, 5000, 64, 100, 100, 250, 0, 7800, 71, -8.5}
PRESET_AUDITORIUM: Reverb_Properties : {4300, 20, 30, 5000, 59, 100, 100, 250, 0, 5850, 64, -11.7}
PRESET_CONCERTHALL: Reverb_Properties : {3900, 20, 29, 5000, 70, 100, 100, 250, 0, 5650, 80, -9.8}
PRESET_CAVE: Reverb_Properties : {2900, 15, 22, 5000, 100, 100, 100, 250, 0, 20000, 59, -11.3}
PRESET_ARENA: Reverb_Properties : {7200, 20, 30, 5000, 33, 100, 100, 250, 0, 4500, 80, -9.6}
PRESET_HANGAR: Reverb_Properties : {10000, 20, 30, 5000, 23, 100, 100, 250, 0, 3400, 72, -7.4}
PRESET_CARPETTEDHALLWAY: Reverb_Properties : {300, 2, 30, 5000, 10, 100, 100, 250, 0, 500, 56, -24.0}
PRESET_HALLWAY: Reverb_Properties : {1500, 7, 11, 5000, 59, 100, 100, 250, 0, 7800, 87, -5.5}
PRESET_STONECORRIDOR: Reverb_Properties : {270, 13, 20, 5000, 79, 100, 100, 250, 0, 9000, 86, -6.0}
PRESET_ALLEY: Reverb_Properties : {1500, 7, 11, 5000, 86, 100, 100, 250, 0, 8300, 80, -9.8}
PRESET_FOREST: Reverb_Properties : {1500, 162, 88, 5000, 54, 79, 100, 250, 0, 760, 94, -12.3}
PRESET_CITY: Reverb_Properties : {1500, 7, 11, 5000, 67, 50, 100, 250, 0, 4050, 66, -26.0}
PRESET_MOUNTAINS: Reverb_Properties : {1500, 300, 100, 5000, 21, 27, 100, 250, 0, 1220, 82, -24.0}
PRESET_QUARRY: Reverb_Properties : {1500, 61, 25, 5000, 83, 100, 100, 250, 0, 3400, 100, -5.0}
PRESET_PLAIN: Reverb_Properties : {1500, 179, 100, 5000, 50, 21, 100, 250, 0, 1670, 65, -28.0}
PRESET_PARKINGLOT: Reverb_Properties : {1700, 8, 12, 5000, 100, 100, 100, 250, 0, 20000, 56, -19.5}
PRESET_SEWERPIPE: Reverb_Properties : {2800, 14, 21, 5000, 14, 80, 60, 250, 0, 3400, 66, 1.2}
PRESET_UNDERWATER: Reverb_Properties : {1500, 7, 11, 5000, 10, 100, 100, 250, 0, 500, 92, 7.0}

MAX_CHANNEL_WIDTH :: 32
MAX_SYSTEMS :: 8
MAX_LISTENERS :: 8
REVERB_MAXINSTANCES :: 4

Thread_Type :: enum i32 {
    mixer,
    feeder,
    stream,
    file,
    nonblocking,
    record,
    geometry,
    profiler,
    studio_update,
    studio_load_bank,
    studio_load_sample,
    convolution1,
    convolution2,
    max,
}

Result :: enum i32 {
    ok,
    err_badcommand,
    err_channel_alloc,
    err_channel_stolen,
    err_dma,
    err_dsp_connection,
    err_dsp_dontprocess,
    err_dsp_format,
    err_dsp_inuse,
    err_dsp_notfound,
    err_dsp_reserved,
    err_dsp_silence,
    err_dsp_type,
    err_file_bad,
    err_file_couldnotseek,
    err_file_diskejected,
    err_file_eof,
    err_file_endofdata,
    err_file_notfound,
    err_format,
    err_header_mismatch,
    err_http,
    err_http_access,
    err_http_proxy_auth,
    err_http_server_error,
    err_http_timeout,
    err_initialization,
    err_initialized,
    err_internal,
    err_invalid_float,
    err_invalid_handle,
    err_invalid_param,
    err_invalid_position,
    err_invalid_speaker,
    err_invalid_syncpoint,
    err_invalid_thread,
    err_invalid_vector,
    err_maxaudible,
    err_memory,
    err_memory_cantpoint,
    err_needs3d,
    err_needshardware,
    err_net_connect,
    err_net_socket_error,
    err_net_url,
    err_net_would_block,
    err_notready,
    err_output_allocated,
    err_output_createbuffer,
    err_output_drivercall,
    err_output_format,
    err_output_init,
    err_output_nodrivers,
    err_plugin,
    err_plugin_missing,
    err_plugin_resource,
    err_plugin_version,
    err_record,
    err_reverb_channelgroup,
    err_reverb_instance,
    err_subsounds,
    err_subsound_allocated,
    err_subsound_cantmove,
    err_tagnotfound,
    err_toomanychannels,
    err_truncated,
    err_unimplemented,
    err_uninitialized,
    err_unsupported,
    err_version,
    err_event_already_loaded,
    err_event_liveupdate_busy,
    err_event_liveupdate_mismatch,
    err_event_liveupdate_timeout,
    err_event_notfound,
    err_studio_uninitialized,
    err_studio_not_loaded,
    err_invalid_string,
    err_already_locked,
    err_not_locked,
    err_record_disconnected,
    err_toomanysamples,
}

ChannelControl_Type :: enum i32 {
    channel,
    channelgroup,
    max,
}

OutputType :: enum i32 {
    autodetect,
    unknown,
    nosound,
    wavwriter,
    nosound_nrt,
    wavwriter_nrt,
    wasapi,
    asio,
    pulseaudio,
    alsa,
    coreaudio,
    audiotrack,
    opensl,
    audioout,
    audio3d,
    webaudio,
    nnaudio,
    winsonic,
    aaudio,
    audioworklet,
    phase,
    max,
}

Debug_Mode :: enum i32 {
    tty,
    file,
    callback,
}

SpeakerMode :: enum i32 {
    default,
    raw,
    mono,
    stereo,
    quad,
    surround,
    _5point1,
    _7point1,
    _7point1point4,
    max,
}

Speaker :: enum i32 {
    none = -1,
    front_left = 0,
    front_right,
    front_center,
    low_frequency,
    surround_left,
    surround_right,
    back_left,
    back_right,
    top_front_left,
    top_front_right,
    top_back_left,
    top_back_right,
    max,
}

ChannelOrder :: enum i32 {
    default,
    waveformat,
    protools,
    allmono,
    allstereo,
    alsa,
    max,
}

PluginType :: enum i32 {
    output,
    codec,
    dsp,
    max,
}

Sound_Type :: enum i32 {
    unknown,
    aiff,
    asf,
    dls,
    flac,
    fsb,
    it,
    midi,
    mod,
    mpeg,
    oggvorbis,
    playlist,
    raw,
    s3m,
    user,
    wav,
    xm,
    xma,
    audioqueue,
    at9,
    vorbis,
    media_foundation,
    mediacodec,
    fadpcm,
    opus,
    max,
}

Sound_Format :: enum i32 {
    none,
    pcm8,
    pcm16,
    pcm24,
    pcm32,
    pcmfloat,
    bitstream,
    max,
}

OpenState :: enum i32 {
    ready,
    loading,
    error,
    connecting,
    buffering,
    seeking,
    playing,
    setposition,
    max,
}

SoundGroup_Behavior :: enum i32 {
    fail,
    mute,
    steallowest,
    max,
}

ChannelControl_Callback_Type :: enum i32 {
    end,
    virtualvoice,
    syncpoint,
    occlusion,
    max,
}

ChannelControl_DSP_Index :: enum i32 {
    head  = -1,
    fader = -2,
    tail  = -3,
}

ErrorCallback_InstanceType :: enum i32 {
    none,
    system,
    channel,
    channelgroup,
    channelcontrol,
    sound,
    soundgroup,
    dsp,
    dspconnection,
    geometry,
    reverb3d,
    studio_system,
    studio_eventdescription,
    studio_eventinstance,
    studio_parameterinstance,
    studio_bus,
    studio_vca,
    studio_bank,
    studio_commandreplay,
}

DSP_Resampler :: enum i32 {
    default,
    nointerp,
    linear,
    cubic,
    spline,
    max,
}

DSP_Callback_Type :: enum i32 {
    dataparameterrelease,
    max,
}

DSPConnection_Type :: enum i32 {
    standard,
    sidechain,
    send,
    send_sidechain,
    max,
}

TagType :: enum i32 {
    unknown,
    id3v1,
    id3v2,
    vorbiscomment,
    shoutcast,
    icecast,
    asf,
    midi,
    playlist,
    fmod,
    user,
    max,
}

TagDataType :: enum i32 {
    binary,
    int,
    float,
    string,
    string_utf16,
    string_utf16be,
    string_utf8,
    max,
}

Port_Type :: enum i32 {
    music,
    copyright_music,
    voice,
    controller,
    personal,
    vibration,
    aux,
    max,
}


///////////////////////////////////////////////////////////////////////////////////////////////////////
// FMOD callbacks
//

debug_callback :: #type proc "c" (
    flags: Debug_Flags,
    file: cstring,
    line: i32,
    func: cstring,
    message: cstring,
) -> Result

system_callback :: #type proc "c" (
    system: ^System,
    type: System_Callback_Type,
    commanddata1: rawptr,
    commanddata2: rawptr,
    userdata: rawptr,
) -> Result

channelcontrol_callback :: proc "c" (
    channelcontrol: ^ChannelControl,
    controltype: ChannelControl_Type,
    callbacktype: ChannelControl_Callback_Type,
    commanddata1: rawptr,
    commanddata2: rawptr,
) -> Result

dsp_callback :: #type proc "c" (dsp: ^DSP, type: DSP_Callback_Type, data: rawptr) -> Result
sound_nonblock_callback :: #type proc "c" (sound: ^Sound, result: Result) -> Result
sound_pcmread_callback :: #type proc "c" (sound: ^Sound, data: rawptr, datalen: u32) -> Result

sound_pcmsetpos_callback :: #type proc "c" (sound: ^Sound, subsound: i32, position: u32, postype: TimeUnit) -> Result

file_open_callback :: #type proc "c" (name: cstring, filesize: ^u32, handle: ^rawptr, userdata: rawptr) -> Result

file_close_callback :: #type proc "c" (handle: rawptr, userdata: rawptr) -> Result

file_read_callback :: #type proc "c" (
    handle: rawptr,
    buffer: rawptr,
    sizebytes: u32,
    bytesread: ^u32,
    userdata: rawptr,
) -> Result

file_seek_callback :: #type proc "c" (handle: rawptr, pos: u32, userdata: rawptr) -> Result
file_asyncread_callback :: #type proc "c" (info: ^AsyncReadInfo, userdata: rawptr) -> Result
file_asynccancel_callback :: #type proc "c" (info: ^AsyncReadInfo, userdata: rawptr) -> Result

file_asyncdone_func :: #type proc "c" (info: ^AsyncReadInfo, result: Result)
alloc_callback :: #type proc "c" (size: u32, _type: Memory_Type, sourcestr: cstring)

realloc_callback :: #type proc "c" (ptr: rawptr, size: u32, _type: Memory_Type, sourcestr: cstring)

free_callback :: #type proc "c" (ptr: rawptr, _type: Memory_Type, sourcestr: cstring)
_3d_rolloff_callback :: #type proc "c" (channelcontrol: ^ChannelControl, distance: f32) -> f32


///////////////////////////////////////////////////////////////////////////////////////////////////////
// FMOD structs
//

AsyncReadInfo :: struct {
    handle:    rawptr,
    offset:    u32,
    sizebytes: u32,
    priority:  i32,
    userdata:  rawptr,
    buffer:    rawptr,
    bytesread: u32,
    done:      file_asyncdone_func,
}

vec :: [3]f32

_3D_Attributes :: struct {
    position: vec,
    velocity: vec,
    forward:  vec,
    up:       vec,
}

GUID :: struct {
    Data1: u32,
    Data2: u16,
    Data3: u16,
    Data4: [8]u8,
}

PluginList :: struct {
    type:        PluginType,
    description: rawptr,
}

AdvancedSettings :: struct {
    cbSize:                   i32,
    maxMPEGCodecs:            i32,
    maxADPCMCodecs:           i32,
    maxXMACodecs:             i32,
    maxVorbisCodecs:          i32,
    maxAT9Codecs:             i32,
    maxFADPCMCodecs:          i32,
    maxPCMCodecs:             i32,
    ASIONumChannels:          i32,
    ASIOChannelList:          ^rawptr,
    ASIOSpeakerList:          ^Speaker,
    vol0virtualvol:           f32,
    defaultDecodeBufferSize:  u32,
    profilePort:              u16,
    geometryMaxFadeTime:      u32,
    distanceFilterCenterFreq: f32,
    reverb3Dinstance:         i32,
    DSPBufferPoolSize:        i32,
    resamplerMethod:          DSP_Resampler,
    randomSeed:               u32,
    maxConvolutionThreads:    i32,
    maxOpusCodecs:            i32,
}

Tag :: struct {
    type:     TagType,
    datatype: TagDataType,
    name:     [^]byte,
    data:     rawptr,
    datalen:  u32,
    updated:  b32,
}

CreateSoundExInfo :: struct {
    cbsize:              i32,
    length:              u32,
    fileoffset:          u32,
    numchannels:         i32,
    defaultfrequency:    i32,
    format:              Sound_Format,
    decodebuffersize:    u32,
    initialsubsound:     i32,
    numsubsounds:        i32,
    inclusionlist:       ^i32,
    inclusionlistnum:    i32,
    pcmreadcallback:     sound_pcmread_callback,
    pcmsetposcallback:   sound_pcmsetpos_callback,
    nonblockcallback:    sound_nonblock_callback,
    dlsname:             cstring,
    encryptionkey:       cstring,
    maxpolyphony:        i32,
    userdata:            rawptr,
    suggestedsoundtype:  Sound_Type,
    fileuseropen:        file_open_callback,
    fileuserclose:       file_close_callback,
    fileuserread:        file_read_callback,
    fileuserseek:        file_seek_callback,
    fileuserasyncread:   file_asyncread_callback,
    fileuserasynccancel: file_asynccancel_callback,
    fileuserdata:        rawptr,
    filebuffersize:      i32,
    channelorder:        ChannelOrder,
    initialsoundgroup:   ^SoundGroup,
    initialseekposition: u32,
    initialseekpostype:  TimeUnit,
    ignoresetfilesystem: i32,
    audioqueuepolicy:    u32,
    minmidigranularity:  u32,
    nonblockthreadid:    i32,
    fsbguid:             ^GUID,
}

Reverb_Properties :: struct {
    DecayTime:         f32,
    EarlyDelay:        f32,
    LateDelay:         f32,
    HFReference:       f32,
    HFDecayRatio:      f32,
    Diffusion:         f32,
    Density:           f32,
    LowShelfFrequency: f32,
    LowShelfGain:      f32,
    HighCut:           f32,
    EarlyLateMix:      f32,
    WetLevel:          f32,
}

Errorcallback_Info :: struct {
    result:         Result,
    instancetype:   ErrorCallback_InstanceType,
    instance:       rawptr,
    functionname:   cstring,
    functionparams: cstring,
}

CPU_Usage :: struct {
    dsp:          f32,
    stream:       f32,
    geometry:     f32,
    update:       f32,
    convolution1: f32,
    convolution2: f32,
}

DSP_Data_Parameter_Info :: struct {
    data:   rawptr,
    length: u32,
    index:  i32,
}
