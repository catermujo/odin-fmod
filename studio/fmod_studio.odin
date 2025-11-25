package fmod_studio

/* ======================================================================================== */
/* FMOD Studio API - C header file.                                                         */
/* Copyright (c), Firelight Technologies Pty, Ltd. 2004-2023.                               */
/*                                                                                          */
/* Use this header in conjunction with fmod_studio_common.h (which contains all the         */
/* constants / callbacks) to develop using the C language.                                  */
/*                                                                                          */
/* For more detail visit:                                                                   */
/* https://fmod.com/docs/2.02/api/studio-api.html                                           */
/* ======================================================================================== */

import fmod "../core"

when ODIN_OS == .Windows {
    when fmod.LOGGING_ENABLED {
        foreign import lib "fmodstudioL_vc.lib"
    } else {
        foreign import lib "fmodstudio_vc.lib"
    }
} else when ODIN_OS == .Darwin {
    when fmod.LOGGING_ENABLED {
        foreign import lib "fmodstudioL.dylib"
    } else {
        foreign import lib "fmodstudio.dylib"
    }
}
@(default_calling_convention = "c", link_prefix = "FMOD_Studio_")
foreign lib {

    ///////////////////////////////////////////////////////////////////////////////////////////////////////
    // Global
    //

    ParseID :: proc(idstring: cstring, id: ^fmod.GUID) -> fmod.Result ---
    System_Create :: proc(system: ^^System, headerversion: u32) -> fmod.Result ---


    ///////////////////////////////////////////////////////////////////////////////////////////////////////
    // System
    //

    System_IsValid :: proc(system: ^System) -> b32 ---
    System_SetAdvancedSettings :: proc(system: ^System, settings: ^AdvancedSettings) -> fmod.Result ---
    System_GetAdvancedSettings :: proc(system: ^System, settings: ^AdvancedSettings) -> fmod.Result ---
    System_Initialize :: proc(system: ^System, maxchannels: i32, studioflags: Init_Flags, flags: fmod.INITFLAGS, extradriverdata: rawptr) -> fmod.Result ---
    System_Release :: proc(system: ^System) -> fmod.Result ---
    System_Update :: proc(system: ^System) -> fmod.Result ---
    System_GetCoreSystem :: proc(system: ^System, coresystem: ^^fmod.System) -> fmod.Result ---
    System_GetEvent :: proc(system: ^System, pathOrID: cstring, event: ^^EventDescription) -> fmod.Result ---
    System_GetBus :: proc(system: ^System, pathOrID: cstring, bus: ^^Bus) -> fmod.Result ---
    System_GetVCA :: proc(system: ^System, pathOrID: cstring, vca: ^^VCA) -> fmod.Result ---
    System_GetBank :: proc(system: ^System, pathOrID: cstring, bank: ^^Bank) -> fmod.Result ---
    System_GetEventByID :: proc(system: ^System, #by_ptr id: fmod.GUID, event: ^^EVENTDESCRIPTION) -> fmod.Result ---
    System_GetBusByID :: proc(system: ^System, #by_ptr id: fmod.GUID, bus: ^^Bus) -> fmod.Result ---
    System_GetVCAByID :: proc(system: ^System, #by_ptr id: fmod.GUID, vca: ^^VCA) -> fmod.Result ---
    System_GetBankByID :: proc(system: ^System, #by_ptr id: fmod.GUID, bank: ^^Bank) -> fmod.Result ---
    System_GetSoundInfo :: proc(system: ^System, key: cstring, info: ^Sound_Info) -> fmod.Result ---
    System_GetParameterDescriptionByName :: proc(system: ^System, name: cstring, parameter: ^PARAMETER_DESCRIPTION) -> fmod.Result ---
    System_GetParameterDescriptionByID :: proc(system: ^System, id: Parameter_ID, parameter: ^PARAMETER_DESCRIPTION) -> fmod.Result ---
    System_GetParameterLabelByName :: proc(system: ^System, name: cstring, labelindex: i32, label: ^u8, size: i32, retrieved: ^i32) -> fmod.Result ---
    System_GetParameterLabelByID :: proc(system: ^System, id: Parameter_ID, labelindex: i32, label: ^u8, size: i32, retrieved: ^i32) -> fmod.Result ---
    System_GetParameterByID :: proc(system: ^System, id: Parameter_ID, value: ^f32, finalvalue: ^f32) -> fmod.Result ---
    System_SetParameterByID :: proc(system: ^System, id: Parameter_ID, value: f32, ignoreseekspeed: b32) -> fmod.Result ---
    System_SetParameterByIDWithLabel :: proc(system: ^System, id: Parameter_ID, label: cstring, ignoreseekspeed: b32) -> fmod.Result ---
    System_SetParametersByIDs :: proc(system: ^System, #by_ptr ids: Parameter_ID, values: ^f32, count: i32, ignoreseekspeed: b32) -> fmod.Result ---
    System_GetParameterByName :: proc(system: ^System, name: cstring, value: ^f32, finalvalue: ^f32) -> fmod.Result ---
    System_SetParameterByName :: proc(system: ^System, name: cstring, value: f32, ignoreseekspeed: b32) -> fmod.Result ---
    System_SetParameterByNameWithLabel :: proc(system: ^System, name: cstring, label: cstring, ignoreseekspeed: b32) -> fmod.Result ---
    System_LookupID :: proc(system: ^System, path: cstring, id: ^fmod.GUID) -> fmod.Result ---
    System_LookupPath :: proc(system: ^System, #by_ptr id: fmod.GUID, path: ^u8, size: i32, retrieved: ^i32) -> fmod.Result ---
    System_GetNumListeners :: proc(system: ^System, numlisteners: ^i32) -> fmod.Result ---
    System_SetNumListeners :: proc(system: ^System, numlisteners: i32) -> fmod.Result ---
    System_GetListenerAttributes :: proc(system: ^System, index: i32, attributes: ^fmod._3D_ATTRIBUTES, attenuationposition: ^fmod.VECTOR) -> fmod.Result ---
    System_SetListenerAttributes :: proc(system: ^System, index: i32, #by_ptr attributes: fmod._3D_ATTRIBUTES, attenuationposition: ^fmod.VECTOR) -> fmod.Result ---
    System_GetListenerWeight :: proc(system: ^System, index: i32, weight: ^f32) -> fmod.Result ---
    System_SetListenerWeight :: proc(system: ^System, index: i32, weight: f32) -> fmod.Result ---
    System_LoadBankFile :: proc(system: ^System, filename: cstring, flags: LOAD_BANK_FLAGS, bank: ^^BANK) -> fmod.Result ---
    System_LoadBankMemory :: proc(system: ^System, buffer: cstring, length: i32, mode: LOAD_MEMORY_MODE, flags: LOAD_BANK_FLAGS, bank: ^^BANK) -> fmod.Result ---
    System_LoadBankCustom :: proc(system: ^System, #by_ptr info: BANK_INFO, flags: LOAD_BANK_FLAGS, bank: ^^BANK) -> fmod.Result ---
    System_RegisterPlugin :: proc(system: ^System, #by_ptr description: fmod.DSP_DESCRIPTION) -> fmod.Result ---
    System_UnregisterPlugin :: proc(system: ^System, name: cstring) -> fmod.Result ---
    System_UnloadAll :: proc(system: ^System) -> fmod.Result ---
    System_FlushCommands :: proc(system: ^System) -> fmod.Result ---
    System_FlushSampleLoading :: proc(system: ^System) -> fmod.Result ---
    System_StartCommandCapture :: proc(system: ^System, filename: cstring, flags: COMMANDCAPTURE_FLAGS) -> fmod.Result ---
    System_StopCommandCapture :: proc(system: ^System) -> fmod.Result ---
    System_LoadCommandReplay :: proc(system: ^System, filename: cstring, flags: CommandReplay_FLAGS, replay: ^^COMMANDREPLAY) -> fmod.Result ---
    System_GetBankCount :: proc(system: ^System, count: ^i32) -> fmod.Result ---
    System_GetBankList :: proc(system: ^System, array: ^^BANK, capacity: i32, count: ^i32) -> fmod.Result ---
    System_GetParameterDescriptionCount :: proc(system: ^System, count: ^i32) -> fmod.Result ---
    System_GetParameterDescriptionList :: proc(system: ^System, array: ^PARAMETER_DESCRIPTION, capacity: i32, count: ^i32) -> fmod.Result ---
    System_GetCPUUsage :: proc(system: ^System, usage: ^CPU_USAGE, usage_core: ^fmod.CPU_USAGE) -> fmod.Result ---
    System_GetBufferUsage :: proc(system: ^System, usage: ^BUFFER_USAGE) -> fmod.Result ---
    System_ResetBufferUsage :: proc(system: ^System) -> fmod.Result ---
    System_SetCallback :: proc(system: ^System, callback: SYSTEM_CALLBACK, callbackmask: SYSTEM_CALLBACK_TYPE) -> fmod.Result ---
    System_SetUserData :: proc(system: ^System, userdata: rawptr) -> fmod.Result ---
    System_GetUserData :: proc(system: ^System, userdata: ^rawptr) -> fmod.Result ---
    System_GetMemoryUsage :: proc(system: ^System, memoryusage: ^MEMORY_USAGE) -> fmod.Result ---


    ///////////////////////////////////////////////////////////////////////////////////////////////////////
    // EventDescription
    //

    EventDescription_IsValid :: proc(eventdescription: ^EVENTDESCRIPTION) -> b32 ---
    EventDescription_GetID :: proc(eventdescription: ^EVENTDESCRIPTION, id: ^fmod.GUID) -> fmod.Result ---
    EventDescription_GetPath :: proc(eventdescription: ^EVENTDESCRIPTION, path: ^u8, size: i32, retrieved: ^i32) -> fmod.Result ---
    EventDescription_GetParameterDescriptionCount :: proc(eventdescription: ^EVENTDESCRIPTION, count: ^i32) -> fmod.Result ---
    EventDescription_GetParameterDescriptionByIndex :: proc(eventdescription: ^EVENTDESCRIPTION, index: i32, parameter: ^PARAMETER_DESCRIPTION) -> fmod.Result ---
    EventDescription_GetParameterDescriptionByName :: proc(eventdescription: ^EVENTDESCRIPTION, name: cstring, parameter: ^PARAMETER_DESCRIPTION) -> fmod.Result ---
    EventDescription_GetParameterDescriptionByID :: proc(eventdescription: ^EVENTDESCRIPTION, id: Parameter_ID, parameter: ^PARAMETER_DESCRIPTION) -> fmod.Result ---
    EventDescription_GetParameterLabelByIndex :: proc(eventdescription: ^EVENTDESCRIPTION, index: i32, labelindex: i32, label: ^u8, size: i32, retrieved: ^i32) -> fmod.Result ---
    EventDescription_GetParameterLabelByName :: proc(eventdescription: ^EVENTDESCRIPTION, name: cstring, labelindex: i32, label: ^u8, size: i32, retrieved: ^i32) -> fmod.Result ---
    EventDescription_GetParameterLabelByID :: proc(eventdescription: ^EVENTDESCRIPTION, id: Parameter_ID, labelindex: i32, label: ^u8, size: i32, retrieved: ^i32) -> fmod.Result ---
    EventDescription_GetUserPropertyCount :: proc(eventdescription: ^EVENTDESCRIPTION, count: ^i32) -> fmod.Result ---
    EventDescription_GetUserPropertyByIndex :: proc(eventdescription: ^EVENTDESCRIPTION, index: i32, property: ^USER_PROPERTY) -> fmod.Result ---
    EventDescription_GetUserProperty :: proc(eventdescription: ^EVENTDESCRIPTION, name: cstring, property: ^USER_PROPERTY) -> fmod.Result ---
    EventDescription_GetLength :: proc(eventdescription: ^EVENTDESCRIPTION, length: ^i32) -> fmod.Result ---
    EventDescription_GetMinMaxDistance :: proc(eventdescription: ^EVENTDESCRIPTION, min: ^f32, max: ^f32) -> fmod.Result ---
    EventDescription_GetSoundSize :: proc(eventdescription: ^EVENTDESCRIPTION, size: ^f32) -> fmod.Result ---
    EventDescription_IsSnapshot :: proc(eventdescription: ^EVENTDESCRIPTION, snapshot: ^b32) -> fmod.Result ---
    EventDescription_IsOneshot :: proc(eventdescription: ^EVENTDESCRIPTION, oneshot: ^b32) -> fmod.Result ---
    EventDescription_IsStream :: proc(eventdescription: ^EVENTDESCRIPTION, isStream: ^b32) -> fmod.Result ---
    EventDescription_Is3D :: proc(eventdescription: ^EVENTDESCRIPTION, is3D: ^b32) -> fmod.Result ---
    EventDescription_IsDopplerEnabled :: proc(eventdescription: ^EVENTDESCRIPTION, doppler: ^b32) -> fmod.Result ---
    EventDescription_HasSustainPoint :: proc(eventdescription: ^EVENTDESCRIPTION, sustainPoint: ^b32) -> fmod.Result ---
    EventDescription_CreateInstance :: proc(eventdescription: ^EVENTDESCRIPTION, instance: ^^Event_Instance) -> fmod.Result ---
    EventDescription_GetInstanceCount :: proc(eventdescription: ^EVENTDESCRIPTION, count: ^i32) -> fmod.Result ---
    EventDescription_GetInstanceList :: proc(eventdescription: ^EVENTDESCRIPTION, array: ^^Event_Instance, capacity: i32, count: ^i32) -> fmod.Result ---
    EventDescription_LoadSampleData :: proc(eventdescription: ^EVENTDESCRIPTION) -> fmod.Result ---
    EventDescription_UnloadSampleData :: proc(eventdescription: ^EVENTDESCRIPTION) -> fmod.Result ---
    EventDescription_GetSampleLoadingState :: proc(eventdescription: ^EVENTDESCRIPTION, state: ^LOADING_STATE) -> fmod.Result ---
    EventDescription_ReleaseAllInstances :: proc(eventdescription: ^EVENTDESCRIPTION) -> fmod.Result ---
    EventDescription_SetCallback :: proc(eventdescription: ^EVENTDESCRIPTION, callback: EVENT_CALLBACK, callbackmask: Event_Callback_Type) -> fmod.Result ---
    EventDescription_GetUserData :: proc(eventdescription: ^EVENTDESCRIPTION, userdata: ^rawptr) -> fmod.Result ---
    EventDescription_SetUserData :: proc(eventdescription: ^EVENTDESCRIPTION, userdata: rawptr) -> fmod.Result ---


    ///////////////////////////////////////////////////////////////////////////////////////////////////////
    // EventInstance
    //

    EventInstance_IsValid :: proc(eventinstance: ^Event_Instance) -> b32 ---
    EventInstance_GetDescription :: proc(eventinstance: ^Event_Instance, description: ^^EVENTDESCRIPTION) -> fmod.Result ---
    EventInstance_GetVolume :: proc(eventinstance: ^Event_Instance, volume: ^f32, finalvolume: ^f32) -> fmod.Result ---
    EventInstance_SetVolume :: proc(eventinstance: ^Event_Instance, volume: f32) -> fmod.Result ---
    EventInstance_GetPitch :: proc(eventinstance: ^Event_Instance, pitch: ^f32, finalpitch: ^f32) -> fmod.Result ---
    EventInstance_SetPitch :: proc(eventinstance: ^Event_Instance, pitch: f32) -> fmod.Result ---
    EventInstance_Get3DAttributes :: proc(eventinstance: ^Event_Instance, attributes: ^fmod._3D_ATTRIBUTES) -> fmod.Result ---
    EventInstance_Set3DAttributes :: proc(eventinstance: ^Event_Instance, attributes: ^fmod._3D_ATTRIBUTES) -> fmod.Result ---
    EventInstance_GetListenerMask :: proc(eventinstance: ^Event_Instance, mask: ^u32) -> fmod.Result ---
    EventInstance_SetListenerMask :: proc(eventinstance: ^Event_Instance, mask: u32) -> fmod.Result ---
    EventInstance_GetProperty :: proc(eventinstance: ^Event_Instance, index: EVENT_PROPERTY, value: ^f32) -> fmod.Result ---
    EventInstance_SetProperty :: proc(eventinstance: ^Event_Instance, index: EVENT_PROPERTY, value: f32) -> fmod.Result ---
    EventInstance_GetReverbLevel :: proc(eventinstance: ^Event_Instance, index: i32, level: ^f32) -> fmod.Result ---
    EventInstance_SetReverbLevel :: proc(eventinstance: ^Event_Instance, index: i32, level: f32) -> fmod.Result ---
    EventInstance_GetPaused :: proc(eventinstance: ^Event_Instance, paused: ^b32) -> fmod.Result ---
    EventInstance_SetPaused :: proc(eventinstance: ^Event_Instance, paused: b32) -> fmod.Result ---
    EventInstance_Start :: proc(eventinstance: ^Event_Instance) -> fmod.Result ---
    EventInstance_Stop :: proc(eventinstance: ^Event_Instance, mode: STOP_MODE) -> fmod.Result ---
    EventInstance_GetTimelinePosition :: proc(eventinstance: ^Event_Instance, position: ^i32) -> fmod.Result ---
    EventInstance_SetTimelinePosition :: proc(eventinstance: ^Event_Instance, position: i32) -> fmod.Result ---
    EventInstance_GetPlaybackState :: proc(eventinstance: ^Event_Instance, state: ^Playback_State) -> fmod.Result ---
    EventInstance_GetChannelGroup :: proc(eventinstance: ^Event_Instance, group: ^^fmod.CHANNELGROUP) -> fmod.Result ---
    EventInstance_GetMinMaxDistance :: proc(eventinstance: ^Event_Instance, min: ^f32, max: ^f32) -> fmod.Result ---
    EventInstance_Release :: proc(eventinstance: ^Event_Instance) -> fmod.Result ---
    EventInstance_IsVirtual :: proc(eventinstance: ^Event_Instance, virtualstate: ^b32) -> fmod.Result ---
    EventInstance_GetParameterByName :: proc(eventinstance: ^Event_Instance, name: cstring, value: ^f32, finalvalue: ^f32) -> fmod.Result ---
    EventInstance_SetParameterByName :: proc(eventinstance: ^Event_Instance, name: cstring, value: f32, ignoreseekspeed: b32) -> fmod.Result ---
    EventInstance_SetParameterByNameWithLabel :: proc(eventinstance: ^Event_Instance, name: cstring, label: cstring, ignoreseekspeed: b32) -> fmod.Result ---
    EventInstance_GetParameterByID :: proc(eventinstance: ^Event_Instance, id: Parameter_ID, value: ^f32, finalvalue: ^f32) -> fmod.Result ---
    EventInstance_SetParameterByID :: proc(eventinstance: ^Event_Instance, id: Parameter_ID, value: f32, ignoreseekspeed: b32) -> fmod.Result ---
    EventInstance_SetParameterByIDWithLabel :: proc(eventinstance: ^Event_Instance, id: Parameter_ID, label: cstring, ignoreseekspeed: b32) -> fmod.Result ---
    EventInstance_SetParametersByIDs :: proc(eventinstance: ^Event_Instance, #by_ptr ids: Parameter_ID, values: ^f32, count: i32, ignoreseekspeed: b32) -> fmod.Result ---
    EventInstance_KeyOff :: proc(eventinstance: ^Event_Instance) -> fmod.Result ---
    EventInstance_SetCallback :: proc(eventinstance: ^Event_Instance, callback: Event_Callback, callbackmask: Event_Callback_Type) -> fmod.Result ---
    EventInstance_GetUserData :: proc(eventinstance: ^Event_Instance, userdata: ^rawptr) -> fmod.Result ---
    EventInstance_SetUserData :: proc(eventinstance: ^Event_Instance, userdata: rawptr) -> fmod.Result ---
    EventInstance_GetCPUUsage :: proc(eventinstance: ^Event_Instance, exclusive: ^u32, inclusive: ^u32) -> fmod.Result ---
    EventInstance_GetMemoryUsage :: proc(eventinstance: ^Event_Instance, memoryusage: ^MEMORY_USAGE) -> fmod.Result ---


    ///////////////////////////////////////////////////////////////////////////////////////////////////////
    // Bus
    //

    Bus_IsValid :: proc(bus: ^BUS) -> b32 ---
    Bus_GetID :: proc(bus: ^BUS, id: ^fmod.GUID) -> fmod.Result ---
    Bus_GetPath :: proc(bus: ^BUS, path: [^]u8, size: i32, retrieved: ^i32) -> fmod.Result ---
    Bus_GetVolume :: proc(bus: ^BUS, volume: ^f32, finalvolume: ^f32) -> fmod.Result ---
    Bus_SetVolume :: proc(bus: ^BUS, volume: f32) -> fmod.Result ---
    Bus_GetPaused :: proc(bus: ^BUS, paused: ^b32) -> fmod.Result ---
    Bus_SetPaused :: proc(bus: ^BUS, paused: b32) -> fmod.Result ---
    Bus_GetMute :: proc(bus: ^BUS, mute: ^b32) -> fmod.Result ---
    Bus_SetMute :: proc(bus: ^BUS, mute: b32) -> fmod.Result ---
    Bus_StopAllEvents :: proc(bus: ^BUS, mode: STOP_MODE) -> fmod.Result ---
    Bus_GetPortIndex :: proc(bus: ^BUS, index: ^fmod.PORT_INDEX) -> fmod.Result ---
    Bus_SetPortIndex :: proc(bus: ^BUS, index: fmod.PORT_INDEX) -> fmod.Result ---
    Bus_LockChannelGroup :: proc(bus: ^BUS) -> fmod.Result ---
    Bus_UnlockChannelGroup :: proc(bus: ^BUS) -> fmod.Result ---
    Bus_GetChannelGroup :: proc(bus: ^BUS, group: ^^fmod.CHANNELGROUP) -> fmod.Result ---
    Bus_GetCPUUsage :: proc(bus: ^BUS, exclusive: ^u32, inclusive: ^u32) -> fmod.Result ---
    Bus_GetMemoryUsage :: proc(bus: ^BUS, memoryusage: ^MEMORY_USAGE) -> fmod.Result ---


    ///////////////////////////////////////////////////////////////////////////////////////////////////////
    // VCA
    //

    VCA_IsValid :: proc(vca: ^VCA) -> b32 ---
    VCA_GetID :: proc(vca: ^VCA, id: ^fmod.GUID) -> fmod.Result ---
    VCA_GetPath :: proc(vca: ^VCA, path: ^u8, size: i32, retrieved: ^i32) -> fmod.Result ---
    VCA_GetVolume :: proc(vca: ^VCA, volume: ^f32, finalvolume: ^f32) -> fmod.Result ---
    VCA_SetVolume :: proc(vca: ^VCA, volume: f32) -> fmod.Result ---


    ///////////////////////////////////////////////////////////////////////////////////////////////////////
    // Bank
    //

    Bank_IsValid :: proc(bank: ^BANK) -> b32 ---
    Bank_GetID :: proc(bank: ^BANK, id: ^fmod.GUID) -> fmod.Result ---
    Bank_GetPath :: proc(bank: ^BANK, path: ^u8, size: i32, retrieved: ^i32) -> fmod.Result ---
    Bank_Unload :: proc(bank: ^BANK) -> fmod.Result ---
    Bank_LoadSampleData :: proc(bank: ^BANK) -> fmod.Result ---
    Bank_UnloadSampleData :: proc(bank: ^BANK) -> fmod.Result ---
    Bank_GetLoadingState :: proc(bank: ^BANK, state: ^LOADING_STATE) -> fmod.Result ---
    Bank_GetSampleLoadingState :: proc(bank: ^BANK, state: ^LOADING_STATE) -> fmod.Result ---
    Bank_GetStringCount :: proc(bank: ^BANK, count: ^i32) -> fmod.Result ---
    Bank_GetStringInfo :: proc(bank: ^BANK, index: i32, id: ^fmod.GUID, path: ^u8, size: i32, retrieved: ^i32) -> fmod.Result ---
    Bank_GetEventCount :: proc(bank: ^BANK, count: ^i32) -> fmod.Result ---
    Bank_GetEventList :: proc(bank: ^BANK, array: ^^EVENTDESCRIPTION, capacity: i32, count: ^i32) -> fmod.Result ---
    Bank_GetBusCount :: proc(bank: ^BANK, count: ^i32) -> fmod.Result ---
    Bank_GetBusList :: proc(bank: ^BANK, array: ^^BUS, capacity: i32, count: ^i32) -> fmod.Result ---
    Bank_GetVCACount :: proc(bank: ^BANK, count: ^i32) -> fmod.Result ---
    Bank_GetVCAList :: proc(bank: ^BANK, array: ^^VCA, capacity: i32, count: ^i32) -> fmod.Result ---
    Bank_GetUserData :: proc(bank: ^BANK, userdata: ^rawptr) -> fmod.Result ---
    Bank_SetUserData :: proc(bank: ^BANK, userdata: rawptr) -> fmod.Result ---


    ///////////////////////////////////////////////////////////////////////////////////////////////////////
    // Command playback information
    //

    CommandReplay_IsValid :: proc(replay: ^CommandReplay) -> b32 ---
    CommandReplay_GetSystem :: proc(replay: ^CommandReplay, system: ^^System) -> fmod.Result ---
    CommandReplay_GetLength :: proc(replay: ^CommandReplay, length: ^f32) -> fmod.Result ---
    CommandReplay_GetCommandCount :: proc(replay: ^CommandReplay, count: ^i32) -> fmod.Result ---
    CommandReplay_GetCommandInfo :: proc(replay: ^CommandReplay, commandindex: i32, info: ^COMMAND_INFO) -> fmod.Result ---
    CommandReplay_GetCommandString :: proc(replay: ^CommandReplay, commandindex: i32, buffer: ^u8, length: i32) -> fmod.Result ---
    CommandReplay_GetCommandAtTime :: proc(replay: ^CommandReplay, time: f32, commandindex: ^i32) -> fmod.Result ---
    CommandReplay_SetBankPath :: proc(replay: ^CommandReplay, bankPath: cstring) -> fmod.Result ---
    CommandReplay_Start :: proc(replay: ^CommandReplay) -> fmod.Result ---
    CommandReplay_Stop :: proc(replay: ^CommandReplay) -> fmod.Result ---
    CommandReplay_SeekToTime :: proc(replay: ^CommandReplay, time: f32) -> fmod.Result ---
    CommandReplay_SeekToCommand :: proc(replay: ^CommandReplay, commandindex: i32) -> fmod.Result ---
    CommandReplay_GetPaused :: proc(replay: ^CommandReplay, paused: ^b32) -> fmod.Result ---
    CommandReplay_SetPaused :: proc(replay: ^CommandReplay, paused: b32) -> fmod.Result ---
    CommandReplay_GetPlaybackState :: proc(replay: ^CommandReplay, state: ^Playback_State) -> fmod.Result ---
    CommandReplay_GetCurrentCommand :: proc(replay: ^CommandReplay, commandindex: ^i32, currenttime: ^f32) -> fmod.Result ---
    CommandReplay_Release :: proc(replay: ^CommandReplay) -> fmod.Result ---
    CommandReplay_SetFrameCallback :: proc(replay: ^CommandReplay, callback: COMMANDREPLAY_FRAME_CALLBACK) -> fmod.Result ---
    CommandReplay_SetLoadBankCallback :: proc(replay: ^CommandReplay, callback: COMMANDREPLAY_LOAD_BANK_CALLBACK) -> fmod.Result ---
    CommandReplay_SetCreateInstanceCallback :: proc(replay: ^CommandReplay, callback: COMMANDREPLAY_CREATE_INSTANCE_CALLBACK) -> fmod.Result ---
    CommandReplay_GetUserData :: proc(replay: ^CommandReplay, userdata: ^rawptr) -> fmod.Result ---
    CommandReplay_SetUserData :: proc(replay: ^CommandReplay, userdata: rawptr) -> fmod.Result ---
}
