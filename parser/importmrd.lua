#!/usr/local/bin/lua-5.1

local rulower = {
	['А'] = 'а',
	['Б'] = 'б',
	['В'] = 'в',
	['Г'] = 'г',
	['Д'] = 'д',
	['Е'] = 'е',
	['Ё'] = 'ё',
	['Ж'] = 'ж',
	['З'] = 'з',
	['И'] = 'и',
	['Й'] = 'й',
	['К'] = 'к',
	['Л'] = 'л',
	['М'] = 'м',
	['Н'] = 'н',
	['О'] = 'о',
	['П'] = 'п',
	['Р'] = 'р',
	['С'] = 'с',
	['Т'] = 'т',
	['У'] = 'у',
	['Ф'] = 'ф',
	['Х'] = 'х',
	['Ц'] = 'ц',
	['Ч'] = 'ч',
	['Ш'] = 'ш',
	['Щ'] = 'щ',
	['Ъ'] = 'ъ',
	['Э'] = 'э',
	['Ь'] = 'ь',
	['Ю'] = 'ю',
	['Я'] = 'я',
	['Ы'] = 'ы',
}
local function tolow(s)
	if not s then
		return
	end
	s = s:lower();
	s = s:gsub("[^a-zA-Z0-9.%-%%%#%*][^a-zA-Z0-9.%-%%%#%*]", rulower)
	return s;
end

local function gramtab(fname)
	local file = io.open(fname, "r")
	local line
	local v = { }
	if not file then
		return
	end
	local function parse_line(s)
		local v = {}
		s:gsub("[^ \t]+", function(s)
			table.insert(v, s)
		end)
		return v
	end
	local function parse_attr(s)
		local v = {}
		v.weight = 9
		s:gsub("[^,]+", function(s)
			if s == 'мр' then
				v.male = true
			elseif tonumber(s) then
				v.secondary = true
			elseif s == 'жр' then
				v.female = true
			elseif s == 'мр-жр' then
				v.male = true
				v.female = true
			elseif s == 'од' then
				v.live = true
			elseif s == 'но' then
				v.live = false
			elseif s == 'ср' then
				v.neuter = true
			elseif s == 'ед' then
				v.singular = true
			elseif s == 'мн' then
				v.plural = true
			elseif s == 'им' then
				v.nom = true
				v.weight = 1
			elseif s == 'рд' then
				v.gen = true
				if v.weight > 2 then
					v.weight = 2
				end
			elseif s == 'дт' then
				v.dat = true
				if v.weight > 3 then
					v.weight = 3
				end
			elseif s == 'вн' then
				v.acc = true
				if v.weight > 4 then
					v.weight = 4
				end
			elseif s == 'тв' then
				v.ins = true
				if v.weight > 5 then
					v.weight = 5
				end
			elseif s == 'пр' then
				v.loc = true
				if v.weight > 6 then
					v.weight = 6
				end
			elseif s == 'зв' then
				v.ask = true
				if v.weight > 7 then
					v.weight = 7
				end
			end
		end)
		return v
	end
	for line in file:lines() do
		line = line:gsub("^[ \t]+",""):gsub("[ \t]+$", "");
		if not line:find("^//") and line ~= '' then
			local l = parse_line(line)
--			if l[3] == 'С' or l[3] == 'П' then
			if l[4] then
				v[l[1]] = parse_attr(l[4])
				v[l[1]].type = l[3]
			end
		end
		table.insert(grams, line)
	end
	file:close()
	return v
end

function paradigms(line, gtab, low)
	local v = {}
	line:gsub("%%[^%%]+", function(s)
		local vx = { }
		s = s:sub(2); -- skip leading % -- gsub("^%%", "");
		local vv = {}
		local a = s:find("*", 1, true)
		if a == 1 then
			table.insert(vv, '')
		end
		s:gsub("[^*]+", function(s)
			table.insert(vv, s);
		end)
		vx.suffix = vv[1]
		vx.prefix = vv[3]
		if low then
			vx.suffix = tolow(vx.suffix)
			vx.prefix = tolow(vx.prefix)
		end
		vx.code = vv[2]
		vx.grammar = gtab[vv[2]]
		if vx.suffix == '' then vx.suffix = nil end
		if vx.prefix == '' then vx.prefix = nil end
		local t = gtab[vx.code]
		if t then
			table.insert(v, vx)
		end
	end)
	return v
