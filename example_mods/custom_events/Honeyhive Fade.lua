-- Event notes hooks
function onEvent(name, value1, value2)
	if name == 'Honeyhive Fade' then
		duration = tonumber(value1);
		if duration < 0 then
			duration = 0;
		end

		targetAlpha = tonumber(value2);
		if duration == 0 then
			setProperty('CosmicBG.alpha', targetAlpha);
			setProperty('bluecometfilter.alpha', targetAlpha);
		else
			doTweenAlpha('CosmicBGFadeEventTween', 'CosmicBG', targetAlpha, duration, 'linear');
			doTweenAlpha('bluecometfilterFadeEventTween', 'bluecometfilter', targetAlpha, duration, 'linear');
		end
		--debugPrint('Event triggered: ', name, duration, targetAlpha);
	end
end