
-- 风滚草钓起时，移除受世界风影响，钓起后1s再受世界风影响


-- 材料表 materials        基础原材料
-- 物品表 goods            道具、工具、武器
-- 穿戴表 equipments       服装、穿戴物品
-- 种植表 plant            种子、可移植植物
-- 食材表 ingredients      可食用非成品食物
-- 料理表 foods            成品食物
-- 生物表 organisms        大部分生物
-- 巨兽表 giants           巨大怪兽
-- 建筑表 builds           建筑、基建物品、不可移植
-- 事件表 events

local loots = {}
local events = TUNING.OCEANFISHINGROD_E.oceanfishingrod

-- 食材表: 可食用非成品食物
loots.ingredients = {
    {chance = 0.4, item = "petals"},--花瓣
    {chance = 0.4, item = "foliage"},--蕨叶
    {chance = 0.4, item = {"forgetmelots","firenettles","tillweed"}},--三种杂草
    {chance = 0.4, item = "foliage"},--蕨叶
    {chance = 0.4, item = "foliage"},--蕨叶
    {chance = 0.1, item = "ice"},--冰
    {chance = 0.1, item = {"berries","berries_juicy"}},--浆果
    {chance = 0.05, item = {"red_cap","green_cap","blue_cap","moon_cap"}},--蘑菇
    {chance = 0.1, item = {"asparagus","carrot","corn","dragonfruit","durian","eggplant","garlic","onion","pepper","pomegranate","potato","pumpkin","tomato","watermelon"}},--蔬菜
    {chance = 0.01, item = "wormlight_lesser"},--小发光浆果
    {chance = 0.01, item = "royal_jelly"},--蜂王浆
    {chance = 0.02, item = "cactus_meat"},--仙人掌肉
    {chance = 0.02, item = "cactus_flower"},--仙人掌花
    {chance = 0.15, item = "monstermeat"},--疯肉
    {chance = 0.15, item = "humanmeat_dried"},--长猪肉干
    {chance = 0.15, item = "humanmeat"},--长猪肉
    {chance = 0.01, item = "tallbirdegg"},--高鸟蛋
    {chance = 0.01, item = "fig"},--无花果
    {chance = 0.01, item = {"oceanfish_medium_1_inv","oceanfish_medium_2_inv","oceanfish_medium_3_inv","oceanfish_medium_4_inv","oceanfish_medium_5_inv",
        "oceanfish_medium_6_inv","oceanfish_medium_7_inv","oceanfish_medium_8_inv","oceanfish_medium_9_inv"}},--大海鱼
    {chance = 0.01, item = {"oceanfish_small_1_inv","oceanfish_small_2_inv","oceanfish_small_3_inv","oceanfish_small_4_inv","oceanfish_small_5_inv",
        "oceanfish_small_6_inv","oceanfish_small_7_inv","oceanfish_small_8_inv","oceanfish_small_9_inv"}},--小海鱼
}
-- 材料表: 基础原材料
loots.materials = {
    {chance = 0.2, item = "log"},--木头
    {chance = 0.2, item = "flint"},--燧石
    {chance = 0.15, item = "nitre"},--硝石
    {chance = 0.2, item = "rocks"},--石头
    {chance = 0.1, item = "cutgrass"},--草
    {chance = 0.1, item = "twigs"},--树枝
    {chance = 0.02, item = "goldnugget"},--黄金
    {chance = 0.4, item = "petals_evil"},--恶魔花瓣
    {chance = 0.1, item = "cutreeds"},--芦苇
    {chance = 0.1, item = "manrabbit_tail"},--兔毛
    {chance = 0.01, item = "honeycomb"},--蜂巢
    {chance = 0.15, item = "poop"},--便便
    {chance = 0.05, item = "moonrocknugget"},--月石
    {chance = 0.02, item = "spidereggsack"},--蜘蛛卵
    {chance = 0.1, item = {"feather_crow","feather_robin","feather_robin_winter","feather_canary"}},--羽毛
    {chance = 0.1, item = "beefalowool"},--牛毛
    {chance = 0.1, item = "beardhair"},--胡子
    {chance = 0.05, item = "lightbulb"},--荧光果
    {chance = 0.03, item = "lureplantbulb"},--食人花
    {chance = 0.1, item = "saltrock"},--盐晶
    {chance = 0.05, item = "seeds"},--种子
    {chance = 0.002, item = "shroom_skin", announce = true},--蛤蟆皮
    {chance = 0.002, item = "shadowheart", announce = true},--暗影之心
    {chance = 0.01, item = "thulecite"},--铥矿
    {chance = 0.3, item = "phlegm"},--脓鼻涕  
    {chance = 0.05, item = "thulecite_pieces"},--铥矿碎片
    {chance = 0.01, item = "mandrake", announce = true},--曼德拉草
    {chance = 0.1, item = "spoiled_fish"},--变质的鱼
    {chance = 0.1, item = "spoiled_fish_small"},--变质的小鱼
    {chance = 0.1, item = "moon_tree_blossom"},--月树花
    {chance = 0.1, item = "succulent_picked"},--肉质植物
    {chance = 0.1, item = "furtuft"},--熊毛簇
    {chance = 0.03, item = "cookiecuttershell"},--饼干切割机壳
    {chance = 0.01, item = "driftwood_log"},--浮木
    {chance = 0.01, item = "fossil_piece"},--化石碎片
    {chance = 0.03, item = "compostwrap"},--肥料包
    {chance = 0.05, item = "reviver"},--救赎之心
    {chance = 0.01, item = "lavae_cocoon", announce = true},--冰冻的熔岩幼虫
    {chance = 0.01, item = "oceantreenut", announce = true},--疙瘩树果
    {chance = 0.3, item = "shadow_despawn"},--冒烟特效
}
-- 物品表: 道具、工具、武器
loots.goods = {
    {chance = 0.02, item = "messagebottle"},--瓶中信
    {chance = 0.01, item = "cursed_monkey_token"},--诅咒饰品
    {chance = 0.01, item = "premiumwateringcan", announce = true},--鸟嘴喷壶
    {chance = 0.04, item = {"axe","pickaxe","shovel","farm_hoe"}},--斧头-鹤嘴锄-铲子-园艺锄
    {chance = 0.03, item = {"goldenaxe","goldenpickaxe","goldenshovel","golden_farm_hoe"}},--黄金工具
    {chance = 0.02, item = "boat_item"},--船套装
    {chance = 0.03, item = {"oar","anchor_item","steeringwheel_item","boatpatch"}},--锚套装-方向舵套装-船补丁-桅杆套装
    {chance = 0.01, item = "mast_malbatross_item", announce = true},--飞翼风帆
    {chance = 0.01, item = "featherpencil"},--羽毛笔
    {chance = 0.02, item = "lifeinjector"},--强心针
    {chance = 0.2, item = "waterballoon"},--水球
    {chance = 0.02, item = "heatrock"},--热能石
    {chance = 0.02, item = "deer_antler"},--鹿角
    {chance = 0.02, item = "dug_trap_starfish"},--海星陷阱
    {chance = 0.01, item = "bundlewrap", announce = true},--捆绑包装纸
    {chance = 0.03, item = "firecrackers"},--鞭炮 算是彩蛋吧
    {chance = 0.03, item = {"redlantern","pumpkin_lantern","miniboatlantern"}},--红灯笼--漂浮灯笼--南瓜灯
    {chance = 0.03, item = {"halloweenpotion_bravery_small","halloweenpotion_bravery_large","halloweenpotion_health_small","halloweenpotion_health_large","halloweenpotion_sanity_small","halloweenpotion_sanity_large"}},--药水
    {chance = 0.01, item = "alterguardianhatshard", announce = true},--启迪之冠碎片
    {chance = 0.01, item = "featherfan", announce = true},--羽毛扇
    {chance = 0.01, item = "multitool_axe_pickaxe", announce = true},--多功能工具
    {chance = 0.02, item = "beemine"},--蜜蜂地雷
    {chance = 0.05, item = "gunpowder"},--炸药
    {chance = 0.3, item = "shadowmeteor"},--陨石
    {chance = 0.1, item = "grotto_war_sfx"},--恐怖音效
    {chance = 0.3, item = "deciduous_root"},--树鞭
    {chance = 0.01, item = "hambat"},--火腿棍
    {chance = 0.02, item = "nightstick", announce = true},--晨星
    {chance = 0.02, item = "tentaclespike"},--狼牙棒
    {chance = 0.02, item = "glasscutter"},--玻璃刀
    {chance = 0.01, item = "malbatross_beak", announce = true},--邪天翁的喙
    {chance = 0.03, item = "whip"},--三尾猫鞭
    {chance = 0.03, item = "waterplant_bomb"},--种壳
    {chance = 0.006, item = "shieldofterror", announce = true},--恐怖盾牌
    {chance = 0.03, item = "spear_wathgrithr"},--战斗长矛
    {chance = 0.02, item = "nightsword", announce = true},--暗夜剑
    {chance = 0.02, item = "batbat", announce = true},--蝙蝠棒
    {chance = 0.02, item = "staff_tornado", announce = true},--天气棒
    {chance = 0.004, item = "cane", announce = true},--步行手杖
    {chance = 0.01, item = "panflute", announce = true},--排箫
    {chance = 0.004, item = "orangestaff", announce = true},--瞬移魔杖
    {chance = 0.004, item = "yellowstaff", announce = true},--唤星者法杖
    {chance = 0.004, item = "greenstaff", announce = true},--解构魔杖
    {chance = 0.007, item = "ruins_bat", announce = true},--远古棒
    {chance = 0.004, item = "eyeturret_item", announce = true},--眼球塔
    {chance = 0.004, item = "opalstaff", announce = true},--唤月法杖
    {chance = 0.05, item = "miniflare"},--信号弹
    {chance = 0.01, item = "saddle_war", announce = true},--战争牛鞍
    {chance = 0.01, item = "mastupgrade_lightningrod_item"},--避雷导线
    {chance = 0.004, item = "oceanfishinglure_hermit_drowsy", announce = true},--麻醉鱼饵
    {chance = 0.01, item = "batnosehat", announce = true},--牛奶帽
    {chance = 0.01, item = "polly_rogershat", announce = true},--波利帽
    {chance = 0.01, item = "moonstorm_goggleshat"},--天文护目镜
}
-- 穿戴表: 服装、穿戴物品
loots.equipments = { 
    {chance = 0.04, item = "spicepack"},--厨师包
    {chance = 0.004, item = "krampus_sack", announce = true},--坎普斯背包
    {chance = 0.1, item = "armorgrass"},--草甲
    {chance = 0.05, item = "flowerhat"},--花环
    {chance = 0.02, item = "watermelonhat"},--西瓜帽
    {chance = 0.02, item = "rainhat"},--防雨帽
    {chance = 0.01, item = "earmuffshat"},--小兔耳罩
    {chance = 0.02, item = "icehat"},--冰块帽
    {chance = 0.02, item = "raincoat"},--雨衣
    {chance = 0.02, item = "hawaiianshirt"},--花衬衫
    {chance = 0.01, item = "minerhat", announce = true},--矿工帽
    {chance = 0.01, item = "molehat", announce = true},--鼹鼠帽
    {chance = 0.01, item = "icepack", announce = true},--保鲜背包
    {chance = 0.02, item = "armorwood"},--木甲
    {chance = 0.03, item = {"mask_queenhat","mask_treehat","mask_blacksmithhat","mask_dollhat","mask_dollrepairedhat","mask_foolhat","mask_kinghat","mask_mirrorhat"}},--各种面具
    {chance = 0.03, item = "footballhat"},--橄榄球头盔
    {chance = 0.04, item = "wathgrithrhat"},--战斗头盔
    {chance = 0.06, item = "cookiecutterhat"},--饼干切割机帽子
    {chance = 0.04, item = "amulet", announce = true},--重生护符
    {chance = 0.02, item = "purpleamulet"},--噩梦护符
    {chance = 0.04, item = "red_mushroomhat"},--红蘑菇帽
    {chance = 0.04, item = "green_mushroomhat"},--绿蘑菇帽
    {chance = 0.04, item = "blue_mushroomhat"},--蓝蘑菇帽
    {chance = 0.03, item = "armor_bramble"},--荆棘甲
    {chance = 0.08, item = "wave_med"},--海浪
    {chance = 0.1, item = "fossilspike2"},-- 骨牢
    {chance = 0.004, item = "eyebrellahat", announce = true},--眼球伞
    {chance = 0.008, item = "ruinshat", announce = true},--远古皇冠
    {chance = 0.004, item = "orangeamulet", announce = true},--懒人强盗
    {chance = 0.004, item = "yellowamulet", announce = true},--魔光护符
    {chance = 0.005, item = "greenamulet", announce = true},--建造护符
    {chance = 0.01, item = "slurtlehat", announce = true},--蜗牛帽
    {chance = 0.01, item = "armorsnurtleshell", announce = true},--蜗牛盔甲
    {chance = 0.004, item = "hivehat", announce = true},--蜂后头冠
    {chance = 0.004, item = "armorskeleton", announce = true},--远古骨甲
    {chance = 0.008, item = "armorruins", announce = true},--远古护甲
}
-- 种植表: 种子、可移植植物
loots.plant = {
    {chance = 0.01, item = "pinecone"},--松果
    {chance = 0.01, item = "acorn"},--桦木果
    {chance = 0.01, item = "twiggy_nut"},--多枝种子
    {chance = 0.01, item = "livingtree_root"},--完全正常的树根
    {chance = 0.02, item = "rock_avocado_fruit_sprout"},--发芽石果
    {chance = 0.1, item = {"seeds","asparagus_seeds","carrot_seeds","corn_seeds","dragonfruit_seeds","durian_seeds","eggplant_seeds","garlic_seeds","onion_seeds","pepper_seeds","pomegranate_seeds","potato_seeds","pumpkin_seeds","tomato_seeds","watermelon_seeds"}},--种子
    {chance = 0.06, item = "dug_grass"},--草丛
    {chance = 0.06, item = "dug_sapling"},--树苗
    {chance = 0.06, item = "dug_marsh_bush"},--荆棘丛
    {chance = 0.08, item = "dug_sapling_moon"},--月岛树苗
    {chance = 0.04, item = "dug_berrybush"},--普通浆果丛
    {chance = 0.04, item = "dug_berrybush2"},--三叶浆果丛
    {chance = 0.04, item = "dug_berrybush_juicy"},--多汁浆果丛
    {chance = 0.02, item = "dug_rock_avocado_bush"},--石果灌木
    {chance = 0.06, item = "bullkelp_root"},--海带茎
    {chance = 0.02, item = "waterplant_planter"},--海芽插穗
}

