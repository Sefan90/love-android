require "buttonClass"
require "heroInfo"
require "firebase"
local utf8 = require("utf8")

function love.load()
	safeX, safeY, width, height = love.window.getSafeArea()
	love.graphics.translate(safeX, safeY)
    grayScale = love.graphics.newShader[[
		vec4 effect( vec4 color, Image texture, vec2 texture_coords, vec2 screen_coords ){
			vec4 pixel = Texel(texture, texture_coords );//This is the current pixel color
			number average = (pixel.r+pixel.b+pixel.g)/3.0;
			pixel.r = average;
			pixel.g = average;
			pixel.b = average;
			return pixel;
		  }
	]]

	fb = firebase:new("AIzaSyBpLN0vrEVfYNi8h9Z2uU__ylQtqEGZFAc","https://fabcounterprod-default-rtdb.europe-west1.firebasedatabase.app")

	math.randomseed(os.time())
	local startscreen = 0--math.random(0, 0)
	outImage, outScale, outQuad = loadGUIImg("Assets/startscreen"..startscreen..".jpg",0,0)
	logoImage, logoScale, logoQuad = loadGUIImg("Assets/logov2butanopacitet.png",0,0)
	love.graphics.clear()
	local imageX, imageY = outImage:getDimensions()
	love.graphics.draw(outImage,outQuad,0,0,0,width/imageX,height/imageY)
	local imageX, imageY = logoImage:getDimensions()
	love.graphics.draw(logoImage,logoQuad,0,height/2,0,width/imageX,width/imageX,0,imageY/2)
	love.graphics.present()

	restartImage, restartScale = loadGUIImg("Assets/reload.png",0,0)
	cardImage, cardScale = loadGUIImg("Assets/swaphero.png",0,0)
	notesImage, notesScale = loadGUIImg("Assets/lifehistory.png",0,0)
	infoImage, infoScale = loadGUIImg("Assets/settings.png",0,0)
	closeImage, closeScale = loadGUIImg("Assets/close.png",0,0)
	cruImage, cruScale, cruQuad = loadGUIImg("Assets/CRU_HOME-PAGE_mobile.width-10000.jpg",0,0)
	arrowImage, arrowScale, arrowQuad = loadGUIImg("Assets/down-filled-triangular-arrow.png",0,0)
	checkboxImage, checkboxScale, checkboxQuad = loadGUIImg("Assets/checkbox.png",0,0)
	mapImage, mapScale, mapQuad = loadGUIImg("Assets/Everfest_Key_Art_FullHD.width-10000.jpg",0,0)
	saveImage, saveScale, saveQuad = loadGUIImg("Assets/save.png",0,0)
	changeImage, changeScale, changeQuad = loadGUIImg("Assets/change.png",0,0)
	trashImage, trashScale, trashQuad = loadGUIImg("Assets/trash-can.png",0,0)
	pauseImage, pauseScale, pauseQuad = loadGUIImg("Assets/pause.png",0,0)
	arrowsImage, arrowsScale, arrowsQuad = loadGUIImg("Assets/swapsides.png",0,0)
	dice1Image, dice1Scale, dice1Quad = loadGUIImg("Assets/dice1.png",0,0)
	dice2Image, dice2Scale, dice2Quad = loadGUIImg("Assets/dice2.png",0,0)
	dice3Image, dice3Scale, dice3Quad = loadGUIImg("Assets/dice3.png",0,0)
	dice4Image, dice4Scale, dice4Quad = loadGUIImg("Assets/dice4.png",0,0)
	dice5Image, dice5Scale, dice5Quad = loadGUIImg("Assets/dice5.png",0,0)
	dice6Image, dice6Scale, dice6Quad = loadGUIImg("Assets/dice6.png",0,0)
	diceImage, diceScale, diceQuad = loadGUIImg("Assets/dice.png",0,0)
	menubgImage, menubgScale, menubgQuad = loadGUIImg("Assets/menubg.png",0,0)
	leviaReImage, leviaReScale, leviaReQuad = loadGUIImg("Assets/levia_redeemed.jpg",0,0)
	blasmoImage, blasmoScale, blasmoQuad = loadGUIImg("Assets/Blasmophet.jpg",0,0)
	mechropotentImage, mechropotentScale, mechropotentQuad = loadGUIImg("Assets/mechropotent.jpg",0,height/10)

	includLLheroes = false
	heroData = heroInfo:new()
    imageList, quadList, imageAltList, quadAltList, lifeList = loadHeroImage()

	timer55 = false
	timeList = timer50to55(timer55)

    CCBlitz = 1
	rotatedImage = false
	flipImage = false
	pauseTime = false
	showPlusMinus = true
	rotPlusMinus = false
	showHeroArt = true
	showTimer = true
	biggerTimer = false
	henrikMode = true
	darkMode = false
	autoResetLife = false
	showDemiHero = false
	showHeroText = false
	formatVisuals = 1
    noOfPlayers = 2
    players = createPlayers(noOfPlayers)
	colors = {{0.5,0.5,0.5},{0.667,0.596,0.224},{0.667,0.478,0.224},{0.667,0.235,0.224},{0.557,0.639,0.212},{0.455,0.153,0.427},{0.259,0.188,0.459},{0.165,0.31,0.431},{0.016,0.957,0.016},{0,0,0}}
    players[1].image = 1
	players[2].image = 2
	players[1].altHeroArt = false
	players[2].altHeroArt = false
	players[1].demiHero = 0
	players[2].demiHero = 0
	loadSettings()
	reloadHeroImage()
	timeList = timer50to55(timer55)
	if CCBlitz < 1 or CCBlitz > #imageList then --If an ccblitz outside of current range was saved
		CCBlitz = 1
	elseif CCBlitz == 4 then
		noOfPlayers = 4
		players = createPlayers(noOfPlayers)
		players[1].image = 1
		players[2].image = 2
		players[3].image = 3
		players[4].image = 4
	end 
	for k, p in ipairs(players) do
		if k > 2 and #imageList[CCBlitz] < k then
			p.image = #imageList[CCBlitz]
			p.altHeroArt = false
		elseif k > 2 then
			p.image = k
			p.altHeroArt = false
		end
		if p.image > #lifeList[CCBlitz] then --If an hero outside of current range was saved
			p.image = 1
		end

		p.change.image = p.image
		p.life = lifeList[CCBlitz][p.image][2]
        p.lifeHistory = {p.life}
        p.lastLife = p.life
        p.lastLifeHistory = {p.life}
    end

    input = {}
	last = {
		last = -1,
		dy = 0,
		dx = 0
	}

    opensettings = false
	opencombatlog = false
	changeHero = false
	changeHeroId = -1
	viewLogs = false
	viewLimited = false
	viewStream = false
	activeStream = false
	loginText = ""
	currentLog = ""
	starttime = -1
	epochtime = -1
	scroll = 0
	oldScroll = 0
	fade = 1
	dice = 7
	diceTime = -1
	textinput = 1
	inputtext = {'',''}
	settingsButtonDraw = 1
	lastclick = 0
	clickInterval = 0.5
	
	loadFirebase()
	resolutionChange()
end

function love.update(dt)
	if activeStream == true and fb.refreshToken ~= '' then
		fb:update(dt)
	end

	if viewStream == false then
		emailButton:setTextInput(false)
		passwordButton:setTextInput(false)
	else
		emailButton:updateText(inputtext[1])
		passwordButton:updateText(string.gsub(inputtext[2],'.','*'))
	end
	if #players ~= noOfPlayers then
        players = createPlayers(noOfPlayers)
		loadSettings()
		players[1].demiHero = 0
		if noOfPlayers > 1 then
			players[2].demiHero = 0
		end

		for k, p in ipairs(players) do
			if k > 2 and #imageList[CCBlitz] < k then
				p.image = #imageList[CCBlitz]
				p.altHeroArt = false
			elseif k > 2 then
				p.image = k
				p.altHeroArt = false
			end
			if p.image > #lifeList[CCBlitz] then
				p.image = 1
			end
			
			p.life = lifeList[CCBlitz][p.image][2]
			p.lifeHistory = {p.life}
			p.lastLife = p.life
			p.lastLifeHistory = {p.life}
		end
	end

	--Update internal varables and set max/min life
	for k, p in ipairs(players) do
		p.change.image = p.image
		if p.life < -99 then
			p.life = -99
		elseif p.life > 999 then
			p.life = 999
		end
	end


	if fade > 0 then
		fade = fade - dt
	end

    if diceTime > 0 then
		diceTime = diceTime - dt
		if diceTime <= 0 then 
			dice = math.random(1,6)
		else
			dice = math.floor(diceTime*10)+1
		end
		local diceList = {dice1Image,dice2Image,dice3Image,dice4Image,dice5Image,dice6Image,diceImage}
		local diceScaleList = {dice1Scale,dice2Scale,dice3Scale,dice4Scale,dice5Scale,dice6Scale,diceScale}
		local imageWidth, imageHeight = diceButton.image1:getDimensions()
		diceButton:updateImage(diceList[dice],diceScaleList[dice]*0.5,diceButton.ix,height/2-imageHeight*diceScaleList[dice]/4)
	end

	if starttime == -1 then
		pauseTime = false
	elseif pauseTime and starttime <= love.timer.getTime()-1 then
		starttime = starttime + dt
		epochtime = epochtime + dt
	end

	if #love.touch.getTouches() == 0 then
		if last.last ~= -1 and love.timer.getTime() - last.last > 2 then
			last.last = -1
			for _, p in ipairs(players) do
				updateHistoryLog(p)
			end
			if activeStream == true and fb.refreshToken ~= '' then
				fb:write_database('{"P1":'..players[1].life..', "P2":'..players[2].life..', "Image1":"'..imageList[CCBlitz][players[1].image][1]..'", "Image2":"'..imageList[CCBlitz][players[2].image][1]..'", "Timer":'..timeList[CCBlitz]+epochtime..',"IsCC":'..bool_to_number(isCC())..'}')
			end
		end

		if last.dy < -1 then
			scroll = scroll + last.dy
			last.dy = last.dy + 0.5 
		elseif last.dy > 1 then
			scroll = scroll + last.dy
			last.dy = last.dy - 0.5
		end
	end

	for i, id in ipairs(love.touch.getTouches()) do
		local x, y = love.touch.getPosition(id)
		id = tostring(id)
		if input[id].last ~= -1 and love.timer.getTime() - input[id].last > 2 then
			input[id].last = -1
			for _, p in ipairs(players) do
				updateHistoryLog(p)
			end
		end

		if input[id].holdtime ~= -1 then 
			if love.timer.getTime()-input[id].holdtime > 0.5 and opensettings == false and opencombatlog == false and changeHero == false and viewLogs == false and changeHeroId == -1 then
				input[id].holdtime = love.timer.getTime()
				input[id].fivepoints = true
				updatePlayerlife(id,x,y,5)
			end
		end
	end

	updateScroll()
end

