--$Name: theme.vvb.goraf.game$
--$Author: jmaks$
--$Version: 0.1$

instead_version "1.8.2";

game.codepage = "UTF-8";
game.act = "Не получается.";
game.inv = "Гм... Странная штука.";
game.use = "Не сработает...";

require "dbg"
require "dash"
require "quotes"
require "para"
-- require "nolife"
-- require "format"
-- require "click"
-- require "prefs"
-- require "counters"
-- require "wroom"
-- require "nolife"
-- require "proxymenu"
-- require "hotkeys"
-- require "fonts"
-- require "snapshots"
-- requrie "trigger"
-- require "keyboard"
-- require "cutscene"
-- require "kbd"
-- require "hideinv"
-- require "nouse"
-- require "timer"
-- require "xact"
-- require "sprites"
-- require "sound"
-- require "theme"


dofile ('parser/metaparser.lua');
input.cursor = img 'theme/cursor.gif';
morph.debug = true;
parser.cmd_history = true;
parser.empty_warning = '?';
parser.hintinv = true;
morph.yo = true;
--morph:init ('main.lua', 'rooms.lua', 'items.lua', 'npc.lua');
morph:init ('main.lua');
--me().person = 2;
--me().plural = true;

parser.err_filter = false;

game.verbs = {};
parser.verb.Close();
parser.verb.Drop();
parser.verb.Exam();
parser.verb.Give();
parser.verb.Inventory();
parser.verb.Pull();
parser.verb.Put();
parser.verb.Read();
parser.verb.Search();
parser.verb.Take();
parser.verb.Wait();
parser.verb.Walk();
--parser.verb.Tie();

--parser.hideverbs = true; -- если прятать глаголы


-- dofile ('globals.lua');
-- dofile ('rooms.lua');
-- dofile ('items.lua');
-- dofile ('npc.lua');
-- dofile ('verbs.lua');

main = room { nam = "Тестовая комната",
    var {
        -- some room vars
    },
    enter = function(s, f)
        return -- enter doings ;
    end,
    --~ pic = './gfx/back.png',
    --~ xdsc = ' -- xroom description ',
    dsc = [[ На данный момент эта комната создана для тестов, отладки и
    настройки отображения общих параметров оформления. ]],
    act = function(s, w)
        return true;-- some acts;
    end,
    obj = {
        -- some objs,
        'tobj',
        vobj('null', 'В данной комнате лежит null и тест.')
    },
    way = {
        -- some ways,
    },
    exit = function(s, t)
        return    -- exit doings ;
    end,
};

tobj = obj
{
    nam = _'тест',
    Exam = function (s)
            p [[ v.v.b. можешь использовать эту тему на свое усмотрение, считай
            все авторские права, а еже с ними ответственность, переходит тебе
            как собственность... И еще так как тема делалась для только
            запланированной игры-ремейка, то довольно
            сложно спрогнозировать, получится из этого хоть что-то приемлимое,
            но в любом случае, благодарю за внимание. ]];
    end,
};

