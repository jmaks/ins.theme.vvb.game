chzhao = obj
{
    nam = _'Чи Чжао|~Настоятель',
    live = true,
    morph =
    {
        ['Настоятель'] = {'Настоятель', 'Настоятеля', 'Настоятелю', 'Настоятеля', 'Настоятелем', 'Настоятеле'}
    },
    dsc = function (s)
        local ldesc =
        {
            'Чи Чжао медитирует. Лучше его сейчас не беспокоить.',
            'Настоятель задумчиво перебирает чётки.',
            [[Чжао с улыбкой Будды смотрит сквозь Вас, и похоже, думает о
            чём-то высоком.
            ]],
            'Настоятель Чжао кланяется Вам.',
            'Настоятель сидит на полу в позе лотоса и шепчет молитву.',
        };
        local v = math.random (#ldesc);
        p (ldesc[v]);
        return;
    end,
    obj =
    {
        'chyetki'
    },
    Exam = function (s)
        p [[Настоятель Чи Чжао – высокий, тощий старик, закутанный в бордового
        цвета мантию. У него светло-карие глаза, волосы с сединой, орлиный
        нос.
        ]];
        return;
    end,
    alias [[TalkAbout: AskAbout]],
    TalkAbout = function (s, w)
        if match_topic (sword, w) then
            p [[– Где может находиться меч Ли Гуана?^
            – В сундуке, может быть? – отвечает Чжао.
            ]];
            return;
        end
        if match_topic (svitok, w) then
            p [[– Что это за свиток?^
            – Прежний настоятель уделял много внимания бумаге. По-моему, это
            не более чем бумага. Я его не читал.
            ]];
            return;
        end
        if match_topic (budda, w) then
            p [[– Что Вы думаете о Будде?^
            – Весь мир – иллюзия. И Будда – это тоже иллюзия. Но он
            существует. Я знаю это, но не могу постигнуть.
            ]];
            return;
        end
        local ldesc =
        {
            [[Едва Вы открыли рот, Чи Чжао покачал головой и сказал:
            «Слово, которое можно сказать – не Истинное слово!»
            ]],
            [[Чжао говорит: «Наш монастырь почти забыт... Я отношусь к этому
            спокойно, потому что так вращается колесо судьбы. Но кое-кто здесь
            хочет изменить путь этого колеса...»
            ]],
            [[«Ли Гуан понял истину и расстался здесь со своим оружием.
            Но мир снова пленил его и он ушёл отсюда – навстречу смерти.
            А куда идёшь ты?»
            ]],
            [[Настоятель Чжао кланяется Вам и показывает чётки: «Смотри.
            Повернётся колесо времени, и могучие государства обратятся в пыль.
            Этим чёткам семьсот лет. Они были сделаны до того, как Цинь Шихуан
            объединил семь царств. И они видели падение Цинов. Их перебирал
            первый настоятель этого монастыря, разговаривающий с Гуаном.
            Они сохранились потому, что они всегда в движении. Подумай об
            этом.»
            ]],
            [[«Если Вы найдёте оружие Гуана, положите его перед Буддой.
            И сам Ли Гуан склонился перед улыбкой Будды. Но лучше – унесите
            его императору. Иначе толпы зевак будут приходить в наш монастырь
            посмотреть на реликвию, и здесь никак нельзя будет
            сосредоточиться.»;
            ]],
            p [[«Хочешь спросить – задай вопрос, а не ходи вокруг, да около.»
            ]],
        };
        local v = math.random (#ldesc);
        p (ldesc[v]);
        return;
    end,
};


pei = obj
{
    nam = _'Пэй Бухай|~Мастер',
    live = true,
    morph =
    {
        ['Пэй'] = {'Пэй', 'Пэя', 'Пэю', 'Пэя', 'Пэем', 'Пэе'},
        ['Бухай'] = {'Бухай', 'Бухая', 'Бухаю', 'Бухая', 'Бухаем', 'Бухае'},
    },
    dsc = function (s)
        local ldesc =
        {
            'Мастер бьёт нерадивого монаха шестом по голове.',
            [[Мастер уворачивается от пяти монахов, демонстрируя совершенное
            владение боевыми приёмами.
            ]],
            [[Пэй Бухай стоит в сложной боевой стойке «Журавль готов взлететь
            в небо!».
            ]],
            'Мастер показывает приём «Бешеный тигр прыгает из камышей».',
            [[Мастер Пэй наблюдает, как громко ученики исполняют приём
            «Бабочка садится на цветок» и вздыхает.
            ]],
            [[Мастер Пэй Бухай показывает ученикам сложный боевой приём с
            вращением шеста вокруг себя.
            ]],
        };
        local v = math.random (#ldesc);
        p (ldesc[v]);
        return;
    end,
    obj =
    {
        'shyest',
    },
    Exam = function (s)
        p [[Мастер Пэй Бухай это не слишком высокий, но очень коренастый
        человек. Его кожа красного цвета, он обнажён по пояс, его голова
        гладко выбрита. Судя по многочисленным шрамам на теле, он принимал
        участие во многих битвах.
        ]];
        return;
    end,
    alias [[TalkAbout: AskAbout]],
    TalkAbout = function (s, w)
        if match_topic (sword, w) then
            p [[– Где может находиться меч Ли Гуана?^
            – В твоём сердце, – отвечает мастер.
            ]];
            return;
        end
        if match_topic (svitok, w) then
            p [[– Что это за свиток?^
            – Прежний настоятель уделял много внимания бумаге. По-моему, это
            не более чем бумага.
            ]];
            return;
        end
        p [[Мастер Пэй Бухай спокойно улыбается тебе. Кажется, ему больше
        всего нравится приём «Довольный кот отдыхает»!
        ]];
        return;
    end,
};


shu = obj
{
    nam = 'Шу|~монах',
    live = true,
    Exam = function (s)
        halat:enable();
        vyer:enable();
        p [[Монах Шу – очень высокий, полный человек. Его губы растянуты в
        доброжелательной улыбке, но тёмно-карие, чуть прищуренные глаза
        смотрят холодно. Голова выбрита, от всех волос осталась только одна
        длинная чёрная прядь на макушке, которая спускается на затылок. Он
        одет в грубый холщовый халат грязно-серого цвета.
        ]];
        return;
    end,
    obj =
    {
        'halat',
        'vyer',
    },
    life = function (s)
        if player_moved() then
            local ldesc =
            {
                'Шу, сутулясь, следует за Вами.',
                'Шу идёт следом.',
                'Шу маячит за спиной.',
                'Шу смиренно идёт сзади.',
                'Шу бесшумной тенью скользит за вами.',
            };
            local v = math.random (#ldesc);
            p (ldesc[v]);
            move (s, here(), where(s) );
        else
            local v = math.random (20);
            if v == 1 then
                p 'Шу тихонько напевает «Ом, мани падме хум».';
            end
            if v == 2 then
                p 'Шу широко улыбается Вам.';
            end
            if v == 3 then
                p 'Шу смотрит на Вас, чуть склонив голову.';
            end
            if v == 4 then
                p 'Шу почёсывает спину.';
            end
            if v == 5 then
                p 'Шу потирает нос...';
            end
        end
    end;
    alias [[TalkAbout: AskAbout]],
    TalkAbout = function (s, w)
        if match_topic (shu, w) then
            p [[«Я скромный монах. Помогаю настоятелю по хозяйственной части.»
            – говорит Шу с усмешкой.
            ]];
            return;
        end
        if match_topic (hram, w) then
            p [[«Наш монастырь построен самим «крылатым генералом» Ли Гуаном.»
            ]];
            return;
        end
        if match_topic (budda, w) then
            p [[«Когда-то в храме стояла бронзовая статуя Будды Амиды, которая
            смотрела на портрет Ли Гуана, нарисованный на занавеске у входа в
            храм. Потом, во время одного из набегов воины уйгуров унесли её и
            монахи были вынуждены сделать изображение Будды на дереве.» –
            отвечает Шу с усмешкой.
            ]];
            return;
        end
        if match_topic (kolokol, w) then
            p [[«Колокол должен был подавать сигналы, если приближался враг.
            Но уже давно нет никаких набегов и монахи забыли об осторожности!»
            – гневно говорит Шу.
            ]];
            return;
        end
        if match_topic (sword, w) then
            p [[«Я плохо разбираюсь в мечах.» – говорит Шу с улыбкой.
            ]];
            return;
        end
        if match_topic (guan, w) then
            p [[«Как можно не восхищаться столь великим воином! Он мог
            пронзить камень стрелой из своего лука, он нападал там, где его не
            ждали! Он был очень умён и хитёр!^
            Впрочем, я думаю, всё это лишь иллюзии...» – замолкает Шу.
            ]];
            return;
        end
        if match_topic (kopye, w) or match_topic (zhuravl, w) then
            p [[«Чёрный Журавль – знаменитое копьё Ли Гуана. Говорят, он
            перебил им тысячу сюнну!» – говорит Шу с уважением.
            ]];
            return;
        end
        if match_topic (zanavyeska, w) then
            p [[«Когда-то давно здесь была не только занавеска с изображением
            Ли Гуана, но и крепкая дверь, окованная бронзой. Но она не спасла
            от набега уйгуров – они разбили её и увезли изображение Ли Гуана
            на запад.» – говорит Шу с каменным выражением лица.
            ]];
            return;
        end
        if match_topic (iyeroglify, w) then
            p [[«Столица находится на востоке отсюда, «Дракон» – это
            император. Путь к небесам – гмм, скорее всего лестница или башня.
            Степь за горой находится на севере, бронзовый Будда похищен десять
            лет назад уйгурами во время набега на монастырь...» – размышляет
            вслух Шу.
            ]];
            return;
        end
        if match_topic (sunduk, w) or match_topic (zamok, w) then
            p [[«Этот сундук тут с незапамятных времён. Никто не может его
            открыть без ключа, а ключ потерян. Он очень крепкий, и замок у
            него крепкий, – даже уйгуры не смогли его ни открыть, ни сломать,
            когда ворвались в храм во время набега.» – говорит Шу с усмешкой.
            ]];
            return;
        end
        if match_topic (oruzhie, w) then
            p [[«Откуда скромному монаху разбираться в оружии? Я знаю только,
            что когда-то давно здесь была сторожевая башня, значит оружие
            может храниться в кладовой.» – пожимает плечами Шу.
            ]];
            return;
        end
        p [[«Всё это майя, иллюзия. Чтобы понять истину надо отрешиться и от
        слова и от вещи.»
        ]];
        return;
    end,
    Order = function (s, w, o)
        if w == 'возьми' and o == odyeyalo then
            p [[Шу задумчиво качает головой и говорит: «Настоятель
            рассердится, если я возьму его одеяло. Лучше положить его
            обратно.»
            ]];
            return false;
        end

        if w == 'чисть' and o == floor and here() == bashnya and bashnya._pomet then
            bashnya._pomet = false;
            bashnya._key = true;
            if kelya1._shvabra then
                kelya1._shvabra = false;
                remove (shvabra, kelya1);
                put (shvabra, bashnya);
            end
            put (vyedro, bashnya);
            put (kluch, bashnya);
            Score = Score + 1;
            p [[Шу принёс швабру, совок и ведро и стал сгребать помёт в кучу,
            чтобы унести. Внезапно Вы заметили на полу какой-то предмет. Это –
            бронзовый язык, оторвавшийся от колокола... Нет, постойте, это же
            ключ! Шу смотрит на Вас совершенно потрясённо! Потом он
            успокаивается и шепчет: «Ом, мани падме хум!»
            ]];
        end
        p 'Шу качает головой.';
        return;
    end,
};

-- qqq
-- monetka
    -- qqq
--        doShowTo (actor, io) =
--{
--   "<> с интересом повертел монетку в руках, и, покачав головой, вернул назад.";
--}