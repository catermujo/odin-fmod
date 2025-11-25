package fmod_core

// ========================================================================================
// FMOD Core API - C header file.
// Copyright (c), Firelight Technologies Pty, Ltd. 2004-2023.
//
// Use this header in conjunction with fmod_common.h (which contains all the constants /
// callbacks) to develop using the C interface
//
// For more detail visit:
// https://fmod.com/docs/2.02/api/core-api.html
// ========================================================================================

LOGGING_ENABLED :: #config(FMOD_LOGGING_ENABLED, ODIN_DEBUG)

when ODIN_OS == .Windows {
    when LOGGING_ENABLED {
        foreign import lib "fmodL_vc.lib"
    } else {
        foreign import lib "fmod_vc.lib"
    }
} else when ODIN_OS == .Darwin {
    when LOGGING_ENABLED {
        foreign import lib "libfmodL.dylib"
    } else {
        foreign import lib "libfmod.dylib"
    }
}

@(default_calling_convention = "c", link_prefix = "FMOD_")
foreign lib {
    ///////////////////////////////////////////////////////////////////////////////////////////////////////
    // FMOD global system functions (optional).
    //

    Memory_Initialize :: proc(poolmem: rawptr, poollen: i32, useralloc: alloc_callback, userrealloc: realloc_callback, userfree: free_callback, memtypeflags: Memory_Type) -> Result ---
    Memory_GetStats :: proc(currentalloced: ^i32, maxalloced: ^i32, blocking: b32) -> Result ---
    Debug_Initialize :: proc(flags: Debug_Flags, mode: Debug_Mode, callback: debug_callback, filename: cstring) -> Result ---
    File_SetDiskBusy :: proc(busy: i32) -> Result ---
    File_GetDiskBusy :: proc(busy: ^i32) -> Result ---
    Thread_SetAttributes :: proc(_type: Thread_Type, affinity: Thread_Affinity, priority: Thread_Priority, stacksize: Thread_Stack_Size) -> Result ---


    ///////////////////////////////////////////////////////////////////////////////////////////////////////
    // FMOD System factory functions.  Use this to create an FMOD System Instance.  below you will see System_Init/Close to get started.
    //
    System_Create :: proc(system: ^^System, headerversion: u32) -> Result ---
    System_Release :: proc(system: ^System) -> Result ---


    ///////////////////////////////////////////////////////////////////////////////////////////////////////
    // 'System' API
    //

    // Setup functions.
    System_SetOutput :: proc(system: ^System, output: OutputType) -> Result ---
    System_GetOutput :: proc(system: ^System, output: ^OutputType) -> Result ---
    System_GetNumDrivers :: proc(system: ^System, numdrivers: ^i32) -> Result ---
    System_GetDriverInfo :: proc(system: ^System, id: i32, name: ^u8, namelen: i32, guid: ^GUID, systemrate: ^i32, speakermode: ^SpeakerMode, speakermodechannels: ^i32) -> Result ---
    System_SetDriver :: proc(system: ^System, driver: i32) -> Result ---
    System_GetDriver :: proc(system: ^System, driver: ^i32) -> Result ---
    System_SetSoftwareChannels :: proc(system: ^System, numsoftwarechannels: i32) -> Result ---
    System_GetSoftwareChannels :: proc(system: ^System, numsoftwarechannels: ^i32) -> Result ---
    System_SetSoftwareFormat :: proc(system: ^System, samplerate: i32, speakermode: SpeakerMode, numrawspeakers: i32) -> Result ---
    System_GetSoftwareFormat :: proc(system: ^System, samplerate: ^i32, speakermode: ^SpeakerMode, numrawspeakers: ^i32) -> Result ---
    System_SetDSPBufferSize :: proc(system: ^System, bufferlength: u32, numbuffers: i32) -> Result ---
    System_GetDSPBufferSize :: proc(system: ^System, bufferlength: ^u32, numbuffers: ^i32) -> Result ---
    System_SetFileSystem :: proc(system: ^System, useropen: file_open_callback, userclose: file_close_callback, userread: file_read_callback, userseek: file_seek_callback, userasyncread: file_asyncread_callback, userasynccancel: file_asynccancel_callback, blockalign: i32) -> Result ---
    System_AttachFileSystem :: proc(system: ^System, useropen: file_open_callback, userclose: file_close_callback, userread: file_read_callback, userseek: file_seek_callback) -> Result ---
    System_SetAdvancedSettings :: proc(system: ^System, settings: ^AdvancedSettings) -> Result ---
    System_GetAdvancedSettings :: proc(system: ^System, settings: ^AdvancedSettings) -> Result ---
    System_SetCallback :: proc(system: ^System, callback: system_callback, callbackmask: System_Callback_Type) -> Result ---

    // Plug-in support.
    System_SetPluginPath :: proc(system: ^System, path: cstring) -> Result ---
    System_LoadPlugin :: proc(system: ^System, filename: cstring, handle: ^u32, priority: u32) -> Result ---
    System_UnloadPlugin :: proc(system: ^System, handle: u32) -> Result ---
    System_GetNumNestedPlugins :: proc(system: ^System, handle: u32, count: ^i32) -> Result ---
    System_GetNestedPlugin :: proc(system: ^System, handle: u32, index: i32, nestedhandle: ^u32) -> Result ---
    System_GetNumPlugins :: proc(system: ^System, plugintype: PluginType, numplugins: ^i32) -> Result ---
    System_GetPluginHandle :: proc(system: ^System, plugintype: PluginType, index: i32, handle: ^u32) -> Result ---
    System_GetPluginInfo :: proc(system: ^System, handle: u32, plugintype: ^PluginType, name: ^u8, namelen: i32, version: ^u32) -> Result ---
    System_SetOutputByPlugin :: proc(system: ^System, handle: u32) -> Result ---
    System_GetOutputByPlugin :: proc(system: ^System, handle: ^u32) -> Result ---
    System_CreateDSPByPlugin :: proc(system: ^System, handle: u32, dsp: ^^DSP) -> Result ---
    System_GetDSPInfoByPlugin :: proc(system: ^System, handle: u32, description: ^^DSP_Description) -> Result ---
    System_RegisterCodec :: proc(system: ^System, description: ^Codec_Description, handle: ^u32, priority: u32) -> Result ---
    System_RegisterDSP :: proc(system: ^System, #by_ptr description: DSP_Description, handle: ^u32) -> Result ---
    System_RegisterOutput :: proc(system: ^System, #by_ptr description: Output_Description, handle: ^u32) -> Result ---

    // Init/Close.
    System_Init :: proc(system: ^System, maxchannels: i32, flags: Init_Flags, extradriverdata: rawptr) -> Result ---
    System_Close :: proc(system: ^System) -> Result ---

    // General post-init system functions.
    System_Update :: proc(system: ^System) -> Result ---
    System_SetSpeakerPosition :: proc(system: ^System, speaker: Speaker, x: f32, y: f32, active: b32) -> Result ---
    System_GetSpeakerPosition :: proc(system: ^System, speaker: Speaker, x: ^f32, y: ^f32, active: ^b32) -> Result ---
    System_SetStreamBufferSize :: proc(system: ^System, filebuffersize: u32, filebuffersizetype: TimeUnit) -> Result ---
    System_GetStreamBufferSize :: proc(system: ^System, filebuffersize: ^u32, filebuffersizetype: ^TimeUnit) -> Result ---
    System_Set3DSettings :: proc(system: ^System, dopplerscale: f32, distancefactor: f32, rolloffscale: f32) -> Result ---
    System_Get3DSettings :: proc(system: ^System, dopplerscale: ^f32, distancefactor: ^f32, rolloffscale: ^f32) -> Result ---
    System_Set3DNumListeners :: proc(system: ^System, numlisteners: i32) -> Result ---
    System_Get3DNumListeners :: proc(system: ^System, numlisteners: ^i32) -> Result ---
    System_Set3DListenerAttributes :: proc(system: ^System, listener: i32, #by_ptr pos: vec, #by_ptr vel: vec, #by_ptr forward: vec, #by_ptr up: vec) -> Result ---
    System_Get3DListenerAttributes :: proc(system: ^System, listener: i32, pos: ^vec, vel: ^vec, forward: ^vec, up: ^vec) -> Result ---
    System_Set3DRolloffCallback :: proc(system: ^System, callback: _3d_rolloff_callback) -> Result ---
    System_MixerSuspend :: proc(system: ^System) -> Result ---
    System_MixerResume :: proc(system: ^System) -> Result ---
    System_GetDefaultMixMatrix :: proc(system: ^System, sourcespeakermode: SpeakerMode, targetspeakermode: SpeakerMode, _matrix: ^f32, matrixhop: i32) -> Result ---
    System_GetSpeakerModeChannels :: proc(system: ^System, mode: SpeakerMode, channels: ^i32) -> Result ---

    // System information functions.
    System_GetVersion :: proc(system: ^System, version: ^u32) -> Result ---
    System_GetOutputHandle :: proc(system: ^System, handle: ^rawptr) -> Result ---
    System_GetChannelsPlaying :: proc(system: ^System, channels: ^i32, realchannels: ^i32) -> Result ---
    System_GetCPUUsage :: proc(system: ^System, usage: ^CPU_Usage) -> Result ---
    System_GetFileUsage :: proc(system: ^System, sampleBytesRead: ^int, streamBytesRead: ^int, otherBytesRead: ^int) -> Result ---

    // Sound/DSP/Channel/FX creation and retrieval.
    System_CreateSound :: proc(system: ^System, name_or_data: cstring, mode: Mode, exinfo: ^CreateSoundExInfo, sound: ^^Sound) -> Result ---
    System_CreateStream :: proc(system: ^System, name_or_data: cstring, mode: Mode, exinfo: ^CreateSoundExInfo, sound: ^^Sound) -> Result ---
    System_CreateDSP :: proc(system: ^System, #by_ptr description: DSP_Description, dsp: ^^DSP) -> Result ---
    System_CreateDSPByType :: proc(system: ^System, _type: DSP_Type, dsp: ^^DSP) -> Result ---
    System_CreateChannelGroup :: proc(system: ^System, name: cstring, channelgroup: ^^ChannelGroup) -> Result ---
    System_CreateSoundGroup :: proc(system: ^System, name: cstring, soundgroup: ^^SoundGroup) -> Result ---
    System_CreateReverb3D :: proc(system: ^System, reverb: ^^Reverb3D) -> Result ---
    System_PlaySound :: proc(system: ^System, sound: ^Sound, channelgroup: ^ChannelGroup, paused: b32, channel: ^^Channel) -> Result ---
    System_PlayDSP :: proc(system: ^System, dsp: ^DSP, channelgroup: ^ChannelGroup, paused: b32, channel: ^^Channel) -> Result ---
    System_GetChannel :: proc(system: ^System, channelid: i32, channel: ^^Channel) -> Result ---
    System_GetDSPInfoByType :: proc(system: ^System, _type: DSP_Type, description: ^^DSP_Description) -> Result ---
    System_GetMasterChannelGroup :: proc(system: ^System, channelgroup: ^^ChannelGroup) -> Result ---
    System_GetMasterSoundGroup :: proc(system: ^System, soundgroup: ^^SoundGroup) -> Result ---

    // Routing to ports.
    System_AttachChannelGroupToPort :: proc(system: ^System, portType: Port_Type, portIndex: Port_Index, channelgroup: ^ChannelGroup, passThru: b32) -> Result ---
    System_DetachChannelGroupFromPort :: proc(system: ^System, channelgroup: ^ChannelGroup) -> Result ---

    // Reverb API.
    System_SetReverbProperties :: proc(system: ^System, instance: i32, #by_ptr prop: Reverb_Properties) -> Result ---
    System_GetReverbProperties :: proc(system: ^System, instance: i32, prop: ^Reverb_Properties) -> Result ---

    // System level DSP functionality.
    System_LockDSP :: proc(system: ^System) -> Result ---
    System_UnlockDSP :: proc(system: ^System) -> Result ---

    // Recording API.
    System_GetRecordNumDrivers :: proc(system: ^System, numdrivers: ^i32, numconnected: ^i32) -> Result ---
    System_GetRecordDriverInfo :: proc(system: ^System, id: i32, name: ^u8, namelen: i32, guid: ^GUID, systemrate: ^i32, speakermode: ^SpeakerMode, speakermodechannels: ^i32, state: ^Driver_State) -> Result ---
    System_GetRecordPosition :: proc(system: ^System, id: i32, position: ^u32) -> Result ---
    System_RecordStart :: proc(system: ^System, id: i32, sound: ^Sound, loop: b32) -> Result ---
    System_RecordStop :: proc(system: ^System, id: i32) -> Result ---
    System_IsRecording :: proc(system: ^System, id: i32, recording: ^b32) -> Result ---

    // Geometry API.
    System_CreateGeometry :: proc(system: ^System, maxpolygons: i32, maxvertices: i32, geometry: ^^Geometry) -> Result ---
    System_SetGeometrySettings :: proc(system: ^System, maxworldsize: f32) -> Result ---
    System_GetGeometrySettings :: proc(system: ^System, maxworldsize: ^f32) -> Result ---
    System_LoadGeometry :: proc(system: ^System, data: rawptr, datasize: i32, geometry: ^^Geometry) -> Result ---
    System_GetGeometryOcclusion :: proc(system: ^System, #by_ptr listener: vec, #by_ptr source: vec, direct: ^f32, reverb: ^f32) -> Result ---

    // Network functions.
    System_SetNetworkProxy :: proc(system: ^System, proxy: cstring) -> Result ---
    System_GetNetworkProxy :: proc(system: ^System, proxy: ^u8, proxylen: i32) -> Result ---
    System_SetNetworkTimeout :: proc(system: ^System, timeout: i32) -> Result ---
    System_GetNetworkTimeout :: proc(system: ^System, timeout: ^i32) -> Result ---

    // Userdata set/get.
    System_SetUserData :: proc(system: ^System, userdata: rawptr) -> Result ---
    System_GetUserData :: proc(system: ^System, userdata: ^rawptr) -> Result ---

    // Sound API
    Sound_Release :: proc(sound: ^Sound) -> Result ---
    Sound_GetSystemObject :: proc(sound: ^Sound, system: ^^System) -> Result ---


    ///////////////////////////////////////////////////////////////////////////////////////////////////////
    // Standard sound manipulation functions.
    //

    Sound_Lock :: proc(sound: ^Sound, offset: u32, length: u32, ptr1: ^rawptr, ptr2: ^rawptr, len1: ^u32, len2: ^u32) -> Result ---
    Sound_Unlock :: proc(sound: ^Sound, ptr1: rawptr, ptr2: rawptr, len1: u32, len2: u32) -> Result ---
    Sound_SetDefaults :: proc(sound: ^Sound, frequency: f32, priority: i32) -> Result ---
    Sound_GetDefaults :: proc(sound: ^Sound, frequency: ^f32, priority: ^i32) -> Result ---
    Sound_Set3DMinMaxDistance :: proc(sound: ^Sound, min: f32, max: f32) -> Result ---
    Sound_Get3DMinMaxDistance :: proc(sound: ^Sound, min: ^f32, max: ^f32) -> Result ---
    Sound_Set3DConeSettings :: proc(sound: ^Sound, insideconeangle: f32, outsideconeangle: f32, outsidevolume: f32) -> Result ---
    Sound_Get3DConeSettings :: proc(sound: ^Sound, insideconeangle: ^f32, outsideconeangle: ^f32, outsidevolume: ^f32) -> Result ---
    Sound_Set3DCustomRolloff :: proc(sound: ^Sound, points: ^vec, numpoints: i32) -> Result ---
    Sound_Get3DCustomRolloff :: proc(sound: ^Sound, points: ^^vec, numpoints: ^i32) -> Result ---
    Sound_GetSubSound :: proc(sound: ^Sound, index: i32, subsound: ^^Sound) -> Result ---
    Sound_GetSubSoundParent :: proc(sound: ^Sound, parentsound: ^^Sound) -> Result ---
    Sound_GetName :: proc(sound: ^Sound, name: ^u8, namelen: i32) -> Result ---
    Sound_GetLength :: proc(sound: ^Sound, length: ^u32, lengthtype: TimeUnit) -> Result ---
    Sound_GetFormat :: proc(sound: ^Sound, _type: ^Sound_Type, format: ^Sound_Format, channels: ^i32, bits: ^i32) -> Result ---
    Sound_GetNumSubSounds :: proc(sound: ^Sound, numsubsounds: ^i32) -> Result ---
    Sound_GetNumTags :: proc(sound: ^Sound, numtags: ^i32, numtagsupdated: ^i32) -> Result ---
    Sound_GetTag :: proc(sound: ^Sound, name: cstring, index: i32, tag: ^Tag) -> Result ---
    Sound_GetOpenState :: proc(sound: ^Sound, openstate: ^OpenState, percentbuffered: ^u32, starving: ^b32, diskbusy: ^b32) -> Result ---
    Sound_ReadData :: proc(sound: ^Sound, buffer: rawptr, length: u32, read: ^u32) -> Result ---
    Sound_SeekData :: proc(sound: ^Sound, pcm: u32) -> Result ---

    Sound_SetSoundGroup :: proc(sound: ^Sound, soundgroup: ^SoundGroup) -> Result ---
    Sound_GetSoundGroup :: proc(sound: ^Sound, soundgroup: ^^SoundGroup) -> Result ---


    ///////////////////////////////////////////////////////////////////////////////////////////////////////
    // Synchronization poAPI: i32.  These points can come from markers embedded in wav files, and can also generate channel callbacks.
    //

    Sound_GetNumSyncPoints :: proc(sound: ^Sound, numsyncpoints: ^i32) -> Result ---
    Sound_GetSyncPoint :: proc(sound: ^Sound, index: i32, point: ^^SyncPoint) -> Result ---
    Sound_GetSyncPointInfo :: proc(sound: ^Sound, point: ^SyncPoint, name: ^u8, namelen: i32, offset: ^u32, offsettype: TimeUnit) -> Result ---
    Sound_AddSyncPoint :: proc(sound: ^Sound, offset: u32, offsettype: TimeUnit, name: cstring, point: ^^SyncPoint) -> Result ---
    Sound_DeleteSyncPoint :: proc(sound: ^Sound, point: ^SyncPoint) -> Result ---


    ///////////////////////////////////////////////////////////////////////////////////////////////////////
    // Functions also in Channel class but here they are the 'default' to save having to change it in Channel all the time.
    //

    Sound_SetMode :: proc(sound: ^Sound, mode: Mode) -> Result ---
    Sound_GetMode :: proc(sound: ^Sound, mode: ^Mode) -> Result ---
    Sound_SetLoopCount :: proc(sound: ^Sound, loopcount: i32) -> Result ---
    Sound_GetLoopCount :: proc(sound: ^Sound, loopcount: ^i32) -> Result ---
    Sound_SetLoopPoints :: proc(sound: ^Sound, loopstart: u32, loopstarttype: TimeUnit, loopend: u32, loopendtype: TimeUnit) -> Result ---
    Sound_GetLoopPoints :: proc(sound: ^Sound, loopstart: ^u32, loopstarttype: TimeUnit, loopend: ^u32, loopendtype: TimeUnit) -> Result ---


    ///////////////////////////////////////////////////////////////////////////////////////////////////////
    // For MOD/S3M/XM/IT/MID sequenced formats only.
    //

    Sound_GetMusicNumChannels :: proc(sound: ^Sound, numchannels: ^i32) -> Result ---
    Sound_SetMusicChannelVolume :: proc(sound: ^Sound, channel: i32, volume: f32) -> Result ---
    Sound_GetMusicChannelVolume :: proc(sound: ^Sound, channel: i32, volume: ^f32) -> Result ---
    Sound_SetMusicSpeed :: proc(sound: ^Sound, speed: f32) -> Result ---
    Sound_GetMusicSpeed :: proc(sound: ^Sound, speed: ^f32) -> Result ---


    ///////////////////////////////////////////////////////////////////////////////////////////////////////
    // Userdata set/get.
    //

    Sound_SetUserData :: proc(sound: ^Sound, userdata: rawptr) -> Result ---
    Sound_GetUserData :: proc(sound: ^Sound, userdata: ^rawptr) -> Result ---


    ///////////////////////////////////////////////////////////////////////////////////////////////////////
    // 'Channel' API
    //

    Channel_GetSystemObject :: proc(channel: ^Channel, system: ^^System) -> Result ---


    ///////////////////////////////////////////////////////////////////////////////////////////////////////
    // General control functionality for Channels and ChannelGroups.
    //

    Channel_Stop :: proc(channel: ^Channel) -> Result ---
    Channel_SetPaused :: proc(channel: ^Channel, paused: b32) -> Result ---
    Channel_GetPaused :: proc(channel: ^Channel, paused: ^b32) -> Result ---
    Channel_SetVolume :: proc(channel: ^Channel, volume: f32) -> Result ---
    Channel_GetVolume :: proc(channel: ^Channel, volume: ^f32) -> Result ---
    Channel_SetVolumeRamp :: proc(channel: ^Channel, ramp: b32) -> Result ---
    Channel_GetVolumeRamp :: proc(channel: ^Channel, ramp: ^b32) -> Result ---
    Channel_GetAudibility :: proc(channel: ^Channel, audibility: ^f32) -> Result ---
    Channel_SetPitch :: proc(channel: ^Channel, pitch: f32) -> Result ---
    Channel_GetPitch :: proc(channel: ^Channel, pitch: ^f32) -> Result ---
    Channel_SetMute :: proc(channel: ^Channel, mute: b32) -> Result ---
    Channel_GetMute :: proc(channel: ^Channel, mute: ^b32) -> Result ---
    Channel_SetReverbProperties :: proc(channel: ^Channel, instance: i32, wet: f32) -> Result ---
    Channel_GetReverbProperties :: proc(channel: ^Channel, instance: i32, wet: ^f32) -> Result ---
    Channel_SetLowPassGain :: proc(channel: ^Channel, gain: f32) -> Result ---
    Channel_GetLowPassGain :: proc(channel: ^Channel, gain: ^f32) -> Result ---
    Channel_SetMode :: proc(channel: ^Channel, mode: Mode) -> Result ---
    Channel_GetMode :: proc(channel: ^Channel, mode: ^Mode) -> Result ---
    Channel_SetCallback :: proc(channel: ^Channel, callback: channelcontrol_callback) -> Result ---
    Channel_IsPlaying :: proc(channel: ^Channel, isplaying: ^b32) -> Result ---


    ///////////////////////////////////////////////////////////////////////////////////////////////////////
    // Note all 'set' functions alter a final _matrix, this is why the only get function is getMixMatrix, to avoid other get functions returning incorrect/obsolete values.
    //

    Channel_SetPan :: proc(channel: ^Channel, pan: f32) -> Result ---
    Channel_SetMixLevelsOutput :: proc(channel: ^Channel, frontleft: f32, frontright: f32, center: f32, lfe: f32, surroundleft: f32, surroundright: f32, backleft: f32, backright: f32) -> Result ---
    Channel_SetMixLevelsInput :: proc(channel: ^Channel, levels: ^f32, numlevels: i32) -> Result ---
    Channel_SetMixMatrix :: proc(channel: ^Channel, _matrix: ^f32, outchannels: i32, inchannels: i32, inchannel_hop: i32) -> Result ---
    Channel_GetMixMatrix :: proc(channel: ^Channel, _matrix: ^f32, outchannels: ^i32, inchannels: ^i32, inchannel_hop: i32) -> Result ---


    ///////////////////////////////////////////////////////////////////////////////////////////////////////
    // Clock based functionality.
    //

    Channel_GetDSPClock :: proc(channel: ^Channel, dspclock: ^uint, parentclock: ^uint) -> Result ---
    Channel_SetDelay :: proc(channel: ^Channel, dspclock_start: uint, dspclock_end: uint, stopchannels: b32) -> Result ---
    Channel_GetDelay :: proc(channel: ^Channel, dspclock_start: ^uint, dspclock_end: ^uint, stopchannels: ^b32) -> Result ---
    Channel_AddFadePoint :: proc(channel: ^Channel, dspclock: uint, volume: f32) -> Result ---
    Channel_SetFadePointRamp :: proc(channel: ^Channel, dspclock: uint, volume: f32) -> Result ---
    Channel_RemoveFadePoints :: proc(channel: ^Channel, dspclock_start: uint, dspclock_end: uint) -> Result ---
    Channel_GetFadePoints :: proc(channel: ^Channel, numpoints: ^u32, point_dspclock: ^uint, point_volume: ^f32) -> Result ---


    ///////////////////////////////////////////////////////////////////////////////////////////////////////
    // DSP effects.
    //

    Channel_GetDSP :: proc(channel: ^Channel, index: i32, dsp: ^^DSP) -> Result ---
    Channel_AddDSP :: proc(channel: ^Channel, index: i32, dsp: ^DSP) -> Result ---
    Channel_RemoveDSP :: proc(channel: ^Channel, dsp: ^DSP) -> Result ---
    Channel_GetNumDSPs :: proc(channel: ^Channel, numdsps: ^i32) -> Result ---
    Channel_SetDSPIndex :: proc(channel: ^Channel, dsp: ^DSP, index: i32) -> Result ---
    Channel_GetDSPIndex :: proc(channel: ^Channel, dsp: ^DSP, index: ^i32) -> Result ---


    ///////////////////////////////////////////////////////////////////////////////////////////////////////
    // 3D functionality.
    //

    Channel_Set3DAttributes :: proc(channel: ^Channel, #by_ptr pos: vec, #by_ptr vel: vec) -> Result ---
    Channel_Get3DAttributes :: proc(channel: ^Channel, pos: ^vec, vel: ^vec) -> Result ---
    Channel_Set3DMinMaxDistance :: proc(channel: ^Channel, mindistance: f32, maxdistance: f32) -> Result ---
    Channel_Get3DMinMaxDistance :: proc(channel: ^Channel, mindistance: ^f32, maxdistance: ^f32) -> Result ---
    Channel_Set3DConeSettings :: proc(channel: ^Channel, insideconeangle: f32, outsideconeangle: f32, outsidevolume: f32) -> Result ---
    Channel_Get3DConeSettings :: proc(channel: ^Channel, insideconeangle: ^f32, outsideconeangle: ^f32, outsidevolume: ^f32) -> Result ---
    Channel_Set3DConeOrientation :: proc(channel: ^Channel, orientation: ^vec) -> Result ---
    Channel_Get3DConeOrientation :: proc(channel: ^Channel, orientation: ^vec) -> Result ---
    Channel_Set3DCustomRolloff :: proc(channel: ^Channel, points: ^vec, numpoints: i32) -> Result ---
    Channel_Get3DCustomRolloff :: proc(channel: ^Channel, points: ^^vec, numpoints: ^i32) -> Result ---
    Channel_Set3DOcclusion :: proc(channel: ^Channel, directocclusion: f32, reverbocclusion: f32) -> Result ---
    Channel_Get3DOcclusion :: proc(channel: ^Channel, directocclusion: ^f32, reverbocclusion: ^f32) -> Result ---
    Channel_Set3DSpread :: proc(channel: ^Channel, angle: f32) -> Result ---
    Channel_Get3DSpread :: proc(channel: ^Channel, angle: ^f32) -> Result ---
    Channel_Set3DLevel :: proc(channel: ^Channel, level: f32) -> Result ---
    Channel_Get3DLevel :: proc(channel: ^Channel, level: ^f32) -> Result ---
    Channel_Set3DDopplerLevel :: proc(channel: ^Channel, level: f32) -> Result ---
    Channel_Get3DDopplerLevel :: proc(channel: ^Channel, level: ^f32) -> Result ---
    Channel_Set3DDistanceFilter :: proc(channel: ^Channel, custom: b32, customLevel: f32, centerFreq: f32) -> Result ---
    Channel_Get3DDistanceFilter :: proc(channel: ^Channel, custom: ^b32, customLevel: ^f32, centerFreq: ^f32) -> Result ---


    ///////////////////////////////////////////////////////////////////////////////////////////////////////
    // Userdata set/get.
    //

    Channel_SetUserData :: proc(channel: ^Channel, userdata: rawptr) -> Result ---
    Channel_GetUserData :: proc(channel: ^Channel, userdata: ^rawptr) -> Result ---


    ///////////////////////////////////////////////////////////////////////////////////////////////////////
    // Channel specific control functionality.
    //

    Channel_SetFrequency :: proc(channel: ^Channel, frequency: f32) -> Result ---
    Channel_GetFrequency :: proc(channel: ^Channel, frequency: ^f32) -> Result ---
    Channel_SetPriority :: proc(channel: ^Channel, priority: i32) -> Result ---
    Channel_GetPriority :: proc(channel: ^Channel, priority: ^i32) -> Result ---
    Channel_SetPosition :: proc(channel: ^Channel, position: u32, postype: TimeUnit) -> Result ---
    Channel_GetPosition :: proc(channel: ^Channel, position: ^u32, postype: TimeUnit) -> Result ---
    Channel_SetChannelGroup :: proc(channel: ^Channel, channelgroup: ^ChannelGroup) -> Result ---
    Channel_GetChannelGroup :: proc(channel: ^Channel, channelgroup: ^^ChannelGroup) -> Result ---
    Channel_SetLoopCount :: proc(channel: ^Channel, loopcount: i32) -> Result ---
    Channel_GetLoopCount :: proc(channel: ^Channel, loopcount: ^i32) -> Result ---
    Channel_SetLoopPoints :: proc(channel: ^Channel, loopstart: u32, loopstarttype: TimeUnit, loopend: u32, loopendtype: TimeUnit) -> Result ---
    Channel_GetLoopPoints :: proc(channel: ^Channel, loopstart: ^u32, loopstarttype: TimeUnit, loopend: ^u32, loopendtype: TimeUnit) -> Result ---


    ///////////////////////////////////////////////////////////////////////////////////////////////////////
    // Information only functions.
    //

    Channel_IsVirtual :: proc(channel: ^Channel, isvirtual: ^b32) -> Result ---
    Channel_GetCurrentSound :: proc(channel: ^Channel, sound: ^^Sound) -> Result ---
    Channel_GetIndex :: proc(channel: ^Channel, index: ^i32) -> Result ---


    ///////////////////////////////////////////////////////////////////////////////////////////////////////
    // 'ChannelGroup' API
    //

    ChannelGroup_GetSystemObject :: proc(channelgroup: ^ChannelGroup, system: ^^System) -> Result ---


    ///////////////////////////////////////////////////////////////////////////////////////////////////////
    // General control functionality for Channels and ChannelGroups.
    //

    ChannelGroup_Stop :: proc(channelgroup: ^ChannelGroup) -> Result ---
    ChannelGroup_SetPaused :: proc(channelgroup: ^ChannelGroup, paused: b32) -> Result ---
    ChannelGroup_GetPaused :: proc(channelgroup: ^ChannelGroup, paused: ^b32) -> Result ---
    ChannelGroup_SetVolume :: proc(channelgroup: ^ChannelGroup, volume: f32) -> Result ---
    ChannelGroup_GetVolume :: proc(channelgroup: ^ChannelGroup, volume: ^f32) -> Result ---
    ChannelGroup_SetVolumeRamp :: proc(channelgroup: ^ChannelGroup, ramp: b32) -> Result ---
    ChannelGroup_GetVolumeRamp :: proc(channelgroup: ^ChannelGroup, ramp: ^b32) -> Result ---
    ChannelGroup_GetAudibility :: proc(channelgroup: ^ChannelGroup, audibility: ^f32) -> Result ---
    ChannelGroup_SetPitch :: proc(channelgroup: ^ChannelGroup, pitch: f32) -> Result ---
    ChannelGroup_GetPitch :: proc(channelgroup: ^ChannelGroup, pitch: ^f32) -> Result ---
    ChannelGroup_SetMute :: proc(channelgroup: ^ChannelGroup, mute: b32) -> Result ---
    ChannelGroup_GetMute :: proc(channelgroup: ^ChannelGroup, mute: ^b32) -> Result ---
    ChannelGroup_SetReverbProperties :: proc(channelgroup: ^ChannelGroup, instance: i32, wet: f32) -> Result ---
    ChannelGroup_GetReverbProperties :: proc(channelgroup: ^ChannelGroup, instance: i32, wet: ^f32) -> Result ---
    ChannelGroup_SetLowPassGain :: proc(channelgroup: ^ChannelGroup, gain: f32) -> Result ---
    ChannelGroup_GetLowPassGain :: proc(channelgroup: ^ChannelGroup, gain: ^f32) -> Result ---
    ChannelGroup_SetMode :: proc(channelgroup: ^ChannelGroup, mode: Mode) -> Result ---
    ChannelGroup_GetMode :: proc(channelgroup: ^ChannelGroup, mode: ^Mode) -> Result ---
    ChannelGroup_SetCallback :: proc(channelgroup: ^ChannelGroup, callback: channelcontrol_callback) -> Result ---
    ChannelGroup_IsPlaying :: proc(channelgroup: ^ChannelGroup, isplaying: ^b32) -> Result ---


    ///////////////////////////////////////////////////////////////////////////////////////////////////////
    // Note all 'set' functions alter a final _matrix, this is why the only get function is getMixMatrix, to avoid other get functions returning incorrect/obsolete values.
    //

    ChannelGroup_SetPan :: proc(channelgroup: ^ChannelGroup, pan: f32) -> Result ---
    ChannelGroup_SetMixLevelsOutput :: proc(channelgroup: ^ChannelGroup, frontleft: f32, frontright: f32, center: f32, lfe: f32, surroundleft: f32, surroundright: f32, backleft: f32, backright: f32) -> Result ---
    ChannelGroup_SetMixLevelsInput :: proc(channelgroup: ^ChannelGroup, levels: ^f32, numlevels: i32) -> Result ---
    ChannelGroup_SetMixMatrix :: proc(channelgroup: ^ChannelGroup, _matrix: ^f32, outchannels: i32, inchannels: i32, inchannel_hop: i32) -> Result ---
    ChannelGroup_GetMixMatrix :: proc(channelgroup: ^ChannelGroup, _matrix: ^f32, outchannels: ^i32, inchannels: ^i32, inchannel_hop: i32) -> Result ---


    ///////////////////////////////////////////////////////////////////////////////////////////////////////
    // Clock based functionality.
    //

    ChannelGroup_GetDSPClock :: proc(channelgroup: ^ChannelGroup, dspclock: ^uint, parentclock: ^uint) -> Result ---
    ChannelGroup_SetDelay :: proc(channelgroup: ^ChannelGroup, dspclock_start: uint, dspclock_end: uint, stopchannels: b32) -> Result ---
    ChannelGroup_GetDelay :: proc(channelgroup: ^ChannelGroup, dspclock_start: ^uint, dspclock_end: ^uint, stopchannels: ^b32) -> Result ---
    ChannelGroup_AddFadePoint :: proc(channelgroup: ^ChannelGroup, dspclock: uint, volume: f32) -> Result ---
    ChannelGroup_SetFadePointRamp :: proc(channelgroup: ^ChannelGroup, dspclock: uint, volume: f32) -> Result ---
    ChannelGroup_RemoveFadePoints :: proc(channelgroup: ^ChannelGroup, dspclock_start: uint, dspclock_end: uint) -> Result ---
    ChannelGroup_GetFadePoints :: proc(channelgroup: ^ChannelGroup, numpoints: ^u32, point_dspclock: ^uint, point_volume: ^f32) -> Result ---


    ///////////////////////////////////////////////////////////////////////////////////////////////////////
    // DSP effects.
    //

    ChannelGroup_GetDSP :: proc(channelgroup: ^ChannelGroup, index: i32, dsp: ^^DSP) -> Result ---
    ChannelGroup_AddDSP :: proc(channelgroup: ^ChannelGroup, index: i32, dsp: ^DSP) -> Result ---
    ChannelGroup_RemoveDSP :: proc(channelgroup: ^ChannelGroup, dsp: ^DSP) -> Result ---
    ChannelGroup_GetNumDSPs :: proc(channelgroup: ^ChannelGroup, numdsps: ^i32) -> Result ---
    ChannelGroup_SetDSPIndex :: proc(channelgroup: ^ChannelGroup, dsp: ^DSP, index: i32) -> Result ---
    ChannelGroup_GetDSPIndex :: proc(channelgroup: ^ChannelGroup, dsp: ^DSP, index: ^i32) -> Result ---


    ///////////////////////////////////////////////////////////////////////////////////////////////////////
    // 3D functionality.
    //

    ChannelGroup_Set3DAttributes :: proc(channelgroup: ^ChannelGroup, #by_ptr pos: vec, #by_ptr vel: vec) -> Result ---
    ChannelGroup_Get3DAttributes :: proc(channelgroup: ^ChannelGroup, pos: ^vec, vel: ^vec) -> Result ---
    ChannelGroup_Set3DMinMaxDistance :: proc(channelgroup: ^ChannelGroup, mindistance: f32, maxdistance: f32) -> Result ---
    ChannelGroup_Get3DMinMaxDistance :: proc(channelgroup: ^ChannelGroup, mindistance: ^f32, maxdistance: ^f32) -> Result ---
    ChannelGroup_Set3DConeSettings :: proc(channelgroup: ^ChannelGroup, insideconeangle: f32, outsideconeangle: f32, outsidevolume: f32) -> Result ---
    ChannelGroup_Get3DConeSettings :: proc(channelgroup: ^ChannelGroup, insideconeangle: ^f32, outsideconeangle: ^f32, outsidevolume: ^f32) -> Result ---
    ChannelGroup_Set3DConeOrientation :: proc(channelgroup: ^ChannelGroup, orientation: ^vec) -> Result ---
    ChannelGroup_Get3DConeOrientation :: proc(channelgroup: ^ChannelGroup, orientation: ^vec) -> Result ---
    ChannelGroup_Set3DCustomRolloff :: proc(channelgroup: ^ChannelGroup, points: ^vec, numpoints: i32) -> Result ---
    ChannelGroup_Get3DCustomRolloff :: proc(channelgroup: ^ChannelGroup, points: ^^vec, numpoints: ^i32) -> Result ---
    ChannelGroup_Set3DOcclusion :: proc(channelgroup: ^ChannelGroup, directocclusion: f32, reverbocclusion: f32) -> Result ---
    ChannelGroup_Get3DOcclusion :: proc(channelgroup: ^ChannelGroup, directocclusion: ^f32, reverbocclusion: ^f32) -> Result ---
    ChannelGroup_Set3DSpread :: proc(channelgroup: ^ChannelGroup, angle: f32) -> Result ---
    ChannelGroup_Get3DSpread :: proc(channelgroup: ^ChannelGroup, angle: ^f32) -> Result ---
    ChannelGroup_Set3DLevel :: proc(channelgroup: ^ChannelGroup, level: f32) -> Result ---
    ChannelGroup_Get3DLevel :: proc(channelgroup: ^ChannelGroup, level: ^f32) -> Result ---
    ChannelGroup_Set3DDopplerLevel :: proc(channelgroup: ^ChannelGroup, level: f32) -> Result ---
    ChannelGroup_Get3DDopplerLevel :: proc(channelgroup: ^ChannelGroup, level: ^f32) -> Result ---
    ChannelGroup_Set3DDistanceFilter :: proc(channelgroup: ^ChannelGroup, custom: b32, customLevel: f32, centerFreq: f32) -> Result ---
    ChannelGroup_Get3DDistanceFilter :: proc(channelgroup: ^ChannelGroup, custom: ^b32, customLevel: ^f32, centerFreq: ^f32) -> Result ---


    ///////////////////////////////////////////////////////////////////////////////////////////////////////
    // Userdata set/get.
    //

    ChannelGroup_SetUserData :: proc(channelgroup: ^ChannelGroup, userdata: rawptr) -> Result ---
    ChannelGroup_GetUserData :: proc(channelgroup: ^ChannelGroup, userdata: ^rawptr) -> Result ---

    ChannelGroup_Release :: proc(channelgroup: ^ChannelGroup) -> Result ---


    ///////////////////////////////////////////////////////////////////////////////////////////////////////
    // Nested channel groups.
    //

    ChannelGroup_AddGroup :: proc(channelgroup: ^ChannelGroup, group: ^ChannelGroup, propagatedspclock: b32, connection: ^^DSPConnection) -> Result ---
    ChannelGroup_GetNumGroups :: proc(channelgroup: ^ChannelGroup, numgroups: ^i32) -> Result ---
    ChannelGroup_GetGroup :: proc(channelgroup: ^ChannelGroup, index: i32, group: ^^ChannelGroup) -> Result ---
    ChannelGroup_GetParentGroup :: proc(channelgroup: ^ChannelGroup, group: ^^ChannelGroup) -> Result ---


    ///////////////////////////////////////////////////////////////////////////////////////////////////////
    // Information only functions.
    //

    ChannelGroup_GetName :: proc(channelgroup: ^ChannelGroup, name: ^u8, namelen: i32) -> Result ---
    ChannelGroup_GetNumChannels :: proc(channelgroup: ^ChannelGroup, numchannels: ^i32) -> Result ---
    ChannelGroup_GetChannel :: proc(channelgroup: ^ChannelGroup, index: i32, channel: ^^Channel) -> Result ---


    ///////////////////////////////////////////////////////////////////////////////////////////////////////
    // 'SoundGroup' API
    //

    SoundGroup_Release :: proc(soundgroup: ^SoundGroup) -> Result ---
    SoundGroup_GetSystemObject :: proc(soundgroup: ^SoundGroup, system: ^^System) -> Result ---


    ///////////////////////////////////////////////////////////////////////////////////////////////////////
    // SoundGroup control functions.
    //

    SoundGroup_SetMaxAudible :: proc(soundgroup: ^SoundGroup, maxaudible: i32) -> Result ---
    SoundGroup_GetMaxAudible :: proc(soundgroup: ^SoundGroup, maxaudible: ^i32) -> Result ---
    SoundGroup_SetMaxAudibleBehavior :: proc(soundgroup: ^SoundGroup, behavior: SoundGroup_Behavior) -> Result ---
    SoundGroup_GetMaxAudibleBehavior :: proc(soundgroup: ^SoundGroup, behavior: ^SoundGroup_Behavior) -> Result ---
    SoundGroup_SetMuteFadeSpeed :: proc(soundgroup: ^SoundGroup, speed: f32) -> Result ---
    SoundGroup_GetMuteFadeSpeed :: proc(soundgroup: ^SoundGroup, speed: ^f32) -> Result ---
    SoundGroup_SetVolume :: proc(soundgroup: ^SoundGroup, volume: f32) -> Result ---
    SoundGroup_GetVolume :: proc(soundgroup: ^SoundGroup, volume: ^f32) -> Result ---
    SoundGroup_Stop :: proc(soundgroup: ^SoundGroup) -> Result ---


    ///////////////////////////////////////////////////////////////////////////////////////////////////////
    // Information only functions.
    //

    SoundGroup_GetName :: proc(soundgroup: ^SoundGroup, name: ^u8, namelen: i32) -> Result ---
    SoundGroup_GetNumSounds :: proc(soundgroup: ^SoundGroup, numsounds: ^i32) -> Result ---
    SoundGroup_GetSound :: proc(soundgroup: ^SoundGroup, index: i32, sound: ^^Sound) -> Result ---
    SoundGroup_GetNumPlaying :: proc(soundgroup: ^SoundGroup, numplaying: ^i32) -> Result ---


    ///////////////////////////////////////////////////////////////////////////////////////////////////////
    // Userdata set/get.
    //

    SoundGroup_SetUserData :: proc(soundgroup: ^SoundGroup, userdata: rawptr) -> Result ---
    SoundGroup_GetUserData :: proc(soundgroup: ^SoundGroup, userdata: ^rawptr) -> Result ---


    ///////////////////////////////////////////////////////////////////////////////////////////////////////
    // 'DSP' API
    //

    DSP_Release :: proc(dsp: ^DSP) -> Result ---
    DSP_GetSystemObject :: proc(dsp: ^DSP, system: ^^System) -> Result ---


    ///////////////////////////////////////////////////////////////////////////////////////////////////////
    // Connection / disconnection / input and output enumeration.
    //

    DSP_AddInput :: proc(dsp: ^DSP, input: ^DSP, connection: ^^DSPConnection, _type: DSPConnection_Type) -> Result ---
    DSP_DisconnectFrom :: proc(dsp: ^DSP, target: ^DSP, connection: ^DSPConnection) -> Result ---
    DSP_DisconnectAll :: proc(dsp: ^DSP, inputs: b32, outputs: b32) -> Result ---
    DSP_GetNumInputs :: proc(dsp: ^DSP, numinputs: ^i32) -> Result ---
    DSP_GetNumOutputs :: proc(dsp: ^DSP, numoutputs: ^i32) -> Result ---
    DSP_GetInput :: proc(dsp: ^DSP, index: i32, input: ^^DSP, inputconnection: ^^DSPConnection) -> Result ---
    DSP_GetOutput :: proc(dsp: ^DSP, index: i32, output: ^^DSP, outputconnection: ^^DSPConnection) -> Result ---


    ///////////////////////////////////////////////////////////////////////////////////////////////////////
    // DSP unit control.
    //

    DSP_SetActive :: proc(dsp: ^DSP, active: b32) -> Result ---
    DSP_GetActive :: proc(dsp: ^DSP, active: ^b32) -> Result ---
    DSP_SetBypass :: proc(dsp: ^DSP, bypass: b32) -> Result ---
    DSP_GetBypass :: proc(dsp: ^DSP, bypass: ^b32) -> Result ---
    DSP_SetWetDryMix :: proc(dsp: ^DSP, prewet: f32, postwet: f32, dry: f32) -> Result ---
    DSP_GetWetDryMix :: proc(dsp: ^DSP, prewet: ^f32, postwet: ^f32, dry: ^f32) -> Result ---
    DSP_SetChannelFormat :: proc(dsp: ^DSP, channelmask: ChannelMask, numchannels: i32, source_speakermode: SpeakerMode) -> Result ---
    DSP_GetChannelFormat :: proc(dsp: ^DSP, channelmask: ^ChannelMask, numchannels: ^i32, source_speakermode: ^SpeakerMode) -> Result ---
    DSP_GetOutputChannelFormat :: proc(dsp: ^DSP, inmask: ChannelMask, inchannels: i32, inspeakermode: SpeakerMode, outmask: ^ChannelMask, outchannels: ^i32, outspeakermode: ^SpeakerMode) -> Result ---
    DSP_Reset :: proc(dsp: ^DSP) -> Result ---
    DSP_SetCallback :: proc(dsp: ^DSP, callback: dsp_callback) -> Result ---


    ///////////////////////////////////////////////////////////////////////////////////////////////////////
    // DSP parameter control.
    //

    DSP_SetParameterf32 :: proc(dsp: ^DSP, index: i32, value: f32) -> Result ---
    DSP_SetParameterInt :: proc(dsp: ^DSP, index: i32, value: i32) -> Result ---
    DSP_SetParameterb32 :: proc(dsp: ^DSP, index: i32, value: b32) -> Result ---
    DSP_SetParameterData :: proc(dsp: ^DSP, index: i32, data: rawptr, length: u32) -> Result ---
    DSP_GetParameterf32 :: proc(dsp: ^DSP, index: i32, value: ^f32, valuestr: ^u8, valuestrlen: i32) -> Result ---
    DSP_GetParameterInt :: proc(dsp: ^DSP, index: i32, value: ^i32, valuestr: ^u8, valuestrlen: i32) -> Result ---
    DSP_GetParameterb32 :: proc(dsp: ^DSP, index: i32, value: ^b32, valuestr: ^u8, valuestrlen: i32) -> Result ---
    DSP_GetParameterData :: proc(dsp: ^DSP, index: i32, data: ^rawptr, length: ^u32, valuestr: ^u8, valuestrlen: i32) -> Result ---
    DSP_GetNumParameters :: proc(dsp: ^DSP, numparams: ^i32) -> Result ---
    DSP_GetParameterInfo :: proc(dsp: ^DSP, index: i32, desc: ^^DSP_Parameter_Desc) -> Result ---
    DSP_GetDataParameterIndex :: proc(dsp: ^DSP, datatype: i32, index: ^i32) -> Result ---
    DSP_ShowConfigDialog :: proc(dsp: ^DSP, hwnd: rawptr, show: b32) -> Result ---


    ///////////////////////////////////////////////////////////////////////////////////////////////////////
    // DSP attributes.
    //

    DSP_GetInfo :: proc(dsp: ^DSP, name: ^u8, version: ^u32, channels: ^i32, configwidth: ^i32, configheight: ^i32) -> Result ---
    DSP_GetType :: proc(dsp: ^DSP, _type: ^DSP_Type) -> Result ---
    DSP_GetIdle :: proc(dsp: ^DSP, idle: ^b32) -> Result ---


    ///////////////////////////////////////////////////////////////////////////////////////////////////////
    // Userdata set/get.
    //

    DSP_SetUserData :: proc(dsp: ^DSP, userdata: rawptr) -> Result ---
    DSP_GetUserData :: proc(dsp: ^DSP, userdata: ^rawptr) -> Result ---


    ///////////////////////////////////////////////////////////////////////////////////////////////////////
    // Metering.
    //

    DSP_SetMeteringEnabled :: proc(dsp: ^DSP, inputEnabled: b32, outputEnabled: b32) -> Result ---
    DSP_GetMeteringEnabled :: proc(dsp: ^DSP, inputEnabled: ^b32, outputEnabled: ^b32) -> Result ---
    DSP_GetMeteringInfo :: proc(dsp: ^DSP, inputInfo: ^DSP_Metering_Info, outputInfo: ^DSP_Metering_Info) -> Result ---
    DSP_GetCPUUsage :: proc(dsp: ^DSP, exclusive: ^u32, inclusive: ^u32) -> Result ---


    ///////////////////////////////////////////////////////////////////////////////////////////////////////
    // 'DSPConnection' API
    //

    DSPConnection_GetInput :: proc(dspconnection: ^DSPConnection, input: ^^DSP) -> Result ---
    DSPConnection_GetOutput :: proc(dspconnection: ^DSPConnection, output: ^^DSP) -> Result ---
    DSPConnection_SetMix :: proc(dspconnection: ^DSPConnection, volume: f32) -> Result ---
    DSPConnection_GetMix :: proc(dspconnection: ^DSPConnection, volume: ^f32) -> Result ---
    DSPConnection_SetMixMatrix :: proc(dspconnection: ^DSPConnection, _matrix: ^f32, outchannels: i32, inchannels: i32, inchannel_hop: i32) -> Result ---
    DSPConnection_GetMixMatrix :: proc(dspconnection: ^DSPConnection, _matrix: ^f32, outchannels: ^i32, inchannels: ^i32, inchannel_hop: i32) -> Result ---
    DSPConnection_GetType :: proc(dspconnection: ^DSPConnection, _type: ^DSPConnection_Type) -> Result ---


    ///////////////////////////////////////////////////////////////////////////////////////////////////////
    // Userdata set/get.
    //

    DSPConnection_SetUserData :: proc(dspconnection: ^DSPConnection, userdata: rawptr) -> Result ---
    DSPConnection_GetUserData :: proc(dspconnection: ^DSPConnection, userdata: ^rawptr) -> Result ---


    ///////////////////////////////////////////////////////////////////////////////////////////////////////
    // 'Geometry' API
    //

    Geometry_Release :: proc(geometry: ^Geometry) -> Result ---


    ///////////////////////////////////////////////////////////////////////////////////////////////////////
    // Polygon manipulation.
    //

    Geometry_AddPolygon :: proc(geometry: ^Geometry, directocclusion: f32, reverbocclusion: f32, doublesided: b32, numvertices: i32, #by_ptr vertices: vec, polygonindex: ^i32) -> Result ---
    Geometry_GetNumPolygons :: proc(geometry: ^Geometry, numpolygons: ^i32) -> Result ---
    Geometry_GetMaxPolygons :: proc(geometry: ^Geometry, maxpolygons: ^i32, maxvertices: ^i32) -> Result ---
    Geometry_GetPolygonNumVertices :: proc(geometry: ^Geometry, index: i32, numvertices: ^i32) -> Result ---
    Geometry_SetPolygonVertex :: proc(geometry: ^Geometry, index: i32, vertexindex: i32, #by_ptr vertex: vec) -> Result ---
    Geometry_GetPolygonVertex :: proc(geometry: ^Geometry, index: i32, vertexindex: i32, vertex: ^vec) -> Result ---
    Geometry_SetPolygonAttributes :: proc(geometry: ^Geometry, index: i32, directocclusion: f32, reverbocclusion: f32, doublesided: b32) -> Result ---
    Geometry_GetPolygonAttributes :: proc(geometry: ^Geometry, index: i32, directocclusion: ^f32, reverbocclusion: ^f32, doublesided: ^b32) -> Result ---


    ///////////////////////////////////////////////////////////////////////////////////////////////////////
    // Object manipulation.
    //

    Geometry_SetActive :: proc(geometry: ^Geometry, active: b32) -> Result ---
    Geometry_GetActive :: proc(geometry: ^Geometry, active: ^b32) -> Result ---
    Geometry_SetRotation :: proc(geometry: ^Geometry, #by_ptr forward: vec, #by_ptr up: vec) -> Result ---
    Geometry_GetRotation :: proc(geometry: ^Geometry, forward: ^vec, up: ^vec) -> Result ---
    Geometry_SetPosition :: proc(geometry: ^Geometry, #by_ptr position: vec) -> Result ---
    Geometry_GetPosition :: proc(geometry: ^Geometry, position: ^vec) -> Result ---
    Geometry_SetScale :: proc(geometry: ^Geometry, #by_ptr scale: vec) -> Result ---
    Geometry_GetScale :: proc(geometry: ^Geometry, scale: ^vec) -> Result ---
    Geometry_Save :: proc(geometry: ^Geometry, data: rawptr, datasize: ^i32) -> Result ---


    ///////////////////////////////////////////////////////////////////////////////////////////////////////
    // Userdata set/get.
    //

    Geometry_SetUserData :: proc(geometry: ^Geometry, userdata: rawptr) -> Result ---
    Geometry_GetUserData :: proc(geometry: ^Geometry, userdata: ^rawptr) -> Result ---


    ///////////////////////////////////////////////////////////////////////////////////////////////////////
    // 'Reverb3D' API
    //

    Reverb3D_Release :: proc(reverb3d: ^Reverb3D) -> Result ---


    ///////////////////////////////////////////////////////////////////////////////////////////////////////
    // Reverb manipulation.
    //

    Reverb3D_Set3DAttributes :: proc(reverb3d: ^Reverb3D, #by_ptr position: vec, mindistance: f32, maxdistance: f32) -> Result ---
    Reverb3D_Get3DAttributes :: proc(reverb3d: ^Reverb3D, position: ^vec, mindistance: ^f32, maxdistance: ^f32) -> Result ---
    Reverb3D_SetProperties :: proc(reverb3d: ^Reverb3D, #by_ptr properties: Reverb_Properties) -> Result ---
    Reverb3D_GetProperties :: proc(reverb3d: ^Reverb3D, properties: ^Reverb_Properties) -> Result ---
    Reverb3D_SetActive :: proc(reverb3d: ^Reverb3D, active: b32) -> Result ---
    Reverb3D_GetActive :: proc(reverb3d: ^Reverb3D, active: ^b32) -> Result ---


    ///////////////////////////////////////////////////////////////////////////////////////////////////////
    // Userdata set/get.
    //

    Reverb3D_SetUserData :: proc(reverb3d: ^Reverb3D, userdata: rawptr) -> Result ---
    Reverb3D_GetUserData :: proc(reverb3d: ^Reverb3D, userdata: ^rawptr) -> Result ---

}
