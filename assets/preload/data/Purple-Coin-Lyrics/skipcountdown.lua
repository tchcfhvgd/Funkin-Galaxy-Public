function onCreate()

 setProperty('camFollowPos.x',200)
 setProperty('camFollowPos.y',500)
 setProperty('camFollow.x',200)
 setProperty('camFollow.y', 500)
 setProperty('isCameraOnForcedPos',true)
 setProperty('skipCountdown',true)
 doTweenAlpha('GUItween', 'camHUD', 0, 0.000001, 'linear');

end