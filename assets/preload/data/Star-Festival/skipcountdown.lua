function onCreate()

 setProperty('camFollowPos.x',760)
 setProperty('camFollowPos.y',450)
 setProperty('camFollow.x',760)
 setProperty('camFollow.y', 450)
 setProperty('isCameraOnForcedPos',true)
 setProperty('skipCountdown',true)
 doTweenAlpha('GUItween', 'camHUD', 0, 0.000001, 'linear');

end