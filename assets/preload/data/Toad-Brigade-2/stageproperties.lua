function onCreate()

	setProperty('boyfriendFNF.alpha', 0);
	setProperty('ToadEep.visible', false)
	setProperty('eepShadow.visible', false)
	setProperty('ToadNerd.visible', false)
	setProperty('nerdShadow.visible', false)
	setProperty('ToadFG.visible', false)

end

function onStepHit()
	if curStep == 1775 then
		doTweenAlpha('boyfriendFNFFadeTween', 'boyfriendFNF', 0.5, 2, 'linear');
	end
	if curStep == 2160 then
		doTweenAlpha('boyfriendFNFFadeTween', 'boyfriendFNF', 0.000001, 1.5, 'linear');
	end
end