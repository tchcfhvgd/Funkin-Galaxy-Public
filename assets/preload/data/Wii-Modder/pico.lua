--[[
    Word typing thingy by ToufG#6291 (aka the smart guy behind how the typing works)
    precaching SPG and making the event play made by Flez (aka the dumb shit)
]]--

------------------------------------------------------------
local word = {
    'P',
    'I',
    'C',
    'O'
}
------------------------------------------------------------

function onCreate()
    addCharacterToList('spgfnf', 'dad');
end

local selected = 1
function onUpdate(elapsed)
    if keyboardJustPressed(word[selected]) then
        if selected < #word then
            selected = selected + 1
        else
            secretWordTyped()
            selected = 1
        end
    end
end
function secretWordTyped()
    -- uhh whatever you want lmfao
    triggerEvent('Change Character', 1, 'spgfnf');
end