function onCreate()

	PosX= 16*10
	PosY= 66*10

	makeLuaSprite('bg', 'stages/panic/PanicBG', -900, -300);
	setScrollFactor('bg', 0.9, 1);
	scaleObject('bg', 10, 10);
	addLuaSprite('bg', false);

	makeAnimatedLuaSprite('stage', 'stages/panic/Panic', -920, -162)
	addAnimationByPrefix('stage','anim','Panic Ground',8,true)
	objectPlayAnimation('stage','anim','false');
	setLuaSpriteScrollFactor('stage', 1,1);
	scaleObject('stage', 10, 10)
	addLuaSprite('stage', false);

	makeAnimatedLuaSprite('darkstage', 'stages/panic/Panic-dark', -1710, -162)
	addAnimationByPrefix('darkstage','anim','Panic Ground',8,true)
	objectPlayAnimation('darkstage','anim','false');
	setLuaSpriteScrollFactor('darkstage', 1,1);
	scaleObject('darkstage', 10, 10)
	addLuaSprite('darkstage', false);

	makeAnimatedLuaSprite('door1', 'stages/panic/door', PosX-1, PosY-2)
	addAnimationByPrefix('door1','anim','Panic door',11,false)
	addAnimationByPrefix('door1','anim2','one door',9,false)
	addAnimationByPrefix('door1','bye','bye door',9,false)
	objectPlayAnimation('door1','anim2','false');
	setLuaSpriteScrollFactor('door1', 1,1);
	scaleObject('door1', 10, 10)
	addLuaSprite('door1', false);

	makeAnimatedLuaSprite('door2', 'stages/panic/door', PosX-1, PosY-2)
	addAnimationByPrefix('door2','anim','second door',11,false)
	setLuaSpriteScrollFactor('door2', 1,1);
	scaleObject('door2', 10, 10)
	addLuaSprite('door2', true);

	makeLuaSprite('white', 'stages/panic/white', -1, -1);
	setScrollFactor('white', 1, 1);
	scaleObject('white', 6, 6);
	addLuaSprite('white', false);
	setObjectCamera('white', 'hud')
	setProperty('white.alpha', 0)


	setProperty('bg.antialiasing', false)
	setProperty('stage.antialiasing', false)
	setProperty('darkstage.antialiasing', false)
	setProperty('door1.antialiasing', false)
	setProperty('door2.antialiasing', false)

	setProperty('door2.visible', false);
       setProperty('defaultCamZoom',1.07)

end

function onCreatePost()
--function onBeatHit()
	--setProperty('camHUD.alpha', 0)
	--		triggerEvent("Play Animation", "walk", "boyfriend")
	doorPosX = getProperty("door1.x")
	doorPosY = getProperty("door1.y")
	MarioposX = getProperty("boyfriend.x")
	MarioposY = getProperty("boyfriend.y")
 	PhraseposX = getProperty("boyfriend.x")-18*10
	PhraseposY = getProperty("boyfriend.y")

      setProperty('boyfriend.x',MarioposX+1012)
      setProperty('boyfriend.y',MarioposY-160)
--setProperty('defaultPlayerStrumX.alpha', 0)
	setProperty('iconP2.alpha', 0)

   		doTweenX('gett', 'boyfriend', doorPosX+54.6, 3.01, 'sineOut');
	triggerEvent("Alt Idle Animation", "boyfriend", "-walk")
	setProperty('dad.visible', false);
	setProperty('gf.visible', false);
		runTimer('startsi', 3.0);
		runTimer('sistart', 0.95);--fall

     makeAnimatedLuaSprite('Phrases', 'stages/panic/HudThing', 62*10, 63*10)
     addAnimationByPrefix('Phrases', 'Bravo','Bravo',6,false)
     addAnimationByPrefix('Phrases', 'OhNo','OhNo',8,false)
     addAnimationByPrefix('Phrases', 'Lucky','Lucky',8,false)
     addAnimationByPrefix('Phrases', 'Go','Go',8,false)
     addAnimationByPrefix('Phrases', 'ThankYou','ThankYou',8,false)
     addAnimationByPrefix('Phrases', 'vacio','vacio',8,false)
    scaleObject('Phrases', 10, 10);
    addLuaSprite('Phrases', false);
   -- setObjectCamera('Phrases', 'hud')
    setProperty('Phrases.antialiasing', false)
    objectPlayAnimation('Phrases', 'vacio', false)
   		setProperty('Phrases.x', PhraseposX);
   		setProperty('Phrases.y', PhraseposY+21*10);

end
function visiblePhrase()
  		doTweenY('MarioSay', 'Phrases', MarioposY-400, 1.25, 'sineOut');--goback
 		runTimer('MarioNoSay', 1.1);

end