function love.draw()
	local drawX, drawY, drawWidth, drawHeight = love.window.getSafeArea()
	if drawX ~= safeX or drawY ~= safeY or drawWidth ~= width or drawHeight ~= height then
		safeX, safeY, width, height = love.window.getSafeArea()
		local demiHeroPlayer1 = players[1].demiHero
		local demiHeroPlayer2 = 0
		if noOfPlayers > 1 then
			demiHeroPlayer2 = players[2].demiHero
		end
        players = createPlayers(noOfPlayers)
		loadSettings()
		if demiHeroPlayer1 >= 0 and demiHeroPlayer1 <= 2 and demiHeroPlayer2 >= 0 and demiHeroPlayer2 <= 2 then
			players[1].demiHero = demiHeroPlayer1
			if noOfPlayers > 1 then
				players[2].demiHero = demiHeroPlayer2
			end
		else
			players[1].demiHero = 0
			if noOfPlayers > 1 then
				players[2].demiHero = 0
			end
		end
		for k, p in ipairs(players) do
			if k > 2 and #imageList[CCBlitz] < k then
				p.image = #imageList[CCBlitz]
				p.altHeroArt = false
			elseif k > 2 then
				p.image = k
				p.altHeroArt = false
			end
			if p.image > #lifeList[CCBlitz] then
				p.image = 1
			end
			
			p.life = lifeList[CCBlitz][p.image][2]
			p.lifeHistory = {p.life}
			p.lastLife = p.life
			p.lastLifeHistory = {p.life}
		end
		resolutionChange()
	end

	love.graphics.translate(safeX, safeY)
    love.graphics.setColor({1,1,1,1})
	addStencil(stencilFunctionBG,"replace", 1,"equal", 1)

	if rotatedImage and noOfPlayers ~=2 then
		if noOfPlayers == 3 or noOfPlayers == 4 then
			for i = 1, noOfPlayers, 1 do
				drawPlayer(players[i],true,stencilFunctionBG,i)
			end
		elseif noOfPlayers == 6 then
			for i = 2, noOfPlayers-1, 2 do
				drawPlayer(players[i],true,stencilFunctionBG,i)
			end
			for i = 1, noOfPlayers, 2 do
				drawPlayer(players[i],true,stencilFunctionBG,i)
			end
			drawPlayer(players[noOfPlayers],true,stencilFunctionBG,noOfPlayers)
		else
			for i = 2, noOfPlayers, 2 do
				drawPlayer(players[i],true,stencilFunctionBG,i)
			end
			for i = 1, noOfPlayers, 2 do
				drawPlayer(players[i],true,stencilFunctionBG,i)
			end
		end
	else
		if noOfPlayers <= 3 then
			for i = noOfPlayers, 1, -1 do
				drawPlayer(players[i],true,stencilFunctionBG,i)
			end
		elseif noOfPlayers == 4 then
			drawPlayer(players[2],true,stencilFunctionBG,2)
			drawPlayer(players[1],true,stencilFunctionBG,1)
			drawPlayer(players[3],true,stencilFunctionBG,3)
			drawPlayer(players[4],true,stencilFunctionBG,4)
		else
			for i = 5, 1, -1 do
				drawPlayer(players[i],true,stencilFunctionBG,i)
			end	
			for i = 5, noOfPlayers, 1 do
				drawPlayer(players[i],true,stencilFunctionBG,i)
			end
		end
	end

	removeStencil(stencilFunctionBG)
	drawMenuBar()
    
	if changeHeroId ~= -1 then
		drawChangeHerosOnPlayer(changeHeroId,players[changeHeroId])
	elseif changeHero == true then
		drawChangeHero()
	elseif opencombatlog == true then
		drawCombatLog(noOfPlayers,players, CCBlitz)
	elseif opensettings == true then
		drawSettings()
	elseif viewLogs == true and currentLog == "" then
		drawCRUbox()
		arrowButton:render(0,0)
		love.graphics.setColor(1,1,1,1)
		local files = getGameFiles()
		local i = 1
		love.graphics.setFont(mediumFont)
		local tempText = "History"
		local textwidth = mediumFont:getWidth(tempText)/2
		local textheight = mediumFont:getHeight(tempText)/2
		glowText(tempText, width/2,height/20*2,width,"left",0, 1, 1, textwidth, textheight, 0, 0)
		love.graphics.setColor(0,0,0,1)
		love.graphics.rectangle("fill", width/20*2, height/20*3, width/10*8, height/20*13.75,25,25)
		love.graphics.setColor(1,1,1,1)
		addStencil(stencilFunctionInner2,"replace", 10,"equal", 10)
		addStencil(stencilFunctionGames,"incrementwrap", 1,"equal", 10)
		local imageX, imageY = mapImage:getDimensions()
		love.graphics.draw(mapImage,width/20*2, height/20*3,0,width/imageX,height/imageY)
		love.graphics.setStencilState()
		love.graphics.rectangle("line", width/20*2, height/20*3, width/10*8, height/20*13.75,25,25)
		for k, file in ipairs(files) do
			if string.find(file,"game") then
				addStencil(stencilFunctionInner2,"replace", 10,"equal", 11)
				addStencil(stencilFunctionGames,"incrementwrap", 1,"equal", 11)
				love.graphics.setColor(0,0,0,1)
				local loadedPlayers, loadedCCBlitz = loadGame(file)
				love.graphics.setFont(smallFont)
				local textwidth = smallFont:getWidth(string.sub(file, 5, -12))/2
				local textheight = smallFont:getHeight(string.sub(file, 5, -12))/2
				glowText(string.sub(file, 5, -12), width/2,height/22*(1.8+i*2)+scroll,width,"left", 0, 1, 1, textwidth, -textheight, 0,0)
				local localPlayerNumber = noOfPlayers
				noOfPlayers = #loadedPlayers
				addStencil(stencilFunctionGames2,"incrementwrap", 1,"equal", 12)
				noOfPlayers = localPlayerNumber
				local gap = 1
				local move = 0
				if #loadedPlayers == 1 then
					move = 3.5
				elseif #loadedPlayers == 2 then
					gap = 3
				elseif #loadedPlayers == 3 then
					gap = 2
					move = 0.5
				elseif #loadedPlayers == 4 then
					gap = 1.5
					move = 0.75
				elseif #loadedPlayers == 5 then
					move = 1.5
				elseif #loadedPlayers == 6 then
					move = 1
				elseif #loadedPlayers == 7 then
					move = 0.4375
				end
				for p = 1, #loadedPlayers, 1 do
					if loadedPlayers[p].image > #imageList[loadedCCBlitz] then
						loadedPlayers[p].image = 1
					end
					if loadedPlayers[p].altHeroArt and imageAltList[loadedCCBlitz][loadedPlayers[p].image][2] then
						local imageWidth, imageHeight = imageAltList[loadedCCBlitz][loadedPlayers[p].image][2]:getDimensions()
						love.graphics.draw(imageAltList[loadedCCBlitz][loadedPlayers[p].image][2],quadAltList[loadedCCBlitz][loadedPlayers[p].image][2],width/7+(width/15)*(1+(1.25*((p*gap+move)-1.5))),height/22*(2+i*2)+height/30+scroll,0,width/15/imageWidth)
					else
						local imageWidth, imageHeight = imageList[loadedCCBlitz][loadedPlayers[p].image][2]:getDimensions()
						love.graphics.draw(imageList[loadedCCBlitz][loadedPlayers[p].image][2],quadList[loadedCCBlitz][loadedPlayers[p].image][2],width/7+(width/15)*(1+(1.25*((p*gap+move)-1.5))),height/22*(2+i*2)+height/30+scroll,0,width/15/imageWidth)
					end
					love.graphics.setStencilState("keep", "gequal", 10)
					love.graphics.rectangle("line",width/7+(width/15)*(1+(1.25*((p*gap+move)-1.5))),height/22*(2+i*2)+height/30+scroll, width/15, width/15,5,5)
					love.graphics.setStencilState("keep", "equal", 12)
				end
				love.graphics.setStencilState("keep", "gequal", 10)
				love.graphics.rectangle("line",width/20*3,height/22*(2+i*2)+scroll,width/20*14,height/12,25,25)
				i = i + 1
			end
		end
		love.graphics.setColor(1,1,1,0.7)
		local imageWidth, imageHeight = arrowImage:getDimensions()
		if scroll <= -10 then
			love.graphics.draw(arrowImage,width/2,height/20*5,math.pi,arrowScale,arrowScale,imageWidth/2)
		end
		if scroll >= -height/22*(2+#files*2)+height/20*14+10 and #files > 7 then
			love.graphics.draw(arrowImage,width/2,height/20*14.5,0,arrowScale,arrowScale,imageWidth/2)
		end
		removeStencil(stencilFunctionInner2)
		removeStencil(stencilFunctionGames)
		removeStencil(stencilFunctionGames2)
		love.graphics.setColor(0,0,0,1)
		love.graphics.rectangle("fill",width/20*2,height/20*17,width/20*16,height/12,25,25)
		love.graphics.setColor(1,1,1,1)
		love.graphics.rectangle("line",width/20*2,height/20*17,width/20*16,height/12,25,25)
		love.graphics.setFont(mediumFont)
		local textwidth = mediumFont:getWidth("Save current history")/2
		local textheight = mediumFont:getHeight("Save current history")/2
		glowText("Save current history", width/2,height/20*17+height/24,width,"left", 0, 1, 1, textwidth, textheight, 0,0)
	elseif viewLogs == true and currentLog ~= "" then
		local localPlayers, localCCBlitz = loadGame(currentLog)
		drawCombatLog(#localPlayers,localPlayers,localCCBlitz)
		local imageX, imageY = trashImage:getDimensions()
		love.graphics.draw(trashImage,width/2-(imageX*trashScale*0.5)/2,height/40*34,0,trashScale*0.5,trashScale*0.5)
		arrowButton:render(0,0)
	end
	
	if fade > 0 then
		love.graphics.setColor(1,1,1,fade)
		local imageX, imageY = outImage:getDimensions()
		love.graphics.draw(outImage,outQuad,0, 0,0,width/imageX,height/imageY)
		local imageX, imageY = logoImage:getDimensions()
		love.graphics.draw(logoImage,logoQuad,0,height/2,0,width/imageX,width/imageX,0,imageY/2)
	end
	--glowText(fb.body, 0,0,width,"left",0, 1, 1, textwidth, textheight, 0, 0)
end
function createPlayers(noOfPlayers)
    players = {}
    if noOfPlayers == 1 then
        table.insert(players,{image=1,x=0, y=0 , w=width, h=height/20*18, r=0, lineX=width/4*3, lineY=height/20*18/8*5, change={x=width/20*2, y=height/20*4.5, w=width/10*8, h=height/20*12.5, demiHero = 0}})
	elseif noOfPlayers == 2 then
        table.insert(players,{image=1,x=0 ,y=0 ,w=width, h=height/2-height/20, r=math.pi, lineX=width/4*3, lineY=height/8, change={x=width/20*2, y=height/20*4.5, w=width/10*8, h=height/20*6, demiHero = 0}})
        table.insert(players,{image=1,x=0, y=height/2+height/20 , w=width, h=height/2-height/20, r=0, lineX=width/4*3, lineY=height/8*2.625, change={x=width/20*2, y=height/20*11, w=width/10*8, h=height/20*6, demiHero = 0}})
    elseif noOfPlayers == 3 then
        table.insert(players,{image=1,x=0 ,y=0 ,w=width/2, h=height/2-height/20, r=math.pi, lineX=width/7, lineY=height/6, change={x=width/20*2, y=height/20*4.5, w=width/10*3.5, h=height/20*6, demiHero = 0}})
        table.insert(players,{image=1,x=width/2 ,y=0 ,w=width/2, h=height/2-height/20, r=math.pi, lineX=width/36*13, lineY=height/6, change={x=width/20*11, y=height/20*4.5, w=width/10*3.5, h=height/20*6, demiHero = 0}})
        table.insert(players,{image=1,x=0, y=height/2+height/20 , w=width, h=height/2-height/20, r=0, lineX=width/5*3, lineY=height/18*5, change={x=width/20*2, y=height/20*11, w=width/10*8, h=height/20*6, demiHero = 0}})
    elseif noOfPlayers == 4 then
        table.insert(players,{image=1,x=0 ,y=0 ,w=width/2, h=height/2-height/20, r=math.pi, lineX=width/7, lineY=height/6, change={x=width/20*2, y=height/20*4.5, w=width/10*3.5, h=height/20*6, demiHero = 0}})
        table.insert(players,{image=1,x=width/2 ,y=0 ,w=width/2, h=height/2-height/20, r=math.pi, lineX=width/36*13, lineY=height/6, change={x=width/20*11, y=height/20*4.5, w=width/10*3.5, h=height/20*6, demiHero = 0}})
        table.insert(players,{image=1,x=0, y=height/2+height/20 , w=width/2, h=height/2-height/20, r=0, lineX=width/7, lineY=height/18*5, change={x=width/20*2, y=height/20*11, w=width/10*3.5, h=height/20*6, demiHero = 0}})
        table.insert(players,{image=1,x=width/2, y=height/2+height/20 , w=width/2, h=height/2-height/20, r=0, lineX=width/36*13, lineY=height/18*5, change={x=width/20*11, y=height/20*11, w=width/10*3.5, h=height/20*6, demiHero = 0}})
    elseif noOfPlayers == 5 then
        table.insert(players,{image=1,x=0 ,y=0 ,w=width/2, h=height/4-height/40, r=math.pi, lineX=width/7, lineY=height/16, change={x=width/20*2, y=height/20*4.5, w=width/10*3.5, h=height/20*2.75, demiHero = 0}})
        table.insert(players,{image=1,x=0 ,y=height/4-height/40 ,w=width/2, h=height/4-height/40, r=math.pi, lineX=width/7, lineY=height/16, change={x=width/20*2, y=height/20*7.75, w=width/10*3.5, h=height/20*2.75, demiHero = 0}})
        table.insert(players,{image=1,x=width/2 ,y=0 ,w=width/2, h=height/2-height/20, r=math.pi, lineX=width/36*13, lineY=height/6, change={x=width/20*11, y=height/20*4.5, w=width/10*3.5, h=height/20*6, demiHero = 0}})
        table.insert(players,{image=1,x=0, y=height/2+height/20 , w=width/2, h=height/2-height/20, r=0, lineX=width/7, lineY=height/18*5, change={x=width/20*2, y=height/20*11, w=width/10*3.5, h=height/20*6, demiHero = 0}})
        table.insert(players,{image=1,x=width/2, y=height/2+height/20 , w=width/2, h=height/2-height/20, r=0, lineX=width/36*13, lineY=height/18*5, change={x=width/20*11, y=height/20*11, w=width/10*3.5, h=height/20*6, demiHero = 0}})
    elseif noOfPlayers == 6 then
        table.insert(players,{image=1,x=0 ,y=0 ,w=width/2, h=height/4-height/40, r=math.pi, lineX=width/7, lineY=height/16, change={x=width/20*2, y=height/20*4.5, w=width/10*3.5, h=height/20*2.75, demiHero = 0}})
        table.insert(players,{image=1,x=0 ,y=height/4-height/40 ,w=width/2, h=height/4-height/40, r=math.pi, lineX=width/7, lineY=height/16, change={x=width/20*2, y=height/20*7.75, w=width/10*3.5, h=height/20*2.75, demiHero = 0}})
        table.insert(players,{image=1,x=width/2 ,y=0 ,w=width/2, h=height/4-height/40, r=math.pi, lineX=width/36*13, lineY=height/16, change={x=width/20*11, y=height/20*4.5, w=width/10*3.5, h=height/20*2.75, demiHero = 0}})
        table.insert(players,{image=1,x=width/2 ,y=height/4-height/40 ,w=width/2, h=height/4-height/40, r=math.pi, lineX=width/36*13, lineY=height/16, change={x=width/20*11, y=height/20*7.75, w=width/10*3.5, h=height/20*2.75, demiHero = 0}})
        table.insert(players,{image=1,x=0, y=height/2+height/20 , w=width/2, h=height/2-height/20, r=0, lineX=width/7, lineY=height/18*5, change={x=width/20*2, y=height/20*11, w=width/10*3.5, h=height/20*6, demiHero = 0}})
        table.insert(players,{image=1,x=width/2, y=height/2+height/20 , w=width/2, h=height/2-height/20, r=0, lineX=width/36*13, lineY=height/18*5, change={x=width/20*11, y=height/20*11, w=width/10*3.5, h=height/20*6, demiHero = 0}})
    elseif noOfPlayers == 7 then
        table.insert(players,{image=1,x=0 ,y=0 ,w=width/2, h=height/4-height/40,  r=math.pi, lineX=width/7, lineY=height/16, change={x=width/20*2, y=height/20*4.5, w=width/10*3.5, h=height/20*2.75, demiHero = 0}})
        table.insert(players,{image=1,x=0 ,y=height/4-height/40 ,w=width/2, h=height/4-height/40, r=math.pi, lineX=width/7, lineY=height/16, change={x=width/20*2, y=height/20*7.75, w=width/10*3.5, h=height/20*2.75, demiHero = 0}})
        table.insert(players,{image=1,x=width/2 ,y=0 ,w=width/2, h=height/4-height/40, r=math.pi, lineX=width/36*13, lineY=height/16, change={x=width/20*11, y=height/20*4.5, w=width/10*3.5, h=height/20*2.75, demiHero = 0}})
        table.insert(players,{image=1,x=width/2 ,y=height/4-height/40 ,w=width/2, h=height/4-height/40, r=math.pi, lineX=width/36*13, lineY=height/16, change={x=width/20*11, y=height/20*7.75, w=width/10*3.5, h=height/20*2.75, demiHero = 0}})
        table.insert(players,{image=1,x=0, y=height/2+height/20 , w=width/2, h=height/4-height/40, r=0, lineX=width/7, lineY=height/6, change={x=width/20*2, y=height/20*11, w=width/10*3.5, h=height/20*2.75, demiHero = 0}})
        table.insert(players,{image=1,x=0, y=height/4*3+height/40 , w=width/2, h=height/4-height/40, r=0, lineX=width/7, lineY=height/6, change={x=width/20*2, y=height/20*14.25, w=width/10*3.5, h=height/20*2.75, demiHero = 0}})
        table.insert(players,{image=1,x=width/2, y=height/2+height/20 , w=width/2, h=height/2-height/20, r=0, lineX=width/36*13, lineY=height/18*5, change={x=width/20*11, y=height/20*11, w=width/10*3.5, h=height/20*6, demiHero = 0}})
    elseif noOfPlayers == 8 then
        table.insert(players,{image=1,x=0 ,y=0 ,w=width/2, h=height/4-height/40, r=math.pi, lineX=width/7, lineY=height/16, change={x=width/20*2, y=height/20*4.5, w=width/10*3.5, h=height/20*2.75, demiHero = 0}})
        table.insert(players,{image=1,x=0 ,y=height/4-height/40 ,w=width/2, h=height/4-height/40, r=math.pi, lineX=width/7, lineY=height/16, change={x=width/20*2, y=height/20*7.75, w=width/10*3.5, h=height/20*2.75, demiHero = 0}})
        table.insert(players,{image=1,x=width/2 ,y=0 ,w=width/2, h=height/4-height/40, r=math.pi, lineX=width/36*13, lineY=height/16, change={x=width/20*11, y=height/20*4.5, w=width/10*3.5, h=height/20*2.75, demiHero = 0}})
        table.insert(players,{image=1,x=width/2 ,y=height/4-height/40 ,w=width/2, h=height/4-height/40, r=math.pi, lineX=width/36*13, lineY=height/16, change={x=width/20*11, y=height/20*7.75, w=width/10*3.5, h=height/20*2.75, demiHero = 0}})
        table.insert(players,{image=1,x=0, y=height/2+height/20 , w=width/2, h=height/4-height/40, r=0, lineX=width/7, lineY=height/6, change={x=width/20*2, y=height/20*11, w=width/10*3.5, h=height/20*2.75, demiHero = 0}})
        table.insert(players,{image=1,x=0, y=height/4*3+height/40 , w=width/2, h=height/4-height/40, r=0, lineX=width/7, lineY=height/6, change={x=width/20*2, y=height/20*14.25, w=width/10*3.5, h=height/20*2.75, demiHero = 0}})
        table.insert(players,{image=1,x=width/2, y=height/2+height/20 , w=width/2, h=height/4-height/40, r=0, lineX=width/36*13, lineY=height/6, change={x=width/20*11, y=height/20*11, w=width/10*3.5, h=height/20*2.75, demiHero = 0}})
        table.insert(players,{image=1,x=width/2, y=height/4*3+height/40 , w=width/2, h=height/4-height/40, r=0, lineX=width/36*13, lineY=height/6, change={x=width/20*11, y=height/20*14.25, w=width/10*3.5, h=height/20*2.6, demiHero = 0}})
    end
    return players
end

function drawPlayer(p,checkRotation,stencil,currentplayer)
    love.graphics.setColor(1,1,1,1)
	local tmp_p
	if rotatedImage and checkRotation then
		tmp_p = {x=p.x,y=p.y,w=p.w,h=p.h,r=math.pi*1.5,image=p.image,altHeroArt=p.altHeroArt}
		if not flipImage then
			if noOfPlayers == 2 and currentplayer == 1 then
				tmp_p.r = math.pi/2
			elseif noOfPlayers == 3 and currentplayer == 1 then
				tmp_p.r = math.pi/2
			elseif noOfPlayers == 4 and (currentplayer == 1 or currentplayer == 3) then
				tmp_p.r = math.pi/2
			elseif noOfPlayers == 5 and (currentplayer == 1 or currentplayer == 2 or currentplayer == 4) then
				tmp_p.r = math.pi/2
			elseif noOfPlayers == 6 and (currentplayer == 1 or currentplayer == 2 or currentplayer == 5) then
				tmp_p.r = math.pi/2
			elseif noOfPlayers == 7 and (currentplayer == 1 or currentplayer == 2 or currentplayer == 5 or currentplayer == 6) then
				tmp_p.r = math.pi/2
			elseif noOfPlayers == 8 and (currentplayer == 1 or currentplayer == 2 or currentplayer == 5 or currentplayer == 6) then
				tmp_p.r = math.pi/2
			end
		end
		tmp_p = imageRotate(tmp_p)
	else
		tmp_p = imageRotate(p)
	end
	if darkMode == true and checkRotation == true then
		love.graphics.setShader(grayScale)
	end
	if showHeroArt == true then
		if tmp_p.altHeroArt and imageAltList[CCBlitz][tmp_p.image][2] and quadAltList[CCBlitz][tmp_p.image][2] then
			local _, _, imageWidth, imageHeight = quadAltList[CCBlitz][tmp_p.image][2]:getViewport()
			if rotatedImage and checkRotation then
				if tmp_p.w/imageHeight < tmp_p.h/imageWidth then
					love.graphics.draw(imageAltList[CCBlitz][tmp_p.image][2],quadAltList[CCBlitz][tmp_p.image][2],tmp_p.x,tmp_p.y,tmp_p.r,tmp_p.h/imageWidth)
				else
					love.graphics.draw(imageAltList[CCBlitz][tmp_p.image][2],quadAltList[CCBlitz][tmp_p.image][2],tmp_p.x,tmp_p.y,tmp_p.r,tmp_p.w/imageHeight)
				end
			elseif tmp_p.w/imageWidth < tmp_p.h/imageHeight then
				love.graphics.draw(imageAltList[CCBlitz][tmp_p.image][2],quadAltList[CCBlitz][tmp_p.image][2],tmp_p.x,tmp_p.y,tmp_p.r,tmp_p.h/imageHeight)
			else
				love.graphics.draw(imageAltList[CCBlitz][tmp_p.image][2],quadAltList[CCBlitz][tmp_p.image][2],tmp_p.x,tmp_p.y,tmp_p.r,tmp_p.w/imageWidth)
			end
		elseif quadList[CCBlitz][tmp_p.image] then --Check so it is not nil
			local _, _, imageWidth, imageHeight = quadList[CCBlitz][tmp_p.image][2]:getViewport()
			if rotatedImage and checkRotation then
				if tmp_p.w/imageHeight < tmp_p.h/imageWidth then
					love.graphics.draw(imageList[CCBlitz][tmp_p.image][2],quadList[CCBlitz][tmp_p.image][2],tmp_p.x,tmp_p.y,tmp_p.r,tmp_p.h/imageWidth)
				else
					love.graphics.draw(imageList[CCBlitz][tmp_p.image][2],quadList[CCBlitz][tmp_p.image][2],tmp_p.x,tmp_p.y,tmp_p.r,tmp_p.w/imageHeight)
				end
			elseif tmp_p.w/imageWidth < tmp_p.h/imageHeight then
				love.graphics.draw(imageList[CCBlitz][tmp_p.image][2],quadList[CCBlitz][tmp_p.image][2],tmp_p.x,tmp_p.y,tmp_p.r,tmp_p.h/imageHeight)
			else
				love.graphics.draw(imageList[CCBlitz][tmp_p.image][2],quadList[CCBlitz][tmp_p.image][2],tmp_p.x,tmp_p.y,tmp_p.r,tmp_p.w/imageWidth)
			end
		end
	else
		if darkMode == true then
			love.graphics.setShader()
			love.graphics.setColor(0,0,0,1)
			love.graphics.rectangle("fill",p.x,p.y,p.w,p.h)
			love.graphics.setShader(grayScale)
		else
			love.graphics.setColor(getPlayerColor(p))
			love.graphics.rectangle("fill",p.x,p.y,p.w,p.h)
		end
	end

	if showHeroArt == true and noOfPlayers == 2 and changeHero == false then
		if imageList[CCBlitz][p.image][1] == "levia" and showDemiHero == true and CCBlitz ~= 9 then
			drawDemiHeroes(p,tmp_p,stencil,currentplayer,checkRotation,imageList[CCBlitz][tmp_p.image][2],quadList[CCBlitz][tmp_p.image][2],leviaReImage,leviaReQuad,blasmoImage,blasmoQuad)
		elseif (imageList[CCBlitz][p.image][1] == "professor" or imageList[CCBlitz][p.image][1] == "teklovossen") and showDemiHero == true and CCBlitz ~= 12 then
			drawDemiHeroes(p,tmp_p,stencil,currentplayer,checkRotation,imageList[CCBlitz][tmp_p.image][2],quadList[CCBlitz][tmp_p.image][2],mechropotentImage,mechropotentQuad,nil,nil)
		elseif p.demiHero ~= 0 then
			p.demiHero = 0
		end
	end
	love.graphics.setShader()

	if changeHero == false then
		if rotatedImage then
			if noOfPlayers <= 2 then
				love.graphics.setFont(bigFont)
				local textheight = bigFont:getHeight(p.life)/2
				if noOfPlayers == 1 then
					glowText(p.life, p.x+p.w/2,p.y+p.h,height/20*18,"center", tmp_p.r, 1, 1, 0, textheight, 0, 0)
				elseif currentplayer == 2 then	
					glowText(p.life, p.x+p.w/2,p.y+p.h,height/20*9,"center", tmp_p.r, 1, 1, 0, textheight, 0, 0)
				else
					if flipImage then
						glowText(p.life, p.x+p.w/2,p.y+p.h,height/20*9,"center", tmp_p.r, 1, 1, 0, textheight, 0, 0)
					else
						glowText(p.life, p.x+p.w/2,p.y,height/20*9,"center", tmp_p.r, 1, 1, 0, textheight, 0, 0)
					end
				end
			else
				love.graphics.setFont(bigFont2)
				local textwidth = bigFont2:getWidth(p.life)/2
				local textheight = bigFont2:getHeight(p.life)/2
				if noOfPlayers == 3 then
					if currentplayer == 1 and flipImage then
						glowText(p.life, p.x+p.w/2,p.y+p.h,height/20*9,"center", tmp_p.r, 1, 1, 0, textheight, 0, 0)
					elseif currentplayer == 1 then
						glowText(p.life, p.x+p.w/2,p.y,height/20*9,"center", tmp_p.r, 1, 1, 0, textheight, 0, 0)
					else
						glowText(p.life, p.x+p.w/2,p.y+p.h,height/20*9,"center", tmp_p.r, 1, 1, 0, textheight, 0, 0)
					end
				elseif noOfPlayers == 4 then
					if (currentplayer == 1 or currentplayer == 3) and flipImage then
						glowText(p.life, p.x+p.w/2,p.y+p.h,height/20*9,"center", tmp_p.r, 1, 1, 0, textheight, 0, 0)
					elseif currentplayer == 1 or currentplayer == 3 then
						glowText(p.life, p.x+p.w/2,p.y,height/20*9,"center", tmp_p.r, 1, 1, 0, textheight, 0, 0)
					else
						glowText(p.life, p.x+p.w/2,p.y+p.h,height/20*9,"center", tmp_p.r, 1, 1, 0, textheight, 0, 0)
					end
				elseif noOfPlayers == 5 then
					if (currentplayer == 1 or currentplayer == 2) and flipImage then
						glowText(p.life, p.x+p.w/2,p.y+p.h,height/20*9/2,"center", tmp_p.r, 1, 1, 0, textheight, 0, 0)
					elseif currentplayer == 1 or currentplayer == 2  then
						glowText(p.life, p.x+p.w/2,p.y,height/20*9/2,"center", tmp_p.r, 1, 1, 0, textheight, 0, 0)
					elseif currentplayer == 4 and flipImage then
						glowText(p.life, p.x+p.w/2,p.y+p.h,height/20*9,"center", tmp_p.r, 1, 1, 0, textheight, 0, 0)
					elseif currentplayer == 4 then
						glowText(p.life, p.x+p.w/2,p.y,height/20*9,"center", tmp_p.r, 1, 1, 0, textheight, 0, 0)
					else
						glowText(p.life, p.x+p.w/2,p.y+p.h,height/20*9,"center", tmp_p.r, 1, 1, 0, textheight, 0, 0)
					end
				elseif noOfPlayers == 6 then
					if (currentplayer == 1 or currentplayer == 2) and flipImage then
						glowText(p.life, p.x+p.w/2,p.y+p.h,height/20*9/2,"center", tmp_p.r, 1, 1, 0, textheight, 0, 0)
					elseif currentplayer == 1 or currentplayer == 2 then
						glowText(p.life, p.x+p.w/2,p.y,height/20*9/2,"center", tmp_p.r, 1, 1, 0, textheight, 0, 0)
					elseif currentplayer == 3 or currentplayer == 4 then
						glowText(p.life, p.x+p.w/2,p.y+p.h,height/20*9/2,"center", tmp_p.r, 1, 1, 0, textheight, 0, 0)
					elseif currentplayer == 5 and flipImage then
						glowText(p.life, p.x+p.w/2,p.y+p.h,height/20*9,"center", tmp_p.r, 1, 1, 0, textheight, 0, 0)
					elseif currentplayer == 5 then
						glowText(p.life, p.x+p.w/2,p.y,height/20*9,"center", tmp_p.r, 1, 1, 0, textheight, 0, 0)
					else
						glowText(p.life, p.x+p.w/2,p.y+p.h,height/20*9,"center", tmp_p.r, 1, 1, 0, textheight, 0, 0)
					end
				elseif noOfPlayers == 7 then
					if (currentplayer == 1 or currentplayer == 2 or currentplayer == 5 or currentplayer == 6) and flipImage then
						glowText(p.life, p.x+p.w/2,p.y+p.h,height/20*9/2,"center", tmp_p.r, 1, 1, 0, textheight, 0, 0)
					elseif currentplayer == 1 or currentplayer == 2 or currentplayer == 5 or currentplayer == 6 then
						glowText(p.life, p.x+p.w/2,p.y,height/20*9/2,"center", tmp_p.r, 1, 1, 0, textheight, 0, 0)
					elseif currentplayer == 3 or currentplayer == 4 then
						glowText(p.life, p.x+p.w/2,p.y+p.h,height/20*9/2,"center", tmp_p.r, 1, 1, 0, textheight, 0, 0)
					else
						glowText(p.life, p.x+p.w/2,p.y+p.h,height/20*9,"center", tmp_p.r, 1, 1, 0, textheight, 0, 0)
					end
				else
					if (currentplayer == 1 or currentplayer == 2 or currentplayer == 5 or currentplayer == 6) and flipImage then
						glowText(p.life, p.x+p.w/2,p.y+p.h,height/20*9/2,"center", tmp_p.r, 1, 1, 0, textheight, 0, 0)
					elseif currentplayer == 1 or currentplayer == 2 or currentplayer == 5 or currentplayer == 6 then
						glowText(p.life, p.x+p.w/2,p.y,height/20*9/2,"center", tmp_p.r, 1, 1, 0, textheight, 0, 0)
					else
						glowText(p.life, p.x+p.w/2,p.y+p.h,height/20*9/2,"center", tmp_p.r, 1, 1, 0, textheight, 0, 0)
					end
				end
			end
		else
			if noOfPlayers <= 2 then
				love.graphics.setFont(bigFont)
				local textheight = bigFont:getHeight(p.life)/2
				if (currentplayer == 1 and noOfPlayers == 1) or currentplayer == 2 then	
					glowText(p.life, p.x,p.y+p.h/2,width,"center", tmp_p.r, 1, 1, 0, textheight, 0, 0)
				else
					glowText(p.life, p.x+p.w,p.y+p.h/2,width,"center", tmp_p.r, 1, 1, 0, textheight, 0, 0)
				end
			else
				love.graphics.setFont(bigFont2)
				local textwidth = bigFont2:getWidth(p.life)/2
				local textheight = bigFont2:getHeight(p.life)/2
				if noOfPlayers == 3 then
					if currentplayer == 1 or currentplayer == 2 then
						glowText(p.life, p.x+p.w,p.y+p.h/2,width/2,"center", tmp_p.r, 1, 1, 0, textheight, 0, 0)
					else
						glowText(p.life, p.x,p.y+p.h/2,width,"center", tmp_p.r, 1, 1, 0, textheight, 0, 0)
					end
				elseif noOfPlayers == 4 then
					if currentplayer == 1 or currentplayer == 2 then
						glowText(p.life, p.x+p.w,p.y+p.h/2,width/2,"center", tmp_p.r, 1, 1, 0, textheight, 0, 0)
					else
						glowText(p.life, p.x,p.y+p.h/2,width/2,"center", tmp_p.r, 1, 1, 0, textheight, 0, 0)
					end
				elseif noOfPlayers == 5 then
					if currentplayer == 1 or currentplayer == 2 or currentplayer == 3 then
						glowText(p.life, p.x+p.w,p.y+p.h/2,width/2,"center", tmp_p.r, 1, 1, 0, textheight, 0, 0)
					else
						glowText(p.life, p.x,p.y+p.h/2,width/2,"center", tmp_p.r, 1, 1, 0, textheight, 0, 0)
					end
				else
					if currentplayer == 1 or currentplayer == 2 or currentplayer == 3 or currentplayer == 4 then
						glowText(p.life, p.x+p.w,p.y+p.h/2,width/2,"center", tmp_p.r, 1, 1, 0, textheight, 0, 0)
					else
						glowText(p.life, p.x,p.y+p.h/2,width/2,"center", tmp_p.r, 1, 1, 0, textheight, 0, 0)
					end
				end
			end
		end
		
		if showPlusMinus then
			love.graphics.setFont(plusFont)
			local textwidth = plusFont:getWidth("+")/2
			local textheight = plusFont:getHeight("+")/2

			if rotatedImage then
				if p.life == 9 or p.life == 6 then
					fadeLineYMid(p,p.h/6*2,p.h/6*4,p.lineX)
				end
				if flipImage then
					if rotPlusMinus then
						glowText("+", p.x+p.w/2,p.y+p.h/6,width,"left", tmp_p.r, 1, 1, textwidth, textheight, 0, 0)
						glowText("-", p.x+p.w/2,p.y+p.h/6*5,width,"left", tmp_p.r, 1, 1, textwidth, textheight, 0, 0)
						love.graphics.setColor(1,1,1,0.6)
						fadeLineX(p,0,p.w/6)
						fadeLineX(p,p.w,p.w/6*5)
					else
						glowText("+", p.x+p.w/6,p.y+p.h/2,width,"left", tmp_p.r, 1, 1, textwidth, textheight, 0, 0)
						glowText("-", p.x+p.w/6*5,p.y+p.h/2,width,"left", tmp_p.r, 1, 1, textwidth, textheight, 0, 0)
						love.graphics.setColor(1,1,1,0.6)
						fadeLineY(p,0,p.h/6)
						fadeLineY(p,p.h,p.h/6*5)
					end
				else
					if rotPlusMinus then
						if noOfPlayers == 1 then
							glowText("+", p.x+p.w/2,p.y+p.h/6,width,"left", tmp_p.r, 1, 1, textwidth, textheight, 0, 0)
							glowText("-", p.x+p.w/2,p.y+p.h/6*5,width,"left", tmp_p.r, 1, 1, textwidth, textheight, 0, 0)
						elseif noOfPlayers == 2 then
							if currentplayer == 1 then
								glowText("-", p.x+p.w/2,p.y+p.h/6,width,"left", tmp_p.r, 1, 1, textwidth, textheight, 0, 0)
								glowText("+", p.x+p.w/2,p.y+p.h/6*5,width,"left", tmp_p.r, 1, 1, textwidth, textheight, 0, 0)
							else
								glowText("+", p.x+p.w/2,p.y+p.h/6,width,"left", tmp_p.r, 1, 1, textwidth, textheight, 0, 0)
								glowText("-", p.x+p.w/2,p.y+p.h/6*5,width,"left", tmp_p.r, 1, 1, textwidth, textheight, 0, 0)
							end
						elseif noOfPlayers == 3 then
							if currentplayer == 1  then
								glowText("-", p.x+p.w/2,p.y+p.h/6,width,"left", tmp_p.r, 1, 1, textwidth, textheight, 0, 0)
								glowText("+", p.x+p.w/2,p.y+p.h/6*5,width,"left", tmp_p.r, 1, 1, textwidth, textheight, 0, 0)
							else
								glowText("+", p.x+p.w/2,p.y+p.h/6,width,"left", tmp_p.r, 1, 1, textwidth, textheight, 0, 0)
								glowText("-", p.x+p.w/2,p.y+p.h/6*5,width,"left", tmp_p.r, 1, 1, textwidth, textheight, 0, 0)
							end
						elseif noOfPlayers == 4 then
							if currentplayer == 1 or currentplayer == 3 then
								glowText("-", p.x+p.w/2,p.y+p.h/6,width,"left", tmp_p.r, 1, 1, textwidth, textheight, 0, 0)
								glowText("+", p.x+p.w/2,p.y+p.h/6*5,width,"left", tmp_p.r, 1, 1, textwidth, textheight, 0, 0)
							else
								glowText("+", p.x+p.w/2,p.y+p.h/6,width,"left", tmp_p.r, 1, 1, textwidth, textheight, 0, 0)
								glowText("-", p.x+p.w/2,p.y+p.h/6*5,width,"left", tmp_p.r, 1, 1, textwidth, textheight, 0, 0)
							end
						elseif noOfPlayers == 5 then
							if currentplayer == 1 or currentplayer == 2 or currentplayer == 4 then
								glowText("-", p.x+p.w/2,p.y+p.h/6,width,"left", tmp_p.r, 1, 1, textwidth, textheight, 0, 0)
								glowText("+", p.x+p.w/2,p.y+p.h/6*5,width,"left", tmp_p.r, 1, 1, textwidth, textheight, 0, 0)
							else
								glowText("+", p.x+p.w/2,p.y+p.h/6,width,"left", tmp_p.r, 1, 1, textwidth, textheight, 0, 0)
								glowText("-", p.x+p.w/2,p.y+p.h/6*5,width,"left", tmp_p.r, 1, 1, textwidth, textheight, 0, 0)
							end
						elseif noOfPlayers == 6 then
							if currentplayer == 1 or currentplayer == 2 or currentplayer == 5 then
								glowText("-", p.x+p.w/2,p.y+p.h/6,width,"left", tmp_p.r, 1, 1, textwidth, textheight, 0, 0)
								glowText("+", p.x+p.w/2,p.y+p.h/6*5,width,"left", tmp_p.r, 1, 1, textwidth, textheight, 0, 0)
							else
								glowText("+", p.x+p.w/2,p.y+p.h/6,width,"left", tmp_p.r, 1, 1, textwidth, textheight, 0, 0)
								glowText("-", p.x+p.w/2,p.y+p.h/6*5,width,"left", tmp_p.r, 1, 1, textwidth, textheight, 0, 0)
							end
						else
							if currentplayer == 1 or currentplayer == 2 or currentplayer == 5 or currentplayer == 6 then
								glowText("-", p.x+p.w/2,p.y+p.h/6,width,"left", tmp_p.r, 1, 1, textwidth, textheight, 0, 0)
								glowText("+", p.x+p.w/2,p.y+p.h/6*5,width,"left", tmp_p.r, 1, 1, textwidth, textheight, 0, 0)
							else
								glowText("+", p.x+p.w/2,p.y+p.h/6,width,"left", tmp_p.r, 1, 1, textwidth, textheight, 0, 0)
								glowText("-", p.x+p.w/2,p.y+p.h/6*5,width,"left", tmp_p.r, 1, 1, textwidth, textheight, 0, 0)
							end
						end
						love.graphics.setColor(1,1,1,0.6)
						fadeLineX(p,0,p.w/6)
						fadeLineX(p,p.w,p.w/6*5)
					else
						if noOfPlayers == 1 then
							glowText("+", p.x+p.w/6,p.y+p.h/2,width,"left", tmp_p.r, 1, 1, textwidth, textheight, 0, 0)
							glowText("-", p.x+p.w/6*5,p.y+p.h/2,width,"left", tmp_p.r, 1, 1, textwidth, textheight, 0, 0)
						elseif noOfPlayers == 2 then
							if currentplayer == 1 then
								glowText("-", p.x+p.w/6,p.y+p.h/2,width,"left", tmp_p.r, 1, 1, textwidth, textheight, 0, 0)
								glowText("+", p.x+p.w/6*5,p.y+p.h/2,width,"left", tmp_p.r, 1, 1, textwidth, textheight, 0, 0)
							else
								glowText("+", p.x+p.w/6,p.y+p.h/2,width,"left", tmp_p.r, 1, 1, textwidth, textheight, 0, 0)
								glowText("-", p.x+p.w/6*5,p.y+p.h/2,width,"left", tmp_p.r, 1, 1, textwidth, textheight, 0, 0)
							end
						elseif noOfPlayers == 3 then
							if currentplayer == 1 then
								glowText("-", p.x+p.w/6,p.y+p.h/2,width,"left", tmp_p.r, 1, 1, textwidth, textheight, 0, 0)
								glowText("+", p.x+p.w/6*5,p.y+p.h/2,width,"left", tmp_p.r, 1, 1, textwidth, textheight, 0, 0)
							else
								glowText("+", p.x+p.w/6,p.y+p.h/2,width,"left", tmp_p.r, 1, 1, textwidth, textheight, 0, 0)
								glowText("-", p.x+p.w/6*5,p.y+p.h/2,width,"left", tmp_p.r, 1, 1, textwidth, textheight, 0, 0)
							end
						elseif noOfPlayers == 4 then
							if currentplayer == 1 or currentplayer == 3 then
								glowText("-", p.x+p.w/6,p.y+p.h/2,width,"left", tmp_p.r, 1, 1, textwidth, textheight, 0, 0)
								glowText("+", p.x+p.w/6*5,p.y+p.h/2,width,"left", tmp_p.r, 1, 1, textwidth, textheight, 0, 0)
							else
								glowText("+", p.x+p.w/6,p.y+p.h/2,width,"left", tmp_p.r, 1, 1, textwidth, textheight, 0, 0)
								glowText("-", p.x+p.w/6*5,p.y+p.h/2,width,"left", tmp_p.r, 1, 1, textwidth, textheight, 0, 0)
							end
						elseif noOfPlayers == 5 then
							if currentplayer == 1 or currentplayer == 2 or currentplayer == 4 then
								glowText("-", p.x+p.w/6,p.y+p.h/2,width,"left", tmp_p.r, 1, 1, textwidth, textheight, 0, 0)
								glowText("+", p.x+p.w/6*5,p.y+p.h/2,width,"left", tmp_p.r, 1, 1, textwidth, textheight, 0, 0)
							else
								glowText("+", p.x+p.w/6,p.y+p.h/2,width,"left", tmp_p.r, 1, 1, textwidth, textheight, 0, 0)
								glowText("-", p.x+p.w/6*5,p.y+p.h/2,width,"left", tmp_p.r, 1, 1, textwidth, textheight, 0, 0)
							end
						elseif noOfPlayers == 6 then
							if currentplayer == 1 or currentplayer == 2 or currentplayer == 5 then
								glowText("-", p.x+p.w/6,p.y+p.h/2,width,"left", tmp_p.r, 1, 1, textwidth, textheight, 0, 0)
								glowText("+", p.x+p.w/6*5,p.y+p.h/2,width,"left", tmp_p.r, 1, 1, textwidth, textheight, 0, 0)
							else
								glowText("+", p.x+p.w/6,p.y+p.h/2,width,"left", tmp_p.r, 1, 1, textwidth, textheight, 0, 0)
								glowText("-", p.x+p.w/6*5,p.y+p.h/2,width,"left", tmp_p.r, 1, 1, textwidth, textheight, 0, 0)
							end
						else
							if currentplayer == 1 or currentplayer == 2 or currentplayer == 5 or currentplayer == 6 then
								glowText("-", p.x+p.w/6,p.y+p.h/2,width,"left", tmp_p.r, 1, 1, textwidth, textheight, 0, 0)
								glowText("+", p.x+p.w/6*5,p.y+p.h/2,width,"left", tmp_p.r, 1, 1, textwidth, textheight, 0, 0)
							else
								glowText("+", p.x+p.w/6,p.y+p.h/2,width,"left", tmp_p.r, 1, 1, textwidth, textheight, 0, 0)
								glowText("-", p.x+p.w/6*5,p.y+p.h/2,width,"left", tmp_p.r, 1, 1, textwidth, textheight, 0, 0)
							end
						end
						love.graphics.setColor(1,1,1,0.6)
						fadeLineY(p,0,p.h/6)
						fadeLineY(p,p.h,p.h/6*5)
					end
				end
			else
				if p.life == 9 or p.life == 6 then
					fadeLineXMid(p,p.w/6*2,p.w/6*4,p.lineY)
				end
				if rotPlusMinus then
					if p.y > height/2 or noOfPlayers == 1 then
						glowText("+", p.x+p.w/2,p.y+p.h/6,width,"left", tmp_p.r, 1, 1, textwidth, textheight, 0, 0)
						glowText("-", p.x+p.w/2,p.y+p.h/6*5,width,"left", tmp_p.r, 1, 1, textwidth, textheight, 0, 0)
					else
						glowText("-", p.x+p.w/2,p.y+p.h/6,width,"left", tmp_p.r, 1, 1, textwidth, textheight, 0, 0)
						glowText("+", p.x+p.w/2,p.y+p.h/6*5,width,"left", tmp_p.r, 1, 1, textwidth, textheight, 0, 0)
					end
					love.graphics.setColor(1,1,1,0.6)
					fadeLineX(p,0,p.w/6)
					fadeLineX(p,p.w,p.w/6*5)
				else
					if p.y > height/2 or noOfPlayers == 1 then
						glowText("-", p.x+p.w/6,p.y+p.h/2,width,"left", tmp_p.r, 1, 1, textwidth, textheight, 0, 0)
						glowText("+", p.x+p.w/6*5,p.y+p.h/2,width,"left", tmp_p.r, 1, 1, textwidth, textheight, 0, 0)
					else
						glowText("+", p.x+p.w/6,p.y+p.h/2,width,"left", tmp_p.r, 1, 1, textwidth, textheight, 0, 0)
						glowText("-", p.x+p.w/6*5,p.y+p.h/2,width,"left", tmp_p.r, 1, 1, textwidth, textheight, 0, 0)
					end
					love.graphics.setColor(1,1,1,0.6)
					fadeLineY(p,0,p.h/6)
					fadeLineY(p,p.h,p.h/6*5)
				end
			end
		end

		if #p.lifeHistory > 0 then
			love.graphics.setFont(mediumFont)
			local tmpText = ""
			if p.life-p.lifeHistory[#p.lifeHistory] > 0 then
				tmpText = "+"..tostring(p.life-p.lifeHistory[#p.lifeHistory])
			elseif p.life-p.lifeHistory[#p.lifeHistory] < 0 then
				tmpText = tostring(p.life-p.lifeHistory[#p.lifeHistory])
			end
			local textwidth = mediumFont:getWidth(tmpText)/2
			local textheight = mediumFont:getHeight(tmpText)/2

			if rotPlusMinus then
				if rotatedImage then
					if flipImage then
						if p.y > height/2 or noOfPlayers == 1 then
							glowText( tmpText, p.x+p.w/10*2,p.y+p.h/4,width,"left", tmp_p.r, 1, 1, textwidth, textheight, 0, 0)
						else
							glowText( tmpText, p.x+p.w/10*2,p.y+p.h/4,width,"left", tmp_p.r, 1, 1, textwidth, textheight, 0, 0)
						end
					else
						if noOfPlayers == 1 or (noOfPlayers == 2 and currentplayer == 2) or (noOfPlayers == 3 and currentplayer == 3) then
							glowText( tmpText, p.x+p.w/10*2,p.y+p.h/4,width,"left", tmp_p.r, 1, 1, textwidth, textheight, 0, 0)
						elseif noOfPlayers == 2 and currentplayer == 1 then
							glowText( tmpText, p.x+p.w/10*8,p.y+p.h/4*3,width,"left", tmp_p.r, 1, 1, textwidth, textheight, 0, 0)
						elseif p.x < width/2 then
							glowText( tmpText, p.x+p.w/10*8,p.y+p.h/4*3,width,"left", tmp_p.r, 1, 1, textwidth, textheight, 0, 0)
						else
							glowText( tmpText, p.x+p.w/10*2,p.y+p.h/4,width,"left", tmp_p.r, 1, 1, textwidth, textheight, 0, 0)
						end
					end
				else
					if p.y > height/2 or noOfPlayers == 1 then
						glowText( tmpText, p.x+p.w/4*3,p.y+p.h/10*2,width,"left", tmp_p.r, 1, 1, textwidth, textheight, 0, 0)
					else
						glowText( tmpText, p.x+p.w/4,p.y+p.h/10*8,width,"left", tmp_p.r, 1, 1, textwidth, textheight, 0, 0)
					end
				end
			else
				if rotatedImage then
					if flipImage then
						if p.y > height/2 or noOfPlayers == 1 then
							glowText( tmpText, p.x+p.w/10*2,p.y+p.h/4,width,"left", tmp_p.r, 1, 1, textwidth, textheight, 0, 0)
						else
							glowText( tmpText, p.x+p.w/10*2,p.y+p.h/4,width,"left", tmp_p.r, 1, 1, textwidth, textheight, 0, 0)
						end
					else
						if noOfPlayers == 1 or (noOfPlayers == 2 and currentplayer == 2) or (noOfPlayers == 3 and currentplayer == 3) then
							glowText( tmpText, p.x+p.w/10*2,p.y+p.h/4,width,"left", tmp_p.r, 1, 1, textwidth, textheight, 0, 0)
						elseif noOfPlayers == 2 and currentplayer == 1 then
							glowText( tmpText, p.x+p.w/10*8,p.y+p.h/4*3,width,"left", tmp_p.r, 1, 1, textwidth, textheight, 0, 0)
						elseif p.x < width/2 then
							glowText( tmpText, p.x+p.w/10*8,p.y+p.h/4*3,width,"left", tmp_p.r, 1, 1, textwidth, textheight, 0, 0)
						else
							glowText( tmpText, p.x+p.w/10*2,p.y+p.h/4,width,"left", tmp_p.r, 1, 1, textwidth, textheight, 0, 0)
						end
					end
				else
					if p.y > height/2 or noOfPlayers == 1 then
						glowText( tmpText, p.x+p.w/4*3,p.y+p.h/10*2,width,"left", tmp_p.r, 1, 1, textwidth, textheight, 0, 0)
					else
						glowText( tmpText, p.x+p.w/4,p.y+p.h/10*8,width,"left", tmp_p.r, 1, 1, textwidth, textheight, 0, 0)
					end
				end
			end
		end
	end
end

function drawTimer()
	love.graphics.setColor(1,1,1,1)
	if showTimer == true then
		if pauseTime == true then
			love.graphics.setColor(1,1,1,0.25)
			local imageWidth, imageHeight = pauseImage:getDimensions()
			love.graphics.draw(pauseImage,width/2-imageWidth*pauseScale/2,height/2-imageHeight*pauseScale/2,0,pauseScale,pauseScale)
		end

		love.graphics.setColor(1,1,1,1)
		love.graphics.setFont(miniFont)
		if starttime == -1 then
			local textwidth = miniFont:getWidth("Start\ntime")/2
			local textheight = miniFont:getHeight("Start\ntime")/2
			if rotatedImage == true then
				love.graphics.printf("Start\ntime",width/5*2, height/2,width/5,"center",-math.pi/2,1,1,textwidth*1.8,-textwidth/1.4)
			else
				love.graphics.printf("Start\ntime",width/5*2, height/2,width/5,"center",0,1,1,0,textheight*2.25)
			end
		elseif biggerTimer == true then
			love.graphics.setFont(timerFont)
			local textwidth = timerFont:getWidth("00:00")/2
			local textheight = timerFont:getHeight("00:00")/2
			if starttime == -1 then
				love.graphics.printf(disp_time(timeList[CCBlitz]),width/4, height/2,width/2,"center",0,1,1,0,textheight)
			elseif timeList[CCBlitz]-(love.timer.getTime()-starttime) < 0 then
				love.graphics.printf(disp_time(0),width/4, height/2,width/2,"center",0,1,1,0,textheight)
			else
				love.graphics.printf(disp_time(timeList[CCBlitz]-(love.timer.getTime()-starttime)),width/4, height/2,width/2,"center",0,1,1,0,textheight)
			end
		elseif rotatedImage == true then
			local textwidth = miniFont:getWidth("00:00")/2
			local textheight = miniFont:getHeight("00:00")/2
			if starttime == -1 then
				love.graphics.printf(disp_time(timeList[CCBlitz]),width/5*2, height/2,width/5,"center",-math.pi/2,1,1,textwidth*1.5,-textheight*2.5)
			elseif timeList[CCBlitz]-(love.timer.getTime()-starttime) < 0 then
				love.graphics.printf(disp_time(0),width/5*2, height/2,width/5,"center",-math.pi/2,1,1,textwidth*1.5,-textheight*2.5)
			else
				love.graphics.printf(disp_time(timeList[CCBlitz]-(love.timer.getTime()-starttime)),width/5*2, height/2,width/5,"center",-math.pi/2,1,1,textwidth*1.5,-textheight*2.5)
			end
		else
			local textheight = miniFont:getHeight("00:00")/2
			if starttime == -1 then
				love.graphics.printf(disp_time(timeList[CCBlitz]),width/5*2, height/2,width/5,"center",0,1,1,0,textheight)
			elseif timeList[CCBlitz]-(love.timer.getTime()-starttime) < 0 then
				love.graphics.printf(disp_time(0),width/5*2, height/2,width/5,"center",0,1,1,0,textheight)
			else
				love.graphics.printf(disp_time(timeList[CCBlitz]-(love.timer.getTime()-starttime)),width/5*2, height/2,width/5,"center",0,1,1,0,textheight)
			end
		end
	end
end

function drawMenuBar()
	if noOfPlayers == 1 then
		love.graphics.origin()
		love.graphics.translate(safeX, safeY+height/2-height/20)
	end
	love.graphics.setColor({1,1,1,1})
	if henrikMode then
		if darkMode then
			love.graphics.setShader(grayScale)
		end
		local imageWidth, imageHeight = menubgImage:getDimensions()
		love.graphics.draw(menubgImage,0,height/2-imageHeight/2*width/imageWidth,0,width/imageWidth)
		love.graphics.setShader()
	else
		love.graphics.setColor({0,0,0,1})
		love.graphics.rectangle("fill",0,height/2-height/20,width,height/10)
		love.graphics.setColor({1,1,1,1})
	end
    opensettingsButton:render(0,0)
	historylogButton:render(0,0)
	if showTimer == false or biggerTimer == false then
		diceButton:render(0,0)
		arrowsButton:render(0,0)
	end
	cardButton:render(0,0)
	restartButton:render(0,0)
	drawTimer()
	love.graphics.setColor({1,1,1,1})
	love.graphics.origin()
	love.graphics.translate(safeX, safeY)
end

function drawCRUbox()
	love.graphics.setColor(1,1,1,1)
	addStencil(stencilFunction,"replace", 1,"greater", 0)
	local imageX, imageY = cruImage:getDimensions()
	love.graphics.draw(cruImage,cruQuad,width/20, height/20,0,width/imageX,height/imageY)
	removeStencil(stencilFunction)
	love.graphics.setColor(1,1,1,1)
	love.graphics.rectangle("line", width/20, height/20, width/10*9, height/10*9,25,25)
	closeButton:render(0,0)
end

function drawChangeHerosOnPlayer(i,p)
	drawCRUbox()
	love.graphics.setFont(mediumFont)
	local tempText = "Change Hero"
	local tempAltHeroArt = p.altHeroArt
	local textwidth = mediumFont:getWidth(tempText)/2
	local textheight = mediumFont:getHeight(tempText)/2
	glowText(tempText, width/2,height/20*2,width,"left",0, 1, 1, textwidth, textheight, 0, 0)
	love.graphics.setColor(1,1,1,1)
	
	if showHeroArt == true then
		local hasAltArt = notNil(imageAltList[CCBlitz])
		if hasAltArt ~= -1 then
			local imageWidth, imageHeight = changeImage:getDimensions()
			love.graphics.draw(changeImage,width/40*3,height/40*3,0,changeScale*0.5,changeScale*0.5)
			local imageWidth, imageHeight = imageAltList[CCBlitz][hasAltArt][2]:getDimensions()
			addStencil(stencilFunctionHeroAlts,"replace", 1,"greater", 0)
			if tempAltHeroArt then
				love.graphics.draw(imageList[CCBlitz][hasAltArt][2],quadList[CCBlitz][hasAltArt][2],width/40*3,height/40*3,0,width/17.5/imageWidth)
				love.graphics.draw(imageAltList[CCBlitz][hasAltArt][2],quadAltList[CCBlitz][hasAltArt][2],width/40*3+width/25,height/40*4,0,width/17.5/imageWidth)
			else
				love.graphics.draw(imageAltList[CCBlitz][hasAltArt][2],quadAltList[CCBlitz][hasAltArt][2],width/40*3,height/40*3,0,width/17.5/imageWidth)
				love.graphics.draw(imageList[CCBlitz][hasAltArt][2],quadList[CCBlitz][hasAltArt][2],width/40*3+width/25,height/40*4,0,width/17.5/imageWidth)
			end
			removeStencil(stencilFunctionHeroAlts)
			love.graphics.rectangle("line", width/40*3,height/40*3, width/17.5, height/45,5,5)
			love.graphics.rectangle("line", width/40*3+width/25,height/40*4, width/17.5, height/45,5,5)
		end
	end
	love.graphics.setColor(0,0,0,1)
	love.graphics.rectangle("fill", width/20*2, height/20*3, width/10*8, height/20*15,25,25)
	addStencil(stencilFunctionInner,"replace", 10,"gequal", 11)
	local image = imageList[CCBlitz]
	local imageQuad = quadList[CCBlitz]
	local alt = imageAltList[CCBlitz]
	local altQuad = quadAltList[CCBlitz]

	if showHeroArt == false then
		addStencil(stencilFunctionColors,"incrementwrap", 1,"gequal", 11)
		image = colors
		for i = 1, #colors, 2 do
			love.graphics.setColor(image[i])
			if darkMode == true then
				love.graphics.setColor(0,0,0,1)
			end
			love.graphics.rectangle("fill",width/10+width/2*mod(i-1,2)+width/100,height/20+height/10*i+scroll+width/100,width/10*4-width/50,height/5-width/50)
			if i+1 <= #colors then
				love.graphics.setColor(image[i+1])
				if darkMode == true then
					love.graphics.setColor(0,0,0,1)
				end
				love.graphics.rectangle("fill",width/2*mod(i,2)+width/100,height/20+height/10*i+scroll+width/100,width/10*4-width/50,height/5-width/50)
			end
		end
		love.graphics.setColor(1,1,1,1)
	else
		addStencil(stencilFunctionHeroes,"incrementwrap", 10,"gequal", 11)
		addStencil(stencilFunctionMiniHeroes,"incrementwrap", 10,"gequal", 11)
		for i = 1, #image, 2 do
			love.graphics.setColor(1,1,1,1)
			if tempAltHeroArt and alt[i][2] then
				local imageWidth, imageHeight = alt[i][2]:getDimensions()
				love.graphics.draw(alt[i][2],altQuad[i][2],width/10+width/2*mod(i-1,2),height/20+height/10*i+scroll,0,width/imageWidth*0.4)
			else
				local imageWidth, imageHeight = image[i][2]:getDimensions()
				love.graphics.draw(image[i][2],imageQuad[i][2],width/10+width/2*mod(i-1,2),height/20+height/10*i+scroll,0,width/imageWidth*0.4)
			end
			if alt[i][2] then
				drawMiniHeroes(i,tempAltHeroArt,width/10+width/2*mod(i-1,2),image,imageQuad,alt,altQuad)
			end
			if i+1 <= #image then
				if tempAltHeroArt and alt[i+1][2] then
					local imageWidth, imageHeight = alt[i+1][2]:getDimensions()
					love.graphics.draw(alt[i+1][2],altQuad[i+1][2],width/2*mod(i,2),height/20+height/10*i+scroll,0,width/imageWidth*0.4)
				elseif CCBlitz == 5 then --Ful fix (men blir fel på 2 i Limited)
					local imageWidth, imageHeight = image[i+1][2]:getDimensions()
					love.graphics.draw(image[i+1][2],imageQuad[i+1][2],width/2*mod(i,2),height/20+height/10*i+scroll,0,width/imageWidth*0.5)
				else
					local imageWidth, imageHeight = image[i+1][2]:getDimensions()
					love.graphics.draw(image[i+1][2],imageQuad[i+1][2],width/2*mod(i,2),height/20+height/10*i+scroll,0,width/imageWidth*0.4)
				end
				if alt[i+1][2] then
					drawMiniHeroes(i+1,tempAltHeroArt,width/2*mod(i,2),image,imageQuad,alt,altQuad)
				end
			else
				love.graphics.setColor(0,0,0,1)
				love.graphics.rectangle("fill", width/2*mod(i,2), height/20+height/10*i+scroll, width/10*8, height/20*15,25,25)
			end
		end
	end
	removeStencil(stencilFunctionHeroes)
	removeStencil(stencilFunctionMiniHeroes)
	love.graphics.setColor(1,1,1,1)
	addStencil(stencilFunctionInner,"replace", 1,"greater", 0)
	for i = 1, #image, 2 do
		love.graphics.rectangle("line",width/10+width/2*mod(i-1,2)+width/100,height/20+height/10*i+scroll+width/100,width/10*4-width/50,height/5-width/50,25,25)
		if i+1 <= #image then
			love.graphics.rectangle("line",width/2*mod(i,2)+width/100,height/20+height/10*i+scroll+width/100,width/10*4-width/50,height/5-width/50,25,25)
		end
	end
	removeStencil(stencilFunctionInner)
	love.graphics.rectangle("line", width/20*2, height/20*3, width/10*8, height/20*15,25,25)

	love.graphics.setColor(1,1,1,0.7)
	local imageWidth, imageHeight = arrowImage:getDimensions()
	if scroll <= -10 then
		love.graphics.draw(arrowImage,width/2,height/20*5,math.pi,arrowScale,arrowScale,imageWidth/2)
	end
	if scroll >= -height/5*(math.ceil(#image/2)-3.75)+10 then
		love.graphics.draw(arrowImage,width/2,height/20*16,0,arrowScale,arrowScale,imageWidth/2)
	end
end

function drawChangeHero()
	drawCRUbox()
	addStencil(stencilFunctionChangeHero,"replace", 200,"greater", 199)
	local imageX, imageY = mapImage:getDimensions()
	love.graphics.setShader(grayScale)
	love.graphics.draw(mapImage,width/20*2, height/20*3,0,width/imageX,height/imageY)
	love.graphics.setShader()
	love.graphics.setStencilState()
	removeStencil(stencilFunctionChangeHero)
	addStencil(stencilFunctionChangeHeroCurrent,"replace", 2,"greater", 1)
	love.graphics.draw(mapImage,width/20*2, height/20*3,0,width/imageX,height/imageY)
	removeStencil(stencilFunctionChangeHeroCurrent)
	addStencil(stencilFunctionSmall,"replace", 2,"greater", 1)
	if noOfPlayers <= 2 then
		love.graphics.setFont(mediumFont)
	else
		love.graphics.setFont(miniFont)
	end
	for i, p in ipairs(players) do
		p.change.altHeroArt = p.altHeroArt
		drawPlayer(p.change,false,stencilFunctionSmall,i)
		love.graphics.setStencilState()
		love.graphics.setColor(1,1,1,1)
		love.graphics.rectangle("line",p.change.x,p.change.y,p.change.w,p.change.h,25,25)
		love.graphics.setStencilState("keep", "greater", 1)
		local tempText = "Change Hero"
		if showHeroArt == false then
			tempText = "Change Color"
		end
		if showHeroText == true and noOfPlayers <= 2 then
			love.graphics.setColor(0.302,0.302,0.302,0.7)
			love.graphics.rectangle("fill",p.change.x,p.change.y,p.change.w,p.change.h,25,25)
			love.graphics.setColor(1,1,1,1)
			tempText =  heroText(imageList[CCBlitz][p.image][1])
			love.graphics.setFont(settingsFont)
			glowText(tempText, p.change.x+p.change.w/20,p.change.y+p.change.h/20,p.change.w/20*18,"left", 0, 1, 1, 0, 0, 0, 0)	
			love.graphics.setFont(mediumFont)	
		elseif noOfPlayers <= 2 then
			local textwidth = mediumFont:getWidth(tempText)/2
			local textheight = mediumFont:getHeight(tempText)/2
			glowText(tempText, p.change.x+p.change.w/2,p.change.y+p.change.h/2,width,"left", 0, 1, 1, textwidth, textheight, 0, 0)
		else
			local textwidth = miniFont:getWidth(tempText)/2
			local textheight = miniFont:getHeight(tempText)/2
			glowText(tempText, p.change.x+p.change.w/2,p.change.y+p.change.h/2,width,"left", 0, 1, 1, textwidth, textheight, 0, 0)
		end
	end
	removeStencil(stencilFunctionSmall)

	if noOfPlayers <=2 and showHeroArt == true and CCBlitz ~= 1 and CCBlitz ~= 2 then
		showHeroTextButton2:render(0,0)
	elseif noOfPlayers <=2 and showHeroArt == true and (CCBlitz == 1 or CCBlitz == 2) then
		showHeroTextButton1:render(0,0)
		includeLLButton1:render(0,0)
	elseif showHeroArt == true and (CCBlitz == 1 or CCBlitz == 2) then
		includeLLButton2:render(0,0)
	end

	love.graphics.setFont(mediumFont)
	local tempText = "Number of players:"
	local textwidth = mediumFont:getWidth(tempText)/2
	local textheight = mediumFont:getHeight(tempText)/2
	glowText(tempText, width/2,height/20*2,width,"left",0, 1, 1, textwidth, textheight, 0, 0)

	love.graphics.setFont(mediumFont)
	for i = 1, 8, 1 do
		blackIfFalse(noOfPlayers == i)
		love.graphics.rectangle("line",width/10*i,height/20*3,width/11,height/20,5,5)
		local textwidth = mediumFont:getWidth(tostring(i))/2
		local textheight = mediumFont:getHeight(tostring(i))/2
		glowText(tostring(i), width/10*(i+0.5),height/20*3.5,width,"left",0, 1, 1, textwidth, textheight, 0, 0)
	end
	love.graphics.setColor(0,0,0,1)
end

function heroText(heroName)
	return heroData:getText(heroName,isCC())
end

function drawCombatLog(localPlayerNumber,localPlayers, localCCBlitz)
	drawCRUbox()
	if opencombatlog == true then
		saveButton:render(0,0)
	end
	love.graphics.setColor(0,0,0,1)
	love.graphics.rectangle("fill", width/20*2, height/20*3, width/10*8, height/20*15,25,25)
	love.graphics.setFont(mediumFont)
	local tempText = "History"
	local textwidth = mediumFont:getWidth(tempText)/2
	local textheight = mediumFont:getHeight(tempText)/2
	glowText(tempText, width/2,height/20*2,width,"left",0, 1, 1, textwidth, textheight, 0, 0)
	addStencil(stencilFunctionInner,"replace", 2,"greater", 1)
	love.graphics.setFont(smallFont)
	local move = 0
	local gap = 1
	if localPlayerNumber == 1 then
		move = 2
	elseif localPlayerNumber == 2 then
		gap = 2
	elseif localPlayerNumber == 3 or localPlayerNumber == 6 then
		move = 1
	elseif localPlayerNumber == 4 then
		move = 0.5
	elseif localPlayerNumber == 7 then
		move = 0.4375
	end
	for p = 1, localPlayerNumber, 1 do
		for i = 1, #localPlayers[p].lifeHistory, 1 do
			local textwidth = smallFont:getWidth(localPlayers[p].lifeHistory[i])
			if localPlayerNumber <= 5 then
				if width <= height/2 then
					glowText(localPlayers[p].lifeHistory[i], width/12+(width/8)*(1+(1.25*((p*gap+move)-1))),height/80*13+height/15+height/40*(i-1)+scroll+height/100,width,"left",0, 1, 1, textwidth, 0, 0, 0)
				else
					glowText(localPlayers[p].lifeHistory[i], width/12+(width/8)*(1+(1.25*((p*gap+move)-1))),height/80*14.5+height/15+height/40*(i-1)+scroll+height/100,width,"left",0, 1, 1, textwidth, 0, 0, 0)
				end
			else
				glowText(localPlayers[p].lifeHistory[i], width/8*1.5+(width/10.5)*((p*gap+move)-1),height/80*13+height/15+height/40*(i-1)+scroll+height/100,width,"left",0, 1, 1, textwidth, 0, 0, 0)
			end
		end
	end
	removeStencil(stencilFunctionInner)
	love.graphics.setColor(1,1,1,1)
	love.graphics.rectangle("line", width/20*2, height/20*3, width/10*8, height/20*15,25,25)

	love.graphics.setColor(1,1,1,0.7)
	local imageWidth, imageHeight = arrowImage:getDimensions()
	if scroll <= -10 then
		love.graphics.draw(arrowImage,width/2,height/20*5,math.pi,arrowScale,arrowScale,imageWidth/2)
	end
	if scroll >= -height/30*(getMaxLifeHistory(localPlayers)-25)+10 then
		love.graphics.draw(arrowImage,width/2,height/20*16,0,arrowScale,arrowScale,imageWidth/2)
	end
	love.graphics.setColor(1,1,1,1)
	local tmpNoPlayers = noOfPlayers
	noOfPlayers = localPlayerNumber
	addStencil(stencilFunctionGames3,"replace", 2,"greater", 1)
	noOfPlayers = tmpNoPlayers
	if showHeroArt then
		for p = 1, localPlayerNumber, 1 do
			if localPlayers[p].image > #imageList[localCCBlitz] then
				localPlayers[p].image = 1
			end
			if localPlayerNumber <= 5 then
				if localPlayers[p].altHeroArt and imageAltList[localCCBlitz][localPlayers[p].image][2] then
					local imageWidth, imageHeight = imageAltList[localCCBlitz][localPlayers[p].image][2]:getDimensions()
					love.graphics.draw(imageAltList[localCCBlitz][localPlayers[p].image][2],quadAltList[localCCBlitz][localPlayers[p].image][2],width/12+(width/8)*(1+(1.25*((p*gap+move)-1.5))),height/80*13,0,width/8/imageWidth)
				else
					local imageWidth, imageHeight = imageList[localCCBlitz][localPlayers[p].image][2]:getDimensions()
					love.graphics.draw(imageList[localCCBlitz][localPlayers[p].image][2],quadList[localCCBlitz][localPlayers[p].image][2],width/12+(width/8)*(1+(1.25*((p*gap+move)-1.5))),height/80*13,0,width/8/imageWidth)
				end
			else
				if localPlayers[p].altHeroArt and imageAltList[localCCBlitz][localPlayers[p].image][2] then
					local imageWidth, imageHeight = imageAltList[localCCBlitz][localPlayers[p].image][2]:getDimensions()
					love.graphics.draw(imageAltList[localCCBlitz][localPlayers[p].image][2],quadAltList[localCCBlitz][localPlayers[p].image][2],width/8+(width/10.5)*((p*gap+move)-1),height/80*13,0,width/10.5/imageWidth)
				else
					local imageWidth, imageHeight = imageList[localCCBlitz][localPlayers[p].image][2]:getDimensions()
					love.graphics.draw(imageList[localCCBlitz][localPlayers[p].image][2],quadList[localCCBlitz][localPlayers[p].image][2],width/8+(width/10.5)*((p*gap+move)-1),height/80*13,0,width/10.5/imageWidth)
				end
			end
		end
	else
		for p = 1, localPlayerNumber, 1 do
			love.graphics.setColor(getPlayerColor(localPlayers[p]))
			if localPlayerNumber <= 5 then
				love.graphics.rectangle("fill",width/12+(width/8)*(1+(1.25*((p*gap+move)-1.5))),height/80*13, width/8, width/8,5,5)
			else
				love.graphics.rectangle("fill",width/8+(width/10.5)*((p*gap+move)-1),height/80*13, width/12, width/12,5,5)
			end
		end
	end
	love.graphics.setColor(1,1,1,1)
	removeStencil(stencilFunctionGames3)
	if localPlayerNumber <= 5 then
		for p = 1, localPlayerNumber, 1 do
			love.graphics.rectangle("line",width/12+(width/8)*(1+(1.25*((p*gap+move)-1.5))),height/80*13, width/8, width/8,5,5)
		end
	else
		for p = 1, localPlayerNumber, 1 do
			love.graphics.rectangle("line",width/8+(width/10.5)*((p*gap+move)-1),height/80*13, width/12, width/12,5,5)
		end
	end
end

function drawSettings()
	drawCRUbox()
	love.graphics.setFont(mediumFont)
	local tempText = "Settings"
	local textwidth = mediumFont:getWidth(tempText)/2
	local textheight = mediumFont:getHeight(tempText)/2
	glowText(tempText, width/2,height/20*2,width,"left",0, 1, 1, textwidth, textheight, 0, 0)

	if viewLimited == true then
		love.graphics.setStencilState()
		drawLimited()
	elseif viewStream == true then
		love.graphics.setStencilState()
		love.graphics.setFont(settingsFont)
		glowText("This is used to stream your games to fabcounter.net. Please create and set up your account on fabcounter.net and then log in below. \nThe following information will be collected and stored on fabcounter.net while using this service: Selected heroes, life of the heroes and timer data. No other information will be collected.",width/8,height/20*3+height/72,width/8*6,"center")
		fabcounternet:render(0,0)
		arrowButton:render(0,0)
		if fb.refreshToken == '' then
			emailButton:render(0,0)
			passwordButton:render(0,0)
			loginButton:render(0,0)
			love.graphics.setFont(settingsFont)
			glowText(tostring(loginText),width/8,height/20*7.5+height/72,width/8*6,"center")
		else
			streamActiveButton:render(0,0)
			logoutButton:render(0,0)
		end
	elseif formatVisuals == 3 then
		visualsButton:render(0,0)
		formatButton:render(0,0)
		gameButton:render(0,0)
		rotationButton:render(0,0)
		flipButton:render(0,0)
		portraitButton:render(0,0)
		overlayButton:render(0,0)
		showplusminusButton:render(0,0)
		rotplusminusButton:render(0,0)
		darkModeButton:render(0,0)
		demiHeroButton:render(0,0)
	elseif formatVisuals == 2 then
		gameButton:render(0,0)
		formatButton:render(0,0)
		visualsButton:render(0,0)
		autoResetLifeButton:render(0,0)
		biggerButton:render(0,0)
		timerButton:render(0,0)
		streamButton:render(0,0)
		Add5Button:render(0,0)
		love.graphics.setFont(miniFont3)
		glowText("FaB Counter is in no way affiliated with Legend Story Studios. Legend Story Studios®, Flesh and Blood™, and set names are trademarks of Legend Story Studios. Flesh and Blood characters, cards, logos, and art are property of Legend Story Studios.",width/8,height/20*16.865+height/72,width/8*6,"center")
		privacyButton:render(0,0)
	else
		formatButton:render(0,0)
		gameButton:render(0,0)
		visualsButton:render(0,0)
		blitzButton:render(0,0)
		ccButton:render(0,0)
		limitedButton:render(0,0)
		llButton:render(0,0)
		upfButton:render(0,0)
		commonerButton:render(0,0)
		love.graphics.setFont(mediumFont)
		local tempText = "Number of players:"
		local textwidth = mediumFont:getWidth(tempText)/2
		local textheight = mediumFont:getHeight(tempText)/2
		glowText(tempText, width/2,height/20*16,width,"left",0, 1, 1, textwidth, textheight, 0, 0)
		love.graphics.setFont(mediumFont)
		for i = 1, 8, 1 do
			love.graphics.setColor(0.302,0.302,0.302,0.7)
			if noOfPlayers == i then
				love.graphics.setColor(0,0.573,0.271,1)
			end
			love.graphics.rectangle("fill",width/10*i,height/20*16.75,width/11,height/20,5,5)
			love.graphics.setColor(0.827,0.827,0.827,1)
			if noOfPlayers == i then
				love.graphics.setColor(0.941,0.878,0.471,1)
			end
			love.graphics.rectangle("line",width/10*i,height/20*16.75,width/11,height/20,5,5)
			local textwidth = mediumFont:getWidth(tostring(i))/2
			local textheight = mediumFont:getHeight(tostring(i))/2
			glowText(tostring(i), width/10*(i+0.5),height/20*17.25,width,"left",0, 1, 1, textwidth, textheight, 0, 0)
		end
	end
	love.graphics.setStencilState()
end

function drawLimited()
	love.graphics.setColor(0,0,0,1)
	love.graphics.rectangle("fill", width/20*2, height/20*3, width/10*8, height/20*15,25,25)
	addStencil(stencilFunctionInner,"replace", 1,"equal", 1)
    if noOfPlayers <= 2 then
        love.graphics.setFont(mediumFont)
    else
        love.graphics.setFont(miniFont)
    end
    limitedWTRButton:render(0,scroll)
    limitedARCButton:render(0,scroll)
    limitedMONButton:render(0,scroll)
    limitedELEButton:render(0,scroll)
    limitedUPRButton:render(0,scroll)
    limitedOUTButton:render(0,scroll)
	limitedEVOButton:render(0,scroll)
	limitedHVYButton:render(0,scroll)
	limitedMSTButton:render(0,scroll)
	limitedROSButton:render(0,scroll)
	--limitedHNTButton:render(0,scroll)
	removeStencil(stencilFunctionInner)
	love.graphics.rectangle("line", width/20*2, height/20*3, width/10*8, height/20*15,25,25)
	love.graphics.setColor(1,1,1,0.7)
	local imageWidth, imageHeight = arrowImage:getDimensions()
	if scroll <= -10 then
		love.graphics.draw(arrowImage,width/2,height/20*5,math.pi,arrowScale,arrowScale,imageWidth/2)
	end
	if scroll >= height/20*17.75-limitedWTRButton.y-limitedWTRButton.h+10 then
		love.graphics.draw(arrowImage,width/2,height/20*16,0,arrowScale,arrowScale,imageWidth/2)
	end
	arrowButton:render(0,0)
end

function drawMiniHeroes(i,tempAltHeroArt,xpos,image,imageQuad,alt,altQuad)
	love.graphics.setStencilState("keep", "equal", 12)
	if tempAltHeroArt == true then
		local imageWidth, imageHeight = image[i][2]:getDimensions()
		love.graphics.draw(image[i][2],imageQuad[i][2],xpos+width/40,height/20+height/10*(math.ceil(i/2)*2-1)+scroll+height/80,0,width/10/imageWidth)
	else
		local imageWidth, imageHeight = alt[i][2]:getDimensions()
		love.graphics.draw(alt[i][2],altQuad[i][2],xpos+width/40,height/20+height/10*(math.ceil(i/2)*2-1)+scroll+height/80,0,width/10/imageWidth)
	end

	--Resets stencil
	love.graphics.setStencilState("keep", "gequal", 11)
	love.graphics.rectangle("line",xpos+width/40,height/20+height/10*(math.ceil(i/2)*2-1)+scroll+height/80,width/10, width/10,15,15)
end

function drawButton(i,localCheck,localImage,localQuad,localWidth,localHeight,localRot,localScale)
	if localCheck then
		love.graphics.draw(localImage,localQuad,localWidth,localHeight,localRot,localScale)
		local imageX, imageY = checkboxImage:getDimensions()
		if i == 11 or i == 12 or i == 13 then
			love.graphics.draw(checkboxImage,checkboxQuad,localWidth,height/20*13,0,(width/12)/imageX)
		elseif mod(i,2) == 1 then
			love.graphics.draw(checkboxImage,checkboxQuad,width/20*2,height/20*(i+2),0,(width/12)/imageX)
		else
			love.graphics.draw(checkboxImage,checkboxQuad,width/20*(10+2/3),height/20*(i+1),0,(width/12)/imageX)
		end
	else
		love.graphics.setShader(grayScale)
		love.graphics.draw(localImage,localQuad,localWidth,localHeight,localRot,localScale)
	end
	love.graphics.setShader()
end

function drawDemiHeroes(p,tmp_p,stencil,currentplayer,checkRotation,heroArt,heroQuad,demiArt1,demiQuad1,demiArt2,demiQuad2)
	addStencil(stencilFunctionDemi,"replace", 2,"greater", 1)
	if demiArt2 == nil and p.demiHero == 2 then
		p.demiHero = 0
	end
	if currentplayer == 1 then
		if p.demiHero == 0 then
			if rotatedImage and checkRotation then
				local imageWidth, imageHeight = demiArt1:getDimensions()
				love.graphics.draw(demiArt1,demiQuad1,p.x+p.w/6*5,p.y+p.h,-math.pi/2,p.w/6/imageWidth)
				if demiArt2 ~= nil then
					local imageWidth, imageHeight = demiArt2:getDimensions()
					love.graphics.draw(demiArt2,demiQuad2,tmp_p.x,tmp_p.y,tmp_p.r,tmp_p.w/6/imageWidth)
				end
			else
				local imageWidth, imageHeight = demiArt1:getDimensions()
				love.graphics.draw(demiArt1,demiQuad1,p.x+p.w,p.y+p.h,-math.pi,p.w/6/imageWidth)
				if demiArt2 ~= nil then
					local imageWidth, imageHeight = demiArt2:getDimensions()
					love.graphics.draw(demiArt2,demiQuad2,p.x+p.w/6,p.y+p.h,-math.pi,tmp_p.w/6/imageWidth)
				end
			end
		elseif p.demiHero == 1 then
			addStencil(stencil,"replace", 2,"greater", 1)
			local imageWidth, imageHeight = demiArt1:getDimensions()
			love.graphics.draw(demiArt1,demiQuad1,tmp_p.x,tmp_p.y,tmp_p.r,tmp_p.w/imageWidth)
			addStencil(stencilFunctionDemi,"replace", 2,"greater", 1)
			local imageWidth, imageHeight = heroArt:getDimensions()
			if rotatedImage and checkRotation then
				if demiArt2 ~= nil then
					love.graphics.draw(demiArt2,demiQuad2,tmp_p.x,tmp_p.y,tmp_p.r,tmp_p.w/6/imageWidth)
				end
				love.graphics.draw(heroArt,heroQuad,p.x+p.w/6*5,p.y+p.h,-math.pi/2,p.w/6/imageWidth)
			else
				love.graphics.draw(heroArt,heroQuad,tmp_p.x,tmp_p.y,tmp_p.r,tmp_p.w/6/imageWidth)
				if demiArt2 ~= nil then
					local imageWidth, imageHeight = demiArt2:getDimensions()
					love.graphics.draw(demiArt2,demiQuad2,p.x+p.w/6,p.y+p.h,-math.pi,tmp_p.w/6/imageWidth)
				end
			end
		else
			addStencil(stencil,"replace", 2,"greater", 1)
			local imageWidth, imageHeight = demiArt2:getDimensions()
			love.graphics.draw(demiArt2,demiQuad2,tmp_p.x,tmp_p.y,tmp_p.r,tmp_p.w/imageWidth)
			addStencil(stencilFunctionDemi,"replace", 2,"greater", 1)
			local imageWidth, imageHeight = heroArt:getDimensions()
			if rotatedImage and checkRotation then
				love.graphics.draw(demiArt1,demiQuad1,p.x+p.w/6*5,p.y+p.h,-math.pi/2,p.w/6/imageWidth)
				love.graphics.draw(heroArt,heroQuad,p.x,p.y+p.h,-math.pi/2,p.w/6/imageWidth)
			else
				love.graphics.draw(heroArt,heroQuad,tmp_p.x-tmp_p.w/6*5,tmp_p.y,tmp_p.r,tmp_p.w/6/imageWidth)
				local imageWidth, imageHeight = demiArt1:getDimensions()
				love.graphics.draw(demiArt1,demiQuad1,p.x+p.w,p.y+p.h,-math.pi,p.w/6/imageWidth)
			end
		end
	else
		if p.demiHero == 0 then
			if rotatedImage and checkRotation then
				if demiArt2 ~= nil then
					local imageWidth, imageHeight = demiArt2:getDimensions()
					love.graphics.draw(demiArt2,demiQuad2,p.x+p.w/6*5,p.y+p.h/6,-math.pi/2,p.w/6/imageWidth)
				end
				local imageWidth, imageHeight = demiArt1:getDimensions()
				love.graphics.draw(demiArt1,demiQuad1,p.x,p.y+p.h/6,-math.pi/2,p.w/6/imageWidth)
			else
				if demiArt2 ~= nil then
					local imageWidth, imageHeight = demiArt2:getDimensions()
					love.graphics.draw(demiArt2,demiQuad2,p.x+p.w/6*5,p.y,0,p.w/6/imageWidth)
				end
				local imageWidth, imageHeight = demiArt1:getDimensions()
				love.graphics.draw(demiArt1,demiQuad1,p.x,p.y,0,p.w/6/imageWidth)
			end
		elseif p.demiHero == 1 then
			addStencil(stencil,"replace", 2,"greater", 1)
			local imageWidth, imageHeight = demiArt1:getDimensions()
			love.graphics.draw(demiArt1,demiQuad1,tmp_p.x,tmp_p.y,tmp_p.r,tmp_p.w/imageWidth)
			addStencil(stencilFunctionDemi,"replace", 2,"greater", 1)
			local imageWidth, imageHeight = heroArt:getDimensions()
			if rotatedImage and checkRotation then
				if demiArt2 ~= nil then
					love.graphics.draw(demiArt2,demiQuad2,p.x+p.w/6*5,p.y+p.h/6,-math.pi/2,p.w/6/imageWidth)
				end
				love.graphics.draw(heroArt,heroQuad,p.x,p.y+p.h/6,-math.pi/2,p.w/6/imageWidth)
			else
				love.graphics.draw(heroArt,heroQuad,tmp_p.x,tmp_p.y,tmp_p.r,tmp_p.w/6/imageWidth)
				if demiArt2 ~= nil then
					local imageWidth, imageHeight = demiArt2:getDimensions()
					love.graphics.draw(demiArt2,demiQuad2,p.x+p.w/6*5,p.y,0,p.w/6/imageWidth)
				end
			end
		else
			addStencil(stencil,"replace", 2,"greater", 1)
			local imageWidth, imageHeight = demiArt2:getDimensions()
			love.graphics.draw(demiArt2,demiQuad2,tmp_p.x,tmp_p.y,tmp_p.r,tmp_p.w/imageWidth)
			addStencil(stencilFunctionDemi,"replace", 2,"greater", 1)
			local imageWidth, imageHeight = heroArt:getDimensions()
			if rotatedImage and checkRotation then
				love.graphics.draw(demiArt1,demiQuad1,p.x,p.y+p.h/6,-math.pi/2,p.w/6/imageWidth)
				love.graphics.draw(heroArt,heroQuad,p.x+p.w/6*5,p.y+p.h/6,-math.pi/2,p.w/6/imageWidth)
			else
				love.graphics.draw(heroArt,heroQuad,tmp_p.x+tmp_p.w/6*5,tmp_p.y,tmp_p.r,tmp_p.w/6/imageWidth)
				local imageWidth, imageHeight = demiArt1:getDimensions()
				love.graphics.draw(demiArt1,demiQuad1,p.x,p.y,0,p.w/6/imageWidth)
			end
		end
	end
	love.graphics.setColor(0,0,0,1)
	removeStencil(stencil)
	removeStencil(stencilFunctionDemi)
	if currentplayer == 1 then 
		love.graphics.rectangle("line",p.x+p.w/6*5,p.y+p.h/6*5,p.w/6,p.h/6,25,25)
		if demiArt2 ~= nil then
			love.graphics.rectangle("line",p.x,p.y+p.h/6*5,p.w/6,p.h/6,25,25)
		end
	else
		love.graphics.rectangle("line",p.x,p.y,p.w/6,p.h/6,25,25)
		if demiArt2 ~= nil then
			love.graphics.rectangle("line",p.x+p.w/6*5,p.y,p.w/6,p.h/6,25,25)
		end
	end
	addStencil(stencil,"replace", 2,"greater", 1)
end

function love.touchmoved( id, x, y, dx, dy, pressure )
	for _, v in ipairs(love.touch.getTouches()) do
        if v == id then
			id = tostring(id)
			if input[id].x ~= -1 and input[id].y ~= -1 then
				input[id].dx = dx
				input[id].dy = dy
				scroll = scroll + dy
			end
		end
	end
end

function love.textinput(t)
    inputtext[textinput] = inputtext[textinput] .. t
end

function love.keypressed( key, scancode, isrepeat )
	if key == "escape" then
		if changeHeroId ~= -1 then
			changeHeroId = -1
			changeHero = true
		elseif viewLogs == true then
			if currentLog == "" then
				opencombatlog = true
				viewLogs = false
			else
				currentLog = ""
			end
		else
			opensettings = false
			opencombatlog = false
			changeHero = false
		end
	elseif key == "backspace" then
		local byteoffset = utf8.offset(inputtext[textinput], -1)
		if byteoffset then
			inputtext[textinput] = string.sub(inputtext[textinput], 1, byteoffset - 1)
		end
	elseif key == "return" then
        if textinput == 1 then
			emailButton:setTextInput(false)
			passwordButton:setTextInput(true)
            textinput = 2
		elseif textinput == 2 and passwordButton.status == true then
			passwordButton:setTextInput(false)
			loginText = fb:signin_email(inputtext[1], inputtext[2])
		end
	elseif key == "up" then
		scroll = scroll-100
	elseif key == "down" then
		scroll = scroll+100
	end
end	

function love.mousepressed( x, y, button, istouch, presses )
	love.touchpressed("1", x, y, 0, 0, 0)
end

function love.mousereleased( x, y, button, istouch, presses )
	love.touchreleased("1", x, y, 0, 0, 0)
end

function love.mousemoved( x, y, dx, dy, istouch )
	love.touchmoved("1", x, y, dx, dy, 0)
end

function love.touchpressed( id, x, y, dx, dy, pressure )
	id = tostring(id)
	input[id] = {
		dx = -1,
		dy = -1,
		x = x - safeX,
		y = y - safeY,
		last = -1,
		holdtime = love.timer.getTime(),
		fivepoints = false
	}	
	last.last = -1
	last.dx = 0
	last.dy = 0
end

function love.touchreleased( id, x, y, dx, dy, pressure )
	id = tostring(id)
	x = x - safeX
	y = y - safeY
	input[id].last = love.timer.getTime()
	last.last = love.timer.getTime()
	last.dx = input[id].dx
	last.dy = input[id].dy

	if opensettings == false and opencombatlog == false and changeHero == false and viewLogs == false and changeHeroId == -1 then
		if starttime == -1 and ((input[id].y > height/2+height/20 and y > height/2+height/20) or (input[id].y < height/2-height/20 and y < height/2-height/20)) then
			starttime = love.timer.getTime()
			epochtime = os.time(os.date("*t"))
		elseif starttime == -1 and  input[id].x < width/15*8 and x < width/15*8 and input[id].x > width/15*7 and x > width/15*7 then
			starttime = love.timer.getTime()
			epochtime = os.time(os.date("*t"))
		end
	end

	if input[id].x ~= -1 and input[id].y ~= -1 then
		if changeHero == true and changeHeroId == -1 then
			if (input[id].y < height/20*3 or input[id].y > height/20*19 or input[id].x < width/20 or input[id].x > width/10*9) and (y < height/20*3 or y > height/20*19 or x < width/20 or x > width/10*9) then
				changeHero = false
			elseif closeButton:input(x,y,input[id],0,0) then
				changeHero = false
			elseif input[id].y < height/20*4 and y < height/20*4 and input[id].y > height/20*3 and y > height/20*3 then
				for i = 1, 8, 1 do
					if input[id].x > width/10*i and x > width/10*i and input[id].x < width/10*i+width/11 and x < width/10*i+width/11 then
						noOfPlayers = i
						break
					end
				end
			elseif noOfPlayers <= 2 and showHeroTextButton2:input(x,y,input[id],0,0) and showHeroArt == true and CCBlitz ~= 1 and CCBlitz ~= 2 then
				showHeroText = not showHeroText
				showHeroTextButton2:updateStatus(not showHeroTextButton2.status)
				saveSettings()
			elseif noOfPlayers <= 2 and showHeroTextButton1:input(x,y,input[id],0,0) and showHeroArt == true and (CCBlitz == 1 or CCBlitz == 2) then
				showHeroText = not showHeroText
				showHeroTextButton1:updateStatus(not showHeroTextButton1.status)
				saveSettings()
			elseif noOfPlayers <= 2 and includeLLButton1:input(x,y,input[id],0,0) and showHeroArt == true and (CCBlitz == 1 or CCBlitz == 2) then
				includLLheroes = not includLLheroes
				includeLLButton1:updateStatus(not includeLLButton1.status)
				reloadHeroImage()
				saveSettings()
			elseif includeLLButton2:input(x,y,input[id],0,0) and showHeroArt == true and (CCBlitz == 1 or CCBlitz == 2) then
				includLLheroes = not includLLheroes
				includeLLButton2:updateStatus(not includeLLButton2.status)
				reloadHeroImage()
				saveSettings()
			else
				for i, p in ipairs(players) do
					if input[id].x >= p.change.x and x >= p.change.x and input[id].x <= p.change.x+p.change.w and x <= p.change.x+p.change.w and input[id].y >= p.change.y and y >= p.change.y and input[id].y <= p.change.y+p.change.h and y <= p.change.y+p.change.h then
						changeHeroId = i
						break
					end
				end
			end
		elseif changeHeroId ~= -1 then
			local p = players[changeHeroId]
			if notNil(imageAltList[CCBlitz]) ~= -1 and input[id].x > width/40*3 and input[id].x < width/40*3+width/10 and input[id].y > height/40*3 and input[id].y < height/40*3+height/20 then
				p.altHeroArt = not p.altHeroArt
				saveSettings()
			elseif closeButton:input(x,y,input[id],0,0) then
				changeHeroId = -1
			elseif (input[id].y < height/20*3 or input[id].y > height/20*19 or input[id].x < width/20*2 or input[id].x > width/10*8) and (y < height/20*3 or y > height/20*19 or x < width/20*2 or x > width/10*8) then
				changeHeroId = -1
			elseif input[id].x <= x+width/20 and input[id].x >= x-width/20 and input[id].y <= y+width/20 and input[id].y >= y-width/20 then
				local tmp = selectHero(id,p.image,x,y)
				if tmp ~= -1 then
					p.image = tmp
					if autoResetLife then
						k = checkCurrentHistory()
						for _, tmp_p in ipairs(players) do
							resetLife(k,tmp_p,false)
						end
					end
					saveSettings()
					changeHeroId = -1
				end
			end
		elseif opencombatlog == true then
			if saveButton:input(x,y,input[id],0,0) then
				viewLogs = true
				opencombatlog = false
			elseif (input[id].y < height/20*3 or input[id].y > height/20*19 or input[id].x < width/20*2 or input[id].x > width/10*8) and (y < height/20*3 or y > height/20*19 or x < width/20*2 or x > width/10*8) then
				opencombatlog = false
			end
		elseif opensettings == true then
			if formatButton:input(x,y,input[id],0,0) and viewLimited == false and viewStream == false then
				formatVisuals = updateformatVisuals(1)
			elseif gameButton:input(x,y,input[id],0,0) and viewLimited == false and viewStream == false then
				formatVisuals = updateformatVisuals(2)
			elseif visualsButton:input(x,y,input[id],0,0) and viewLimited == false and viewStream == false then
				formatVisuals = updateformatVisuals(3)
			elseif closeButton:input(x,y,input[id],0,0) then
				opensettings = false
				viewLimited = false
				viewStream = false
			elseif arrowButton:input(x,y,input[id],0,0) and viewLimited == true then -- För att man inte ska hoppa ur båda menyerna samtidigt
				viewLimited = true
			elseif arrowButton:input(x,y,input[id],0,0) and viewStream == true then -- För att man inte ska hoppa ur båda menyerna samtidigt
				viewStream = true
			elseif (input[id].y < height/20*3 or input[id].y > height/20*19 or input[id].x < width/20*2 or input[id].x > width/10*9) and (y < height/20*3 or y > height/20*19 or x < width/20*2 or x > width/10*9) then
				opensettings = false
				viewLimited = false
				viewStream = false
			end
			if viewLimited == true then
				local tmplist = {limitedWTRButton,limitedARCButton,limitedMONButton,limitedELEButton,limitedUPRButton,limitedOUTButton,limitedEVOButton,limitedHVYButton,limitedMSTButton,limitedROSButton}--,limitedHNTButton}
				for i, v in pairs(tmplist) do 
					if not CCBlitzToBool(v:getID()) and v:input(x,y,input[id],0,scroll) then
						updateCCBlitz(v:getID())
						for _, p in ipairs(players) do	
							convertHeroes(p,v:getID(),showHeroArt)
						end
						CCBlitz = v:getID()
						k = checkCurrentHistory()
						for _, p in ipairs(players) do
							resetLife(k,p,false)
						end
						saveSettings()
					end
				end
				if arrowButton:input(x,y,input[id],0,0) then
					viewLimited = false
				end
			elseif viewStream == true then
				if fabcounternet:input(x,y,input[id],0,0) then
					emailButton:setTextInput(false)
					passwordButton:setTextInput(false)
					love.system.openURL("http://fabcounter.net")
				elseif fb.refreshToken == '' then
					if emailButton:input(x,y,input[id],0,0) then
						textinput = 1
						passwordButton:setTextInput(false)
						emailButton:setTextInput(true)
					elseif passwordButton:input(x,y,input[id],0,0) then
						textinput = 2
						emailButton:setTextInput(false)
						passwordButton:setTextInput(true)
					elseif loginButton:input(x,y,input[id],0,0) then
						emailButton:setTextInput(false)
						passwordButton:setTextInput(false)
						loginText = fb:signin_email(inputtext[1], inputtext[2])
						saveFirebase()
					end
				elseif fb.refreshToken  ~= '' then
					if logoutButton:input(x,y,input[id],0,0) then
						emailButton:setTextInput(false)
						passwordButton:setTextInput(false)
						streamButton:updateStatus(false)
						fb:signout_email()
						loginText = ''
						inputtext[1] = ''
						inputtext[2] = ''
						saveFirebase()
					elseif streamActiveButton:input(x,y,input[id],0,0) then
						activeStream = not activeStream
						streamActiveButton:updateStatus(activeStream)
						streamButton:updateStatus(activeStream)
					end
				end
				if arrowButton:input(x,y,input[id],0,0) then
					viewStream = false
				end
			elseif formatVisuals == 3 then
				if rotationButton:input(x,y,input[id],0,0) then
					rotatedImage = not rotatedImage
					rotationButton:updateStatus(not rotationButton.status)
					saveSettings()
				elseif flipButton:input(x,y,input[id],0,0) then
					flipImage = not flipImage
					flipButton:updateStatus(not flipButton.status)
					if flipImage then
						rotatedImage = true
						rotationButton:updateStatus(rotatedImage)
					end
					saveSettings()
				elseif showplusminusButton:input(x,y,input[id],0,0) then
					showPlusMinus = not showPlusMinus
					showplusminusButton:updateStatus(not showplusminusButton.status)
					saveSettings()
				elseif rotplusminusButton:input(x,y,input[id],0,0) then
					rotPlusMinus = not rotPlusMinus
					rotplusminusButton:updateStatus(not rotplusminusButton.status)
					saveSettings()
				elseif overlayButton:input(x,y,input[id],0,0) then
					henrikMode = not henrikMode
					overlayButton:updateStatus(not overlayButton.status)
					saveSettings()
				elseif portraitButton:input(x,y,input[id],0,0) then
					for _, p in ipairs(players) do	
						convertHeroes(p,CCBlitz,not showHeroArt)
					end
					showHeroArt = not showHeroArt
					saveSettings()
					portraitButton:updateStatus(not portraitButton.status)
					saveSettings()
				elseif darkModeButton:input(x,y,input[id],0,0) then
					darkMode = not darkMode
					darkModeButton:updateStatus(not darkModeButton.status)
					saveSettings()
				elseif demiHeroButton:input(x,y,input[id],0,0) then
					showDemiHero = not showDemiHero
					demiHeroButton:updateStatus(not demiHeroButton.status)
					saveSettings()
				end
			elseif formatVisuals == 2 then
				if autoResetLifeButton:input(x,y,input[id],0,0) then
					autoResetLife = not autoResetLife
					autoResetLifeButton:updateStatus(not autoResetLifeButton.status)
					saveSettings()
				elseif biggerButton:input(x,y,input[id],0,0) then
					biggerTimer = not biggerTimer
					biggerButton:updateStatus(not biggerButton.status)
					saveSettings()
				elseif timerButton:input(x,y,input[id],0,0) then
					showTimer = not showTimer
					timerButton:updateStatus(not timerButton.status)
					saveSettings()
				elseif streamButton:input(x,y,input[id],0,0) then
					viewStream = true
				elseif Add5Button:input(x,y,input[id],0,0) then
					timeList = timer50to55(not timer55)
					saveSettings()
					Add5Button:updateStatus(not Add5Button.status)
					starttime = -1
					epochtime = -1
					saveSettings()
				elseif privacyButton:input(x,y,input[id],0,0) then
					love.system.openURL("http://sites.google.com/view/fab-counter")
				end
			else
				local tmplist = {blitzButton,ccButton,llButton,upfButton,commonerButton}
				for i, v in ipairs(tmplist) do
					if not CCBlitzToBool(i) and v:input(x,y,input[id],0,0) then
						updateCCBlitz(i)
						for _, p in ipairs(players) do	
							convertHeroes(p,i,showHeroArt)
						end
						CCBlitz = i
						k = checkCurrentHistory()
						for _, p in ipairs(players) do
							resetLife(k,p,false)
						end
						saveSettings()
					end
				end
				if input[id].y < height/20*17.75 and y < height/20*17.75 and input[id].y > height/20*16.75 and y > height/20*16.75 then
					for i = 1, 8, 1 do
						if input[id].x > width/10*i and x > width/10*i and input[id].x < width/10*i+width/11 and x < width/10*i+width/11 then
							noOfPlayers = i
							break
						end
					end
				elseif limitedButton:input(x,y,input[id],0,0) then
					viewLimited = true
				end
			end
		elseif viewLogs == true and currentLog == "" then
			if x > width/20*2 and x < width/20*18 and y > height/20*17 and y < height/20*17+height/80*7 and input[id].x > width/20*2 and input[id].x < width/20*18 and input[id].y > height/20*17 and input[id].y < height/20*17+height/80*7 then
				saveGame()
			elseif arrowButton:input(x,y,input[id],0,0) then
				viewLogs = false
				opencombatlog = true
				scroll = 0
			elseif closeButton:input(x,y,input[id],0,0) then
				viewLogs = false
				opencombatlog = false
				scroll = 0
			elseif (input[id].y < height/20*3 or input[id].y > height/20*19 or input[id].x < width/20*2 or input[id].x > width/10*8) and (y < height/20*3 or y > height/20*19 or x < width/20*2 or x > width/10*8) then
				viewLogs = false
				scroll = 0
			else
				local files = getGameFiles()
				for k, file in ipairs(files) do
					if x > width/20*2 and x < width/20*18 and y > height/22*(2+k*2)+scroll and y < height/22*(2+k*2)+scroll+height/12 and input[id].x > width/20*2 and input[id].x < width/20*18 and input[id].y > height/22*(2+k*2)+scroll and input[id].y < height/22*(2+k*2)+scroll+height/12 then
						currentLog = file
						oldScroll = scroll
						scroll = 0
					end
				end
			end	
		elseif viewLogs == true and currentLog ~= "" then
			imageX, imageY = trashImage:getDimensions()
			if closeButton:input(x,y,input[id],0,0) then
				currentLog = ""
				viewLogs = false
				opencombatlog = false
				scroll = 0
			elseif arrowButton:input(x,y,input[id],0,0) then
				currentLog = ""
				scroll = oldScroll
			elseif input[id].x > width/2-(imageX*trashScale*0.5)/2 and input[id].x < width/2-(imageX*trashScale*0.5)/2+width/10 and input[id].y > height/40*34 and input[id].y < height/40*34+height/20 then
				local tmp = currentLog
				deleteGameFiles(currentLog)
				currentLog = ""
				scroll = oldScroll
			elseif (input[id].y < height/20*3 or input[id].y > height/20*19 or input[id].x < width/20*2 or input[id].x > width/10*8) and (y < height/20*3 or y > height/20*19 or x < width/20*2 or x > width/10*8) then
				viewLogs = false
				currentLog = ""
			end	
			scroll = 0
			oldScroll = 0
		else
			if noOfPlayers == 1 then
				input[id].y = input[id].y - height/2+height/20
				y = y - height/2 + height/20
			end
			for i = 0, 6,1 do
				love.graphics.rectangle("line",width/30+width/7.5*i,height/2-width/16,width/8,width/8)
			end
			if input[id].fivepoints == false then
				if input[id].y < height/2+height/29 and y < height/2+height/29 and input[id].y > height/2-height/29 and y > height/2-height/29 then
					if opensettingsButton:input(x,y,input[id],0,0) then
						opensettings = true
					elseif historylogButton:input(x,y,input[id],0,0) then
						scroll = 0
						for _, p in ipairs(players) do
							updateHistoryLog(p)
						end
						opencombatlog = true
					elseif diceButton:input(x,y,input[id],0,0) and (showTimer == false or biggerTimer == false) then
						diceTime = 0.5
					elseif input[id].x < width/30+width/7.5*3+width/8 and x < width/30+width/7.5*3+width/8 and input[id].x > width/30+width/7.5*3 and x > width/30+width/7.5*3 then
						if starttime <= love.timer.getTime()-1 then
							local time = love.timer.getTime()
							if time <= lastclick + clickInterval then
								starttime = -1
								epochtime = -1
							else
								lastclick = time
								pauseTime = not pauseTime
							end
						end
					elseif arrowsButton:input(x,y,input[id],0,0) and (showTimer == false or biggerTimer == false) then
						local temp = {
							image = players[1].image,
							life = players[1].life,
							lifeHistory = players[1].lifeHistory,
							lastLife = players[1].lastLife,
							lastLifeHistory = players[1].lastLifeHistory
						}
						for i = 2, #players do
							players[i-1].image = players[i].image
							players[i-1].life = players[i].life
							players[i-1].lifeHistory = players[i].lifeHistory
							players[i-1].lastLife = players[i].lastLife
							players[i-1].lastLifeHistory = players[i].lastLifeHistory
						end
						players[#players].image = temp.image
						players[#players].life = temp.life
						players[#players].lifeHistory = temp.lifeHistory
						players[#players].lastLife = temp.lastLife
						players[#players].lastLifeHistory = temp.lastLifeHistory
					elseif cardButton:input(x,y,input[id],0,0) then
						changeHero = true
					elseif restartButton:input(x,y,input[id],0,0) then
						for _, p in ipairs(players) do
							updateHistoryLog(p)
						end
						k = checkCurrentHistory()
						local tmpbool = true
						if checkLastHistory() == 1 then
							tmpbool = false
						end
						for _, p in ipairs(players) do
							resetLife(k,p,tmpbool)
						end
						dice = 7
						local imageWidth, imageHeight = diceImage:getDimensions()
						diceButton:updateImage(diceImage,diceScale*0.5,diceButton.ix,height/2-imageHeight*diceScale/4)
						pauseTime = false
					end
				else
					if noOfPlayers == 1 then
						input[id].y = input[id].y + height/2 - height/20
						y = y + height/2 - height/20
					end
					local demiHeroChanged = false
					if showHeroArt == true and showDemiHero == true then
						for i, p in ipairs(players) do
							if imageList[CCBlitz][p.image][1] == "levia" and noOfPlayers == 2 and CCBlitz ~= 9 then
								if i == 1 then
									if leviaRe1Button:input(x,y,input[id],0,0) then
										if p.demiHero == 1 then
											p.demiHero = 0
										else
											p.demiHero = 1
										end
										demiHeroChanged = true
									end
									if blasmo1Button:input(x,y,input[id],0,0) then
										if p.demiHero == 2 then
											p.demiHero = 0
										else
											p.demiHero = 2
										end
										demiHeroChanged = true
									end
								elseif i == 2 then
									if leviaRe2Button:input(x,y,input[id],0,0) then
										if p.demiHero == 1 then
											p.demiHero = 0
										else
											p.demiHero = 1
										end
										demiHeroChanged = true
									end
									if blasmo2Button:input(x,y,input[id],0,0) then
										if p.demiHero == 2 then
											p.demiHero = 0
										else
											p.demiHero = 2
										end
										demiHeroChanged = true
									end
								else
									break
								end
							elseif (imageList[CCBlitz][p.image][1] == "teklovossen" or imageList[CCBlitz][p.image][1] == "professor") and noOfPlayers == 2 and CCBlitz ~= 12 then
								if i == 1 then
									if leviaRe1Button:input(x,y,input[id],0,0) then
										if p.demiHero == 1 then
											p.demiHero = 0
										else
											p.demiHero = 1
										end
										demiHeroChanged = true
									end
								elseif i == 2 then
									if leviaRe2Button:input(x,y,input[id],0,0) then
										if p.demiHero == 1 then
											p.demiHero = 0
										else
											p.demiHero = 1
										end
										demiHeroChanged = true
									end
								else
									break
								end
							end
						end
					end
					if demiHeroChanged == false then
						updatePlayerlife(id,x,y,1)
					end
				end
			end
			input[id].holdtime = -1
			input[id].fivepoints = false
		end
	end
	input[id].x = -1
	input[id].y = -1
	table[id] = nil
end

function updatePlayerlife(id,x,y,increment)
	for currentplayer, p in ipairs(players) do
		if input[id].x >= p.x and x >= p.x and input[id].x <= p.x+p.w and x <= p.x+p.w and input[id].y >= p.y and y >= p.y and input[id].y <= p.y+p.h and y <= p.y+p.h then
			if rotPlusMinus == true then
				if rotatedImage == true then
					if flipImage == true then
						if input[id].y > p.y+p.h/2 then
							p.life = p.life-increment
						else
							p.life = p.life+increment
						end
					else
						if noOfPlayers == 1 or (noOfPlayers == 2 and currentplayer == 2) then
							if input[id].y > p.y+p.h/2 then
								p.life = p.life-increment
							else
								p.life = p.life+increment
							end
						elseif (noOfPlayers == 2 and currentplayer == 1) or (noOfPlayers == 3 and currentplayer == 3) then
							if input[id].y > p.y+p.h/2 then
								p.life = p.life+increment
							else
								p.life = p.life-increment
							end
						elseif input[id].x < width/2 then
							if input[id].y > p.y+p.h/2 then
								p.life = p.life+increment
							else
								p.life = p.life-increment
							end
						else
							if input[id].y > p.y+p.h/2 then
								p.life = p.life-increment
							else
								p.life = p.life+increment
							end
						end			
					end
				else
					if p.y > height/2 or noOfPlayers == 1 then
						if input[id].y > p.y+p.h/2 then
							p.life = p.life-increment
						else
							p.life = p.life+increment
						end
					else
						if input[id].y > p.y+p.h/2 then
							p.life = p.life+increment
						else
							p.life = p.life-increment
						end
					end
				end
			else
				if rotatedImage == true then
					if flipImage == true then
						if input[id].x < p.x+p.w/2 then
							p.life = p.life+increment
						elseif input[id].x > p.x+p.w/2 then
							p.life = p.life-increment
						end
					else
						if noOfPlayers == 1 or (noOfPlayers == 2 and currentplayer == 2) or (noOfPlayers == 3 and currentplayer == 3) then
							if input[id].x < p.x+p.w/2 then
								p.life = p.life+increment
							elseif input[id].x > p.x+p.w/2 then
								p.life = p.life-increment
							end
						elseif noOfPlayers == 2 and currentplayer == 1 then
							if input[id].x < p.x+p.w/2 then
								p.life = p.life-increment
							elseif input[id].x > p.x+p.w/2 then
								p.life = p.life+increment
							end
						elseif input[id].x < width/2 then
							if input[id].x < p.x+p.w/2 then
								p.life = p.life-increment
							elseif input[id].x > p.x+p.w/2 then
								p.life = p.life+increment
							end
						else
							if input[id].x < p.x+p.w/2 then
								p.life = p.life+increment
							elseif input[id].x > p.x+p.w/2 then
								p.life = p.life-increment
							end
						end		
					end
				else
					if p.y > height/2 or noOfPlayers == 1 then
						if input[id].x < p.x+p.w/2 then
							p.life = p.life-increment
						elseif input[id].x > p.x+p.w/2 then
							p.life = p.life+increment
						end
					else
						if input[id].x < p.x+p.w/2 then
							p.life = p.life+increment
						elseif input[id].x > p.x+p.w/2 then
							p.life = p.life-increment
						end
					end
				end
			end
		end
	end
end

function selectHero(id,imageplayer,x,y)
	if showHeroArt == true then
		local image = imageList[CCBlitz]
		for i = 1, #image, 2 do
			if input[id].y <= height/20+height/10*(i+2)+scroll-width/50 and y <= height/20+height/10*(i+2)+scroll-width/50 and input[id].y >= height/20+height/10*i+scroll-width/50 and y >= height/20+height/10*i+scroll-width/50 then
				if (input[id].y < height/20*2 and y < height/20*2) or (input[id].y > height/20*2+height/10*8  and y > height/20*2+height/10*8) then
					return imageplayer
				elseif input[id].x >= width/10+width/100 and input[id].x <= width/2-width/50 and x >= width/10+width/100 and x <= width/2-width/50 then
					imageplayer = i
					return imageplayer
				elseif input[id].x >= width/2+width/100 and input[id].x <= width/10*9-width/50 and x >= width/2+width/100 and x <= width/10*9-width/50 then
					if i+1 <= #image then
						imageplayer = i+1
						return imageplayer
					end
				end
			end
		end
	else
		for i = 1, #colors, 2 do
			if input[id].y <= height/20+height/10*(i+2)+scroll-width/50 and y <= height/20+height/10*(i+2)+scroll-width/50 then
				if (input[id].y < height/20*2 and y < height/20*2) or (input[id].y > height/20*2+height/10*8  and y > height/20*2+height/10*8) then
					return imageplayer
				elseif input[id].x >= width/10+width/100 and input[id].x <= width/2-width/50 and x >= width/10+width/100 and x <= width/2-width/50 then
					imageplayer = i
					return imageplayer
				elseif input[id].x >= width/2+width/100 and input[id].x <= width/10*9-width/50 and x >= width/2+width/100 and x <= width/10*9-width/50 then
					if i+1 <= #colors then
						imageplayer = i+1
						return imageplayer
					end
				end
			end
		end
	end
	return -1
end

function isCC()
	return (CCBlitzToBool(2) or CCBlitzToBool(3))
end

function resetLife(k,p,checklast)
	updateHistoryLog(p)
	starttime = -1
	epochtime = -1
	if checklast == true and k == 1 then
		local tempLife = p.lastLife
		local tempLifeHistory = p.lastLifeHistory
		p.lastLife = p.life
		p.lastLifeHistory = p.lifeHistory 
		p.life = tempLife
		p.lifeHistory = tempLifeHistory
	else
		p.lastLife = p.life
		p.lastLifeHistory = p.lifeHistory 
		if showHeroArt == false then
			if isCC() then
				p.life = 40
			else
				p.life = 20
			end
		else
			p.life = lifeList[CCBlitz][p.image][2]
		end
		p.lifeHistory = {p.life}
	end
	if checklast == false then
		--Don't save settings if checklast is true
		saveSettings()
	end
end

function convertToNewHero(tmp,p,newCCBlitz)
	for key,value in pairs(imageList[newCCBlitz]) do
		if value[1] == tmp then
			tmp = false
			return key, tmp
		end
	end
	return p.image, tmp
end

function convertHeroes(p,newCCBlitz,newshowHeroArt)
	if showHeroArt == true and newshowHeroArt == true then
		tmp = imageList[CCBlitz][p.image][1]
		p.image, tmp = convertToNewHero(tmp,p,newCCBlitz)
		if tmp ~= false then
			p.image = 1
		end
	elseif newshowHeroArt == false then --Oberoende om showHeroArt är true eller false
		if p.image > #colors then
			p.image = 1
		end
	else -- if showHeroArt == false and newshowHeroArt == true
		if p.image > #imageList[CCBlitz] then
			p.image = 1
		end
	end
end
	
function checkCurrentHistory()
	local tmp = 0
	for i = 1, noOfPlayers, 1 do
		if tmp < #players[i].lifeHistory then
			tmp = #players[i].lifeHistory
		end
	end
	return tmp
end

function checkLastHistory()
	local tmp = 0
	for i = 1, noOfPlayers, 1 do
		if tmp < #players[i].lastLifeHistory then
			tmp = #players[i].lastLifeHistory
		end
	end
	return tmp
end

function updateHistoryLog(p)
	if p.lifeHistory[#p.lifeHistory] ~= p.life then
		table.insert(p.lifeHistory,p.life)
	end
end

function resolutionChange()
	bigFont = love.graphics.newFont("Assets/Roboto-Black.ttf",width/2)
	bigFont2 = love.graphics.newFont("Assets/Roboto-Black.ttf",width/4)
	timerFont = love.graphics.newFont("Assets/Roboto-Black.ttf",width/8)
	plusFont = love.graphics.newFont("Assets/Roboto-Black.ttf",width/10)
	mediumFont = love.graphics.newFont("Assets/Roboto-Black.ttf",width/15)
	mediumFont2 = love.graphics.newFont("Assets/Roboto-Black.ttf",width/17)
	miniFont = love.graphics.newFont("Assets/Roboto-Black.ttf",width/20)
	settingsFont = love.graphics.newFont("Assets/Roboto-Black.ttf",width/25)
	smallFont = love.graphics.newFont("Assets/Roboto-Black.ttf",width/30)
	miniFont3 = love.graphics.newFont("Assets/Roboto-Black.ttf",width/40)

	restartScale = reloadGUIImgScale(restartImage)
	cardScale = reloadGUIImgScale(cardImage)
	notesScale = reloadGUIImgScale(notesImage)
	infoScale = reloadGUIImgScale(infoImage)
	closeScale = reloadGUIImgScale(closeImage)
	cruScale = reloadGUIImgScale(cruImage)
	arrowScale = reloadGUIImgScale(arrowImage)
	checkboxScale = reloadGUIImgScale(checkboxImage)
	mapScale = reloadGUIImgScale(mapImage)
	saveScale = reloadGUIImgScale(saveImage)
	changeScale = reloadGUIImgScale(changeImage)
	trashScale = reloadGUIImgScale(trashImage)
	pauseScale = reloadGUIImgScale(pauseImage)
	arrowsScale = reloadGUIImgScale(arrowsImage)
	dice1Scale = reloadGUIImgScale(dice1Image)
	dice2Scale = reloadGUIImgScale(dice2Image)
	dice3Scale = reloadGUIImgScale(dice3Image)
	dice4Scale = reloadGUIImgScale(dice4Image)
	dice5Scale = reloadGUIImgScale(dice5Image)
	dice6Scale = reloadGUIImgScale(dice6Image)
	diceScale = reloadGUIImgScale(diceImage)
	menubgScale = reloadGUIImgScale(menubgImage)
	outScale = reloadGUIImgScale(outImage)
	logoScale = reloadGUIImgScale(logoImage)
	leviaReScale = reloadGUIImgScale(leviaReImage)
	blasmoScale = reloadGUIImgScale(blasmoImage)
	mechropotentScale = reloadGUIImgScale(mechropotentImage)

	local imageWidth, imageHeight = leviaReImage:getDimensions()
	leviaRe1Button = buttonClass:new(0,false,players[1].x+players[1].w/5*4,players[1].w/5,players[1].y+players[1].h/5*4,players[1].h/5,players[1].r,0,{0.5,0.5,0.5},{0,0,0},{0.5,0.5,0.5},{0,0,0},leviaReImage, leviaReImage, players[1].w/5/imageWidth ,players[1].x+players[1].w, players[1].y+players[1].h,nil,nil,nil,nil,nil,nil)
	leviaRe2Button = buttonClass:new(0,false,players[2].x,players[2].w/5,players[2].y,players[2].h/5,players[2].r,0,{0.5,0.5,0.5},{0,0,0},{0.5,0.5,0.5},{0,0,0},leviaReImage, leviaReImage, players[2].w/5/imageWidth ,players[2].x, players[2].y,nil,nil,nil,nil,nil,nil)
	local imageWidth, imageHeight = blasmoImage:getDimensions()
	blasmo1Button = buttonClass:new(0,false,players[1].x,players[1].w/5,players[1].y+players[1].h/5*4,players[1].h/5,players[1].r,0,{0.5,0.5,0.5},{0,0,0},{0.5,0.5,0.5},{0,0,0},blasmoImage, blasmoImage, players[1].w/5/imageWidth ,players[1].x+players[1].w/5, players[1].y+players[1].h,nil,nil,nil,nil,nil,nil)
	blasmo2Button = buttonClass:new(0,false,players[2].x+players[2].w/5*4,players[2].w/5,players[2].y,players[2].h/5,players[2].r,0,{0.5,0.5,0.5},{0,0,0},{0.5,0.5,0.5},{0,0,0},blasmoImage, blasmoImage, players[2].w/5/imageWidth ,players[2].x+players[2].w/5*4, players[2].y,nil,nil,nil,nil,nil,nil)

	local imageWidth, imageHeight = infoImage:getDimensions()
	opensettingsButton = buttonClass:new(0,false,width/30,width/30*3,height/2-height/29,height/14.5,0,0,{0.5,0.5,0.5},{0,0,0},{0.5,0.5,0.5},{0,0,0},infoImage, infoImage, infoScale*0.5 ,width/30, height/2-imageHeight*infoScale/4,nil,nil,nil,nil,nil,nil)
	local imageWidth, imageHeight = notesImage:getDimensions()
	historylogButton = buttonClass:new(0,false,width/30*5,width/30*3,height/2-height/29,height/14.5,0,0,{0.5,0.5,0.5},{0,0,0},{0.5,0.5,0.5},{0,0,0},notesImage, notesImage, notesScale*0.5 ,width/30*5, height/2-imageHeight*notesScale/4,nil,nil,nil,nil,nil,nil)
	local imageWidth, imageHeight = diceImage:getDimensions()
	diceButton = buttonClass:new(0,false,width/30*9,width/30*3,height/2-height/29,height/14.5,0,0,{0.5,0.5,0.5},{0,0,0},{0.5,0.5,0.5},{0,0,0},diceImage, diceImage, diceScale*0.5 ,width/30*9, height/2-imageHeight*diceScale/4,nil,nil,nil,nil,nil,nil)
	local imageWidth, imageHeight = arrowsImage:getDimensions()
	arrowsButton = buttonClass:new(0,false,width/30*18,width/30*3,height/2-height/29,height/14.5,0,0,{0.5,0.5,0.5},{0,0,0},{0.5,0.5,0.5},{0,0,0},arrowsImage, arrowsImage, arrowsScale*0.5 ,width/30*18, height/2-imageHeight*arrowsScale/4,nil,nil,nil,nil,nil,nil)
	local imageWidth, imageHeight = cardImage:getDimensions()
	cardButton = buttonClass:new(0,false,width/30*22,width/30*3,height/2-height/29,height/14.5,0,0,{0.5,0.5,0.5},{0,0,0},{0.5,0.5,0.5},{0,0,0},cardImage,cardImage, cardScale*0.5 ,width/30*22, height/2-imageHeight*cardScale/4,nil,nil,nil,nil,nil,nil)
	local imageWidth, imageHeight = restartImage:getDimensions()
	restartButton = buttonClass:new(0,false,width/30*26,width/30*3,height/2-height/29,height/14.5,0,0,{0.5,0.5,0.5},{0,0,0},{0.5,0.5,0.5},{0,0,0},restartImage,restartImage, restartScale*0.5 ,width/30*26, height/2-imageHeight*restartScale/4,nil,nil,nil,nil,nil,nil)

	arrowButton = buttonClass:new(0,false,width/40*3,width/10,height/40*3,height/20,math.pi/2,0,{0.5,0.5,0.5},{0,0,0},{0.5,0.5,0.5},{0,0,0},arrowImage,arrowImage,arrowScale*0.5,width/40*6,height/40*3,nil,nil,nil,nil,nil,nil)
	saveButton = buttonClass:new(0,false,width/40*3,width/10,height/40*3,height/20,0,0,{0.5,0.5,0.5},{0,0,0},{0.5,0.5,0.5},{0,0,0},saveImage,saveImage,saveScale*0.5,width/40*3,height/40*3,nil,nil,nil,nil,nil,nil)
	local imageX, imageY = closeImage:getDimensions()
	closeButton = buttonClass:new(0,false,width/40*33,width/10,height/40*3,height/20,0,0,{0.5,0.5,0.5},{0,0,0},{0.5,0.5,0.5},{0,0,0},closeImage,closeImage,closeScale*0.5,width/40*33,height/40*3,nil,nil,nil,nil,nil,nil)

	
	showHeroTextButton1 = buttonClass:new(0,showHeroText,width/20*2,width/20*7.5,height/20*17.5,height/20,25,25,{0.302,0.302,0.302,0.7},{0.827,0.827,0.827,1},{0,0.573,0.271,1},{0.941,0.878,0.471,1},nil,nil,width/imageX*0.75,nil,nil,smallFont,"Show hero text",width/20*2,height/20*17.5+height/40,{0,0,0},{1,1,1},width/20*7.5,"center")
	showHeroTextButton2 = buttonClass:new(0,showHeroText,width/20*2,width/20*16,height/20*17.5,height/20,25,25,{0.302,0.302,0.302,0.7},{0.827,0.827,0.827,1},{0,0.573,0.271,1},{0.941,0.878,0.471,1},nil,nil,width/imageX*0.75,nil,nil,mediumFont,"Show hero text",width/10,height/20*17.5+height/40,{0,0,0},{1,1,1},width/10*8,"center")
	includeLLButton1 = buttonClass:new(0,includLLheroes,width/20*10.5,width/20*7.5,height/20*17.5,height/20,25,25,{0.302,0.302,0.302,0.7},{0.827,0.827,0.827,1},{0,0.573,0.271,1},{0.941,0.878,0.471,1},nil,nil,width/imageX*0.75,nil,nil,smallFont,"Include Living Legend",width/20*10.5,height/20*17.5+height/40,{0,0,0},{1,1,1},width/20*7.5,"center")
	includeLLButton2 = buttonClass:new(0,includLLheroes,width/20*2,width/20*16,height/20*17.5,height/20,25,25,{0.302,0.302,0.302,0.7},{0.827,0.827,0.827,1},{0,0.573,0.271,1},{0.941,0.878,0.471,1},nil,nil,width/imageX*0.75,nil,nil,mediumFont,"Include Living Legend",width/10,height/20*17.5+height/40,{0,0,0},{1,1,1},width/10*8,"center")

	formatButton = buttonClass:new(0,formatVisuals==1,width/20*2,width/20*5,height/20*3,height/15,25,25,{0.302,0.302,0.302,0.7},{0.827,0.827,0.827,1},{0,0.573,0.271,1},{0.941,0.878,0.471,1},nil,nil,width/imageX*0.55,nil,nil,mediumFont2,"Format",width/20*2,height/20*3+height/30,{0,0,0},{1,1,1},width/20*5,"center")
	gameButton = buttonClass:new(0,formatVisuals==2,width/20*7.5,width/20*5,height/20*3,height/15,25,25,{0.302,0.302,0.302,0.7},{0.827,0.827,0.827,1},{0,0.573,0.271,1},{0.941,0.878,0.471,1},nil,nil,width/imageX*0.55,nil,nil,mediumFont2,"Game",width/20*7.5,height/20*3+height/30,{0,0,0},{1,1,1},width/20*5,"center")
	visualsButton = buttonClass:new(0,formatVisuals==3,width/20*13,width/20*5,height/20*3,height/15,25,25,{0.302,0.302,0.302,0.7},{0.827,0.827,0.827,1},{0,0.573,0.271,1},{0.941,0.878,0.471,1},nil,nil,width/imageX*0.55,nil,nil,mediumFont2,"Visuals",width/20*13,height/20*3+height/30,{0,0,0},{1,1,1},width/20*5,"center")

	rotationButton = buttonClass:new(0,rotatedImage,width/20*2,width/20*16,height/20*5,height/13,25,25,{0.302,0.302,0.302,0.7},{0.827,0.827,0.827,1},{0,0.573,0.271,1},{0.941,0.878,0.471,1},nil,nil,width/imageX*0.75,nil,nil,mediumFont,"Rotate hero portraits",width/10,height/20*5+height/26,{0,0,0},{1,1,1},width/10*8,"center")
	flipButton = buttonClass:new(0,flipImage,width/20*2,width/20*16,height/20*6.75,height/13,25,25,{0.302,0.302,0.302,0.7},{0.827,0.827,0.827,1},{0,0.573,0.271,1},{0.941,0.878,0.471,1},nil,nil,width/imageX*0.75,nil,nil,mediumFont,"Hero portraits facing right",width/10,height/20*6.75+height/26,{0,0,0},{1,1,1},width/10*8,"center")
	portraitButton = buttonClass:new(0,showHeroArt,width/20*2,width/20*16,height/20*8.5,height/13,25,25,{0.302,0.302,0.302,0.7},{0.827,0.827,0.827,1},{0,0.573,0.271,1},{0.941,0.878,0.471,1},nil,nil,width/imageX*0.75,nil,nil,mediumFont,"Show hero portraits",width/10,height/20*8.5+height/26,{0,0,0},{1,1,1},width/10*8,"center")
	overlayButton = buttonClass:new(0,henrikMode,width/20*2,width/20*16,height/20*10.25,height/13,25,25,{0.302,0.302,0.302,0.7},{0.827,0.827,0.827,1},{0,0.573,0.271,1},{0.941,0.878,0.471,1},nil,nil,width/imageX*0.75,nil,nil,mediumFont,"Show overlay",width/10,height/20*10.25+height/26,{0,0,0},{1,1,1},width/10*8,"center")
	showplusminusButton = buttonClass:new(0,showPlusMinus,width/20*2,width/20*16,height/20*12,height/13,25,25,{0.302,0.302,0.302,0.7},{0.827,0.827,0.827,1},{0,0.573,0.271,1},{0.941,0.878,0.471,1},nil,nil,width/imageX*0.75,nil,nil,mediumFont,"Show + and -",width/10,height/20*12+height/26,{0,0,0},{1,1,1},width/10*8,"center")
	rotplusminusButton = buttonClass:new(0,rotPlusMinus,width/20*2,width/20*16,height/20*13.75,height/13,25,25,{0.302,0.302,0.302,0.7},{0.827,0.827,0.827,1},{0,0.573,0.271,1},{0.941,0.878,0.471,1},nil,nil,width/imageX*0.75,nil,nil,mediumFont,"Rotate + and -",width/10,height/20*13.75+height/26,{0,0,0},{1,1,1},width/10*8,"center")
	darkModeButton = buttonClass:new(0,darkMode,width/20*2,width/20*16,height/20*15.5,height/13,25,25,{0.302,0.302,0.302,0.7},{0.827,0.827,0.827,1},{0,0.573,0.271,1},{0.941,0.878,0.471,1},nil,nil,width/imageX*0.75,nil,nil,mediumFont,"Dark mode",width/10,height/20*15.5+height/26,{0,0,0},{1,1,1},width/10*8,"center")
	demiHeroButton = buttonClass:new(0,showDemiHero,width/20*2,width/20*16,height/20*17.25,height/13,25,25,{0.302,0.302,0.302,0.7},{0.827,0.827,0.827,1},{0,0.573,0.271,1},{0.941,0.878,0.471,1},nil,nil,width/imageX*0.75,nil,nil,mediumFont,"Show Demi-heroes",width/10,height/20*17.25+height/26,{0,0,0},{1,1,1},width/10*8,"center")

	local buttonFont = miniFont
	Add5Button = buttonClass:new(0,timer55,width/20*2,width/20*16,height/20*5,height/13,25,25,{0.302,0.302,0.302,0.7},{0.827,0.827,0.827,1},{0,0.573,0.271,1},{0.941,0.878,0.471,1},nil,nil,width/imageX*0.75,nil,nil,buttonFont,"Add 5 minutes setup timer",width/10*1.5,height/20*5+height/26,{0,0,0},{1,1,1},width/10*7,"center")
	autoResetLifeButton = buttonClass:new(0,autoResetLife,width/20*2,width/20*16,height/20*6.75,height/13,25,25,{0.302,0.302,0.302,0.7},{0.827,0.827,0.827,1},{0,0.573,0.271,1},{0.941,0.878,0.471,1},nil,nil,width/imageX*0.75,nil,nil,buttonFont,"Auto reset life on hero change",width/10*1.5,height/20*6.75+height/26,{0,0,0},{1,1,1},width/10*7,"center")
	biggerButton = buttonClass:new(0,biggerTimer,width/20*2,width/20*16,height/20*8.5,height/13,25,25,{0.302,0.302,0.302,0.7},{0.827,0.827,0.827,1},{0,0.573,0.271,1},{0.941,0.878,0.471,1},nil,nil,width/imageX*0.75,nil,nil,mediumFont,"Bigger timer",width/10,height/20*8.5+height/26,{0,0,0},{1,1,1},width/10*8,"center")
	timerButton = buttonClass:new(0,showTimer,width/20*2,width/20*16,height/20*10.25,height/13,25,25,{0.302,0.302,0.302,0.7},{0.827,0.827,0.827,1},{0,0.573,0.271,1},{0.941,0.878,0.471,1},nil,nil,width/imageX*0.75,nil,nil,mediumFont,"Show timer",width/10,height/20*10.25+height/26,{0,0,0},{1,1,1},width/10*8,"center")
	streamButton = buttonClass:new(0,false,width/20*2,width/20*16,height/20*12,height/13,25,25,{0.302,0.302,0.302,0.7},{0.827,0.827,0.827,1},{0,0.573,0.271,1},{0.941,0.878,0.471,1},nil,nil,width/imageX*0.75,nil,nil,mediumFont,"Stream",width/10,height/20*12+height/26,{0,0,0},{1,1,1},width/10*8,"center")

	privacyButton = buttonClass:new(0,false,width/2-width/8,width/4,height/20*18.25,height/24,25,25,{0,0,0,0},{0,0,0,0},{0,0,0,0},{0,0,0,0},nil,nil,nil,nil,nil,smallFont,"Privacy Policy",width/10,height/20*18.25+height/48,{0,0,0},{1,1,1},width/10*8,"center")

	blitzButton = buttonClass:new(1,CCBlitzToBool(1),width/20*2,width/20*16,height/20*5,height/13,25,25,{0.302,0.302,0.302,0.7},{0.827,0.827,0.827,1},{0,0.573,0.271,1},{0.941,0.878,0.471,1},nil,nil,width/imageX*0.75,nil,nil,mediumFont,"Blitz",width/10,height/20*5+height/26,{0,0,0},{1,1,1},width/10*8,"center")
	ccButton = buttonClass:new(2,CCBlitzToBool(2),width/20*2,width/20*16,height/20*6.75,height/13,25,25,{0.302,0.302,0.302,0.7},{0.827,0.827,0.827,1},{0,0.573,0.271,1},{0.941,0.878,0.471,1},nil,nil,width/imageX*0.75,nil,nil,mediumFont,"Classic Constructed",width/10,height/20*6.75+height/26,{0,0,0},{1,1,1},width/10*8,"center")
	llButton = buttonClass:new(3,CCBlitzToBool(3),width/20*2,width/20*16,height/20*8.5,height/13,25,25,{0.302,0.302,0.302,0.7},{0.827,0.827,0.827,1},{0,0.573,0.271,1},{0.941,0.878,0.471,1},nil,nil,width/imageX*0.75,nil,nil,mediumFont,"CC Living Legend",width/10,height/20*8.5+height/26,{0,0,0},{1,1,1},width/10*8,"center")
	limitedButton = buttonClass:new(99,CCBlitzToBool(99),width/20*2,width/20*16,height/20*12,height/13,25,25,{0.302,0.302,0.302,0.7},{0.827,0.827,0.827,1},{0,0.573,0.271,1},{0.941,0.878,0.471,1},nil,nil,width/imageX*0.75,nil,nil,mediumFont,"Limited",width/10,height/20*12+height/26,{0,0,0},{1,1,1},width/10*8,"center")

	commonerButton = buttonClass:new(5,CCBlitzToBool(5),width/20*2,width/20*16,height/20*10.25,height/13,25,25,{0.302,0.302,0.302,0.7},{0.827,0.827,0.827,1},{0,0.573,0.271,1},{0.941,0.878,0.471,1},nil,nil,width/imageX*0.75,nil,nil,mediumFont,"Commoner",width/10,height/20*10.25+height/26,{0,0,0},{1,1,1},width/10*8,"center")
	upfButton = buttonClass:new(4,CCBlitzToBool(4),width/20*2,width/20*16,height/20*13.75,height/13,25,25,{0.302,0.302,0.302,0.7},{0.827,0.827,0.827,1},{0,0.573,0.271,1},{0.941,0.878,0.471,1},nil,nil,width/imageX*0.75,nil,nil,mediumFont,"Ultimate Pit Fight",width/10,height/20*13.75+height/26,{0,0,0},{1,1,1},width/10*8,"center")

	local lastLimited = 19
	limitedWTRButton = buttonClass:new(6,CCBlitzToBool(6),width/20*2.5,width/20*15,height/20*lastLimited,height/13,25,25,{0.302,0.302,0.302,0.7},{0.827,0.827,0.827,1},{0,0.573,0.271,1},{0.941,0.878,0.471,1},nil,nil,width/imageX*0.75,nil,nil,mediumFont,"Welcome to Rathe",width/10,height/20*lastLimited+height/26,{0,0,0},{1,1,1},width/10*8,"center")
    limitedARCButton = buttonClass:new(7,CCBlitzToBool(7),width/20*2.5,width/20*15,height/20*(lastLimited-1.75),height/13,25,25,{0.302,0.302,0.302,0.7},{0.827,0.827,0.827,1},{0,0.573,0.271,1},{0.941,0.878,0.471,1},nil,nil,width/imageX*0.75,nil,nil,mediumFont,"Arcane Rising",width/10,height/20*(lastLimited-1.75)+height/26,{0,0,0},{1,1,1},width/10*8,"center")
    limitedMONButton = buttonClass:new(8,CCBlitzToBool(8),width/20*2.5,width/20*15,height/20*(lastLimited-1.75*2),height/13,25,25,{0.302,0.302,0.302,0.7},{0.827,0.827,0.827,1},{0,0.573,0.271,1},{0.941,0.878,0.471,1},nil,nil,width/imageX*0.75,nil,nil,mediumFont,"Monarch",width/10,height/20*(lastLimited-1.75*2)+height/26,{0,0,0},{1,1,1},width/10*8,"center")
    limitedELEButton = buttonClass:new(9,CCBlitzToBool(9),width/20*2.5,width/20*15,height/20*(lastLimited-1.75*3),height/13,25,25,{0.302,0.302,0.302,0.7},{0.827,0.827,0.827,1},{0,0.573,0.271,1},{0.941,0.878,0.471,1},nil,nil,width/imageX*0.75,nil,nil,mediumFont,"Tales of Aria",width/10,height/20*(lastLimited-1.75*3)+height/26,{0,0,0},{1,1,1},width/10*8,"center")
    limitedUPRButton = buttonClass:new(10,CCBlitzToBool(10),width/20*2.5,width/20*15,height/20*(lastLimited-1.75*4),height/13,25,25,{0.302,0.302,0.302,0.7},{0.827,0.827,0.827,1},{0,0.573,0.271,1},{0.941,0.878,0.471,1},nil,nil,width/imageX*0.75,nil,nil,mediumFont,"Uprising",width/10,height/20*(lastLimited-1.75*4)+height/26,{0,0,0},{1,1,1},width/10*8,"center")
    limitedOUTButton = buttonClass:new(11,CCBlitzToBool(11),width/20*2.5,width/20*15,height/20*(lastLimited-1.75*5),height/13,25,25,{0.302,0.302,0.302,0.7},{0.827,0.827,0.827,1},{0,0.573,0.271,1},{0.941,0.878,0.471,1},nil,nil,width/imageX*0.75,nil,nil,mediumFont,"Outsiders",width/10,height/20*(lastLimited-1.75*5)+height/26,{0,0,0},{1,1,1},width/10*8,"center")
	limitedEVOButton = buttonClass:new(12,CCBlitzToBool(12),width/20*2.5,width/20*15,height/20*(lastLimited-1.75*6),height/13,25,25,{0.302,0.302,0.302,0.7},{0.827,0.827,0.827,1},{0,0.573,0.271,1},{0.941,0.878,0.471,1},nil,nil,width/imageX*0.75,nil,nil,mediumFont,"Bright Lights",width/10,height/20*(lastLimited-1.75*6)+height/26,{0,0,0},{1,1,1},width/10*8,"center")
	limitedHVYButton = buttonClass:new(13,CCBlitzToBool(13),width/20*2.5,width/20*15,height/20*(lastLimited-1.75*7),height/13,25,25,{0.302,0.302,0.302,0.7},{0.827,0.827,0.827,1},{0,0.573,0.271,1},{0.941,0.878,0.471,1},nil,nil,width/imageX*0.75,nil,nil,mediumFont,"Heavy Hitters",width/10,height/20*(lastLimited-1.75*7)+height/26,{0,0,0},{1,1,1},width/10*8,"center")
	limitedMSTButton = buttonClass:new(14,CCBlitzToBool(14),width/20*2.5,width/20*15,height/20*(lastLimited-1.75*8),height/13,25,25,{0.302,0.302,0.302,0.7},{0.827,0.827,0.827,1},{0,0.573,0.271,1},{0.941,0.878,0.471,1},nil,nil,width/imageX*0.75,nil,nil,mediumFont,"Part the Mistveil",width/10,height/20*(lastLimited-1.75*8)+height/26,{0,0,0},{1,1,1},width/10*8,"center")
	limitedROSButton = buttonClass:new(15,CCBlitzToBool(15),width/20*2.5,width/20*15,height/20*(lastLimited-1.75*9),height/13,25,25,{0.302,0.302,0.302,0.7},{0.827,0.827,0.827,1},{0,0.573,0.271,1},{0.941,0.878,0.471,1},nil,nil,width/imageX*0.75,nil,nil,mediumFont,"Rosetta",width/10,height/20*(lastLimited-1.75*9)+height/26,{0,0,0},{1,1,1},width/10*8,"center")
	--limitedHNTButton = buttonClass:new(16,CCBlitzToBool(16),width/20*2.5,width/20*15,height/20*(lastLimited-1.75*10),height/13,25,25,{0.302,0.302,0.302,0.7},{0.827,0.827,0.827,1},{0,0.573,0.271,1},{0.941,0.878,0.471,1},nil,nil,width/imageX*0.75,nil,nil,mediumFont,"The Hunted",width/10,height/20*(lastLimited-1.75*10)+height/26,{0,0,0},{1,1,1},width/10*8,"center")

	emailButton = buttonClass:new(6,false,width/20*2,width/20*16,height/20*8.5,height/13,25,25,{0.302,0.302,0.302,0.7},{0.827,0.827,0.827,1},{0,0.573,0.271,1},{0.941,0.878,0.471,1},nil,nil,width/imageX*0.75,nil,nil,mediumFont,"Email",width/10,height/20*8.5+height/26,{0,0,0},{0.5,0.5,0.5},width/10*8,"center")
    passwordButton = buttonClass:new(6,false,width/20*2,width/20*16,height/20*10.25,height/13,25,25,{0.302,0.302,0.302,0.7},{0.827,0.827,0.827,1},{0,0.573,0.271,1},{0.941,0.878,0.471,1},nil,nil,width/imageX*0.75,nil,nil,mediumFont,"Password",width/10,height/20*10.25+height/26,{0,0,0},{0.5,0.5,0.5},width/10*8,"center")
    loginButton = buttonClass:new(6,false,width/20*2,width/20*16,height/20*12,height/13,25,25,{0.302,0.302,0.302,0.7},{0.827,0.827,0.827,1},{0,0.573,0.271,1},{0.941,0.878,0.471,1},nil,nil,width/imageX*0.75,nil,nil,mediumFont,"Sign in",width/10,height/20*12+height/26,{0,0,0},{1,1,1},width/10*8,"center")
	fabcounternet = buttonClass:new(6,false,width/20*2,width/20*16,height/20*13.75,height/13,25,25,{0.302,0.302,0.302,0.7},{0.827,0.827,0.827,1},{0,0.573,0.271,1},{0.941,0.878,0.471,1},nil,nil,width/imageX*0.75,nil,nil,mediumFont,"Open fabcounter.net",width/10,height/20*13.75+height/26,{0,0,0},{1,1,1},width/10*8,"center")
	logoutButton = buttonClass:new(6,false,width/20*2,width/20*16,height/20*15.5,height/13,25,25,{0.302,0.302,0.302,0.7},{0.827,0.827,0.827,1},{0,0.573,0.271,1},{0.941,0.878,0.471,1},nil,nil,width/imageX*0.75,nil,nil,mediumFont,"Sign out",width/10,height/20*15.5+height/26,{0,0,0},{1,1,1},width/10*8,"center")
	streamActiveButton = buttonClass:new(6,false,width/20*2,width/20*16,height/20*8,height/13,25,25,{0.302,0.302,0.302,0.7},{0.827,0.827,0.827,1},{0,0.573,0.271,1},{0.941,0.878,0.471,1},nil,nil,width/imageX*0.75,nil,nil,mediumFont,"Stream enabled",width/10,height/20*8+height/26,{0,0,0},{1,1,1},width/10*8,"center")
end

function loadGUIImgQuad(image,ox,oy)
	local imageX, imageY = image:getDimensions()
	local scale = (height/11)/imageX
	local Quad = love.graphics.newQuad( ox,oy, imageX-ox, imageY-oy, imageX, imageY)
	return scale, Quad
end

function reloadGUIImgScale(image)
	local imageX, imageY = image:getWidth()
	local scale = (height/11)/imageX
	return scale
end

function loadGUIImg(path,ox,oy)
	local image = love.graphics.newImage(path)
	local scale, Quad = loadGUIImgQuad(image,ox,oy)
	return image,scale,Quad
end

function loadImg(path,ox,oy)
	local image, _, Quad = loadGUIImg("Assets/"..path,ox,oy)
	return image,Quad
end

function reloadHeroImage()
	local tmp = {}
	for _, p in ipairs(players) do	
		table.insert(tmp,imageList[CCBlitz][p.image][1])
	end
	imageList, quadList, imageAltList, quadAltList, lifeList = loadHeroImage()
	for i, p in ipairs(players) do
		local tmpbool = false	
		p.image, tmpbool = convertToNewHero(tmp[i],p,CCBlitz)
		if tmpbool == tmp[i] then
			p.image = 1
		elseif p.image > #imageList[CCBlitz] then
			p.image = 1
		end
	end
end

function loadHeroImage()
	imageCC, altCC, imageCCQuad, altCCQuad, lifeCC = heroData:getInfo("cc", includLLheroes, false, false) 
	imageBlitz, altBlitz, imageBlitzQuad, altBlitzQuad, lifeBlitz = heroData:getInfo("blitz", includLLheroes, false, false)
	imageUPF, altUPF, imageUPFQuad, altUPFQuad, lifeUPF = heroData:getInfo("blitz", true, true, false)
	imageLL, altLL, imageLLQuad, altLLQuad, lifeLL = heroData:getInfo("cc", true, false, false)
	imageCommon, altCommon, imageCommonQuad, altCommonQuad, lifeCommon = heroData:getInfo("blitz", true, false, true)
	imageWTR, altWTR, imageWTRQuad, altWTRQuad, lifeWTR = heroData:getInfo("blitz", true, true, true, {"bravo","dori","katsu","rhinar"})
	imageARC, altARC, imageARCQuad, altARCQuad, lifeARC = heroData:getInfo("blitz", true, true, true, {"azalea","dash","kano","viserai"})
	imageMON, altMON, imageMONQuad, altMONQuad, lifeMON = heroData:getInfo("blitz", true, true, true, {"boltyn","chane","levia","prism"})
	imageELE, altELE, imageELEQuad, altELEQuad, lifeELE = heroData:getInfo("blitz", true, true, true, {"briar","lexi","oldhim"})
	imageUPR, altUPR, imageUPRQuad, altUPRQuad, lifeUPR = heroData:getInfo("blitz", true, true, true, {"dromai","fai","iyslander"})
	imageOUT, altOUT, imageOUTQuad, altOUTQuad, lifeOUT = heroData:getInfo("blitz", true, true, true, {"azalea","arakniSol","benji","katsu","riptide","uzuri"})
	imageEVO, altEVO, imageEVOQuad, altEVOQuad, lifeEVO = heroData:getInfo("blitz", true, true, true, {"dashIO","maxx","teklovossen"})
	imageHVY, altHVY, imageHVYQuad, altHVYQuad, lifeHVY = heroData:getInfo("blitz", true, true, true, {"betsy","kassaiHVY","kayoHVY","olympia","rhinar","victor"})
	imageMST, altMST, imageMSTQuad, altMSTQuad, lifeMST = heroData:getInfo("blitz", true, true, true, {"enigma","nuu","zen"})
	imageROS, altROS, imageROSQuad, altROSQuad, lifeROS = heroData:getInfo("blitz", true, true, true, {"aurora","florian","oscilio","verdance"})
	--imageHNT, altHNT, imageHNTQuad, altHNTQuad, lifeHNT = heroData:getInfo("blitz", true, true, true, {"cindra","fang"})

	imageList = {imageBlitz, imageCC, imageLL, imageUPF, imageCommon, imageWTR, imageARC, imageMON, imageELE, imageUPR, imageOUT, imageEVO, imageHVY, imageMST, imageROS}--, imageHNT}
	quadList = {imageBlitzQuad, imageCCQuad, imageLLQuad, imageUPFQuad, imageCommonQuad, imageWTRQuad, imageARCQuad, imageMONQuad, imageELEQuad, imageUPRQuad, imageOUTQuad, imageEVOQuad, imageHVYQuad, imageMSTQuad, imageROSQuad}--, imageHNTQuad}
	imageAltList = {altBlitz, altCC, altLL, altUPF, altCommon, altWTR, altARC, altMON, altELE, altUPR, altOUT, altEVO, altHVY, altMST, altROS}--, altHNT}
	quadAltList = {altBlitzQuad, altCCQuad, altLLQuad, altUPFQuad, altCommonQuad, altWTRQuad, altARCQuad, altMONQuad, altELEQuad, altUPRQuad, altOUTQuad, altEVOQuad, altHVYQuad, altMSTQuad, altROSQuad}--, altHNTQuad}
	lifeList = {lifeBlitz, lifeCC, lifeLL, lifeUPF, lifeCommon, lifeWTR, lifeARC, lifeMON, lifeELE, lifeUPR, lifeOUT, lifeEVO, lifeHVY, lifeMST, lifeROS}--, lifeHNT}

	return imageList, quadList, imageAltList, quadAltList, lifeList
end

function glowText(text, x, y, limit, align, r, sx, sy, ox, oy, kx, ky)
	love.graphics.setColor(0,0,0,1)
    love.graphics.printf(text, x-1, y-1, limit, align, r, sx, sy, ox, oy, kx, ky)
    love.graphics.printf(text, x, y-1, limit, align, r, sx, sy, ox, oy, kx, ky)
    love.graphics.printf(text, x+1, y-1, limit, align, r, sx, sy, ox, oy, kx, ky)
    love.graphics.printf(text, x-1, y, limit, align, r, sx, sy, ox, oy, kx, ky)
    love.graphics.printf(text, x+1, y, limit, align, r, sx, sy, ox, oy, kx, ky)
    love.graphics.printf(text, x-1, y+1, limit, align, r, sx, sy, ox, oy, kx, ky)
    love.graphics.printf(text, x, y+1, limit, align, r, sx, sy, ox, oy, kx, ky)
    love.graphics.printf(text, x+1, y+1, limit, align, r, sx, sy, ox, oy, kx, ky)
	love.graphics.setColor(1,1,1,1)
    love.graphics.printf(text, x, y, limit, align, r, sx, sy, ox, oy, kx, ky)
end

function addStencil(stencilFunc,stencilAction,stencilNumber,compareMode,compareValue)
	love.graphics.setStencilState(stencilAction, "always", stencilNumber)
	love.graphics.setColorMask(false)
	stencilFunc()
	love.graphics.setStencilState("keep", compareMode, compareValue)
	love.graphics.setColorMask(true)
end

function removeStencil(stencilFunc)
	love.graphics.setStencilState("replace", "always", 0)
	love.graphics.setColorMask(false)
	stencilFunc()
	love.graphics.setStencilState()
	love.graphics.setColorMask(true)
end

function stencilFunction()
	love.graphics.rectangle("fill", width/20, height/20, width/10*9, height/10*9,25,25)
end

function stencilFunctionBG()
	for _, p in ipairs(players) do
		love.graphics.rectangle("fill", p.x+width/200,p.y+width/200,p.w-width/100,p.h-width/100,25,25)
	end
end

function stencilFunctionChangeHero()
	for i = 1, 8, 1 do
		love.graphics.rectangle("fill",width/10*i,height/20*3,width/11,height/20,5,5)
	end
end

function stencilFunctionChangeHeroCurrent()
	love.graphics.rectangle("fill",width/10*noOfPlayers,height/20*3,width/11,height/20,5,5)
end

function stencilFunctionInner()
	love.graphics.rectangle("fill", width/20*2, height/20*3, width/10*8, height/20*15,25,25)
end

function stencilFunctionInner2()
	love.graphics.rectangle("fill", width/20*2, height/20*3, width/10*8, height/20*13.75,25,25)
end

function stencilFunctionSmall()
	for _, p in ipairs(players) do
		love.graphics.rectangle("fill", p.change.x,p.change.y,p.change.w,p.change.h,25,25)
	end
end

function stencilFunctionHeroes()
	local image = imageList[CCBlitz]
	for i = 1, #image, 2 do
		love.graphics.rectangle("fill",width/10+width/2*mod(i-1,2)+width/100,height/20+height/10*i+scroll+width/100,width/10*4-width/50,height/5-width/50,25,25)
		love.graphics.rectangle("fill",width/2*mod(i,2)+width/100,height/20+height/10*i+scroll+width/100,width/10*4-width/50,height/5-width/50,25,25)
	end
end

function stencilFunctionColors()
	for i = 1, #colors, 2 do
		love.graphics.rectangle("fill",width/10+width/2*mod(i-1,2)+width/100,height/20+height/10*i+scroll+width/100,width/10*4-width/50,height/5-width/50,25,25)
		love.graphics.rectangle("fill",width/2*mod(i,2)+width/100,height/20+height/10*i+scroll+width/100,width/10*4-width/50,height/5-width/50,25,25)
	end
end

function stencilFunctionMiniHeroes()
	local image = imageList[CCBlitz]
	for i = 1, #image, 2 do
		love.graphics.rectangle("fill",width/10+width/2*mod(i-1,2)+width/40,height/20+height/10*i+scroll+height/80,width/10, width/10,15,15)
		love.graphics.rectangle("fill",width/2*mod(i,2)+width/40,height/20+height/10*i+scroll+height/80,width/10, width/10,15,15)
	end
end

function stencilFunctionHeroAlts()
	love.graphics.rectangle("fill", width/40*3,height/40*3, width/17.5, height/45,5,5)
	love.graphics.rectangle("fill", width/40*3+width/25,height/40*4, width/17.5, height/45,5,5)
end

function stencilFunctionGames()
	local files = getGameFiles()
	for i = 1, #files, 1 do
		love.graphics.rectangle("fill",width/20*3,height/22*(2+i*2)+scroll,width/20*14,height/12,25,25)
	end
end

function stencilFunctionGames2()
	local files = getGameFiles()
	for i = 1, #files, 1 do
		local gap = 1
		local move = 0
		if noOfPlayers == 1 then
			move = 3.5
		elseif noOfPlayers == 2 then
			gap = 3
		elseif noOfPlayers == 3 then
			gap = 2
			move = 0.5
		elseif noOfPlayers == 4 then
			gap = 1.5
		move = 0.75
		elseif noOfPlayers == 5 then
			move = 1.5
		elseif noOfPlayers == 6 then
			move = 1
		elseif noOfPlayers == 7 then
			move = 0.4375
		end
		for p = 1, noOfPlayers do
			love.graphics.rectangle("fill",width/7+(width/15)*(1+(1.25*((p*gap+move)-1.5))),height/22*(2+i*2)+height/30+scroll, width/15, width/15,5,5)
		end
	end
end

function stencilFunctionGames3()
	local move = 0
	local gap = 1
	if noOfPlayers == 1 then
		move = 2
	elseif noOfPlayers == 2 then
		gap = 2
	elseif noOfPlayers == 3 or noOfPlayers == 6 then
		move = 1
	elseif noOfPlayers == 4 then
		move = 0.5
	elseif noOfPlayers == 7 then
		move = 0.4375
	end
	if noOfPlayers <= 5 then
		for p = 1, noOfPlayers, 1 do
			love.graphics.rectangle("fill",width/12+(width/8)*(1+(1.25*((p*gap+move)-1.5))),height/80*13, width/8, width/8,5,5)
		end
	else
		for p = 1, noOfPlayers, 1 do
			love.graphics.rectangle("fill",width/8+(width/10.5)*((p*gap+move)-1),height/80*13, width/12, width/12,5,5)
		end
	end
end

function stencilFunctionDemi()
	for i, p in ipairs(players) do
		if i == 1 then 
			love.graphics.rectangle("fill",p.x+p.w/6*5,p.y+p.h/6*5,p.w/6,p.h/6,25,25)
			love.graphics.rectangle("fill",p.x,p.y+p.h/6*5,p.w/6,p.h/6,25,25)
		else
			love.graphics.rectangle("fill",p.x,p.y,p.w/6,p.h/6,25,25)
			love.graphics.rectangle("fill",p.x+p.w/6*5,p.y,p.w/6,p.h/6,25,25)
		end
	end
end

function saveFirebase()
	local data = {}
	table.insert(data,fb.refreshToken)
	love.filesystem.write("firebase.txt", table.concat(data,"\n"))
end

function loadFirebase()
    if not love.filesystem.getInfo("firebase.txt") then
        saveFirebase()
    end
	fb.refreshToken = love.filesystem.read("firebase.txt")
end

function saveSettings()
	if #players == 1 then
		local data = {}
		if players[1].image > #imageList[CCBlitz] then
			table.insert(data,imageList[CCBlitz][1][1])
			table.insert(data,imageList[CCBlitz][1][1])
		else
			table.insert(data,imageList[CCBlitz][players[1].image][1])
			table.insert(data,imageList[CCBlitz][players[1].image][1])
		end
		table.insert(data,CCBlitz)
		table.insert(data,bool_to_number(rotatedImage))
		table.insert(data,bool_to_number(showPlusMinus))
		table.insert(data,bool_to_number(showHeroArt))
		table.insert(data,bool_to_number(showTimer))
		table.insert(data,bool_to_number(players[1].altHeroArt))
		table.insert(data,bool_to_number(players[1].altHeroArt))
		table.insert(data,bool_to_number(rotPlusMinus))
		table.insert(data,bool_to_number(henrikMode))
		table.insert(data,bool_to_number(darkMode))
		table.insert(data,bool_to_number(autoResetLife))
		table.insert(data,bool_to_number(biggerTimer))
		table.insert(data,bool_to_number(timer55))
		table.insert(data,bool_to_number(showDemiHero))
		table.insert(data,bool_to_number(includLLheroes))
		love.filesystem.write("settings.txt", table.concat(data,"\n"))
	else
		local data = {}
		if players[1].image > #imageList[CCBlitz] then
			table.insert(data,imageList[CCBlitz][1][1])
		else
			table.insert(data,imageList[CCBlitz][players[1].image][1])
		end
		if players[2].image > #imageList[CCBlitz] then
			table.insert(data,imageList[CCBlitz][1][1])
		else
			table.insert(data,imageList[CCBlitz][players[2].image][1])
		end
		table.insert(data,CCBlitz)
		table.insert(data,bool_to_number(rotatedImage))
		table.insert(data,bool_to_number(showPlusMinus))
		table.insert(data,bool_to_number(showHeroArt))
		table.insert(data,bool_to_number(showTimer))
		table.insert(data,bool_to_number(players[1].altHeroArt))
		table.insert(data,bool_to_number(players[2].altHeroArt))
		table.insert(data,bool_to_number(rotPlusMinus))
		table.insert(data,bool_to_number(henrikMode))
		table.insert(data,bool_to_number(darkMode))
		table.insert(data,bool_to_number(autoResetLife))
		table.insert(data,bool_to_number(biggerTimer))
		table.insert(data,bool_to_number(timer55))
		table.insert(data,bool_to_number(showDemiHero))
		table.insert(data,bool_to_number(includLLheroes))
		table.insert(data,bool_to_number(flipImage))
		love.filesystem.write("settings.txt", table.concat(data,"\n"))
	end
end

function loadSettings()
    if not love.filesystem.getInfo("settings.txt") then
        saveSettings()
    end

	local data = {}
	for line in love.filesystem.lines("settings.txt") do
		table.insert(data,line) 
	end

	CCBlitz = tonumber(data[3])
	if noOfPlayers ~= 1 then
		for k,v in pairs(imageList[CCBlitz]) do
			if data[2] == v[1] then
				players[2].image = k
				break
			end
		 end
		players[2].altHeroArt = number_to_bool(data[9],players[2].altHeroArt)
	end

	for k,v in pairs(imageList[CCBlitz]) do
		if data[1] == v[1] then
			players[1].image = k
			break
		end
	 end
	rotatedImage = number_to_bool(data[4],rotatedImage)
	showPlusMinus = number_to_bool(data[5],showPlusMinus)
	showHeroArt = number_to_bool(data[6],showHeroArt)
	showTimer = number_to_bool(data[7],showTimer)
	players[1].altHeroArt = number_to_bool(data[8],players[1].altHeroArt)
	rotPlusMinus = number_to_bool(data[10],rotPlusMinus)
	henrikMode = number_to_bool(data[11],henrikMode)
	darkMode = number_to_bool(data[12],darkMode)
	autoResetLife = number_to_bool(data[13],autoResetLife)
	biggerTimer = number_to_bool(data[14],biggerTimer)
	timer55 = number_to_bool(data[15],timer55)
	showDemiHero = number_to_bool(data[16],showDemiHero)
	includLLheroes = number_to_bool(data[17],includLLheroes)
	flipImage = number_to_bool(data[18],flipImage)
end

function saveGame()
	local chars = {"A","B","C","D","E","F","G","H","I","J","K","L","M"}
	local data = {}
	table.insert(data, CCBlitz.."Ö")
	for p = 1, noOfPlayers, 1 do
		table.insert(data, players[p].image..chars[p])
		table.insert(data, bool_to_number(players[p].altHeroArt)..chars[p])
		local localColor = getPlayerColor(players[p])
		table.insert(data, localColor[1]..localColor[2]..localColor[3]..chars[p])
		for i = 1, #players[p].lifeHistory, 1 do
			table.insert(data, players[p].lifeHistory[i]..chars[p])
		end
	end
	love.filesystem.write("game"..os.date("%Y-%m-%d_%H%M%S")..".txt", table.concat(data,"\n"))
end

function getGameFiles()
	local files = love.filesystem.getDirectoryItems("")
	table.sort(files, function (a,b) return a > b end)
	local tempfiles = {}
	for k, file in ipairs(files) do
		if string.find(file,"game") and love.filesystem.getInfo(file) then
			table.insert(tempfiles,file)
		end
	end
	return tempfiles
end

function deleteGameFiles(filename)
	if love.filesystem.getInfo(filename) then
		love.filesystem.remove(filename)
	end
end

function loadGame(filename)
	local data = {}
	for line in love.filesystem.lines(filename) do
		table.insert(data,line) 
	end
	local chars = {"A","B","C","D","E","F","G","H","I","J","K","L","M"}
	local lifeHistory = {}
	local loadedPlayers = {}
	local loadedNoPlayer = 1
	local loadedCCBlitz = 1
	local i = 4

	if string.find(data[1],"Ö") then
		loadedCCBlitz = tonumber(string.sub(data[1],0, string.find(data[1],"Ö")-1))
		i = 5
	end

	table.insert(loadedPlayers,{image=tonumber(string.sub(data[i-3],0, string.find(data[i-3],chars[loadedNoPlayer])-1))})
	loadedPlayers[loadedNoPlayer].altHeroArt=tonumber(number_to_bool(string.sub(data[i-2],0, string.find(data[i-2],chars[loadedNoPlayer])-1),0))
	loadedPlayers[loadedNoPlayer].color=string.sub(data[i-1],0, string.find(data[i-1],chars[loadedNoPlayer])-1)

	
	while i <= #data do
		if not string.find(data[i],chars[loadedNoPlayer]) then
			loadedPlayers[loadedNoPlayer].lifeHistory = {}
			loadedPlayers[loadedNoPlayer].lifeHistory = lifeHistory
			lifeHistory = {}
			loadedNoPlayer = loadedNoPlayer + 1
			if loadedNoPlayer > #chars then
				break
			end
			table.insert(loadedPlayers,{image=tonumber(string.sub(data[i],0, string.find(data[i],chars[loadedNoPlayer])-1))})
			loadedPlayers[loadedNoPlayer].altHeroArt=tonumber(number_to_bool(string.sub(data[i+1],0, string.find(data[i+1],chars[loadedNoPlayer])-1),0))
			loadedPlayers[loadedNoPlayer].color=string.sub(data[i+2],0, string.find(data[i+2],chars[loadedNoPlayer])-1)
			i = i + 3
		else
			table.insert(lifeHistory,string.sub(data[i],0, string.find(data[i],chars[loadedNoPlayer])-1))
			i = i + 1
		end
	end
	loadedPlayers[loadedNoPlayer].lifeHistory = {}
	loadedPlayers[loadedNoPlayer].lifeHistory = lifeHistory
	
	return loadedPlayers, loadedCCBlitz
end

function disp_time(time)
	local minutes = math.floor(mod(time,3600)/60)
	local seconds = math.floor(mod(time,60))
	if (minutes < 10) then
		minutes = "0" .. tostring(minutes)
	end
	if (seconds < 10) then
		seconds = "0" .. tostring(seconds)
	end
	return minutes..':'..seconds
end

function bool_to_number(value)
	return value and 1 or 0
end

function number_to_bool(value,default)
	if value == "1" then
		return true
	elseif value == "0" then
		return false
	end
	return default
end

function mod(a,b)
	return a-math.floor(a/b)*b
end

function imageRotate(p)
	if p.r == 0 then
		return p
	elseif p.r == math.pi/2 then
		return {x=p.x+p.w,y=p.y,w=p.w,h=p.h,r=p.r,image=p.image,altHeroArt=p.altHeroArt}
	elseif p.r == math.pi then
		return {x=p.x+p.w,y=p.y+p.h,w=p.w,h=p.h,r=p.r,image=p.image,altHeroArt=p.altHeroArt}
	elseif p.r == math.pi*1.5 then
		return {x=p.x,y=p.y+p.h,w=p.w,h=p.h,r=p.r,image=p.image,altHeroArt=p.altHeroArt}
	end
	return p
end

function notNil(list)
	for n = 1, #list, 1 do
		if list[n][2] ~= false then
			return n
		end
	end
	return -1
end

function getMaxLifeHistory(playerlist)
	local maxLifeHistory = 0
	for p = 1, #playerlist, 1 do
		if maxLifeHistory < #playerlist[p].lifeHistory then
			maxLifeHistory = #playerlist[p].lifeHistory
		end
	end
	return maxLifeHistory
end

function blackIfFalse(aBool)
	if aBool == false then
		love.graphics.setColor(0,0,0,1)
	else
		love.graphics.setColor(1,1,1,1)
	end
end

function fadeLineX(p,xStart,xEnd)
	colorA = 1
	for i = xStart, xEnd, (xEnd-xStart)/100  do
		love.graphics.setColor(1,1,1,colorA)
		love.graphics.line(p.x+i,p.y+p.h/2,p.x+i+(xEnd-xStart)/100,p.y+p.h/2)
		colorA = colorA - 0.01
		if i > xEnd and xEnd-xStart > 0 then
			break
		elseif i < xEnd and xEnd-xStart < 0 then
			break
		end
	end
end

function fadeLineY(p,yStart,yEnd)
	colorA = 1
	for i = yStart, yEnd, (yEnd-yStart)/100  do
		love.graphics.setColor(1,1,1,colorA)
		love.graphics.line(p.x+p.w/2,p.y+i,p.x+p.w/2,p.y+i+(yEnd-yStart)/100)
		colorA = colorA - 0.01
		if i > yEnd and yEnd-yStart > 0 then
			break
		elseif i < yEnd and yEnd-yStart < 0 then
			break
		end
	end
end

function fadeLineXMid(p,xStart,xEnd,yHight)
	colorA = 1
	for i = xStart, xEnd, (xEnd-xStart)/1000  do
		love.graphics.setColor(1,1,1,1-math.abs(colorA))
		love.graphics.line(p.x+i,p.y+yHight,p.x+i+(xEnd-xStart)/100,p.y+yHight)
		colorA = colorA - 0.002
		if i > xEnd and xEnd-xStart > 0 then
			break
		elseif i < xEnd and xEnd-xStart < 0 then
			break
		end
	end
end

function fadeLineYMid(p,yStart,yEnd,xHight)
	colorA = 1
	for i = yStart, yEnd, (yEnd-yStart)/1000  do
		love.graphics.setColor(1,1,1,1-math.abs(colorA))
		love.graphics.line(p.x+xHight,p.y+i,p.x+xHight,p.y+i+(yEnd-yStart)/100)
		colorA = colorA - 0.002
		if i > yEnd and yEnd-yStart > 0 then
			break
		elseif i < yEnd and yEnd-yStart < 0 then
			break
		end
	end
end

function getPlayerColor(p)
	if p.image <= #colors then
		return colors[p.image]
	end
	return colors[1]
end

function CCBlitzToBool(value)
	if CCBlitz == value then
		return true
	elseif CCBlitz >= 6 and value == 99 then
		return true
	else
		return false
	end
end

function comapreValues(value, newValue)
	if value == newValue then
		return trueupdateCCBlit
	else
		return false
	end
end

function updateformatVisuals(newValue)
	if newValue == formatVisuals then
		return newValue
	elseif newValue == 1 then
		if formatVisuals == 2 then
			formatButton:updateStatus(true)
			gameButton:updateStatus(false)
		else
			formatButton:updateStatus(true)
			visualsButton:updateStatus(false)
		end
	elseif newValue == 2 then
		if formatVisuals == 1 then
			formatButton:updateStatus(false)
			gameButton:updateStatus(true)
		else
			gameButton:updateStatus(true)
			visualsButton:updateStatus(false)
		end
	else
		if formatVisuals == 1 then
			formatButton:updateStatus(false)
			visualsButton:updateStatus(true)
		else
			gameButton:updateStatus(false)
			visualsButton:updateStatus(true)
		end
	end
	return newValue
end

function updateCCBlitz(newValue)
	if newValue == CCBlitz then
		return
	else
		blitzButton:updateStatus(comapreValues(1, newValue))
		ccButton:updateStatus(comapreValues(2, newValue))
		llButton:updateStatus(comapreValues(3, newValue))
		upfButton:updateStatus(comapreValues(4, newValue))
		commonerButton:updateStatus(comapreValues(5, newValue))
		limitedWTRButton:updateStatus(comapreValues(6, newValue))
		limitedARCButton:updateStatus(comapreValues(7, newValue))
		limitedMONButton:updateStatus(comapreValues(8, newValue))
		limitedELEButton:updateStatus(comapreValues(9, newValue))
		limitedUPRButton:updateStatus(comapreValues(10, newValue))
		limitedOUTButton:updateStatus(comapreValues(11, newValue))
		limitedEVOButton:updateStatus(comapreValues(12, newValue))
		limitedHVYButton:updateStatus(comapreValues(13, newValue))
		limitedMSTButton:updateStatus(comapreValues(14, newValue))
		limitedROSButton:updateStatus(comapreValues(15, newValue))
		--limitedHNTButton:updateStatus(comapreValues(16, newValue))

		if newValue >= 6  and newValue <= 99 then
			limitedButton:updateStatus(true)
		else
			limitedButton:updateStatus(false)
		end
	end
end

function timer50to55(newTimer)
	timer55 = newTimer
	local timeCC = 3000 
	local timeBlitz = 1800
	local timeUPF = 3600 
	if timer55 == true then
		timeCC = 3300 
		timeBlitz = 2100
		timeUPF = 3600 
	end
	tmp_list = {timeBlitz, timeCC, timeCC, timeUPF, timeBlitz, timeBlitz, timeBlitz, timeBlitz, timeBlitz, timeBlitz, timeBlitz, timeBlitz, timeBlitz}
	if #imageList > #tmp_list then
		for i = 1, #imageList - #tmp_list, 1 do
			table.insert(tmp_list,timeBlitz)
		end
	end
	return tmp_list
end

function updateScroll()
	if scroll > 0 then
		scroll = 0
	elseif viewLimited == true then
		if scroll < height/20*17.75-limitedWTRButton.y-limitedWTRButton.h then
			scroll = height/20*17.75-limitedWTRButton.y-limitedWTRButton.h
		end
	elseif changeHeroId ~= -1 then
		if not showHeroArt then 
			if scroll < -height/5*(math.ceil(#colors/2)-3.75) then
				scroll =  -height/5*(math.ceil(#colors/2)-3.75)
			end
		elseif CCBlitz >= 6 then --Om mindre än 8 hjältar så måste denna sättas Limited
			scroll = 0
		elseif scroll < -height/5*(math.ceil(#imageList[CCBlitz]/2)-3.75) then
			scroll =  -height/5*(math.ceil(#imageList[CCBlitz]/2)-3.75)
		end
	elseif opencombatlog == true and scroll < -height/30*(getMaxLifeHistory(players)-25) then 
		if getMaxLifeHistory(players) < 25 then
			scroll = 0
		else
			scroll = -height/30*(getMaxLifeHistory(players)-25)
		end
	elseif currentLog ~= "" and viewLogs == true then
		local loadedPlayers = loadGame(currentLog)
		if viewLogs == true and scroll < -height/30*(getMaxLifeHistory(loadedPlayers)-25) then 
			if getMaxLifeHistory(loadedPlayers) < 25 then
				scroll = 0
			else
				scroll = -height/30*(getMaxLifeHistory(loadedPlayers)-25)
			end
		end
	elseif currentLog == "" and viewLogs == true then
		local files = getGameFiles()
		if -height/22*(2+#files*2)+height/20*14 > 0 or #files <= 7 then
			scroll = 0
		elseif viewLogs == true and scroll < -height/22*(2+#files*2)+height/20*14 then 
			scroll = -height/22*(2+#files*2)+height/20*14
		end
	end
end