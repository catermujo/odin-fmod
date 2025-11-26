package fmod_studio

/* ======================================================================================== */
/* FMOD Studio API - Common C/C++ header file.                                              */
/* Copyright (c), Firelight Technologies Pty, Ltd. 2004-2023.                               */
/*                                                                                          */
/* This header defines common enumerations, structs and callbacks that are shared between   */
/* the C and C++ interfaces.                                                                */
/*                                                                                          */
/* For more detail visit:                                                                   */
/* https://fmod.com/docs/2.03/api/studio-api.html                                           */
/* ======================================================================================== */

import fmod "../core"


///////////////////////////////////////////////////////////////////////////////////////////////////////
// FMOD Studio types
//

System :: struct {}
EventDescription :: struct {}
EventInstance :: struct {}
Bus :: struct {}
VCA :: struct {}
Bank :: struct {}
CommandReplay :: struct {}


LOAD_MEMORY_ALIGNMENT :: 32

Init_Flag :: enum u8 {
    // normal,
    liveupdate,
    allow_missing_plugins,
    synchronous_update,
    deferred_callbacks,
    load_from_update,
    memory_tracking,
}
Init_Flags :: bit_set[Init_Flag;u32]

Parameter_Flag :: enum u8 {
    readonly,
    automatic,
    global,
    discrete,
    labeled,
}
Parameter_Flags :: bit_set[Parameter_Flag;u32]

_System_Callback_Type :: enum u8 {
    preupdate,
    postupdate,
    bank_unload,
    liveupdate_connected,
    liveupdate_disconnected,
}
System_Callback_Type :: bit_set[_System_Callback_Type;u32]

System_Callback_ALL: System_Callback_Type : ~{}

_Event_Callback_Type :: enum u8 {
    created,
    destroyed,
    starting,
    started,
    restarted,
    stopped,
    start_failed,
    create_programmer_sound,
    destroy_programmer_sound,
    plugin_created,
    plugin_destroyed,
    timeline_marker,
    timeline_beat,
    sound_played,
    sound_stopped,
    real_to_virtual,
    virtual_to_real,
    start_event_command,
    nested_timeline_beat,
}

Event_Callback_Type :: bit_set[_Event_Callback_Type;u32]
Event_Callback_ALL: Event_Callback_Type : ~{}

Load_Bank_Flag :: enum u8 {
    // normal ,
    nonblocking,
    decompress_samples,
    unencrypted,
}
Load_Bank_Flags :: bit_set[Load_Bank_Flag;u32]

CommandCapture_Flag :: enum u8 {
    // normal ,
    fileflush,
    skip_initial_state,
}
CommandCapture_Flags :: bit_set[CommandCapture_Flag;u32]

CommandReplay_Flag :: enum u8 {
    // CommandReplay_NORMAL :: 0x00000000
    skip_cleanup,
    fast_forward,
    skip_bank_load,
}
CommandReplay_Flags :: bit_set[CommandReplay_Flag;u32]

Loading_State :: enum i32 {
    unloading,
    unloaded,
    loading,
    loaded,
    error,
}

Load_Memory_Mode :: enum i32 {
    load_memory,
    load_memory_point,
}

Parameter_Type :: enum i32 {
    game_controlled,
    automatic_distance,
    automatic_event_cone_angle,
    automatic_event_orientation,
    automatic_direction,
    automatic_elevation,
    automatic_listener_orientation,
    automatic_speed,
    automatic_speed_absolute,
    automatic_distance_normalized,
}

User_Property_Type :: enum i32 {
    integer,
    boolean,
    float,
    string,
}

Event_Property :: enum i32 {
    channelpriority,
    schedule_delay,
    schedule_lookahead,
    minimum_distance,
    maximum_distance,
    cooldown,
    max,
}

Playback_State :: enum i32 {
    playing,
    sustaining,
    stopped,
    starting,
    stopping,
}

Stop_Mode :: enum i32 {
    allowfadeout,
    immediate,
}

InstanceType :: enum i32 {
    none,
    system,
    eventdescription,
    eventinstance,
    parameterinstance,
    bus,
    vca,
    bank,
    commandreplay,
}


