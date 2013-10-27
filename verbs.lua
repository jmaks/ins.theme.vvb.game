orders = {'возьми', 'брось', 'дай', 'сними', 'чисть', 'читай'};

show_orders = function(s)
    local k,v
    local rc=''
    for k,v in pairs (orders) do
        rc = rc..v..'|';
--        print(v, rc)
    end
--    print(rc)
    return rc
end

Verb { 'Open %2', 'открыть', '{obj}вн'};
Verb { 'Unlock %2 %3', 'отпереть', '{obj}вн', '{}|{inv}тв'};
Verb { 'Turn %2', 'повернуть|~вращать|~сдвинуть', '{obj}вн' };
Verb { 'Clean %2 %3', 'очистить|~очищать|~чистить', '{obj}вн', '{}|{inv}тв'};
Verb { 'Ring %3', 'звонить|~позвонить', 'в', '{obj}вн' };
Verb { 'Unwear %2', 'снять|~снимать|~дёрнуть', '{obj}вн|{inv}вн' };
Verb { 'Meditate', 'медитировать|~думать|~молиться' };
Verb { 'AskAbout %2 %4', 'спросить', '{obj}вн', '{}|о', show_topics };
Verb { 'TalkAbout %3 %5', 'говорить|~поговорить', '{}|с', '{obj}тв', '{}|о', show_topics };
Verb { 'Attach %2 %4', 'прикрепить', '{inv}вн', 'к', '{inv}дт' };
Verb { 'Bend %2', 'свернуть|~согнуть|~скрутить', '{inv}вн'};
Verb { 'Unbend %2', 'развернуть|~разогнуть|~раскрутить|~размотать', '{inv}вн'};
Verb { 'Smell %2', 'нюхать|~понюхать', '{}|{obj}вн'};
Verb { 'About', '~автор|~информация' };
Verb { 'Help', '~помощь' };
Verb { 'Gratitudes', '~благодарности' };
Verb { 'Map', '~карта' };
Verb { 'Show_Score', '~счёт' };
Verb { 'Order %2 %4 %5', 'попросить', '{obj}вн', ':', show_orders, '{obj}вн|{inv}вн' };
-- вызовется у будды, order, с 1м параметром – текст приказа – второй = объект
-- w -- слово приказа
-- o -- объект направленности
Verb { 'Attack %2 %3', 'ударить|~атаковать|~бить', '{obj}вн', '{}|{inv}тв'};


parser.events.before_About = function (self)
    walk (about);
    return;
end


parser.events.before_Help = function (self)
    walk (help);
    return;
end


parser.events.before_Gratitudes = function (self)
    walk (gratitudes);
    return;
end


parser.events.before_Meditate = function (self)
    p [[Медитация привела Вас в благостное, расслабленное состояние. Есть в
    атмосфере храма что-то, наводящее на мысли о высоком...
    ]];
    return;
end


parser.events.before_Map = function (self)
    local l;
    p '^';
    l = '';
    if bashnya._visited then
        p '  башня^';
    end
    if ladder._visited then
        p '       |^';
        l = 'лестница';
    else
        l = '                 ';
    end
    if zal._visited then
        l = l..' –– зал –– ';
    end
    if kelya1._visited then
        if have (lampa) then
            l = l..'келья';
        else
            l = l..'???';
        end
    end
    if zal._visited then
        l = l..'^';
        p (l);
    end

    p '                         |^';
    l = '';
    if kelya._visited then
        l = '   келья';
    else
        l = '              ';
    end
    l = l..' –– вход –– ';
    if kladovaya._visited then
        l = l..'кладовая';
    end
    p (l);
    p '^';
    p '                         |^';

    l = '';
    if dvor._visited then
        l = l..'                    двор –– ';
    end
    if kuhna._visited then
        l = l..'кухня';
    end
    if dvor._visited then
        l = l..'^';
        p (l);
        p '                         |^';
    end
    if skala._visited then
        p '                    скала';
    end
    p '^';
    return;