-- 生物表: 大部分生物
loots.organisms = {
    {chance = 0.04, item = {"wilson","wortox","wendy","willow","wickerbottom","waxwell","webber",
        "wes","winona","woodie","wormwood","wurt","warly","wathgrithr","wolfgang","wx78","walter","wanda"},
        announce = true, eventF = events.getplayer,
        },--人物
    {chance = 0.02, item = "butterfly"},--蝴蝶
    {chance = 0.02, item = "fireflies"},--萤火虫
    {chance = 0.05, item = "moonstorm_spark"}, --月熠
    {chance = 0.2, item = "bee"},--蜜蜂   
    {chance = 0.02, item = "beefalo"},--牛
    {chance = 0.02, item = "lightninggoat"},--闪电羊
    {chance = 0.04, item = "pigman"},--猪人
    {chance = 0.03, item = "rocky"},--石虾
    {chance = 0.02, item = "catcoon"},--猫
    {chance = 0.02,item="wobster_sheller"},--龙虾
    {chance = 0.02, item = "little_walrus"},--小海象
    {chance = 0.01, item = {"koalefant_summer","koalefant_winter"}},--冬夏象
    {chance = 0.03, item = "spider_healer"},--护士蜘蛛 
    {chance = 0.03, item = "spider_water"},--海黾 
    {chance = 0.02, item = "grassgator"},--草鳄鱼 
    {chance = 0.07, item = "shark", sleeper = true},--岩石大白鲨 
    {chance = 0.05, item = "gnarwail", sleeper = true},--一角鲸 
    {chance = 0.06, item = "tallbird"},--高鸟
    {chance = 0.08, item = "crawlinghorror"},--暗影爬行怪
    {chance = 0.08, item = "terrorbeak"},--尖嘴暗影怪
    {chance = 0.06, item = "pigguard"},--猪人守卫
    {chance = 0.08, item = "bunnyman"},--兔人
    {chance = 0.08, item = "merm"},--鱼人
    {chance = 0.01, item = "mandrake_active", announce = true},--活曼德拉草
    {chance = 0.02, item = "squid", sleeper = false},--鱿鱼
    {chance = 0.02, item = "mushgnome"},--蘑菇地精
    {chance = 0.1, item = "spider_warrior"},--蜘蛛战士
    {chance = 0.1, item = "spider_hider"},--蜘蛛2
    {chance = 0.1, item = "spider_spitter"},--蜘蛛3
    {chance = 0.1, item = "spider_dropper"},--白蜘蛛
    {chance = 0.1, item = "spider_moon"},--破碎蜘蛛
    {chance = 0.1, item = {"hound","firehound","icehound"}},--猎狗
    {chance = 0.1, item = {"hedgehound","hedgehound_bush"}},--蔷薇狗
    {chance = 0.05, item = "firehound"},--火猎狗
    {chance = 0.02, item = "walrus", announce = true},--海象
    {chance = 0.08, item = "slurtle"},--蜗牛1
    {chance = 0.04, item = "snurtle"},--蜗牛2
    {chance = 0.1, item = "slurper"},--缀食者
    {chance = 0.1, item = "fruitfly"},--果蝇
    {chance = 0.1, item = "beeguard"},--蜜蜂守卫
    {chance = 0.1, item = "spat", announce = true},--钢羊
    {chance = 0.1, item = "eyeofterror_mini"},--恐怖小眼
    {chance = 0.02, item = "ticoon"},--大虎
    {chance = 0.1, item = "mutatedhound", sleeper = false},--僵尸狗
    {chance = 0.1, item = "houndcorpse", sleeper = false},--月狗
    {chance = 0.1, item = "clayhound"},--粘土狗
    {chance = 0.08, item = "teenbird"},--中高鸟
    {chance = 0.05, item = "smallbird"},--小高鸟
    {chance = 0.06, item = "fruitdragon", sleeper = false},--沙拉蝾螈
    {chance = 0.1, item = "slumutated_penguinrper"},--月企鹅
    {chance = 0.1, item = "spore_tall"},--孢子1
    {chance = 0.1, item = "spore_small"},--孢子2
    {chance = 0.1, item = "spore_medium"},--孢子3
    {chance = 0.04, item = "birchnutdrake"},--小桦树精
    {chance = 0.1, item = "monkey"},--猴子
    {chance = 0.1, item = "bat", sleeper = false},--蝙蝠
    {chance = 0.1, item = "mosquito"},--蚊子
    {chance = 0.1, item = "spider"},--蜘蛛
    {chance = 0.1, item = "frog"},--青蛙
    {chance = 0.1, item = "penguin"},--企鹅
    {chance = 0.1, item = {"knight","knight_nightmare"}},--发条骑士\损坏的发条骑士
    {chance = 0.1, item = {"bishop","bishop_nightmare"}},--发条主教\损坏的发条主教
    {chance = 0.1, item = {"rook","rook_nightmare"}},--发条战车\损坏的发条战车
    {chance = 0.05, item = "worm"},--洞穴蠕虫
    {chance = 0.1, item = "krampus"},--小偷
    {chance = 0.1, item = "mossling"},--小鸭
    {chance = 0.1, item = "tentacle"},--触手
    {chance = 0.1, item = "tentacle_pillar_arm"},--小触手
    {chance = 0.1, item = "molebat"},--裸鼹鼠蝙蝠
    {chance = 0.1, item = "ghost"},--鬼魂
    {chance = 0.02, item = "smallghost", announce = true},--小鬼魂
    {chance = 0.1, item = "eyeplant"},--眼球
    {chance = 0.1, item = "bird_mutant"},--月盲鸦
    {chance = 0.1, item = "mutated_penguin"},--僵尸企鹅
    {chance = 0.1, item = "bird_mutant_spitter"},--奇型鸟
    {chance = 0.05, item = "babybeefalo"},--牛宝宝
    {chance = 0.02, item = "moonbutterfly"},--月蛾
    {chance = 0.01, item = "deer_red"},--红无眼鹿
    {chance = 0.01, item = "deer_blue"},--蓝无眼鹿
    {chance = 0.02, item = "waterplant", announce = true},--藤壶怪
    {chance = 0.02, item = "gingerbreadpig"},--姜饼猪
    {chance = 0.02, item = "crabking_claw"},--蟹钳
    {chance = 0.04, item = {"stalker_minion","stalker_minion1","stalker_minion2"}},--影织者召唤物
    {chance = 0.1, item = "prime_mate", announce = true, eventF = events.giveitem},--大幅
    {chance = 0.01, item = "polly_rogers"},--波利罗杰
    {chance = 0.05, item = "grassgekko", sleeper = false},--草蜥蜴
    {chance = 0.03, item = {"crow","robin","canary","puffin","robin_winter"}, eventA = events.gift},--鸟类

    -- boss
    {chance = 0.018, item = "shadow_rook", announce = true},--暗影战车
    {chance = 0.018, item = "shadow_knight", announce = true},--暗影骑士
    {chance = 0.018, item = "shadow_bishop", announce = true},--暗影主教 
    {chance = 0.018, item = "spiderqueen", announce = true},--蜘蛛女王
    {chance = 0.005, item = "leif", announce = true},--树精
    {chance = 0.005, item = "leif_sparse", announce = true},--稀有树精
    {chance = 0.005, item = "stalker_forest", sleeper = false, announce = true},--森林守护者
    {chance = 0.018, item = "deerclops", announce = true},--巨鹿
    {chance = 0.018, item = "moose", sleeper = false, announce = true},--鹿鸭\麋鹿鹅
    {chance = 0.018, item = "warg", announce = true},--座狼
    {chance = 0.04, item = "warglet", announce = true},--年轻座狼
    {chance = 0.018, item = "bearger", announce = true},--熊大
    {chance = 0.018, item = "klaus", eventF = events.klaus, announce = true},--克劳斯
    {chance = 0.018, item = "dragonfly", announce = true},--龙蝇
    {chance = 0.018, item = "beequeen", announce = true},--蜂后
    {chance = 0.018, item = "minotaur", announce = true},--远古守护者
    {chance = 0.018, item = "toadstool", announce = true},--蘑菇蛤
    {chance = 0.018, item = "toadstool_dark", announce = true},--毒蘑菇蛤
    {chance = 0.018, item = "stalker_atrium", eventF = events.stalker_atrium, announce = true},--远古影织者
    {chance = 0.005, item = "stalker", announce = true},--复活的骨架
    {chance = 0.013, item = "alterguardian_phase1", announce = true},--天体英雄1
    {chance = 0.018, item = "malbatross", announce = true},--邪天翁
    {chance = 0.01, item = "crabking", announce = true},--帝王蟹
    {chance = 0.018, item = "eyeofterror", announce = true},--恐怖之眼
    {chance = 0.03, item = "gingerbreadwarg", announce = true},--姜饼座狼
    {chance = 0.04, item = "claywarg", announce = true},--粘土座狼
    {chance = 0.02, item = "ancient_hulk", announce = true},--梦魇疯猪
    {chance = 0.02, item = "daywalker", announce = true},--铁巨人

}

