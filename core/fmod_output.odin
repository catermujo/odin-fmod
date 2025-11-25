package fmod_core

/* ======================================================================================== */
/* FMOD Core API - output development header file.                                          */
/* Copyright (c), Firelight Technologies Pty, Ltd. 2004-2023.                               */
/*                                                                                          */
/* Use this header if you are wanting to develop your own output plugin to use with         */
/* FMOD's output system.  With this header you can make your own output plugin that FMOD    */
/* can register and use.  See the documentation and examples on how to make a working       */
/* plugin.                                                                                  */
/*                                                                                          */
/* For more detail visit:                                                                   */
/* https://fmod.com/docs/2.02/api/plugin-api-output.html                                    */
/* ======================================================================================== */


///////////////////////////////////////////////////////////////////////////////////////////////////////
// Output constants
//

OUTPUT_PLUGIN_VERSION :: 5

Output_Method :: enum u32 {
    direct   = 0,
    buffered = 1,
}


///////////////////////////////////////////////////////////////////////////////////////////////////////
// Output callbacks
//

output_getnumdrivers_callback :: #type proc "c" (output_state: ^Output_State, numdrivers: ^i32) -> Result

output_getdriverinfo_callback :: #type proc "c" (
    output_state: ^Output_State,
    id: i32,
    name: [^]u8,
    namelen: i32,
    guid: ^GUID,
    systemrate: ^i32,
    speakermode: ^SpeakerMode,
    speakermodechannels: ^i32,
) -> Result

output_init_callback :: #type proc "c" (
    output_state: ^Output_State,
    selecteddriver: i32,
    flags: Init_Flags,
    outputrate: ^i32,
    speakermode: ^SpeakerMode,
    speakermodechannels: ^i32,
    outputformat: ^Sound_Format,
    dspbufferlength: i32,
    dspnumbuffers: ^i32,
    dspnumadditionalbuffers: ^i32,
    extradriverdata: rawptr,
) -> Result

output_start_callback :: #type proc "c" (output_state: ^Output_State) -> Result
output_stop_callback :: #type proc "c" (output_state: ^Output_State) -> Result
output_close_callback :: #type proc "c" (output_state: ^Output_State) -> Result
output_update_callback :: #type proc "c" (output_state: ^Output_State) -> Result
output_gethandle_callback :: #type proc "c" (output_state: ^Output_State, handle: ^rawptr) -> Result
output_mixer_callback :: #type proc "c" (output_state: ^Output_State) -> Result

output_object3dgetinfo_callback :: #type proc "c" (output_state: ^Output_State, maxhardwareobjects: ^i32) -> Result

output_object3dalloc_callback :: #type proc "c" (output_state: ^Output_State, object3d: ^rawptr) -> Result

output_object3dfree_callback :: #type proc "c" (output_state: ^Output_State, object3d: rawptr) -> Result

output_object3dupdate_callback :: #type proc "c" (
    output_state: ^Output_State,
    object3d: rawptr,
    #by_ptr info: Output_Object3DInfo,
) -> Result

output_openport_callback :: #type proc "c" (
    output_state: ^Output_State,
    portType: Port_Type,
    portIndex: Port_Index,
    portId: ^i32,
    portRate: ^i32,
    portChannels: ^i32,
    portFormat: ^Sound_Format,
) -> Result

output_closeport_callback :: #type proc "c" (output_state: ^Output_State, portId: i32) -> Result
output_devicelistchanged_callback :: #type proc "c" (output_state: ^Output_State) -> Result

output_readfrommixer_func :: #type proc "c" (output_state: ^Output_State, buffer: rawptr, length: u32) -> Result

output_copyport_func :: #type proc "c" (
    output_state: ^Output_State,
    portId: i32,
    buffer: rawptr,
    length: u32,
) -> Result

output_requestreset_func :: #type proc "c" (output_state: ^Output_State) -> Result
output_alloc_func :: #type proc "c" (size: u32, align: u32, file: cstring, line: i32) -> rawptr
output_free_func :: #type proc "c" (ptr: rawptr, file: cstring, line: i32)

output_log_func :: #type proc "c" (
    level: Debug_Flags,
    file: cstring,
    line: i32,
    function: cstring,
    str: cstring,
    #c_vararg args: ..any,
)


///////////////////////////////////////////////////////////////////////////////////////////////////////
// Output structures
//

Output_Description :: struct {
    apiversion:        u32,
    name:              cstring,
    version:           u32,
    method:            Output_Method,
    getnumdrivers:     output_getnumdrivers_callback,
    getdriverinfo:     output_getdriverinfo_callback,
    init:              output_init_callback,
    start:             output_start_callback,
    stop:              output_stop_callback,
    close:             output_close_callback,
    update:            output_update_callback,
    gethandle:         output_gethandle_callback,
    mixer:             output_mixer_callback,
    object3dgetinfo:   output_object3dgetinfo_callback,
    object3dalloc:     output_object3dalloc_callback,
    object3dfree:      output_object3dfree_callback,
    object3dupdate:    output_object3dupdate_callback,
    openport:          output_openport_callback,
    closeport:         output_closeport_callback,
    devicelistchanged: output_devicelistchanged_callback,
}

Output_State :: struct {
    plugindata:    rawptr,
    readfrommixer: output_readfrommixer_func,
    alloc:         output_alloc_func,
    free:          output_free_func,
    log:           output_log_func,
    copyport:      output_copyport_func,
    requestreset:  output_requestreset_func,
}

Output_Object3DInfo :: struct {
    buffer:       [^]f32,
    bufferlength: u32,
    position:     vec,
    gain:         f32,
    spread:       f32,
    priority:     f32,
}


///////////////////////////////////////////////////////////////////////////////////////////////////////
// Output macros
//

/*
#define OUTPUT_READFROMMIXER(_state, _buffer, _length) \
    (_state)->readfrommixer(_state, _buffer, _length)
#define OUTPUT_ALLOC(_state, _size, _align) \
    (_state)->alloc(_size, _align, __FILE__, __LINE__)
#define OUTPUT_FREE(_state, _ptr) \
    (_state)->free(_ptr, __FILE__, __LINE__)
#define OUTPUT_LOG(_state, _level, _location, _format, ...) \
    (_state)->log(_level, __FILE__, __LINE__, _location, _format, ##__VA_ARGS__)
#define OUTPUT_COPYPORT(_state, _id, _buffer, _length) \
    (_state)->copyport(_state, _id, _buffer, _length)
#define OUTPUT_REQUESTRESET(_state) \
    (_state)->requestreset(_state)
*/