end


parser.events.before_Show_Score = function (self)
    p 'Сделано ходов:';
    local a = stead.time() + 1;
    p (tostring (a)..'.');
    p 'Вы достигли счёта в';
    p (Score);
    p 'единиц из возможных';
    p ((MaxScore)..',');
    p 'что дало Вам ранг';
    if Score==0 then
        p 'Жень (человек).';
    end
    if Score==1 then
        p 'Сюцай (молодой талант).';
    end
    if Score==2 or Score==3 then
        p 'Сюцай (молодой талант).';
    end
    if Score==4 or Score==5 or Score==6 then
        p 'Цзиньши (продвинувшийся муж).';
    end
    if Score==7 or Score==8 or Score==9 or Score==10 then
        p 'Цзюньцзы (благородный муж).';
    end
    if Score==11 or Score==12 or Score==13 or Score==14 or Score==15 then
        p 'Шэн жэнь (совершенномудрый муж).';
    end
    return;
end


-- реакция на глаголы по умолчанию
parser.events.after_Order = function (self, w, o)
    if self:react() then -- нечего делать, вывод уже был
        return;
    end
-- qqq
-- как быть с женским родом?
--    p 'Вашу просьбу проигнорировали...'; -- реакция "по умолчанию"
    p (w:M('им')..' проигнорировал Вашу просьбу.');
    return;
end


parser.events.after_Unlock = function (self, w, o)
    if self:react() then
        return;
    end
--    local r = '';
--    r = r..'Вам не удалось отпереть ';
--    r = r..(w:M('вн'));
--    if o then
--        r = r..' '..(o:M('тв'));
--    end
--    r = r..'.';
--    p (r);
    p 'Не стоит этого делать.';
    return;
end


parser.events.after_Turn = function (self, w)
    if self:react() then
        return;
    end
    p 'Не стоит этого делать.';
    return;
end


parser.events.after_Clean = function (self, w, o)
    if self:react() then
        return;
    end
    p 'Не стоит этого делать.';
    return;
end


parser.events.after_Ring = function (self, w)
    if self:react() then
        return;
    end
    p 'Звонить надо там где положено, тем, чем положено, и когда положено.';
    return;
end


parser.events.after_Unwear = function (self, w)
    if self:react() then
        return;
    end
    p 'Не стоит этого делать.';
    return;
end


parser.events.after_AskAbout = function (self, w, o)
    if self:react() then
        return;
    end
    p (w:CM 'им');
    p 'молчит.';
    return;
end


parser.events.after_TalkAbout = function (self, w, o)
    if self:react() then
        return;
    end
    p (w:CM 'им');
    p 'молчит.';
    return;
end


parser.events.after_Attach = function (self, w, o)
    if self:react() then
        return;
    end
    p 'Не стоит этого делать.';
    return;
end


parser.events.after_Bend = function (self, w, o)
    if self:react() then
        return;
    end
    p 'Не стоит этого делать.';
    return;
end


parser.events.after_Unbend = function (self, w, o)
    if self:react() then
        return;
    end
    p 'Не стоит этого делать.';
    return;
end


parser.events.after_Smell = function (self, w, o)
    if self:react() then
        return;
    end
    if w == false then
        vozduh:Smell();
    else
        p ('Вы понюхали '..(w:M 'вн')..'.');
        if w:G().singular then
            p 'Пахнет';
        else
            p 'Пахнут';
        end
        p ('как '..(w:M 'им')..'.');
    end
    return;
end


parser.events.after_Attack = function (self, w, o)
    if self:react() then
        return;
    end
    -- qqq
    -- доработать
    if w == chzhao or w == pei or w == shu or w == monks then
        p [[За убийство придётся отвечать перед законом. И своей совестью.
        Первое будет больнее. А от второго – не убежишь.
        ]];
        return;
    end
    p ('Бить '..w:M'вн'..' сейчас не нужно.');
    return;
end
