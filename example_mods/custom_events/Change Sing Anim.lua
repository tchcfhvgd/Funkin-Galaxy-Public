local current = ""
local toChar = ""
local changeSING = false

function onEvent(n,value1,value2)

if n == 'Change Sing Anim' then 

--	        current = "-dodge"
--	        current = ""
--	        current = "miss"
--	        current = "-alt"
		if value1 == '' or value2 == 'normal' or value2 == 'og' or value2 == 'basic' then
		 current = ""
		   	changeSING  = false
else
	   	changeSING  = true
				current = value1; --get name of value1

		end
		
		if value2 == 'bf' or value2 == 'boyfriend' or value2 == 'BF' or value2 == '' then
		toChar = "boyfriend"

		end
		if value2 == 'dad' or value2 == 'opponent' or value2 == 'noBf' then
		toChar = "dad"

		end
		if value2 == 'gf' or value2 == 'girlfriend' or value2 == 'GF' then
		toChar = "gf"

		end
end
end

    function goodNoteHit(id, direction, noteType, isSustainNote)
    dir = ""
  		setProperty('boyfriend.specialAnim', true);
		setProperty('dad.specialAnim', true);
    if direction == 0 then
        dir = "LEFT"
    elseif direction == 1 then
        dir = "DOWN"
    elseif direction == 2 then
        dir = "UP"
    elseif direction == 3 then
        dir = "RIGHT"
    end
if changeSING  == true then
    characterPlayAnim(toChar, "sing" .. dir .. current, true)
end
if changeSING  == false then
  --  characterPlayAnim(toChar, "sing" .. dir .. current, true)

end
--example final template
--	    characterPlayAnim("boyfriend", "sing" .. "LEFT" .. "-alt", true)
end

 function onStepHit()
	--   if curStep == 244 then
 --       triggerEvent("Change Sing Anim", "altSing", "bf")
--end
end



--by LinkstormZ, free to use just remember don't delete this.

