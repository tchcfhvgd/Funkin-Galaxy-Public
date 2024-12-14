function onEvent(name, value1, value2)
if name == 'CameraFlipEvent' then
    if getRandomBool(50) then
       setProperty("camGame.flashSprite.scaleX", getProperty("camGame.flashSprite.scaleX") * -1)
    end
    if getRandomBool(50) then
       setProperty("camGame.flashSprite.scaleY", getProperty("camGame.flashSprite.scaleY") * -1)
    end
end
end