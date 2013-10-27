global
{
    Weapon = 0,
    MaxWeapon = 5,
    Score = 0,
    MaxScore = 16,
    ScoreEffect = false,
    topics = {};
};

--global { topics = {}}

instead.get_title = function(s)
    local scene = stead.dispof(stead.here());
    if type(scene) ~= 'string' then
        scene = ''
    end
    return txtb(txtu(txtnb(scene))..txttab("100%", "right")..txtu(txtnb(tostring(Score)..'/'..tostring(stead.time()))) )
end


show_topics = function(s)
    local k,v
    local rc=''
    for k,v in pairs (topics) do
        rc = rc..v..'|';
--        print(v, rc)
    end
--    print(rc)
    return rc
end


function add_topic(w)
--    local n = "{"..stead.deref(w).."}пр"
    local n = parser:morph(w, "пр");
    topics[n] = n;
--    print("Добавлено: ", n)
end

function match_topic(w, txt)
    local n = tolow(parser:morph(w, "пр"));
    local rc = false
    if not txt then return false end
    n:gsub("[^|]+", function(s) 
        local os = s:gsub("^[ \t]+","")
        if os:find("^~") then
            os = os:gsub("^~", "")
        end
        if txt == tolow(os) then
            rc = true
            return
        end
    end)
    return rc
end

