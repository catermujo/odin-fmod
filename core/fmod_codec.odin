package fmod_core

/* ======================================================================================== */
/* FMOD Core API - Codec development header file.                                           */
/* Copyright (c), Firelight Technologies Pty, Ltd. 2004-2023.                               */
/*                                                                                          */
/* Use this header if you are wanting to develop your own file format plugin to use with    */
/* FMOD's codec system.  With this header you can make your own fileformat plugin that FMOD */
/* can register and use.  See the documentation and examples on how to make a working       */
/* plugin.                                                                                  */
/*                                                                                          */
/* For more detail visit:                                                                   */
/* https://fmod.com/docs/2.02/api/core-api.html                                             */
/* ======================================================================================== */


///////////////////////////////////////////////////////////////////////////////////////////////////////
// Codec constants
//

CODEC_PLUGIN_VERSION :: 1

Codec_Seek_Method :: enum i32 {
    set     = 0,
    current = 1,
    end     = 2,
}


///////////////////////////////////////////////////////////////////////////////////////////////////////
// Codec callbacks
//

codec_open_callback :: #type proc "c" (
    codec_state: ^Codec_State,
    usermode: Mode,
    userexinfo: ^CreateSoundExInfo,
) -> Result

codec_close_callback :: #type proc "c" (codec_state: ^Codec_State) -> Result

codec_read_callback :: #type proc "c" (
    codec_state: ^Codec_State,
    buffer: rawptr,
    samples_in: u32,
    samples_out: ^u32,
) -> Result

codec_getlength_callback :: #type proc "c" (codec_state: ^Codec_State, length: ^u32, lengthtype: TimeUnit) -> Result

codec_setposition_callback :: #type proc "c" (
    codec_state: ^Codec_State,
    subsound: i32,
    position: u32,
    postype: TimeUnit,
) -> Result

codec_getposition_callback :: #type proc "c" (codec_state: ^Codec_State, position: ^u32, postype: TimeUnit) -> Result

codec_soundcreate_callback :: #type proc "c" (codec_state: ^Codec_State, subsound: i32, sound: ^Sound) -> Result

codec_getwaveformat_callback :: #type proc "c" (
    codec_state: ^Codec_State,
    index: i32,
    waveformat: ^Codec_Waveformat,
) -> Result


///////////////////////////////////////////////////////////////////////////////////////////////////////
// Codec functions
//

codec_metadata_func :: #type proc "c" (
    codec_state: ^Codec_State,
    tagtype: TagType,
    name: [^]u8,
    data: rawptr,
    datalen: u32,
    datatype: TagDataType,
    unique: i32,
) -> Result

codec_alloc_func :: #type proc "c" (size: u32, align: u32, file: cstring, line: i32) -> rawptr
codec_free_func :: #type proc "c" (ptr: rawptr, file: cstring, line: i32)

codec_log_func :: #type proc "c" (
    level: Debug_Flags,
    file: cstring,
    line: i32,
    function: cstring,
    str: cstring,
    #c_vararg args: ..any,
)

codec_file_read_func :: #type proc "c" (
    codec_state: ^Codec_State,
    buffer: rawptr,
    sizebytes: u32,
    bytesread: ^u32,
) -> Result

codec_file_seek_func :: #type proc "c" (codec_state: ^Codec_State, pos: u32, method: Codec_Seek_Method) -> Result

codec_file_tell_func :: #type proc "c" (codec_state: ^Codec_State, pos: ^u32) -> Result
codec_file_size_func :: #type proc "c" (codec_state: ^Codec_State, size: ^u32) -> Result


///////////////////////////////////////////////////////////////////////////////////////////////////////
// Codec structures
//

Codec_Description :: struct {
    apiversion:      u32,
    name:            cstring,
    version:         u32,
    defaultasstream: i32,
    timeunits:       TimeUnit,
    open:            codec_open_callback,
    close:           codec_close_callback,
    read:            codec_read_callback,
    getlength:       codec_getlength_callback,
    setposition:     codec_setposition_callback,
    getposition:     codec_getposition_callback,
    soundcreate:     codec_soundcreate_callback,
    getwaveformat:   codec_getwaveformat_callback,
}

Codec_Waveformat :: struct {
    name:         cstring,
    format:       Sound_Format,
    channels:     i32,
    frequency:    i32,
    lengthbytes:  u32,
    lengthpcm:    u32,
    pcmblocksize: u32,
    loopstart:    i32,
    loopend:      i32,
    mode:         Mode,
    channelmask:  ChannelMask,
    channelorder: ChannelOrder,
    peakvolume:   f32,
}

Codec_State_Functions :: struct {
    metadata: codec_metadata_func,
    alloc:    codec_alloc_func,
    free:     codec_free_func,
    log:      codec_log_func,
    read:     codec_file_read_func,
    seek:     codec_file_seek_func,
    tell:     codec_file_tell_func,
    size:     codec_file_size_func,
}

Codec_State :: struct {
    plugindata:   rawptr,
    waveformat:   ^Codec_Waveformat,
    functions:    ^Codec_State_Functions,
    numsubsounds: i32,
}


///////////////////////////////////////////////////////////////////////////////////////////////////////
// Codec macros
//

/*
#define CODEC_METADATA(_state, _tagtype, _name, _data, _datalen, _datatype, _unique) \
    (_state)->functions->metadata(_state, _tagtype, _name, _data, _datalen, _datatype, _unique)
#define CODEC_ALLOC(_state, _size, _align) \
    (_state)->functions->alloc(_size, _align, __FILE__, __LINE__)
#define CODEC_FREE(_state, _ptr) \
    (_state)->functions->free(_ptr, __FILE__, __LINE__)
#define CODEC_LOG(_state, _level, _location, _format, ...) \
    (_state)->functions->log(_level, __FILE__, __LINE__, _location, _format, __VA_ARGS__)
#define CODEC_FILE_READ(_state, _buffer, _sizebytes, _bytesread) \
    (_state)->functions->read(_state, _buffer, _sizebytes, _bytesread)
#define CODEC_FILE_SEEK(_state, _pos, _method) \
    (_state)->functions->seek(_state, _pos, _method)
#define CODEC_FILE_TELL(_state, _pos) \
    (_state)->functions->tell(_state, _pos)
#define CODEC_FILE_SIZE(_state, _size) \
    (_state)->functions->size(_state, _size)
*/
