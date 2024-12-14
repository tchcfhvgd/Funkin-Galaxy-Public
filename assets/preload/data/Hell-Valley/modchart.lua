coolSteps = {1104, 1120, 1136, 1152, 1161, 1164, 1168, 1184, 1200, 1216, 1232}

noteRotations = {
    {87, 94, 95, 82}, {87, 96, 87, 100},
    {70, 108, 94, 101}, {105, 85, 77, 80},
    {84, 76, 88, 110}, {87, 94, 95, 82},
    {109, 89, 70, 100}, {110, 91, 92, 81},
    {87, 96, 77, 104}, {83, 72, 73, 93},

    {90, 90, 90, 90} --reset
}
noteOffsetsX = {
    {-4, 3, 10, -16}, {-19, 13, 15, -1},
    {-13, 11, -3, 18}, {9, 12, -19, 15}, 
    {13, 19, -4, -9}, {9, 7, 14, 17},
    {-4, 19, -11, -12}, {20, 4, -10, 7},
    {5, -20, 15, -13}, {2, -12, -11, -2},

    {0, 0, 0, 0} --reset
}
noteOffsetsY = {
    {30, -23, 41, 24}, {8, 37, 3, -1},
    {-25, 39, 16, -18}, {26, -47, -8, -46},
    {11, 22, -16, -27}, {27, -5, -25, 23},
    {11, -18, -24, 1}, {20, 23, -1, 12},
    {-3, 46, -23, 22}, {21, 16, 4, 47},

    {0, 0, 0, 0} --reset
}

local defaultPosX = {}
local defaultPosY

function onSongStart()
    defaultPosX = {defaultPlayerStrumX0, defaultPlayerStrumX1, defaultPlayerStrumX2, defaultPlayerStrumX3}
    defaultPosY = defaultPlayerStrumY0
end

function onSpawnNote(i, d, n, s)
    setPropertyFromGroup("notes", i, "copyAngle", false)
end

function onStepHit()
    for i, step in pairs(coolSteps) do
        if step == curStep then
            local rotations = noteRotations[i];
            local opfssetsX, opfssetsY = noteOffsetsX[i], noteOffsetsY[i];
            for note = 1, 4 do
                noteTweenDirection("noteRotate"..note, note + 3, rotations[note], 1.5, "quadOut")
                noteTweenX("noteMoveX"..note, note + 3, defaultPosX[note] - opfssetsX[note], 1, "quadOut")
                noteTweenY("noteMoveY"..note, note + 3, defaultPosY + (opfssetsY[note] * (downscroll and -1 or 1)), 1, "quadOut")
            end
        end
    end
end