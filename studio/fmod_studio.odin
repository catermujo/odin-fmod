package fmod_studio

/* ======================================================================================== */
/* FMOD Studio API - C header file.                                                         */
/* Copyright (c), Firelight Technologies Pty, Ltd. 2004-2023.                               */
/*                                                                                          */
/* Use this header in conjunction with fmod_studio_common.h (which contains all the         */
/* constants / callbacks) to develop using the C language.                                  */
/*                                                                                          */
/* For more detail visit:                                                                   */
/* https://fmod.com/docs/2.03/api/studio-api.html                                           */
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
        foreign import lib "libfmodstudioL.dylib"
    } else {
        foreign import lib "libfmodstudio.dylib"
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
    System_Initialize :: proc(system: ^System, maxchannels: i32, studioflags: Init_Flags, flags: fmod.Init_Flags, extradriverdata: rawptr) -> fmod.Result ---
    System_Release :: proc(system: ^System) -> fmod.Result ---
    System_Update :: proc(system: ^System) -> fmod.Result ---
    System_GetCoreSystem :: proc(system: ^System, coresystem: ^^fmod.System) -> fmod.Result ---
    System_GetEvent :: proc(system: ^System, pathOrID: cstring, event: ^^EventDescription) -> fmod.Result ---
    System_GetBus :: proc(system: ^System, pathOrID: cstring, bus: ^^Bus) -> fmod.Result ---
    System_GetVCA :: proc(system: ^System, pathOrID: cstring, vca: ^^VCA) -> fmod.Result ---
    System_GetBank :: proc(system: ^System, pathOrID: cstring, bank: ^^Bank) -> fmod.Result ---
    System_GetEventByID :: proc(system: ^System, #by_ptr id: fmod.GUID, event: ^^EventDescription) -> fmod.Result ---
    System_GetBusByID :: proc(system: ^System, #by_ptr id: fmod.GUID, bus: ^^Bus) -> fmod.Result ---
    System_GetVCAByID :: proc(system: ^System, #by_ptr id: fmod.GUID, vca: ^^VCA) -> fmod.Result ---
    System_GetBankByID :: proc(system: ^System, #by_ptr id: fmod.GUID, bank: ^^Bank) -> fmod.Result ---
    System_GetSoundInfo :: proc(system: ^System, key: cstring, info: ^Sound_Info) -> fmod.Result ---
    System_GetParameterDescriptionByName :: proc(system: ^System, name: cstring, parameter: ^Parameter_Description) -> fmod.Result ---
    System_GetParameterDescriptionByID :: proc(system: ^System, id: Parameter_ID, parameter: ^Parameter_Description) -> fmod.Result ---
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
    System_GetListenerAttributes :: proc(system: ^System, index: i32, attributes: ^fmod._3D_Attributes, attenuationposition: ^fmod.vec) -> fmod.Result ---
    System_SetListenerAttributes :: proc(system: ^System, index: i32, #by_ptr attributes: fmod._3D_Attributes, attenuationposition: ^fmod.vec) -> fmod.Result ---
    System_GetListenerWeight :: proc(system: ^System, index: i32, weight: ^f32) -> fmod.Result ---
    System_SetListenerWeight :: proc(system: ^System, index: i32, weight: f32) -> fmod.Result ---
    System_LoadBankFile :: proc(system: ^System, filename: cstring, flags: Load_Bank_Flags, bank: ^^Bank) -> fmod.Result ---
    System_LoadBankMemory :: proc(system: ^System, buffer: cstring, length: i32, mode: Load_Memory_Mode, flags: Load_Bank_Flags, bank: ^^Bank) -> fmod.Result ---
    System_LoadBankCustom :: proc(system: ^System, #by_ptr info: Bank_Info, flags: Load_Bank_Flags, bank: ^^Bank) -> fmod.Result ---
    System_RegisterPlugin :: proc(system: ^System, #by_ptr description: fmod.DSP_Description) -> fmod.Result ---
    System_UnregisterPlugin :: proc(system: ^System, name: cstring) -> fmod.Result ---
    System_UnloadAll :: proc(system: ^System) -> fmod.Result ---
    System_FlushCommands :: proc(system: ^System) -> fmod.Result ---
    System_FlushSampleLoading :: proc(system: ^System) -> fmod.Result ---
    System_StartCommandCapture :: proc(system: ^System, filename: cstring, flags: CommandCapture_Flags) -> fmod.Result ---
    System_StopCommandCapture :: proc(system: ^System) -> fmod.Result ---
    System_LoadCommandReplay :: proc(system: ^System, filename: cstring, flags: CommandReplay_Flags, replay: ^^CommandReplay) -> fmod.Result ---
    System_GetBankCount :: proc(system: ^System, count: ^i32) -> fmod.Result ---
    System_GetBankList :: proc(system: ^System, array: ^^Bank, capacity: i32, count: ^i32) -> fmod.Result ---
    System_GetParameterDescriptionCount :: proc(system: ^System, count: ^i32) -> fmod.Result ---
    System_GetParameterDescriptionList :: proc(system: ^System, array: ^Parameter_Description, capacity: i32, count: ^i32) -> fmod.Result ---
    System_GetCPUUsage :: proc(system: ^System, usage: ^CPU_Usage, usage_core: ^fmod.CPU_Usage) -> fmod.Result ---
    System_GetBufferUsage :: proc(system: ^System, usage: ^Buffer_Usage) -> fmod.Result ---
    System_ResetBufferUsage :: proc(system: ^System) -> fmod.Result ---
    System_SetCallback :: proc(system: ^System, callback: system_callback, callbackmask: System_Callback_Type) -> fmod.Result ---
    System_SetUserData :: proc(system: ^System, userdata: rawptr) -> fmod.Result ---
    System_GetUserData :: proc(system: ^System, userdata: ^rawptr) -> fmod.Result ---
    System_GetMemoryUsage :: proc(system: ^System, memoryusage: ^Memory_Usage) -> fmod.Result ---


    ///////////////////////////////////////////////////////////////////////////////////////////////////////
    // EventDescription
    //

    EventDescription_IsValid :: proc(eventdescription: ^EventDescription) -> b32 ---
    EventDescription_GetID :: proc(eventdescription: ^EventDescription, id: ^fmod.GUID) -> fmod.Result ---
    EventDescription_GetPath :: proc(eventdescription: ^EventDescription, path: ^u8, size: i32, retrieved: ^i32) -> fmod.Result ---
    EventDescription_GetParameterDescriptionCount :: proc(eventdescription: ^EventDescription, count: ^i32) -> fmod.Result ---
    EventDescription_GetParameterDescriptionByIndex :: proc(eventdescription: ^EventDescription, index: i32, parameter: ^Parameter_Description) -> fmod.Result ---
    EventDescription_GetParameterDescriptionByName :: proc(eventdescription: ^EventDescription, name: cstring, parameter: ^Parameter_Description) -> fmod.Result ---
    EventDescription_GetParameterDescriptionByID :: proc(eventdescription: ^EventDescription, id: Parameter_ID, parameter: ^Parameter_Description) -> fmod.Result ---
    EventDescription_GetParameterLabelByIndex :: proc(eventdescription: ^EventDescription, index: i32, labelindex: i32, label: ^u8, size: i32, retrieved: ^i32) -> fmod.Result ---
    EventDescription_GetParameterLabelByName :: proc(eventdescription: ^EventDescription, name: cstring, labelindex: i32, label: ^u8, size: i32, retrieved: ^i32) -> fmod.Result ---
    EventDescription_GetParameterLabelByID :: proc(eventdescription: ^EventDescription, id: Parameter_ID, labelindex: i32, label: ^u8, size: i32, retrieved: ^i32) -> fmod.Result ---
    EventDescription_GetUserPropertyCount :: proc(eventdescription: ^EventDescription, count: ^i32) -> fmod.Result ---
    EventDescription_GetUserPropertyByIndex :: proc(eventdescription: ^EventDescription, index: i32, property: ^User_Property) -> fmod.Result ---
    EventDescription_GetUserProperty :: proc(eventdescription: ^EventDescription, name: cstring, property: ^User_Property) -> fmod.Result ---
    EventDescription_GetLength :: proc(eventdescription: ^EventDescription, length: ^i32) -> fmod.Result ---
    EventDescription_GetMinMaxDistance :: proc(eventdescription: ^EventDescription, min: ^f32, max: ^f32) -> fmod.Result ---
    EventDescription_GetSoundSize :: proc(eventdescription: ^EventDescription, size: ^f32) -> fmod.Result ---
    EventDescription_IsSnapshot :: proc(eventdescription: ^EventDescription, snapshot: ^b32) -> fmod.Result ---
    EventDescription_IsOneshot :: proc(eventdescription: ^EventDescription, oneshot: ^b32) -> fmod.Result ---
    EventDescription_IsStream :: proc(eventdescription: ^EventDescription, isStream: ^b32) -> fmod.Result ---
    EventDescription_Is3D :: proc(eventdescription: ^EventDescription, is3D: ^b32) -> fmod.Result ---
    EventDescription_IsDopplerEnabled :: proc(eventdescription: ^EventDescription, doppler: ^b32) -> fmod.Result ---
    EventDescription_HasSustainPoint :: proc(eventdescription: ^EventDescription, sustainPoint: ^b32) -> fmod.Result ---
    EventDescription_CreateInstance :: proc(eventdescription: ^EventDescription, instance: ^^EventInstance) -> fmod.Result ---
    EventDescription_GetInstanceCount :: proc(eventdescription: ^EventDescription, count: ^i32) -> fmod.Result ---
    EventDescription_GetInstanceList :: proc(eventdescription: ^EventDescription, array: ^^EventInstance, capacity: i32, count: ^i32) -> fmod.Result ---
    EventDescription_LoadSampleData :: proc(eventdescription: ^EventDescription) -> fmod.Result ---
    EventDescription_UnloadSampleData :: proc(eventdescription: ^EventDescription) -> fmod.Result ---
    EventDescription_GetSampleLoadingState :: proc(eventdescription: ^EventDescription, state: ^Loading_State) -> fmod.Result ---
    EventDescription_ReleaseAllInstances :: proc(eventdescription: ^EventDescription) -> fmod.Result ---
    EventDescription_SetCallback :: proc(eventdescription: ^EventDescription, callback: event_callback, callbackmask: Event_Callback_Type) -> fmod.Result ---
    EventDescription_GetUserData :: proc(eventdescription: ^EventDescription, userdata: ^rawptr) -> fmod.Result ---
    EventDescription_SetUserData :: proc(eventdescription: ^EventDescription, userdata: rawptr) -> fmod.Result ---


    ///////////////////////////////////////////////////////////////////////////////////////////////////////
    // EventInstance
    //

    EventInstance_IsValid :: proc(eventinstance: ^EventInstance) -> b32 ---
    EventInstance_GetDescription :: proc(eventinstance: ^EventInstance, description: ^^EventDescription) -> fmod.Result ---
    EventInstance_GetVolume :: proc(eventinstance: ^EventInstance, volume: ^f32, finalvolume: ^f32) -> fmod.Result ---
    EventInstance_SetVolume :: proc(eventinstance: ^EventInstance, volume: f32) -> fmod.Result ---
    EventInstance_GetPitch :: proc(eventinstance: ^EventInstance, pitch: ^f32, finalpitch: ^f32) -> fmod.Result ---
    EventInstance_SetPitch :: proc(eventinstance: ^EventInstance, pitch: f32) -> fmod.Result ---
    EventInstance_Get3DAttributes :: proc(eventinstance: ^EventInstance, attributes: ^fmod._3D_Attributes) -> fmod.Result ---
    EventInstance_Set3DAttributes :: proc(eventinstance: ^EventInstance, attributes: ^fmod._3D_Attributes) -> fmod.Result ---
    EventInstance_GetListenerMask :: proc(eventinstance: ^EventInstance, mask: ^u32) -> fmod.Result ---
    EventInstance_SetListenerMask :: proc(eventinstance: ^EventInstance, mask: u32) -> fmod.Result ---
    EventInstance_GetProperty :: proc(eventinstance: ^EventInstance, index: Event_Property, value: ^f32) -> fmod.Result ---
    EventInstance_SetProperty :: proc(eventinstance: ^EventInstance, index: Event_Property, value: f32) -> fmod.Result ---
    EventInstance_GetReverbLevel :: proc(eventinstance: ^EventInstance, index: i32, level: ^f32) -> fmod.Result ---
    EventInstance_SetReverbLevel :: proc(eventinstance: ^EventInstance, index: i32, level: f32) -> fmod.Result ---
    EventInstance_GetPaused :: proc(eventinstance: ^EventInstance, paused: ^b32) -> fmod.Result ---
    EventInstance_SetPaused :: proc(eventinstance: ^EventInstance, paused: b32) -> fmod.Result ---
    EventInstance_Start :: proc(eventinstance: ^EventInstance) -> fmod.Result ---
    EventInstance_Stop :: proc(eventinstance: ^EventInstance, mode: Stop_Mode) -> fmod.Result ---
    EventInstance_GetTimelinePosition :: proc(eventinstance: ^EventInstance, position: ^i32) -> fmod.Result ---
    EventInstance_SetTimelinePosition :: proc(eventinstance: ^EventInstance, position: i32) -> fmod.Result ---
    EventInstance_GetPlaybackState :: proc(eventinstance: ^EventInstance, state: ^Playback_State) -> fmod.Result ---
    EventInstance_GetChannelGroup :: proc(eventinstance: ^EventInstance, group: ^^fmod.ChannelGroup) -> fmod.Result ---
    EventInstance_GetMinMaxDistance :: proc(eventinstance: ^EventInstance, min: ^f32, max: ^f32) -> fmod.Result ---
    EventInstance_Release :: proc(eventinstance: ^EventInstance) -> fmod.Result ---
    EventInstance_IsVirtual :: proc(eventinstance: ^EventInstance, virtualstate: ^b32) -> fmod.Result ---
    EventInstance_GetParameterByName :: proc(eventinstance: ^EventInstance, name: cstring, value: ^f32, finalvalue: ^f32) -> fmod.Result ---
    EventInstance_SetParameterByName :: proc(eventinstance: ^EventInstance, name: cstring, value: f32, ignoreseekspeed: b32) -> fmod.Result ---
    EventInstance_SetParameterByNameWithLabel :: proc(eventinstance: ^EventInstance, name: cstring, label: cstring, ignoreseekspeed: b32) -> fmod.Result ---
    EventInstance_GetParameterByID :: proc(eventinstance: ^EventInstance, id: Parameter_ID, value: ^f32, finalvalue: ^f32) -> fmod.Result ---
    EventInstance_SetParameterByID :: proc(eventinstance: ^EventInstance, id: Parameter_ID, value: f32, ignoreseekspeed: b32) -> fmod.Result ---
    EventInstance_SetParameterByIDWithLabel :: proc(eventinstance: ^EventInstance, id: Parameter_ID, label: cstring, ignoreseekspeed: b32) -> fmod.Result ---
    EventInstance_SetParametersByIDs :: proc(eventinstance: ^EventInstance, #by_ptr ids: Parameter_ID, values: ^f32, count: i32, ignoreseekspeed: b32) -> fmod.Result ---
    EventInstance_KeyOff :: proc(eventinstance: ^EventInstance) -> fmod.Result ---
    EventInstance_SetCallback :: proc(eventinstance: ^EventInstance, callback: event_callback, callbackmask: Event_Callback_Type) -> fmod.Result ---
    EventInstance_GetUserData :: proc(eventinstance: ^EventInstance, userdata: ^rawptr) -> fmod.Result ---
    EventInstance_SetUserData :: proc(eventinstance: ^EventInstance, userdata: rawptr) -> fmod.Result ---
    EventInstance_GetCPUUsage :: proc(eventinstance: ^EventInstance, exclusive: ^u32, inclusive: ^u32) -> fmod.Result ---
    EventInstance_GetMemoryUsage :: proc(eventinstance: ^EventInstance, memoryusage: ^Memory_Usage) -> fmod.Result ---


    ///////////////////////////////////////////////////////////////////////////////////////////////////////
    // Bus
    //

    Bus_IsValid :: proc(bus: ^Bus) -> b32 ---
    Bus_GetID :: proc(bus: ^Bus, id: ^fmod.GUID) -> fmod.Result ---
    Bus_GetPath :: proc(bus: ^Bus, path: [^]u8, size: i32, retrieved: ^i32) -> fmod.Result ---
    Bus_GetVolume :: proc(bus: ^Bus, volume: ^f32, finalvolume: ^f32) -> fmod.Result ---
    Bus_SetVolume :: proc(bus: ^Bus, volume: f32) -> fmod.Result ---
    Bus_GetPaused :: proc(bus: ^Bus, paused: ^b32) -> fmod.Result ---
    Bus_SetPaused :: proc(bus: ^Bus, paused: b32) -> fmod.Result ---
    Bus_GetMute :: proc(bus: ^Bus, mute: ^b32) -> fmod.Result ---
    Bus_SetMute :: proc(bus: ^Bus, mute: b32) -> fmod.Result ---
    Bus_StopAllEvents :: proc(bus: ^Bus, mode: Stop_Mode) -> fmod.Result ---
    Bus_GetPortIndex :: proc(bus: ^Bus, index: ^fmod.Port_Index) -> fmod.Result ---
    Bus_SetPortIndex :: proc(bus: ^Bus, index: fmod.Port_Index) -> fmod.Result ---
    Bus_LockChannelGroup :: proc(bus: ^Bus) -> fmod.Result ---
    Bus_UnlockChannelGroup :: proc(bus: ^Bus) -> fmod.Result ---
    Bus_GetChannelGroup :: proc(bus: ^Bus, group: ^^fmod.ChannelGroup) -> fmod.Result ---
    Bus_GetCPUUsage :: proc(bus: ^Bus, exclusive: ^u32, inclusive: ^u32) -> fmod.Result ---
    Bus_GetMemoryUsage :: proc(bus: ^Bus, memoryusage: ^Memory_Usage) -> fmod.Result ---


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

    Bank_IsValid :: proc(bank: ^Bank) -> b32 ---
    Bank_GetID :: proc(bank: ^Bank, id: ^fmod.GUID) -> fmod.Result ---
    Bank_GetPath :: proc(bank: ^Bank, path: ^u8, size: i32, retrieved: ^i32) -> fmod.Result ---
    Bank_Unload :: proc(bank: ^Bank) -> fmod.Result ---
    Bank_LoadSampleData :: proc(bank: ^Bank) -> fmod.Result ---
    Bank_UnloadSampleData :: proc(bank: ^Bank) -> fmod.Result ---
    Bank_GetLoadingState :: proc(bank: ^Bank, state: ^Loading_State) -> fmod.Result ---
    Bank_GetSampleLoadingState :: proc(bank: ^Bank, state: ^Loading_State) -> fmod.Result ---
    Bank_GetStringCount :: proc(bank: ^Bank, count: ^i32) -> fmod.Result ---
    Bank_GetStringInfo :: proc(bank: ^Bank, index: i32, id: ^fmod.GUID, path: ^u8, size: i32, retrieved: ^i32) -> fmod.Result ---
    Bank_GetEventCount :: proc(bank: ^Bank, count: ^i32) -> fmod.Result ---
    Bank_GetEventList :: proc(bank: ^Bank, array: ^^EventDescription, capacity: i32, count: ^i32) -> fmod.Result ---
    Bank_GetBusCount :: proc(bank: ^Bank, count: ^i32) -> fmod.Result ---
    Bank_GetBusList :: proc(bank: ^Bank, array: ^^Bus, capacity: i32, count: ^i32) -> fmod.Result ---
    Bank_GetVCACount :: proc(bank: ^Bank, count: ^i32) -> fmod.Result ---
    Bank_GetVCAList :: proc(bank: ^Bank, array: ^^VCA, capacity: i32, count: ^i32) -> fmod.Result ---
    Bank_GetUserData :: proc(bank: ^Bank, userdata: ^rawptr) -> fmod.Result ---
    Bank_SetUserData :: proc(bank: ^Bank, userdata: rawptr) -> fmod.Result ---


    ///////////////////////////////////////////////////////////////////////////////////////////////////////
    // Command playback information
    //

    CommandReplay_IsValid :: proc(replay: ^CommandReplay) -> b32 ---
    CommandReplay_GetSystem :: proc(replay: ^CommandReplay, system: ^^System) -> fmod.Result ---
    CommandReplay_GetLength :: proc(replay: ^CommandReplay, length: ^f32) -> fmod.Result ---
    CommandReplay_GetCommandCount :: proc(replay: ^CommandReplay, count: ^i32) -> fmod.Result ---
    CommandReplay_GetCommandInfo :: proc(replay: ^CommandReplay, commandindex: i32, info: ^Command_Info) -> fmod.Result ---
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
    CommandReplay_SetFrameCallback :: proc(replay: ^CommandReplay, callback: commandreplay_frame_callback) -> fmod.Result ---
    CommandReplay_SetLoadBankCallback :: proc(replay: ^CommandReplay, callback: commandreplay_load_bank_callback) -> fmod.Result ---
    CommandReplay_SetCreateInstanceCallback :: proc(replay: ^CommandReplay, callback: commandreplay_create_instance_callback) -> fmod.Result ---
    CommandReplay_GetUserData :: proc(replay: ^CommandReplay, userdata: ^rawptr) -> fmod.Result ---
    CommandReplay_SetUserData :: proc(replay: ^CommandReplay, userdata: rawptr) -> fmod.Result ---
}