///////////////////////////////////////////////////////////////////////////////////////////////////////
// FMOD Studio structures
//

Bank_Info :: struct {
    size:           i32,
    userdata:       rawptr,
    userdatalength: i32,
    opencallback:   fmod.file_open_callback,
    closecallback:  fmod.file_close_callback,
    readcallback:   fmod.file_read_callback,
    seekcallback:   fmod.file_seek_callback,
}

Parameter_ID :: struct {
    data1: u32,
    data2: u32,
}

Parameter_Description :: struct {
    name:         cstring,
    id:           Parameter_ID,
    minimum:      f32,
    maximum:      f32,
    defaultvalue: f32,
    type:         Parameter_Type,
    flags:        Parameter_Flags,
    guid:         fmod.GUID,
}

User_Property :: struct {
    name:       cstring,
    type:       User_Property_Type,
    using data: struct #raw_union {
        i32value:    i32,
        boolvalue:   b32,
        f32value:    f32,
        stringvalue: cstring,
    },
}

Programmer_Sound_Properties :: struct {
    name:          cstring,
    sound:         ^fmod.Sound,
    subsoundIndex: i32,
}

Plugin_Instance_Properties :: struct {
    name: cstring,
    dsp:  ^fmod.DSP,
}

Timeline_Marker_Properties :: struct {
    name:     cstring,
    position: i32,
}

Timeline_Beat_Properties :: struct {
    bar:                i32,
    beat:               i32,
    position:           i32,
    tempo:              f32,
    timesignatureupper: i32,
    timesignaturelower: i32,
}

Timeline_Nested_Beat_Properties :: struct {
    eventid:    fmod.GUID,
    properties: Timeline_Beat_Properties,
}

AdvancedSettings :: struct {
    cbsize:                 i32,
    commandqueuesize:       u32,
    handleinitialsize:      u32,
    studioupdateperiod:     i32,
    idlesampledatapoolsize: i32,
    streamingscheduledelay: u32,
    encryptionkey:          cstring,
}

CPU_Usage :: struct {
    update: f32,
}

Buffer_Info :: struct {
    currentusage: i32,
    peakusage:    i32,
    capacity:     i32,
    stallcount:   i32,
    stalltime:    f32,
}

Buffer_Usage :: struct {
    studiocommandqueue: Buffer_Info,
    studiohandle:       Buffer_Info,
}

Sound_Info :: struct {
    name_or_data:  cstring,
    mode:          fmod.Mode,
    exinfo:        fmod.CreateSoundExInfo,
    subsoundindex: i32,
}

Command_Info :: struct {
    commandname:        cstring,
    parentcommandindex: i32,
    framenumber:        i32,
    frametime:          f32,
    instancetype:       InstanceType,
    outputtype:         InstanceType,
    instancehandle:     u32,
    outputhandle:       u32,
}

Memory_Usage :: struct {
    exclusive:  i32,
    inclusive:  i32,
    sampledata: i32,
}


///////////////////////////////////////////////////////////////////////////////////////////////////////
// FMOD Studio callbacks.
//


system_callback :: #type proc(
    system: ^System,
    _type: System_Callback_Type,
    commanddata: rawptr,
    userdata: rawptr,
) -> fmod.Result

event_callback :: #type proc(_type: Event_Callback_Type, event: ^EventInstance, parameters: rawptr) -> fmod.Result

commandreplay_frame_callback :: #type proc(
    replay: ^CommandReplay,
    commandindex: i32,
    currenttime: f32,
    userdata: rawptr,
) -> fmod.Result

commandreplay_load_bank_callback :: #type proc(
    replay: ^CommandReplay,
    commandindex: i32,
    #by_ptr bankguid: fmod.GUID,
    bankfilename: cstring,
    flags: Load_Bank_Flags,
    bank: ^^Bank,
    userdata: rawptr,
) -> fmod.Result

commandreplay_create_instance_callback :: #type proc(
    replay: ^CommandReplay,
    commandindex: i32,
    eventdescription: ^EventDescription,
    instance: ^^EventInstance,
    userdata: rawptr,
) -> fmod.Result
