function onEvent(name, value1, value2)
if name == 'MoveGF' then
doTweenX('posX', 'gf', value1, 1.5, 'cubeOut')
doTweenY('posY', 'gf', value2, 1.5, 'cubeOut')
end
end