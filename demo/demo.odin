package fmod_core_example
// Based on the '3D' example from FMOD core

import "core:fmt"
import "core:sys/windows"

import rl "vendor:raylib"

import fmod "../core"

// base distance scaling, choose your preferred units
DISTANCEFACTOR :: 1000.0 // per meter
// DISTANCEFACTOR :: 3.28 // per feet

main :: proc() {
    WIDTH :: 800
    HEIGHT :: 480
    rl.InitWindow(WIDTH, HEIGHT, "FMOD Core Example")
    defer rl.CloseWindow()
    rl.SetTargetFPS(60)

    when ODIN_OS == .Windows {
        windows.CoInitializeEx(nil, .APARTMENTTHREADED)
        defer windows.CoUninitialize()
    }

    run :: proc() -> fmod.Result {
        system: ^fmod.System
        fmod.System_Create(&system, fmod.VERSION) or_return
        defer fmod.System_Release(system)
        fmod.System_Init(system, 100, {}, nil) or_return
        defer fmod.System_Close(system)
        fmod.System_Set3DSettings(system, 1.0, DISTANCEFACTOR, 1.0) or_return

        sound1, sound2: ^fmod.Sound
        fmod.System_CreateSound(system, "drumloop.wav", {._3d}, nil, &sound1) or_return
        defer fmod.Sound_Release(sound1)
        fmod.System_CreateSound(system, "swish.wav", {._2d}, nil, &sound2) or_return
        defer fmod.Sound_Release(sound2)

        fmod.Sound_Set3DMinMaxDistance(sound1, 0.5 * DISTANCEFACTOR, 5000 * DISTANCEFACTOR) or_return

        channel1, channel2: ^fmod.Channel
        pos1: fmod.vec = 0

        fmod.System_PlaySound(system, sound1, nil, true, &channel1) or_return
        fmod.Channel_Set3DAttributes(channel1, pos1, 0) or_return
        fmod.Channel_SetPaused(channel1, false) or_return

        camera: rl.Camera3D = {
            position   = {10, 10, 10},
            target     = 0,
            up         = {0, 1, 0},
            fovy       = 45,
            projection = .PERSPECTIVE,
        }

        for !rl.WindowShouldClose() {
            delta := clamp(rl.GetFrameTime(), 1.0 / 240.0, 1.0 / 10.0)

            prev_pos := camera.position
            if rl.IsMouseButtonDown(.LEFT) {
                rl.UpdateCamera(&camera, .FREE)
            }

            // Note: we should pass forward and up vector from the camera here.
            fmod.System_Set3DListenerAttributes(
                system,
                0,
                cast(fmod.vec)camera.position,
                cast(fmod.vec)(camera.position - prev_pos) * (1000.0 / delta),
                {0, 0, 1},
                {0, 1, 0},
            ) or_return

            if rl.IsKeyPressed(.F) {
                fmod.System_PlaySound(system, sound2, nil, false, &channel2) or_return
            }

            fmod.System_Update(system) or_return

            rl.BeginDrawing()
            defer rl.EndDrawing()
            rl.ClearBackground({30, 40, 50, 255})

            {
                rl.BeginMode3D(camera)
                defer rl.EndMode3D()
                rl.DrawCube(0, 2.0, 2.0, 2.0, rl.RED)
                rl.DrawCubeWires(0, 2.0, 2.0, 2.0, rl.MAROON)
                rl.DrawGrid(10, 1.0)
            }

            rl.DrawFPS(2, 2)
            rl.DrawText("Press F to play swish.wav", 2, 24, 20, rl.WHITE)
        }

        return .ok
    }
    fmt.println(fmod.FANCY_ERR[run()])
}