-- 事件表
loots.events = {
    {chance = 0.01, item = "fishingsurprised", name = "阴晴不定", eventF = events.weatherchanged},--阴晴不定
    {chance = 0.01, item = "fishingsurprised", name = "岩石怪圈", eventF = events.rockcircle},--岩石怪圈
    {chance = 0.03, item = "fishingsurprised", name = "营火晚会", eventF = events.campfirecircle},--营火晚会
    {chance = 0.08, item = "fishingsurprised", name = "生物怪圈", eventA = events.monstercircle},--生物怪圈
    {chance = 0.08, item = "fishingsurprised", name = "犬牙陷阱圈", eventF = events.maxwellcircle},--犬牙陷阱圈
    {chance = 0.08, item = "fishingsurprised", name = "天雷陷阱", eventA = events.lightningTarget},--天雷陷阱
    {chance = 0.08, item = "fishingsurprised", name = "天体陷阱", eventF = events.celestialfury},--天体陷阱
    {chance = 0.08, item = "fishingsurprised", name = "教你做人", eventF = events.teachyou},--教你做人
    {chance = 0.06, item = "fishingsurprised", name = "双倍快乐", eventF = events.doubletrap},--双倍快乐
    {chance = 0.08, item = "fishingsurprised", name = "水火相容", eventF = events.floods},--水火相容
    {chance = 0.08, item = "fishingsurprised", name = "一圈灵魂", eventF = events.ghostcir},--一圈灵魂
    {chance = 0.08, item = "fishingsurprised", name = "真假孢子堆", eventF = events.sporebombs},--真假孢子堆
    {chance = 0.08, item = "fishingsurprised", name = "狠狠地打", eventF = events.pigelite},--狠狠地打
    {chance = 0.08, item = "fishingsurprised", name = "整不死你", eventF = events.moonspiderspike},--整不死你
    {chance = 0.08, item = "fishingsurprised", name = "眼球圈", eventF = events.eyecircle},--眼球圈
    {chance = 0.08, item = "fishingsurprised", name = "辐射触手", eventF = events.radiationtentacle},--辐射触手
    {chance = 0.08, item = "fishingsurprised", name = "拙略模仿", eventF = events.clumsyimitation},--拙略模仿
    {chance = 0.08, item = "fishingsurprised", name = "幸运弹弹弹", eventF = events.luckybounce},--幸运弹弹弹
    {chance = 0.08, item = "fishingsurprised", name = "追踪蛋", eventF = events.virtualshadow},--追踪蛋
    {chance = 0.08, item = "fishingsurprised", name = "蘑菇炸弹", eventF = events.mushroombomb1},--蘑菇炸弹
    {chance = 0.02, item = "fishingsurprised", name = "双子魔眼", eventF = events.geminimagiceye},--双子魔眼
    {chance = 0.08, item = "fishingsurprised", name = "扎不扎你", eventF = events.bonerain},--扎不扎你
    {chance = 0.08, item = "fishingsurprised", name = "蔷薇陷阱", eventF = events.hedgehounds},--蔷薇陷阱
    {chance = 0.08, item = "fishingsurprised", name = "火药陷阱", eventF = events.gunpowdercircle},--火药陷阱
    {chance = 0.05, item = "fishingsurprised", name = "啜食", eventF = events.onAddHun},--状态陷阱
    {chance = 0.05, item = "fishingsurprised", name = "降智", eventF = events.onAddSan},--状态陷阱
    {chance = 0.05, item = "fishingsurprised", name = "流血", eventF = events.onAddHp},--状态陷阱
    {chance = 0.03, item = "fishingsurprised", name = "暗影陷阱", eventF = events.shadow_level},--暗影基佬
    {chance = 0.06, item = "fishingsurprised", name= "单向生命链接", eventF = events.healthlink},--单向生命链接
    {chance = 0.12, item = "fishingsurprised", name="多重孢子云", eventF = events.sporecloud},--多重孢子云 
    {chance = 0, item = "fishingsurprised", name="清理物品", eventF = events.removeitems},--清理物品
    {chance = 0.08, item = "fishingsurprised", name="风滚草包", eventF = events.fengguncaobao},--
    {chance = 0.08, item = "fishingsurprised", name="大量风滚草", eventF = events.fengguncao},--
    {chance = 0.06, item = "fishingsurprised", name="灵机一动", eventF = events.getbuilds},--
    
}

