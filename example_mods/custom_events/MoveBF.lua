function onEvent(name, value1, value2)
if name == 'MoveBF' then
doTweenX('posX', 'boyfriend', value1, 1, 'cubeOut')
doTweenY('posY', 'boyfriend', value2, 1, 'cubeOut')
end
end