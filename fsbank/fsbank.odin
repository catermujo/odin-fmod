package fmod_fsbank

when ODIN_OS == .Windows {
    foreign import lib "fsbank_vc.lib"
} else when ODIN_OS == .Darwin {
    foreign import lib "fsbank.dylib"
}

///////////////////////////////////////////////////////////////////////////////////////////////////////
// FSBank types
//

Init_Flag :: enum u8 {
    // normal ,
    ignoreerrors,
    warningsaserrors,
    createincludeheader,
    dontloadcachefiles,
    generateprogressitems,
}
Init_Flags :: bit_set[Init_Flag;u32]


Build_Flag :: enum u8 {
    // default ,
    disablesyncpoints,
    dontloop,
    filterhighfreq,
    disableseeking,
    optimizesamplerate = 7,
    fsb5_dontwritenames,
    noguid,
    writepeakvolume,
}
Build_Flags :: bit_set[Build_Flag;u32]

Build_CACHE_VALIDATION_MASK: Build_Flags : {.dontloop, .filterhighfreq, .optimizesamplerate}
Build_OVERRIDE_MASK: Build_Flags :
    {.disablesyncpoints, .disableseeking, .writepeakvolume} | Build_CACHE_VALIDATION_MASK

Result :: enum i32 {
    ok,
    err_cache_chunknotfound,
    err_cancelled,
    err_cannot_continue,
    err_encoder,
    err_encoder_init,
    err_encoder_notsupported,
    err_file_os,
    err_file_notfound,
    err_fmod,
    err_initialized,
    err_invalid_format,
    err_invalid_param,
    err_memory,
    err_uninitialized,
    err_writer_format,
    warn_cannotloop,
    warn_ignored_filterhighfreq,
    warn_ignored_disableseeking,
    warn_forced_dontwritenames,
    err_encoder_file_notfound,
    err_encoder_file_bad,
}

Format :: enum i32 {
    pcm,
    xma,
    at9,
    vorbis,
    fadpcm,
    opus,
}

State :: enum i32 {
    decoding,
    analysing,
    preprocessing,
    encoding,
    writing,
    finished,
    failed,
    warning,
}

SubSound :: struct {
    fileNames:            [^]cstring,
    fileData:             [^]rawptr,
    fileDataLengths:      [^]u32,
    numFiles:             u32,
    overrideFlags:        Build_Flags,
    overrideQuality:      u32,
    desiredSampleRate:    f32,
    percentOptimizedRate: f32,
}

ProgressItem :: struct {
    subSoundIndex: int,
    threadIndex:   int,
    state:         State,
    stateData:     rawptr,
}

Statedata_Failed :: struct {
    errorCode:   Result,
    errorString: [256]u8,
}

Statedata_Warning :: struct {
    warnCode:      Result,
    warningString: [256]u8,
}

alloc_callback :: #type proc(size: u32, type: u32, sourceStr: cstring) -> rawptr
realloc_callback :: #type proc(ptr: rawptr, size: u32, type: u32, sourceStr: cstring) -> rawptr
free_callback :: #type proc(ptr: rawptr, type: u32, sourceStr: cstring)

FSBVERSION_FSB5 :: 0
// FSBVERSION :: enum i32 {
//     FSBVERSION_FSB5,
// }

@(default_calling_convention = "c", link_prefix = "FSBank_")
foreign lib {
    MemoryInit :: proc(userAlloc: alloc_callback, userRealloc: realloc_callback, userFree: free_callback) -> Result ---
    Init :: proc(version: i32, flags: Init_Flags, numSimultaneousJobs: u32, cacheDirectory: cstring) -> Result ---
    Release :: proc() -> Result ---
    Build :: proc(subSounds: [^]SubSound, numSubSounds: u32, encodeFormat: Format, buildFlags: Build_Flags, quality: u32, encryptKey: cstring, outputFileName: cstring) -> Result ---
    FetchFSBMemory :: proc(data: ^rawptr, length: ^u32) -> Result ---
    BuildCancel :: proc() -> Result ---
    FetchNextProgressItem :: proc(progressItem: ^^ProgressItem) -> Result ---
    ReleaseProgressItem :: proc(#by_ptr progressItem: ProgressItem) -> Result ---
    MemoryGetStats :: proc(currentAllocated: ^u32, maximumAllocated: ^u32) -> Result ---
}