-- 巨兽表: 巨大怪兽
loots.giants = {
    -- {chance = 0.02, item = "shadow_rook"},--暗影战车
    -- {chance = 0.02, item = "shadow_knight"},--暗影骑士
    -- {chance = 0.02, item = "shadow_bishop"},--暗影主教 
    -- {chance = 0.05, item = "spiderqueen"},--蜘蛛女王
    -- {chance = 0.05, item = "leif"},--树精
    -- {chance = 0.05, item = "leif_sparse"},--稀有树精
    -- {chance = 0.004, item = "stalker_forest", sleeper = false},--森林守护者
    -- {chance = 0.03, item = "deerclops"},--巨鹿
    -- {chance = 0.05, item = "moose", sleeper = false},--鹿鸭\麋鹿鹅
    -- {chance = 0.02, item = "warg"},--座狼
    -- {chance = 0.09, item = "warglet"},--年轻座狼
    -- {chance = 0.03, item = "bearger"},--熊大
    -- {chance = 0.01, item = "klaus", eventF = events.klaus},--克劳斯
    -- {chance = 0.01, item = "dragonfly"},--龙蝇
    -- {chance = 0.01, item = "beequeen"},--蜂后
    -- {chance = 0.01, item = "minotaur"},--远古守护者
    -- {chance = 0.01, item = "toadstool"},--蘑菇蛤
    -- {chance = 0.003, item = "toadstool_dark"},--毒蘑菇蛤
    -- {chance = 0.001, item = "stalker_atrium", eventF = events.stalker_atrium},--远古影织者
    -- {chance = 0.01, item = "stalker"},--复活的骨架
    -- {chance = 0.005, item = "alterguardian_phase1"},--天体英雄1
    -- {chance = 0.002, item = "alterguardian_phase2"},--天体英雄2
    -- {chance = 0.001, item = "alterguardian_phase3"},--天体英雄3
    -- {chance = 0.03, item = "malbatross"},--邪天翁
    -- {chance = 0.01, item = "crabking"},--帝王蟹
    -- {chance = 0.03, item = "eyeofterror"},--恐怖之眼
    -- {chance = 0.01, item = {"twinofterror1","twinofterror2"}},--机械之眼1 激光眼 机械之眼2 魔焰眼
    -- default = {announce = true, sleeper = true}, -- 其他选项设置, 默认设置
}
-- 建筑表: 建筑、基建物品、不可移植植物
loots.builds = {
    {chance = 0.1, item = {"weed_forgetmelots","weed_firenettle","weed_tillweed","weed_ivy"}},--四种杂草
    {chance = 0.1, item = {"ruinsrelic_plate_placer","ruinsrelic_bowl_placer","ruinsrelic_chair_placer","ruinsrelic_chipbowl_placer",
                            "ruinsrelic_vase_placer","ruinsrelic_table_placer","ruinsrelic_table","ruinsrelic_chair",
                            "ruinsrelic_vase","ruinsrelic_bowl","ruinsrelic_chipbowl","ruinsrelic_plate"}},--远古遗迹
                            
    {chance = 0.02, item = "gravestone"}, --墓碑
    {chance = 0.2, item = {"mushroombomb","mushroombomb_dark"}},--炸弹蘑菇\悲惨的炸弹蘑菇 
    {chance = 0.02, item = "houndfire"}, --火
    {chance = 0.1, item = "tornado"},--龙卷风
    {chance = 0.04, item = "sporecloud"}, --孢子云
    {chance = 0.06, item = "sandspike"}, --沙刺
    {chance = 0.06, item = "sandblock"}, --沙堡
    {chance = 0.02, item = "ruins_cavein_obstacle"}, --块状废墟
    {chance = 0.02, item = {"rabbithole","molehill","tallbirdnest"}, announce = true},--兔子鼹鼠洞高脚鸟巢
    {chance = 0.04, item = "carrat_planted"},--胡萝卜鼠
    {chance = 0.02, item = {"chessjunk","chessjunk1","chessjunk2","chessjunk3"}},--损坏的发条装置
    {chance = 0.01, item = {"statuemaxwell","marblepillar","statueharp","statue_marble_pawn","statue_marble","statue_marble_muse","marbletree"}},--大理石雕像
    {chance = 0.04, item = {"asparagus_oversized","carrot_oversized","corn_oversized","dragonfruit_oversized","durian_oversized","eggplant_oversized","garlic_oversized","onion_oversized","pepper_oversized","pomegranate_oversized","potato_oversized","pumpkin_oversized","tomato_oversized","watermelon_oversized"}},--巨型蔬菜
    {chance = 0.004, item = "saltstack", announce = true},--盐堆
    {chance = 0.006, item = "seastack", announce = true},--浮堆
    {chance = 0.008, item = {"perdshrine","pigshrine","wargshrine","yot_catcoonshrine","yotb_beefaloshrine","yotc_carratshrine"}, announce = true},--各种神龛
    {chance = 0.01, item = "klaus_sack", announce = true},--克劳斯袋
    {chance = 0.002, item = "ruins_statue_mage", announce = true}, --远古雕像
    {chance = 0.002, item = "archive_moon_statue", announce = true}, --远古月亮雕像
    {chance = 0.001, item = "moonbase", announce = true}, --月亮石
    {chance = 0.001, item = "statueglommer", announce = true}, --格罗姆雕像
    {chance = 0.002, item = "resurrectionstone", announce = true}, --复活石
    {chance = 0.002, item = "pigking", announce = true}, --猪王
    {chance = 0.002, item = {"ancient_altar","ancient_altar_broken"}, announce = true}, --远古伪科学站
    {chance = 0.002, item = "archive_cookpot", announce = true}, --远古锅
    {chance = 0.002, item = "atrium_overgrowth", announce = true}, --远古方尖碑2
    {chance = 0.004, item = "monkeybarrel", announce = true}, -- 猴子桶
    {chance = 0.004, item = "catcoonden", announce = true}, --中空树桩
    {chance = 0.004, item = "walrus_camp", announce = true}, --海象营地
    {chance = 0.004, item = "pigtorch", announce = true}, -- 猪人火炬
    {chance = 0.004, item = "houndmound", announce = true}, -- 猎犬丘
    {chance = 0.004, item = "oceanvine_cocoon", announce = true}, -- 海蜘蛛巢穴
    {chance = 0.004, item = "wasphive", announce = true}, -- 杀人蜂巢
    {chance = 0.004, item = "beehive", announce = true}, -- 蜂窝
    {chance = 0.005, item = "pond", announce = true},-- 青蛙池塘
    {chance = 0.005, item = "pond_cave", announce = true},-- 鳗鱼池塘
    {chance = 0.002, item = "grotto_pool_small", announce = true, eventA = events.grotto_pool_small},--小月亮玻璃池
    {chance = 0.004, item = "pond_mos", announce = true},--蚊子池塘
    {chance = 0.003, item = "lava_pond", announce = true},--熔岩池
    {chance = 0.002, item = "hotspring", announce = true},--温泉
    {chance = 0.006, item = {"cactus","oasis_cactus"}},--仙人掌植株
    {chance = 0.008, item = {"blue_mushroom","green_mushroom","red_mushroom"}},--蘑菇植株
    {chance = 0.008, item = "wormlight_plant"},--神秘植物    
    {chance = 0.008, item = "oceanvine"},--苔藓藤条植株
    {chance = 0.008, item = {"flower_cave_triple","flower_cave_double","flower_cave","lightflier_flower"}}, -- 荧光花
    {chance = 0.008, item = {"evergreen","deciduoustree_normal","moon_tree_tall","cave_banana_tree","mushtree_medium","mushtree_small","mushtree_tall","mushtree_moon","mushroomsprout","mushroomsprout_dark","oceantree"}},--树  
    {chance = 0.004, item = "wobster_den"}, -- 龙虾窝
    {chance = 0.002, item = "moonglass_wobster_den"}, -- 月光玻璃窝
    {chance = 0.004, item = "gingerbreadhouse"}, -- 姜饼猪屋
    {chance = 0.002, item = "cavelight", name = "洞穴光"}, -- 洞穴光
    {chance = 0.1, item = "moonspider_spike"},--月亮蜘蛛钉
    {chance = 0.04, item = "slurtlehole", announce = true},--蛞蝓洞
    {chance = 0.1, item = "trap_teeth_maxwell",build = false},--麦斯威尔的犬牙陷阱
    {chance = 0.1, item = "beemine_maxwell"},--麦斯威尔的蚊子陷阱
    {chance = 0.01, item = "batcave", announce = true},--蝙蝠洞
    
    -- 概率不一样就不放一起了
    {chance = 0.01, item = "treasurechest", eventF = events.chest},--木箱
    {chance = 0.003, item = "pandoraschest", eventF = events.chest},--华丽宝箱
    {chance = 0.003, item = "dragonflychest", eventF = events.chest},--龙鳞宝箱
    {chance = 0.001, item = "minotaurchest", eventF = events.chest},--大号华丽箱子

    default = {
        build = build,
    }
}
loots.blueprints={--各种蓝图
		{chance=.01,item="TOOLS_blueprint", announce = true},--工具蓝图
		{chance=.01,item="LIGHT_blueprint", announce = true},--照明蓝图
		{chance=.01,item="SURVIVAL_blueprint", announce = true},--生存蓝图
		{chance=.01,item="FARM_blueprint", announce = true},--食物蓝图
		{chance=.01,item="SCIENCE_blueprint", announce = true},--科技蓝图
		{chance=.01,item="WAR_blueprint", announce = true},--战斗蓝图
		{chance=.01,item="TOWN_blueprint", announce = true},--建筑蓝图
		{chance=.01,item="REFINE_blueprint", announce = true},--合成蓝图
		{chance=.01,item="MAGIC_blueprint", announce = true},--魔法蓝图
		{chance=.01,item="DRESS_blueprint", announce = true},--衣物蓝图
}

