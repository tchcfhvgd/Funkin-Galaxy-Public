function onEvent(name, value1, value2)
if name == 'CameraFlipBackEvent' then
    setProperty("camGame.flashSprite.scaleX",1)
    setProperty("camGame.flashSprite.scaleY", 1)
end
end