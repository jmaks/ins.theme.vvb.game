dofile "morph.lua"
word_pattern = "[^ \t,.?!:-]+"
words_num = 0
function make_dict(fname, words)
	local file = io.open(fname, "r")
	if not file then
		return false
	end
	local line
	for line in file:lines() do
		line:gsub("'([^']+)'", function(s)
			s:gsub(word_pattern, function(s)
				words[s] = true;
				words_num = words_num + 1
			end)
		end)
	end
	file:close()
	return true
end

function morph_load(fname, para)
	local file = io.open(fname, "r")
	local line
	local db = {}
	local npara
	local npre
	for line in file:lines() do
		if not npara then 
			npara = tonumber(line) 
		else
			table.insert(para, paradigms(line, gtab))
			npara = npara - 1
			if npara == 0 then break end
		end
	end

	for line in file:lines() do
		if not npre then 
			npre = tonumber(line) 
		else
			npre = npre - 1
			if npre == 0 then break end
		end
	end

	for line in file:lines() do
		local v = {};
		line:gsub("[^ \t]+", function(s)
			table.insert(v, s)
		end)
		local b = v[1]
		if b == '#' then b = '' end
		local p = tonumber(v[2])
		local k, v
		p = para[p + 1]
		if p then
			for k,v in ipairs(p) do
				local g = v.grammar
				local s = v.suffix
				if not s then s = '' end
				if g and s then
					if s == '#' then s = '' end
					if g.nom then
						s = b..s
						if not db[s] then
							if words[s] then
								db[s] = { b, p, g }
								words_num = words_num - 1
								if words_num == 0 then
									file:clse()
									return db
								end
								print(s)
							end
						end
					end
				end
			end
		end
	end
	file:close()
	return db
end

function do_morph(db, word, n)
--	if n == 1 then
--		return word
--	end
	ww = word:gsub("[^ \t-]+", function(w)
		local s = db[w]
		local ww
		if s then
			local b = s[1]
			local p = s[2]
			local g = s[3]
			local post = ''
			local k, v
			for k,v in ipairs(p) do
				if v.grammar.male == g.male and v.grammar.female == g.female and
					v.grammar.neuter == v.neuter and v.grammar.plural == g.plural
					and v.grammar.singular == g.singular then
					if v.grammar.nom and n == 1 then
						post = v.suffix
						break
					elseif v.grammar.gen and n == 2 then
						post = v.suffix
						break
					elseif v.grammar.dat and n == 3 then
						post = v.suffix
						break
					elseif v.grammar.acc and n == 4 then
						post = v.suffix
						break
					elseif v.grammar.ins and n == 5 then
						post = v.suffix
						break
					elseif v.grammar.loc and n == 6 then
						post = v.suffix
						break
					end
				end
			end
			ww = b..post;
		else
			ww = w;
		end
		return ww
	end)
	return ww
end


words = {}
make_dict ('main.lua', words)

gtab = gramtab 'rgramtab.tab'
para = {}
--para = load_para ('paradigm.txt', gtab)
db = morph_load('words.txt', para)

--for i=1,6 do 
--	print(do_morph(db, 'делающая база', i))
--end