function onStepHit()

    if curStep == 60 then

	triggerEvent("Play Animation", "singUP-alt", "boyfriend")
	triggerEvent("Alt Idle Animation", "boyfriend", "")
	setProperty('defaultCamZoom', 0.7)

	end

    if curStep == 603 then --603
	 triggerEvent("Play Animation", "superJump", "boyfriend")
	 triggerEvent("Camera Follow Pos", "342", "631")
  	doTweenY('goback', 'boyfriend', MarioposY-48*10, 0.55, 'sineOut');--goback

	end

    if curStep == 92 or curStep == 618 or curStep == 668 then --bravo

    objectPlayAnimation('Phrases', 'Bravo', false)
visiblePhrase()

end
    if curStep == 154 or curStep == 730 then --tenkiu

    objectPlayAnimation('Phrases', 'ThankYou', false)
visiblePhrase()

end
    if curStep == 316 then --go

    objectPlayAnimation('Phrases', 'Go', false)
visiblePhrase()

end
    if curStep == 577 then --Lucky

    objectPlayAnimation('Phrases', 'Lucky', false)
visiblePhrase()

end
end
function noteMiss(id, direction, noteType, isSustainNote)

    objectPlayAnimation('Phrases', 'OhNo', false)
		visiblePhrase()
end 


function onTweenCompleted(tag, loops, loopsLeft)
	if tag == 'goback' then -- Timer completed,
  		doTweenY('getback', 'boyfriend', MarioposY, 0.35, 'sineIn');--goback
  		end
	if tag == 'MarioSay' then -- Timer completeda
   		setProperty('Phrases.y', PhraseposY+18*10);
		end

end
function onTimerCompleted(tag, loops, loopsLeft)
	if tag == 'MarioNoSay' then -- Timer completed, play dialogue
    objectPlayAnimation('Phrases', 'vacio', false)
   		setProperty('Phrases.y', MarioposY+34*10);

end

	if tag == 'sistart' then -- fall

	  		doTweenY('get3t', 'boyfriend', MarioposY, 0.62, 'sineIn');
end
	if tag == 'startsi' then -- Timer completed, play dialogue
		runTimer('start', 0.3);
	triggerEvent("Alt Idle Animation", "boyfriend", "-stop")
  		setProperty('boyfriend.specialAnim', true);

end
	if tag == 'start' then -- Timer completed, dooropen
		runTimer('start2', 0.5);
	objectPlayAnimation('door1','anim','false');
	triggerEvent("Alt Idle Animation", "boyfriend", "-back")
	triggerEvent("Play Animation", "idle-back", "boyfriend")
  		setProperty('boyfriend.specialAnim', true);
	playSound('doorOpen', 0.5)

end
	if tag == 'start2' then -- Timer completed, play dialogue
	setProperty('door2.visible', true);
	objectPlayAnimation('door2','anim','false');
		runTimer('waitDoor', 0.3);
end
	if tag == 'waitDoor' then -- Timer completed, play dialogue
	triggerEvent("Alt Idle Animation", "boyfriend", "-front")
			triggerEvent("Play Animation", "idle-front", "boyfriend")
		runTimer('start3', 0.4);
	setProperty('white.alpha', 1)
	playSound('doorClose', 0.5)

end

	if tag == 'start3' then -- Timer completed, play dialogue
	setProperty('door2.visible', false);
	objectPlayAnimation('door1','anim','false');

		setProperty('darkstage.visible', false);
	setProperty('white.alpha', 0)

		runTimer('start4', 0.5);

end
	if tag == 'start4' then -- Timer completed, play dialogue
		triggerEvent("Alt Idle Animation", "boyfriend", "-walk")
 			triggerEvent("Play Animation", "idle-walk", "boyfriend")
  		doTweenX('get2t', 'boyfriend', MarioposX, 1.95, 'sineOut');
	setProperty('boyfriend.flipX', true);

	objectPlayAnimation('door1','anim2','false');
		runTimer('start5', 1.2);

	end
	if tag == 'start5' then -- Timer completed, play dialogue
		triggerEvent("Alt Idle Animation", "boyfriend", "-skid")
	setProperty('white.alpha', 0.3)
		runTimer('start6', 1.2);

	end
	if tag == 'start6' then -- Timer completed, play dialogue
		triggerEvent("Alt Idle Animation", "boyfriend", "-stop")
	 			triggerEvent("Play Animation", "idle-stop", "boyfriend")
setProperty('boyfriend.flipX', false);
	setProperty('dad.visible', true);
	setProperty('gf.visible', true);
			runTimer('start7', 0.5);
		triggerEvent("Alt Idle Animation", "dad", "-stop")
	 			triggerEvent("Play Animation", "ImHere", "dad")
	 				setProperty('white.alpha', 0)
	setProperty('iconP2.alpha', 1)

	end
	if tag == 'start7' then -- Timer completed, play dialogue
	objectPlayAnimation('door1','bye','false');
		triggerEvent("Alt Idle Animation", "dad", "")
		runTimer('start8', 11.2);

	end
	if tag == 'start8' then -- Timer completed, play dialogue
		triggerEvent("Alt Idle Animation", "boyfriend", "")

	end


end