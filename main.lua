CURRENTSCENE = "momscreen"
CURRENTSTATE = "PHONE"
--print = function() end
pprint = require 'lib.pprint'

require 'helpers.core_funcs'
require 'inputoutput.keyboard_input'
require 'inputoutput.click'
SCENES = {momscreen = require 'scenes.schoolscenes.momcall', test = require 'scenes.test.testscene'}
GIRLS = {}
GAME = {}
DRAWSCENE = function() end
DRAWGIRL  = function() end
Gamestate = require 'lib.gamestate'


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


end
