function onSongStart()
		playSound('shootingStar');
		doTweenX('PurpleCometX', 'PurpleComet', -480, 1.8, 'linear');
		doTweenY('PurpleCometY', 'PurpleComet', 60, 1.8, 'linear');
	end