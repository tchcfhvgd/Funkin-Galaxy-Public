-- Event notes hooks
function onEvent(name, value1, value2)
	if name == 'Gold Leaf Fade' then
		duration = tonumber(value1);
		if duration < 0 then
			duration = 0;
		end

		targetAlpha = tonumber(value2);
		if duration == 0 then
			setProperty('CosmicBG2.alpha', targetAlpha);
		else
			doTweenAlpha('CosmicBG2FadeEventTween', 'CosmicBG2', targetAlpha, duration, 'linear');
		end
		--debugPrint('Event triggered: ', name, duration, targetAlpha);
	end
end