end
function words(s, gtab, para, prist)
	local v = {}
	s:gsub("[^ \t]+", function(s)
		table.insert(v, s)
	end)
	local p = para[v[2] + 1]
	if p and not p.deleted then
		i = ' '..v[5]
		if tonumber(v[6]) then
			i = i..' '..v[6]
		end
		print(v[1]..' '..tostring(p.num)..' '..v[3]..i)
	end
end

function sort_paradigm(p)
	local k, v
	local rc = ''
--	table.sort(p, function(a, b)
--		return a.grammar.weight < b.grammar.weight
--	end)

	for k,v in ipairs(p) do
		local a, b, c
		a = v.prefix
		b = v.code
		c = v.suffix
		if not a then 
			a = '' 
		else
			a = ':'..a
		end
		if not c then 
			c = '' 
		else
			c = ':'..c
		end
		if rc ~= '' then
			rc = rc..' '
		end

		if a == '' and v.grammar.weight < 9 then
--		or (v.male ~= nile or v.female ~= nil or v.neuter ~= nil or v.live ~= nil or v.plural ~= nil or v.singular ~= nil) then
			rc = rc..b..c..a
		else
			rc = rc..'-'
		end
	end
	if rc == '' then
		p.deleted = true
	else
		p.output = rc
	end
end


function renum_paradigms(para)
	local k,v
	local nn = 0
	for k,v in ipairs(para) do
		sort_paradigm(v)
		if not v.deleted then
			v.num = nn
			nn = nn + 1
		end
	end
	print(nn)
	for k,v in ipairs(para) do
		if not v.deleted then
			print(v.output)
		end
	end
end

function mrd(fname, gtab)
	local file = io.open(fname, "r")
	local line
	local v = { }
	local toc = { }
	local para = { }
	local state = 1
	local n_par = -1
	local n_accpar = -1
	local n_hist = -1
	local n_prist = -1
	local n_words = -1
	local prist = {}
	if not file then
		return
	end
	for line in file:lines() do
		if not toc[state] then
			toc[state]  = tonumber(line)
			if state == 2 then
				renum_paradigms(para)
			end
			if state == 4 or state == 2 then
				print(toc[state])
			end

		else
			if state == 1 then
				--line = tolow(line)
				local p = paradigms(line, gtab, true)
				table.insert(para, p)
--				flush_paradigm(p)
--				print(line)
			elseif state == 2 then
				local v = line:gsub(";"," "):gsub("[ \t]+$", "")
				print(v)
			elseif state == 4 then
				line = tolow(line)
				table.insert(prist, line)
				print(line)
			elseif state == 5 then
				line = tolow(line)
				words(line, gtab, para, prist)
			end
			toc[state] = toc[state] - 1
			if toc[state] <= 0 then
				state = state + 1
				if state > 5 then
					break
				end
			end
		end
	end
	file:close()
end

function load_para(fname, gtab)
	local file = io.open(fname, "r")
	local para = {}
	for line in file:lines() do
		table.insert(para, paradigms(line, gtab))
	end
	file:close()
	return para
end
function split(str, delim)
	local r = {}
	local s, e, os
	s = 1 
	os = 1
	while true do
		s,e = str:find(delim, s, true)
		if s then
			table.insert(r, str:sub(os, s - 1))
		else
			local a = str:sub(os)
			if a ~= '' then
				table.insert(r, a)
			end
			break
		end
		s = e + 1
		os = e + 1
	end
	return r
end
grams = {}
gtab = gramtab 'rgramtab.tab'
print(#grams)
for k,v in ipairs(grams) do
	print(v)
end
mrd('morphs.mrd', gtab)