-- 料理表: 成品食物
loots.foods = {}

-- 添加两种加调料的食物集
local preparedfoods = {}
local preparedfoods_spice = {}
local preparedfoods_warly = {}
local preparedfoods_warly_spice = {}
-- 添加普通料理
for k, v in pairs(require("preparedfoods")) do
    -- table.insert(loots.foods,{chance = 0.04, item = v.name})
    table.insert(preparedfoods, v.name)
    -- -- 添加调料
    table.insert(preparedfoods_spice, v.name.."_spice_garlic") --蒜
    table.insert(preparedfoods_spice, v.name.."_spice_sugar") --糖
    table.insert(preparedfoods_spice, v.name.."_spice_chili") --辣椒
    table.insert(preparedfoods_spice, v.name.."_spice_salt") --盐
end
-- 添加大厨料理
for k, v in pairs(require("preparedfoods_warly")) do
    -- table.insert(loots.foods,{chance = 0.01, item = v.name})
    table.insert(preparedfoods_warly, v.name)
    -- -- 添加调料
    table.insert(preparedfoods_warly_spice, v.name.."_spice_garlic") --蒜
    table.insert(preparedfoods_warly_spice, v.name.."_spice_sugar") --糖
    table.insert(preparedfoods_warly_spice, v.name.."_spice_chili") --辣椒
    table.insert(preparedfoods_warly_spice, v.name.."_spice_salt") --盐
end
table.insert(loots.foods,{chance = 0.09, item = preparedfoods})
table.insert(loots.foods,{chance = 0.05, item = preparedfoods_spice})
table.insert(loots.foods,{chance = 0.01, item = preparedfoods_warly})
table.insert(loots.foods,{chance = 0.01, item = preparedfoods_warly_spice})

return loots