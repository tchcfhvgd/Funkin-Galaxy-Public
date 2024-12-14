function onCreate()
	makeLuaSprite('gaming', 'gaming', 0, -420);
	addLuaSprite('gaming', true);
	scaleObject('gaming', 2.4, 2.4);

	setObjectCamera('gaming', 'camHUD') --make image not be on UI, but on "other" (since a hide UI event is used right before image shows up)
	setProperty('gaming.alpha', 1); --make the image be visible
	screenCenter('gaming', 'X') --center the image on the X axis
end

function onCreatePost()
	setProperty('camHUD.zoom', 0.5);
	setProperty('camGame.zoom', 0.275);

	if getPropertyFromClass('ClientPrefs', 'middleScroll') == false then
	for i = 0,3 do
	setPropertyFromGroup('strumLineNotes', i, "x", getPropertyFromGroup('strumLineNotes', i, "x") + 87)
	end
	for i = 4,7 do
	setPropertyFromGroup('strumLineNotes', i, "x", getPropertyFromGroup('strumLineNotes', i, "x") + - 78)
	setPropertyFromGroup('strumLineNotes', i, "y", getPropertyFromGroup('strumLineNotes', i, "y") + 0)
	end
end
end