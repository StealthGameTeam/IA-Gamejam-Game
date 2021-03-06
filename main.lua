Gamestate = require 'lib.gamestate'
ANDROID = true
CURRENTSCENE = "momscreen"
CURRENTSTATE = "PHONE"
--print = function() end
pprint = require 'lib.pprint'
require 'lib.TEsound'
local SS = {}
SS[#SS+1] = "assets/batfail.mp3"
SS[#SS+1] = "assets/hedfail.mp3"
SS[#SS+1] = "assets/ltrfail.mp3"
SS[#SS+1] ="assets/pirfail1.mp3"
SS[#SS+1] = "assets/pirfail2.mp3"
SS[#SS+1] ="assets/whifail.mp3"
MUSIC = TEsound.playLooping("assets/battle_music.mp3", {"music"})
interruptMusicToPlayFail = function(name)
	return function()
		TEsound.volume("music", 0)
		TEsound.stop("EFF")
		print(name)
		TEsound.play(name, {"EFF"}, 1, 1, core.PreFill(TEsound.volume, "music", 1))
	end
end
local FS = 1
RANDOMFAIL = function()
	FS = (FS%(#SS)) + 1
	return interruptMusicToPlayFail(SS[FS])
end
require 'helpers.core_funcs'
require 'inputoutput.keyboard_input'
require 'inputoutput.click'
function POPBACK ()
	
	IGNORE_THIS_ROUND = true
	core.events = {}
	core.clicks = {}
	print("POP")
	RANDOMFAIL()()
	Gamestate.pop()
	ready_between()
	
end
SCENES = {momscreen = require 'scenes.schoolscenes.momcall',
	test = require 'scenes.test.testscene',
	populargirl1 = require 'scenes.schoolscenes.populargirl1',
	busstopgirlday1 = require 'scenes.schoolscenes.busstopgirlday1',
	librarygirlday1 = require 'scenes.schoolscenes.librarygirlday1',
	room = require 'scenes.room.room',
	leiaposter = require 'scenes.room.leiaposter'
}
GIRLS = {}
GAME = {}
DAY = 1
DAYPART = 3
DRAWSCENE = function() end
DRAWGIRL  = function() end


function love.load()
    Gamestate.registerEvents()
 	Gamestate.switch(require 'states.1_pre_game')
 	

end
function love.draw()
	love.graphics.print(love.timer.getFPS(), 10,10)
	love.graphics.print(collectgarbage('count'), 50,10)
end

function reverse(map)
	return fun.foldl(function(acc, x) return fun.op.insert(acc, map[x], x) end, {},  fun.op.keys(map))
end
function love.update(dt)
	--- Events
	TEsound.cleanup()
end

scale = function()
	if ANDROID then
		local width = love.graphics.getWidth()
		local height = love.graphics.getHeight()
		love.graphics.scale(width/720, height/960)
		-- print("Scaled to:" .. width/720 .. " : " .. height/960)
	end
end

convert = function (poly)
	local vertices = {}
	for i,v in ipairs(poly) do
		vertices[#vertices+1] = v['x']
		vertices[#vertices+1] = v['y']
	end
	return vertices
end

convert_poly = function (poly)
	local new_poly = {}
	for i,v in ipairs(poly) do
		new_poly[#new_poly+1] = {x = v.x*(love.graphics.getWidth()/720), y = v.y*(love.graphics.getHeight()/960)}
	end
	return new_poly
end