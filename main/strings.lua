--还是很乱:P 懒
local STRINGS = GLOBAL.STRINGS
GLOBAL.setfenv(1, GLOBAL)

STRINGS.RECIPE_DESC.BLUEPRINT = "Random Blueprint"

STRINGS.NAMES.ADULT_FLYTRAP = "利齿捕蝇草"

STRINGS.CHARACTERS.GENERIC.DESCRIBE.ADULT_FLYTRAP = {
			GENERIC = "科学可做不到这一点。",
			SLEEPING = "嘘。它睡着了。",
			DEAD = "受死吧。",
}

STRINGS.NAMES.ROCK_BASALT = "玄武岩"    --显示的名字
STRINGS.CHARACTERS.GENERIC.DESCRIBE.ROCK_BASALT = "硬邦邦"    --人物检查时说的话

STRINGS.NAMES.ANCIENT_HULK = "远古铁巨人"
STRINGS.NAMES.ANCIENT_HULK_MINE = "地雷"
STRINGS.NAMES.ANCIENT_HULK_ORB = "能量球（铁巨人）"
STRINGS.NAMES.ANCIENT_HULK_ORB_SMALL = "小能量球（铁巨人）"
STRINGS.NAMES.ANCIENT_HULK_ORB_CHARGE = "大能量球（铁巨人）"
STRINGS.NAMES.ANCIENT_HULK_MARKER = "铁巨人标记"

STRINGS.NAMES.DUNGBALL = "粪球"
STRINGS.CHARACTERS.GENERIC.DESCRIBE.DUNGBALL = "确确实实是粪便。"

STRINGS.NAMES.DUNGBEETLE = "屎壳郎"
STRINGS.CHARACTERS.GENERIC.DESCRIBE.DUNGBEETLE =
{
			GENERIC = "她运气不错",
			UNDUNGED = "她要和她的粪球一起。",
			SLEEPING = "她累了。",
			DEAD = "为了粪便",
}

-- STRINGS.NAMES.IRON = "铁矿石"
-- STRINGS.CHARACTERS.GENERIC.DESCRIBE.IRON = "老铁，这不搞笑吗?"

STRINGS.NAMES.MEAN_FLYTRAP = "利齿幼苗"
STRINGS.CHARACTERS.GENERIC.DESCRIBE.MEAN_FLYTRAP =
{
			GENERIC = "植物不应该移动，那才是科学！",
			SLEEPING = "安睡吧，恐怖的植物。",
			DEAD = "成为尸体吧！",
}

STRINGS.NAMES.PIG_ROYALGUARD_RICH = "皇室守卫"
STRINGS.NAMES.PIG_ROYALGUARD_RICH_2 = "皇室守卫"
STRINGS.NAMES.PIGMAN_ROYALGUARD_3 = "皇室守卫"

STRINGS.NAMES.POG = "哈巴狸"
STRINGS.CHARACTERS.GENERIC.DESCRIBE.POG = "它怎么一直是饥饿的。"

STRINGS.NAMES.SPIDER_MONKEY = "蜘蛛猩猩"
STRINGS.CHARACTERS.GENERIC.DESCRIBE.SPIDER_MONKEY =
{
			GENERIC = "那玩意儿相当大！",
			SLEEPING = "我可不想弄醒它。",
			DEAD = "就是这样。",
}

STRINGS.NAMES.THUNDERBIRD = "雷鸟"
STRINGS.CHARACTERS.GENERIC.DESCRIBE.THUNDERBIRD = "令人震惊的景象！"

STRINGS.NAMES.VAMPIREBAT = "吸血蝙蝠"
STRINGS.CHARACTERS.GENERIC.DESCRIBE.VAMPIREBAT =
{
			GENERIC = "我宁愿保留我全部的血液。",
			SLEEPING = "我希望它不要再站起来。",
			DEAD = "我感觉安全点了。",
}

STRINGS.CITY_PIG_TALK_FOLLOWWILSON = {
    DEFAULT = {"伙计，你为什么这么坏？", "再一次面对破坏者，非猪人。", "拿起武器！", "杀！杀！杀！", "破坏，哀哉！", "游戏结束了！",},
    pigman_beautician = {"请参观我的药品店。", "你有羽毛吗？", "我需要羽毛。"},
    pigman_mechanic = {"让我看看你那些精炼的东西。", "需要修理吗？", "你有绳子吗？", "把你的木板卖给我吧。"},
    pigman_mayor = {"你投了反对票？", "把你的金子给我，这是正当的理由。", "请支持我。",},
    pigman_collector = {"有奇怪的东西吗？", "给我看看你身上那些奇怪的东西。","我可以买你手上那些奇怪的东西。",},
    pigman_banker = {"所有闪亮的东西都是值钱的。", "你有珠宝吗？", "我要买你的珠宝。"},
    pigman_florist = {"到我的商店买种子吧。", "我需要植物的一部分。", "有花瓣卖吗？"},
    pigman_farmer = {"我是个农民。", "你有草吗？", "别碰我农场里的东西。"},
    pigman_miner = {"我要买你的石头。", "你有能卖的石头吗？", "别偷我矿场里的东西。"},
    pigman_shopkeep = {"把你修剪树篱下来的碎叶卖给我吧。", "我需要碎叶。", "树篱需要你的修剪。"},
    pigman_storeowner = {"你有剪下来的碎叶吗？", "", "来买东西吧。"},
    pigman_erudite = {"汝需魔法材料?来吾店一看。", "汝有噩梦燃料？", "卖予吾噩梦燃料。"},
    pigman_hatmaker = {"要帽子吗？来我店里看看吧。", "有蜘蛛丝吗？", "你头上不需要盖个东西吗？"},
    pigman_professor = {"拜访彼处学院。", "你有遗物吗？", "卖给我古老的遗物吧。"},
    pigman_hunter = {"需要武器吗？来我的店看看吧。", "你有狗牙吗？", "去你对面的那个武器店。"},
}
STRINGS.CITY_PIG_TALK_FIND_LIGHT = {
    DEFAULT = {"把光找回来！", "光在哪里？", "太阳在哪儿？", "朋友，小猪，非猪人，给我借个火。"},
    pigman_beautician = {"我受不了了，太黑了。", "变黑了！", "什么地方有光？"},
    pigman_mechanic = {"是黑暗！是恐惧！", "多么疯狂的谎言！",},
    pigman_mayor = {"朋友，小猪，非猪人，给我借个火。", "我的光在哪儿？"},
    pigman_royalguard = {"光明化为乌有！", "拿起武器！", "把光找回来！"},
    -- pigman_royalguard = {"光明化为乌有！", "拿起武器！", "把光找回来！"},
    pigman_collector = {"什么地方有光？！", "我需要光明！",},
    pigman_banker = {"把光带回来！", "这是黑暗的谎言！"},
    pigman_florist = {"我受不了了，太黑了。！", "这是黑暗的谎言！",},
    pigman_storeowner = {"把光找回来！", "你为什么不在了？光明。"},
    pigman_farmer = {"太阳在哪儿？", "需要光明！",},
    pigman_miner = {"寻找光明！", "太可怕了！"},
    pigman_shopkeep = {"保护我！", "光明化为乌有！",},
    pigman_erudite = {"这里太黑了！", "黑暗踏足进来了！"},
    pigman_hatmaker = {"这是黑暗的谎言！", "我受不了了，太黑了。！"},
    pigman_professor = {"这是黑暗的谎言！", "黑暗怎么不消失！"},
    pigman_hunter = {"请把光带回来！", "是黑暗！是恐惧！"},

}
STRINGS.CITY_PIG_TALK_LOOKATWILSON_TRADER = {
    pigman_beautician = {"你有羽毛吗？", "不想被别人嘲笑的话来我的店吧。", "卖给我羽毛。"},
    pigman_mechanic = {"你是做什么的？", "你有木板吗？", "你有绳子吗？", "我要买你那些精炼的东西。"},
    pigman_mayor = {"想要在哈姆雷特有一座房子吗？", "需要猪人安保吗？", "你只能给我投票。"},
    pigman_collector = {"你有新奇的小东西吗？", "我能买你身上的小东西吗？", "我销售奇怪的小东西。"},
    pigman_banker = {"有珠宝吗？", "我要买你的珠宝。", "你愿意卖给我珠宝吗？"},
    pigman_florist = {"要我给你栽培植物吗？", "你不想’噗通‘吗", "你有花瓣吗？"},
    pigman_farmer = {"你有草吗？", "别拿我农场的东西。", "能卖给我你的草吗？"},
    pigman_miner = {"你有石头吗？", "别动我的石头。", "我会为你的石头付钱。"},
    pigman_shopkeep = {"你有碎叶吗？", "去那边的树篱吧。", "把你的碎叶卖给我吧。"},
    pigman_storeowner = {"有修剪下来的碎叶吗？", "去看看那边的树篱。", "把你修剪树篱下来的碎叶卖给我吧。"},
    pigman_erudite = {"你有古代的遗物吗？", "给我看看你的小猪遗物", "遗物是很有价值的。"},
    pigman_hatmaker = {"你要帽子吗？", "非猪人。我给你的头准备了帽子。", "我要买你的羽毛。"},
    pigman_professor = {"你有遗物吗？", "来店里看看，我有遗物。", "我要古代的宝贝。"},
    pigman_hunter = {"你需要粉碎的材料吗？", "我为你的钱准备好了武器。", "武器可以让你满意恐惧。"},

    DEFAULT = {"今天怎么样？非猪人。","你好吗？","遇见你真好。","祝你好运，非猪人。","我们的王国对你开放。"},
}
STRINGS.CITY_PIG_TALK_LOOKATROYALTY_TRADER = {
    pigman_beautician = {"您有最漂亮的鼻子。", "多么威严。", "要给您带礼物吗？"},
    pigman_mechanic = {"今天感觉怎么样？殿下。", "为您效劳。", "您是至高王权的象征。"},
    pigman_mayor = {"多么威严！", "我感到光荣！", "为您效劳。"},
    pigman_royalguard = {"永远为您效劳。", "多么威严！", "皇室万岁！"},
    pigman_royalguard_2 = {"您是我们这些卑微猪的荣耀。", "多么威严！", "您是至高王权的象征。"},
    pigman_collector = {"为您效劳。", "您就是我们的荣耀。", "您要一份礼物吗？"},
    pigman_banker = {"多么威严！", "您是我的荣耀。", "我诚心为您服务。",},
    pigman_florist = {"您想要我的花朵吗？", "为您效劳。", "您作为我们的荣耀！"},
    pigman_farmer = {"您卑微的随从", "殿下。", "为您效劳。"},
    pigman_miner = {"您是我的荣耀。", "这个礼物给您。", "接受这份礼物！"},
    pigman_shopkeep = {"今天怎么样？殿下。", "喜欢我的礼物吗？", "拿走您的礼物。",},
    pigman_storeowner = {"为您效劳。", "喜欢我的礼物吗？", "您是至高王权的象征。"},
    pigman_erudite = {"接受我卑微的礼物。", "您的威严长存！", "愿意接受这份礼物吗？"},
    pigman_hatmaker = {"多么威严！", "为您效劳。", "您是至高王权的象征。"},
    pigman_professor = {"接受这份礼物！", "是您照耀了我吗？", "我是您最卑微的仆人。"},
    pigman_hunter = {"您是我们这些卑微猪的荣耀。", "多么威严！", "为您效劳, 殿下。"},

    DEFAULT = {"您感觉怎么样？殿下。","您需要什么？","日安。","需要什么？您想要那个吗？","有我想要的东西吗？我可以买。", "殿下。"},
}

STRINGS.CITY_PIG_TALK_LOOKATWILSON = {
    DEFAULT = {"多新奇呀，非猪人。", "今天怎么样？善良的非猪人。", "多么新奇？", "遇见你真好。"},
    ROYALTY = {"女王万岁！","万岁，高贵的猪！", "我的君王。", "遇见您真好，高贵而善良的猪。",},
}
STRINGS.CITY_PIG_TALK_APORKALYPSE_SOON = {
        DEFAULT = { "猪人的毁灭！", "悲哀，毁灭，废墟，腐烂！", "末日临近！", "某些邪恶的事情要发生了。", "十万猪肉的景象！", "可怕，快躲起来！"},
    }
STRINGS.CITY_TALK_ANNOUNCE_APORKALYPSE = {
        DEFAULT = { "毁灭之猪来了！", "末日的霹雳！", "死亡日！", "他们回来了！", "他们会像运动一样杀了我们！", "我们家园的瘟疫！", "创造一切，毁灭一切！"},
}
STRINGS.CITY_PIG_TALK_RUNAWAY_WILSON = {
    DEFAULT = {"你不是善良的！", "离你远些！", "你滚开！", "你再见！"},
    pigman_beautician = {"天呐！", "噗！ 哼！", "离开你！！", "你这非猪人的味道。"},
    pigman_mechanic = {"再也不相信你了！", "你不要再回来！", "离开这，非猪人。"},
    pigman_mayor = {"你去死！", "你滚开！", "守卫！ 过来保护我！",},
    pigman_shopkeep = {"太近了！ 你太近了！", "离开我！", "你去死！"},
    pigman_royalguard = {"离你远些！", "你去死！", "你这个恶臭的非猪人！"},
    pigman_royalguard_2 = {"你滚开", "你不要再回来！", "要和我谈判吗?"},
    pigman_storeowner = {"你不要离我太近！", "太近了！", "滚回你的地方！"},
    pigman_farmer = {"你想要怎样才能放过我?", "滚回去！", "滚开！"},
    pigman_miner = {"离开我！！", "赶走！", "离你远些！"},
    pigman_collector = {"你最好消失！", "你去死", "你滚开！"},
    pigman_banker = {"你这非猪人的味道。", "你滚开！", "你去死！"},
    pigman_florist = {"告辞！", "你太近了！", "你一点儿也不要靠近我！"},
    pigman_erudite = {"离开我！", "你要怎样才能放过我?", "你离开！"},
    pigman_hatmaker = {"你滚开！", "你想要偷我的货物?", "你去死！", "我相信你会消失！"},
    pigman_professor = {"离开我！！", "你滚开", "为什么你这么近?"},
    pigman_hunter = {"滚开！", "快让我离开！", "你滚开！"},
}
STRINGS.CITY_PIG_TALK_FIGHT = {
    DEFAULT = {"停下！", "去死吧！", "啊呜呜呜！", "我用我的蹄子痛击你！"},
    pigman_beautician = {"死透吧，现在！", "我杀了你", "去见死神吧！"},
    pigman_mechanic = {"我要锤你！", "打, 锤！ 打！", "我要消灭你！"},
    pigman_mayor = {"杀！", "你去死！", "我暴怒了！", "毁灭！"},
    pigman_shopkeep = {"I GET THEE！", "THOU NOT NICE！", "I GET THEE！"},
    pigman_storeowner = {"GETEST THEE OUT！", "THY NOT BE WELCOME！", "GET OFF MINE PROPERTY！"},
    pigman_farmer = {"GET THEE BACK！！", "I BURY THINE！", "I GET THEE！"},
    pigman_miner = {"I CRUSHETH YOU！", "THY DYING！", "THOU DONE IT NOW！"},
    pigman_collector = {"THOU ART DONE FOR！", "GET THINE HENCE！", "THY BAD UNPIG！"},
    pigman_banker = {"THY NOT MINE FRIEND！", "I CHOP-ETH THEE！", "DIE！ DIE！"},
    pigman_florist = {"THOU ART THE WORST！", "GO AWAY-EST！", "THOU ART A VILLAIN！"},
    pigman_erudite = {"VILLAIN UNPIG！ BAD！", "THINE ART THE BADEST！", "AWAY FROM ME！"},
    pigman_hatmaker = {"YOU BE UNDONE！", "I SAY THEE OUT！！", "YOU MOST VEXING！"},
    pigman_professor = {"BE DONE-EST WITH THEE！", "WILL NOT YOU GO?！！", "OUT DAMNED UNPIG！"},
    pigman_hunter = {"I ATTACK-ETH THEE！", "GET THOU AWAY FROM HERE！", "YOU MOST NOT WELCOME！"},
}
STRINGS.CITY_PIG_TALK_DAILYGIFT = {
    DEFAULT = {"WARE FOR ART THOU", "THY HUMBL'ST PIGGY SERVANT", "REMEMBER'ST ME", "GIFT FOR'ST YOU", "WITH MINE HUMBLEST GRATITUDE","TAKEST THEE MINE GIFT, YOUR MAJESTY"},
    pigman_beautician = {"WARE FOR ART THOU", "THY HUMBL'ST PIGGY SERVANT", "REMEMBER'ST ME", "GIFT FOR'ST YOU", "WITH MINE HUMBLEST GRATITUDE","TAKEST THEE MINE GIFT, YOUR MAJESTY"},
    pigman_mechanic = {"WARE FOR ART THOU", "THY HUMBL'ST PIGGY SERVANT", "REMEMBER'ST ME", "GIFT FOR'ST YOU", "WITH MINE HUMBLEST GRATITUDE","TAKEST THEE MINE GIFT, YOUR MAJESTY"},
    pigman_mayor = {"WARE FOR ART THOU", "THY HUMBL'ST PIGGY SERVANT", "REMEMBER'ST ME", "GIFT FOR'ST YOU", "WITH MINE HUMBLEST GRATITUDE","TAKEST THEE MINE GIFT, YOUR MAJESTY"},
    pigman_shopkeep = {"WARE FOR ART THOU", "THY HUMBL'ST PIGGY SERVANT", "REMEMBER'ST ME", "GIFT FOR'ST YOU", "WITH MINE HUMBLEST GRATITUDE","TAKEST THEE MINE GIFT, YOUR MAJESTY"},
    pigman_storeowner = {"WARE FOR ART THOU", "THY HUMBL'ST PIGGY SERVANT", "REMEMBER'ST ME", "GIFT FOR'ST YOU", "WITH MINE HUMBLEST GRATITUDE","TAKEST THEE MINE GIFT, YOUR MAJESTY"},
    pigman_farmer = {"WARE FOR ART THOU", "THY HUMBL'ST PIGGY SERVANT", "REMEMBER'ST ME", "GIFT FOR'ST YOU", "WITH MINE HUMBLEST GRATITUDE","TAKEST THEE MINE GIFT, YOUR MAJESTY"},
    pigman_miner = {"WARE FOR ART THOU", "THY HUMBL'ST PIGGY SERVANT", "REMEMBER'ST ME", "GIFT FOR'ST YOU", "WITH MINE HUMBLEST GRATITUDE","TAKEST THEE MINE GIFT, YOUR MAJESTY"},
    pigman_collector = {"WARE FOR ART THOU", "THY HUMBL'ST PIGGY SERVANT", "REMEMBER'ST ME", "GIFT FOR'ST YOU", "WITH MINE HUMBLEST GRATITUDE","TAKEST THEE MINE GIFT, YOUR MAJESTY"},
    pigman_banker = {"WARE FOR ART THOU", "THY HUMBL'ST PIGGY SERVANT", "REMEMBER'ST ME", "GIFT FOR'ST YOU", "WITH MINE HUMBLEST GRATITUDE","TAKEST THEE MINE GIFT, YOUR MAJESTY"},
    pigman_florist = {"WARE FOR ART THOU", "THY HUMBL'ST PIGGY SERVANT", "REMEMBER'ST ME", "GIFT FOR'ST YOU", "WITH MINE HUMBLEST GRATITUDE","TAKEST THEE MINE GIFT, YOUR MAJESTY"},
    pigman_erudite = {"WARE FOR ART THOU", "THY HUMBL'ST PIGGY SERVANT", "REMEMBER'ST ME", "GIFT FOR'ST YOU", "WITH MINE HUMBLEST GRATITUDE","TAKEST THEE MINE GIFT, YOUR MAJESTY"},
    pigman_hatmaker = {"WARE FOR ART THOU", "THY HUMBL'ST PIGGY SERVANT", "REMEMBER'ST ME", "GIFT FOR'ST YOU", "WITH MINE HUMBLEST GRATITUDE","TAKEST THEE MINE GIFT, YOUR MAJESTY"},
    pigman_professor = {"WARE FOR ART THOU", "THY HUMBL'ST PIGGY SERVANT", "REMEMBER'ST ME", "GIFT FOR'ST YOU", "WITH MINE HUMBLEST GRATITUDE","TAKEST THEE MINE GIFT, YOUR MAJESTY"},
    pigman_hunter = {"WARE FOR ART THOU", "THY HUMBL'ST PIGGY SERVANT", "REMEMBER'ST ME", "GIFT FOR'ST YOU", "WITH MINE HUMBLEST GRATITUDE","TAKEST THEE MINE GIFT, YOUR MAJESTY"},
}
STRINGS.CITY_PIG_TALK_POOPTIP = {
    DEFAULT = {"OUT, DAMNED PLOP", "HUMBLE THANKS, KIND UNPIG", "MY THANKS"},
    pigman_beautician = {"TAKEST THEE THY COIN", "HERE BE YOUR OUTRAGEOUS FORTUNE", "THANK YE, UNPIG"},
    pigman_mechanic = {"OUT, DAMNED PLOP！", "FAIR PRICE, FAIR UNPIG?", "LET-EST ME PAY FOR THYST HELP"},
    pigman_mayor = {"IS THAT PLOP I SEE BEFORE THEE?", "HONEST UNPIG", "KINDEST UNPIG"},
    pigman_shopkeep = {"UNPIG IS AN HONORABLE UNPIG", "I GIVE EVERY PLOP MY OINC", "FAIR TERMS"},
    pigman_storeowner = {"FOR THY PLOP PICKING", "MOST EXCELLENT PICKING", "HONORABLE UNPIG"},
    pigman_farmer = {"FOR THY HONEST MANURING", "TAKEST THOU WHAT THOU'ST OWED", "HONEST OINC FOR UNPIG"},
    pigman_miner = {"'TIS FOUL", "IS A JUST PAYMENT?", "'TIS WORTHY DEED"},
    pigman_collector = {"HERE BE OINC FOR THOUST MANURE", "ALAS POOR UNPIG", "FORTUNE SMILES ONST THEE"},
    pigman_banker = {"AN OINC FOR THY TROUBLE", "A TAX FOR THY PLOP PICKING", "MANY THANKS"},
    pigman_florist = {"WE WILLST PAY FOR THY PLOPPING", "IS POO, UNPIG?", "ME PAYEST FOR PLOP PICKING"},
    pigman_erudite = {"FAIR PRICE FOR FOUL DEED", "THY PLOP-PICKING IS MOST PROFESSIONALS", "FOR PLOP OF PIGGY MAN"},
    pigman_hatmaker = {"I GIVE THE UNPIG ITS DUE", "WHAT PIECE OF WORK IS UNPIG", "YOU'ST PAID FOR PLOP OF PIG"},
    pigman_professor = {"THOUST MILK OF UNPIG KINDNESS", "SUCH STUFF AS PLOP IS MADE ON", "FOR THY "},
    pigman_hunter = {"PLOP AND CIRCUMSTANCE", "FOR POUND OF PLOP", "HAVE OINCS THRUST UPON THEE"},
}
STRINGS.CITY_PIG_TALK_PAYTAX = {
    DEFAULT = {"TAKETH THINE TAX","NEED'ST THOU MINE TAX", "TAKEST THOU MINE TAX", "MANY THANKS UNTO YOU, UNPIG MAYOR"},
    pigman_beautician = {"TAKETH THINE TAX","NEED'ST THOU MINE TAX", "TAKEST THOU MINE TAX", "MANY THANKS UNTO YOU, UNPIG MAYOR"},
    pigman_mechanic = {"TAKETH THINE TAX","NEED'ST THOU MINE TAX", "TAKEST THOU MINE TAX", "MANY THANKS UNTO YOU, UNPIG MAYOR"},
    pigman_mayor = {"TAKETH THINE TAX","NEED'ST THOU MINE TAX", "TAKEST THOU MINE TAX", "MANY THANKS UNTO YOU, UNPIG MAYOR"},
    pigman_shopkeep = {"TAKETH THINE TAX","NEED'ST THOU MINE TAX", "TAKEST THOU MINE TAX", "MANY THANKS UNTO YOU, UNPIG MAYOR"},
    pigman_storeowner = {"TAKETH THINE TAX","NEED'ST THOU MINE TAX", "TAKEST THOU MINE TAX", "MANY THANKS UNTO YOU, UNPIG MAYOR"},
    pigman_farmer = {"TAKETH THINE TAX","NEED'ST THOU MINE TAX", "TAKEST THOU MINE TAX", "MANY THANKS UNTO YOU, UNPIG MAYOR"},
    pigman_miner = {"TAKETH THINE TAX","NEED'ST THOU MINE TAX", "TAKEST THOU MINE TAX", "MANY THANKS UNTO YOU, UNPIG MAYOR"},
    pigman_collector = {"TAKETH THINE TAX","NEED'ST THOU MINE TAX", "TAKEST THOU MINE TAX", "MANY THANKS UNTO YOU, UNPIG MAYOR"},
    pigman_banker = {"TAKETH THINE TAX","NEED'ST THOU MINE TAX", "TAKEST THOU MINE TAX", "MANY THANKS UNTO YOU, UNPIG MAYOR"},
    pigman_florist = {"TAKETH THINE TAX","NEED'ST THOU MINE TAX", "TAKEST THOU MINE TAX", "MANY THANKS UNTO YOU, UNPIG MAYOR"},
    pigman_erudite = {"TAKETH THINE TAX","NEED'ST THOU MINE TAX", "TAKEST THOU MINE TAX", "MANY THANKS UNTO YOU, UNPIG MAYOR"},
    pigman_hatmaker = {"TAKETH THINE TAX","NEED'ST THOU MINE TAX", "TAKEST THOU MINE TAX", "MANY THANKS UNTO YOU, UNPIG MAYOR"},
    pigman_professor = {"TAKETH THINE TAX","NEED'ST THOU MINE TAX", "TAKEST THOU MINE TAX", "MANY THANKS UNTO YOU, UNPIG MAYOR"},
    pigman_hunter = {"TAKETH THINE TAX","NEED'ST THOU MINE TAX", "TAKEST THOU MINE TAX", "MANY THANKS UNTO YOU, UNPIG MAYOR"},
}
STRINGS.CITY_PIG_TALK_PROTECT = {
    DEFAULT = {"太污秽！ 太邪恶了！", "拿起武器！ 拿起武器！", "你卑鄙！", "你这个懦夫！"},
}
STRINGS.CITY_PIG_TALK_EXTINGUISH = {
    DEFAULT = {"快跑，快跑，发生火灾了！", "火是坏的！", "那边着火了！"},
}
STRINGS.CITY_PIG_TALK_STAYOUT = {
    DEFAULT = {"太讨厌了！", "滚出去，坏蛋！", "你该死！", "我唾弃你, 恶棍！"},
    pigman_beautician = {"MOST UNWELCOME", "AWAY, YOU CUR!", "BE'ST THEE GONE!", "FIE ON THEE, VILLAIN!"},
    pigman_mechanic = {"MOST UNWELCOME", "AWAY, YOU CUR!", "BE'ST THEE GONE!", "FIE ON THEE, VILLAIN!"},
    pigman_mayor = {"MOST UNWELCOME", "AWAY, YOU CUR!", "BE'ST THEE GONE!", "FIE ON THEE, VILLAIN!"},
    pigman_shopkeep = {"MOST UNWELCOME", "AWAY, YOU CUR!", "BE'ST THEE GONE!", "FIE ON THEE, VILLAIN!"},
    pigman_storeowner = {"MOST UNWELCOME", "AWAY, YOU CUR!", "BE'ST THEE GONE!", "FIE ON THEE, VILLAIN!"},
    pigman_farmer = {"MOST UNWELCOME", "AWAY, YOU CUR!", "BE'ST THEE GONE!", "FIE ON THEE, VILLAIN!"},
    pigman_miner = {"MOST UNWELCOME", "AWAY, YOU CUR!", "BE'ST THEE GONE!", "FIE ON THEE, VILLAIN!"},
    pigman_collector = {"MOST UNWELCOME", "AWAY, YOU CUR!", "BE'ST THEE GONE!", "FIE ON THEE, VILLAIN!"},
    pigman_banker = {"MOST UNWELCOME", "AWAY, YOU CUR!", "BE'ST THEE GONE!", "FIE ON THEE, VILLAIN!"},
    pigman_florist = {"MOST UNWELCOME", "AWAY, YOU CUR!", "BE'ST THEE GONE!", "FIE ON THEE, VILLAIN!"},
    pigman_erudite = {"MOST UNWELCOME", "AWAY, YOU CUR!", "BE'ST THEE GONE!", "FIE ON THEE, VILLAIN!"},
    pigman_hatmaker = {"MOST UNWELCOME", "AWAY, YOU CUR!", "BE'ST THEE GONE!", "FIE ON THEE, VILLAIN!"},
    pigman_professor = {"MOST UNWELCOME", "AWAY, YOU CUR!", "BE'ST THEE GONE!", "FIE ON THEE, VILLAIN!"},
    pigman_hunter = {"MOST UNWELCOME", "AWAY, YOU CUR!", "BE'ST THEE GONE!", "FIE ON THEE, VILLAIN!"},
}
STRINGS.CITY_PIG_TALK_FLEE = {
    DEFAULT = {"流氓！", "低贱的奴隶！", "好可怕！", "太怪异了！"},
    pigman_beautician = {"好可怕！", "太怪异了！！", "太恐怖了"},
    pigman_mechanic = {"你这个显眼的懦夫！", "逃跑！", "停下！"},
    pigman_mayor = {"疯狂的谎言！", "最好一个有没有！", "乞求怜悯！"},
    pigman_royalguard = {"杀！杀！杀！", "你珍重！", "再一次面对破坏者！！"},
    pigman_royalguard_2 = {"拿起武器！！", "我要粉碎你！", "游戏结束了！"},
    pigman_shopkeep = {"入侵！", "这不公平！", "灾难降临了！"},
    pigman_storeowner = {"猪人大动肝火！", "这是一场对猪人的野蛮追杀！", "多么的一个难事，啊！"},
    pigman_farmer = {"你这个胆怯的非猪人！", "藏起来！", "哦，痛苦！"},
    pigman_miner = {"如果你戳伤我们，我们会流血的！", "这是毁灭！", "一场灾难！"},
    pigman_collector = {"我跑的太多了！", "逃跑,呸，呼，呼！", "有东西腐败了！"},
    pigman_banker = {"告辞，告辞！", "记住我！", "我唾弃你！"},
    pigman_florist = {"受伤了！", "畜生！", "懦夫！"},
    pigman_erudite = {"发生在家园的灾祸！", "你暴怒了！", "离我远点！"},
    pigman_hatmaker = {"破坏！", "哈啊！不再！", "坏蛋！"},
    pigman_professor = {"太犯规了！", "不公平！", "离开我！"},
    pigman_hunter = {"把他们赶出去！", "我唾弃你！", "难事，麻烦！"},
}
STRINGS.CITY_PIG_TALK_RUN_FROM_SPIDER = {
    DEFAULT = {"蜘蛛太坏了！", "我更喜欢那个蜘蛛消失！", "你滚开！"},
    pigman_beautician = {"哦，怪物！", "哦，可怕！", "极其令人厌恶！"},
    pigman_mayor = {"你滚开！", "呜呼！！ 哀哉！", "我憎恨你，蜘蛛！"},
    pigman_mechanic = {"显眼的怪物！", "别破坏我们的东西！", "滚开！"},
    pigman_royalguard = {"保护城市！", "欢迎蜘蛛送死！", "去你的吧！"},
    pigman_royalguard_2 = {"保卫城市！", "粉碎蜘蛛！", "去你的吧！"},
    pigman_shopkeep = {"保护我的商店！", "你滚开！", "滚出去！"},
    pigman_storeowner = {"哼！ 啊！ 停下！", "最烦人的东西！", "哦太可怕了！"},
    pigman_farmer = {"哦，怪物！", "对蜘蛛是零欢迎！", "最烦人的东西！"},
    pigman_miner = {"你滚出去！", "滚开！", "这里不欢迎你！"},
    pigman_collector = {"你滚出去！！", "你这个坏家伙！！", "最烦人的东西！！"},
    pigman_banker = {"太污秽了！ 太邪恶了！", "怪物！", "你滚开！！！"},
    pigman_florist = {"蜘蛛太坏了！", "哦，怪物！！", "哦，恐怖的怪物！"},
    pigman_erudite = {"滚出去！", "滚开！ 滚开！！", "啊啊啊！"},
    pigman_hatmaker = {"令人毛骨悚然！", "你滚出去！！", "护卫！"},
    pigman_professor = {"你滚开！", "呜呼！ 哀哉！", "你滚出去！！"},
    pigman_hunter = {"我唾弃你！", "我更喜欢你消失！", "哼！啊！ 停下！！"},

}
STRINGS.CITY_PIG_TALK_HELP_CHOP_WOOD = {
    DEFAULT = {"TAKETH THAT TREE！", "I SMASH-ETH YON TREE！", "I PUNCH-ETH TREE！"},
    pigman_beautician = {"I SHALL CHOP-ETH！", "YON TREE NEEDS CHOPPIN'！",},
    pigman_mechanic = {"SHALL I COMPARE TREE TO SUMMER'S DAY?", "WORK-ETH, WORK-ETH, WORK-ETH",},
    pigman_mayor = {"WHAT PIECE OF WORK IS CHOPPING", "FALL, TREE！",},
    pigman_royalguard = {"I TAKETH DOWN YON TREE", "I CHOPTING", "I GOOD FRIEND, I CHOPT TREE"},
    pigman_royalguard_2 = {"CHOP'T CHOP'T", "I AXE THEE！", "FAIR TREE SHALT FALL！"},
    pigman_shopkeep = {"'TIS HARD WORK", "I SMASH-ETH", "I SMASH THEE"},
    pigman_storeowner = {"SMASH-ETH！ SMASH-ETH", "DOTH HARD WORK！", "HAVE AT THEE TREE！"},
    pigman_farmer = {"THIS TREE DOTH CHOP'T", "I TOIL", "CHOP'T CHOP'T！"},
    pigman_miner = {"YON TREE IS'T CHOP'T", "'TIS EASIER THAN MINING", "YON TREE IS'T DONE FOR！"},
    pigman_collector = {"'TIS HARD WORK", "WHAT A PIECE OF WORK IS CHOPPING",},
    pigman_banker = {"MINE HOOVES GET-ETH DIRTY", "FALL, TREE！",},
    pigman_florist = {"CHOP'T, CHOP'T", "SMASHINGS！", "TOIL, TOIL"},
    pigman_erudite = {"I HELP-ETH", "FALL, TREE！", "I AXE THEE！"},
    pigman_hatmaker = {"YON TREE SHALL FALL！", "THUS FALL-ETH THY TREE",},
    pigman_professor = {"WITH MINE LAST BREATH I CHOP AT THEE！", "CHOP'T CHOP'T", "HAVE AT THEE TREE"},
    pigman_hunter = {"THUS FALL THE TREE", "I BID THEE FALL！", "I WIN！"},
}
STRINGS.CITY_PIG_TALK_ATTEMPT_TRADE = {
    DEFAULT = {"你有什么，非猪人？", "需要货物吗？"},
    pigman_beautician = {"你有羽毛吗？", "你有鸟儿的羽毛吗？", "你有漂亮的羽毛吗？"},
    pigman_mechanic = {"你需要修理吗？", "把要修的给我。", "你有精炼货物吗？"},
    pigman_mayor = {"想有一栋房子吗？", "契约在市政厅。", "你想要在哈姆雷特有个家吗？"},
    pigman_shopkeep = {"去看看树篱吧！", "你有碎叶吗？", "你有剪下的树篱吗？"},
    pigman_storeowner = {"去看看那边的树篱。", "你有碎叶吗？", "你有剪下的树篱吗？"},
    pigman_farmer = {"你有草吗？", "卖给我一些草吧。", "我想要草材料。"},
    pigman_miner = {"你有石头吗？", "我可以为石头付钱。", "我给你硬币买你的石头。"},
    pigman_collector = {"你有奇怪的东西吗？", "我买那些奇怪的东西。", "试试卖给我那些奇怪的东西？"},
    pigman_banker = {"你有珠宝吗？", "我想买你的珠宝。", "我可以为你的珠宝付钱。"},
    pigman_florist = {"你有’噗通‘吗？", "卖给我花瓣吗？", "我喜欢漂亮的花朵。", "我喜欢臭臭的噗通。 "},
    pigman_erudite = {"你想使用黑暗魔法吗？", "你有噩梦燃料吗？", "卖给我噩梦燃料吧。"},
    pigman_hatmaker = {"你有蜘蛛丝吗？", "我需要蜘蛛丝。", "卖给我一些蜘蛛丝吧。"},
    pigman_professor = {"遗物？", "你有遗物吗？", "我可以为你的遗物付钱。"},
    pigman_hunter = {"你有狗牙吗？", "能卖给我狗牙吗？", "我收购狗牙。"},

}
STRINGS.CITY_PIG_TALK_PANIC = {
    DEFAULT = {"哦，太可怕了！", "啊啊啊啊嗷！！", "停止！", "不喜欢这样！", "太粗鲁了！"},
    pigman_beautician = {"恶魔临近了！", "某种邪恶的东西从远处过来了！", "哦，太恐怖了。"},
    pigman_mechanic = {"告辞！", "我太害怕了。", "太犯规了！ 太犯规了！"},
    pigman_mayor = {"太恐怖了", "哦，该诅咒的！", "这就是疯狂。"},
    pigman_royalguard = {"再一次面对破坏者！", "我们会保护你！", "停下！"},
    pigman_royalguard_2 = {"再一次面对破坏者！", "我们会保护你！", "停下！"},
    pigman_shopkeep = {"哦恐惧！ 哦恐惧！哦恐惧！", "瘟疫来临了！", "啊不义之财！"},
    pigman_storeowner = {"嘿，我的心脏啊！", "瘟疫会降临在它头上！", "什么都没了！"},
    pigman_farmer = {"什么都没了！", "告辞！ 告辞！", "我要领盒饭了！"},
    pigman_miner = {"我要死了！", "哦，灾难日！", "这就是终结！"},
    pigman_collector = {"坏东西接近了！", "我强烈抗议！", "我不想这么轻易的狗带！"},
    pigman_banker = {"太可怕了！", "太怪异了！", "帮帮我！"},
    pigman_florist = {"滚开！ 滚开！", "拿起武器！", "某种邪恶的东西从远处过来了！"},
    pigman_erudite = {"哦，该诅咒的！", "滚出去！", "极其不友好！"},
    pigman_hatmaker = {"滚开！ 滚开！", "救救我！", "太恐怖了！ 太怪异了！"},
    pigman_professor = {"恸哭乞求你的怜悯！", "太恐怖了！ 太怪异了！", "它是冲我们来的！"},
    pigman_hunter = {"喧哗与骚动！", "嗷，嗷，嗷，啊！", "什么都没了！"},
}
STRINGS.CITY_PIG_TALK_PANICFIRE = {
    DEFAULT = {"它在燃烧！", "火焰熊熊燃烧，小猪身上起泡。", "拿水来与火战斗！", "火从那边烧过来了！", "火，火，火"},
}
STRINGS.CITY_PIG_TALK_FIND_MEAT = {
    DEFAULT = {"难道这不是肉吗！", "这是什么?我面前的肉！", "我吃掉它！", "吃饭时间到！"},
    pigman_beautician = {"肉是爱情的食粮。", "我必须为了我的肚子。", "我吃到的是真实的。",},
    pigman_mechanic = {"这是什么?我面前的肉！", "上得好。", "这边有好吃的东西。"},
    pigman_mayor = {"这道菜是给我们猪吃的。", "这是给市长应得的。"},
    pigman_royalguard = {"吃还是不吃，这是个问题。", "肉类是给小猪准备的。"},
    pigman_royalguard_2 = {"只有我的肚子才是真实的！", "是肉！是食物！", "好哇！"},
    pigman_shopkeep = {"只有我的肚子才是真实的！", "它最好的结局就是进我的肚子。",},
    pigman_storeowner = {"是好吃的！", "我吃！", "这边有好吃的东西。"},
    pigman_farmer = {"吃呀吃呀，这肉太犯规了！", "为了我的大肥肚子！", "这肉的味道让我食欲高涨。"},
    pigman_miner = {"肉是食物的灵魂。", "要是它在我的肚子里。", "玛丽啊，我要吃肉！"},
    pigman_collector = {"是吃的!是食物!", "这食物是哪儿来的？", "求求你，让我吃吧！"},
    pigman_banker = {"食物就是这样。", "见鬼，为了我的大肥肚子！！", "这食物是哪儿来的？！"},
    pigman_florist = {"玛丽啊，我要吃肉！", "唉，整天为了肉！"},
    pigman_erudite = {"啊，这就是吃的！", "到我的肚子里去吧。", "肉应该在我的肚子里！"},
    pigman_hatmaker = {"我的肚子不会抗议太多。", "老兄！ 我的食物！", "没什么最佳时期！"},
    pigman_professor = {"嗯嗯呃...肉强行让我吃它。", "这里为什么会有肉？"},
    pigman_hunter = {"一磅肉！", "这是食物！这是确确实实的！", "肉真是麻烦！"},
}
STRINGS.CITY_PIG_TALK_FIND_MONEY = {
    DEFAULT = {"这亮晶晶的东西！", "那闪烁的是金子！", "赞成，去拿那些闪亮的东西。", "我要去买东西咯。"},
    pigman_beautician = {"硬币真有吸引力！", "这真漂亮。", "硬币极有价值。"},
    pigman_mechanic = {"我喜欢硬币！", "把硬币装我兜里。", "我用它买东西。"},
    pigman_mayor = {"我的！", "这能买来选票。", "这是作为市长应得的。"},
    pigman_royalguard = {"不义之财！", "我的生活费！", "把钱放我包里！"},
    pigman_royalguard_2 = {"真的是我的硬币！", "财富在对我微笑！"},
    pigman_shopkeep = {"它显示出来了。", "我拿！", "那边有闪亮亮的东西。"},
    pigman_storeowner = {"玛丽啊！", "我喜欢。", "把它放到合适的地方。", "我拿走它！"},
    pigman_farmer = {"这真是极好的。", "这真是诚实工作的一天。", "它们是哪儿来的？"},
    pigman_miner = {"我的！", "一枚硬币！", "这是我的！"},
    pigman_collector = {"呀，我要有这些闪亮的东西了！", "它们确实是我包里的。",},
    pigman_banker = {"一枚硬币！", "玛丽啊, 这是硬币！", "这些丢失的硬币都是我包里的。"},
    pigman_florist = {"多可爱啊。", "真漂亮！", "那些闪亮的都是金子。"},
    pigman_erudite = {"它抓住了我的视线！", "有价值的。", "这闪闪发亮的。"},
    pigman_hatmaker = {"我喜欢！", "把这钱放进我包里。", "这是哪儿来的？"},
    pigman_professor = {"运气不错！", "想要钱。", "它吸引了我的眼球。"},
    pigman_hunter = {"这是我的！", "财富在对我微笑！"},
}
STRINGS.CITY_PIG_TALK_FORGIVE_PLAYER = {
    DEFAULT = {"我表现出了宽容的品质。", "一切都被原谅了。", "我衷心的对你表示谅解", "一枚呼噜币就行了。"},
}
STRINGS.CITY_PIG_TALK_NOT_ENOUGH = {
    DEFAULT = {"我还想要更多。", "看起来还不够。", "我需要更多这个。", "还要更多。"}, -- NEW
}
STRINGS.CITY_PIG_TALK_EAT_MEAT = {
    DEFAULT = {"吃吃吃！", "哦吃的！ 哦食物！", "嚼，嚼，再嚼。"},

}
STRINGS.CITY_PIG_TALK_GO_HOME = {
    DEFAULT = {"快回去！ 再见！", "我要去睡觉了！"},
    pigman_beautician = {"很抱歉我先走了。", "我去睡了。", "我可能会做一个美梦。"},
    pigman_mechanic = {"抱歉了。", "我们这儿，到了穿睡衣的时候了", "祝你有个美妙的傍晚。"},
    pigman_mayor = {"天晴再说吧。", "我是我的枕边人。", "我的美梦要来了。"},
    pigman_shopkeep = {"对我说晚安吧。", "我要去房间了。", "晚上了穿睡衣了, 宝贝儿非猪人。"},
    pigman_storeowner = {"我预见了我的美梦成真。", "再见，再见。", "别忘了我啊。"},
    pigman_farmer = {"晚安，非猪人。", "离别是甜蜜的悲痛。", "直到明天。"},
    pigman_miner = {"直到明天啊明天啊明天。", "我要呼呼大睡了。", "睡还是不睡？"},
    pigman_collector = {"祝你整夜安好。", "甜蜜的夜晚！", "我向你告别。"},
    pigman_banker = {"再见，非猪人。", "祝你珍重。", "好猪猪, 我们睡觉吧。"},
    pigman_florist = {"温柔的睡衣。", "再次穿上我的睡衣。", "很快再见，晚安。"},
    pigman_erudite = {"现在是晚上了，别让我们不满。", "我的宠物呢？", "直到明天。"},
    pigman_hatmaker = {"我的睡衣放哪儿了？", "啊啦，我要走了。", "我给你的睡衣出价。"},
    pigman_professor = {"月光穿过了我的窗户。", "这就是夜晚的魔力。", "我说我要走了。"},
    pigman_hunter = {"我今晚要做一个美梦。", "我的身体太累了需要休息。", "明天见！"},
}
STRINGS.CITY_PIG_TALK_FIX = {
    DEFAULT = {"都修好啦！", "我修理的非常好！"},
    pigman_beautician = {"我修不好这个。", "你去找修理工来。"},
    pigman_mechanic = {"我做的非常非常棒。", "建造, 建造。", "我非常擅长使用我的锤子。"},
    pigman_mayor = {"市长不应该干修理的活。","我不会修。", "你去找修理工来。"},

}
STRINGS.CITY_PIG_GUARD_TALK_TORCH = {
    DEFAULT = {"点燃火炬！", "点亮火炬！", "燃烧, 火炬, 带来清明！"},
}
STRINGS.CITY_PIG_GUARD_TALK_FIGHT = {
    DEFAULT = {"我砍死你！", "攻击！", "滚开, 恶徒！ 滚开！"},
}
STRINGS.CITY_PIG_GUARD_TALK_GOHOME = {
    DEFAULT = {"站住！", "那是谁?", "谁在那?", "那是什么！"},
}
CITY_PIG_TALK_REFUSE_PRICELESS_GIFT	= {
    DEFAULT = {"不，那是非卖品。", "找到它了！ 必须去找女王。", "我不能收这个，这是皇室物品。"},
}

STRINGS.CITY_PIG_GUARD_TALK_LOOKATWILSON = {
    DEFAULT = {"你最好别惹麻烦。", "谁在那？", "停下！",},
}
STRINGS.CITY_PIG_GUARD_LIGHT_TORCH = {
    DEFAULT = {"我点亮了这热烈的火炬！", "火炬，火炬！", "宵禁时间！"},
}
STRINGS.CITY_PIG_TALK_REFUSE_GIFT = {
    DEFAULT = {"你有 %s吗？我可以付钱。"},
}
STRINGS.CITY_PIG_TALK_REFUSE_GIFT_DELAY = {
    DEFAULT = {" %s 天再来吧。"},
}
STRINGS.CITY_PIG_TALK_REFUSE_GIFT_DELAY_TOMORROW = {
    DEFAULT = {"第二天再来吧。"},
}
STRINGS.CITY_PIG_TALK_RELIC_GIFT = {
    DEFAULT = {"拿去那边的博物馆吧。", "“猪圈”才是存放它的地方。"},            -- \"THE STY\"
}
STRINGS.CITY_PIG_TALK_TAKE_GIFT = {
    DEFAULT = {"非常感谢, 请给我更多 %s 。"},
}
STRINGS.CITY_PIG_TALK_GIVE_REWARD = {
    DEFAULT = {"一份可敬的工作，这是你的奖励", "你做的真高尚", "干得漂亮"},
}
STRINGS.CITY_PIG_TALK_GIVE_TRINKET_REWARD = {
    DEFAULT = {"哦，多么可爱！ 拿上这个礼物。"},
}
STRINGS.CITY_PIG_TALK_REFUSE_TRINKET_GIFT = {
    DEFAULT = {"别开玩笑，谢谢。"},
}
STRINGS.CITY_PIG_TALK_GIVE_RELIC_REWARD = {
    DEFAULT = {"太棒了！", "难道这不是宝藏吗！", "那个古代遗物！"},
}
STRINGS.CITY_PIG_GUARD_TALK_ANGRY_PLAYER = {
    DEFAULT = {"你还敢回来？！", "杂种！恶棍！", "滚开！ 逃跑吧！", "你就是无穷无尽的麻烦！"},
}
STRINGS.CITY_PIG_TALK_ATTEMPT_TRADE = {
    DEFAULT = {"你有什么？", "你想要交易吗？", "来一场交易？"},
}
STRINGS.CITY_PIG_SHOPKEEPER_NOT_ENOUGH = {"你的钱不够。", "拿更多的钱来。"}
STRINGS.CITY_PIG_SHOPKEEPER_DONT_HAVE = {"你没有 %s。", "你还没有 %s。", "先看看钱, 这是前提。"}
STRINGS.CITY_PIG_SHOPKEEPER_SALE = {"谢谢。", "一次完美的交易。", "非常感谢。", "你是个不错的非猪人。",}
STRINGS.CITY_PIG_SHOPKEEPER_ROBBED = {"这是谁干的？！", "被抢了！被抢了！被抢了！", "哦，我了个猪啊！", "报复！",}

STRINGS.CITY_PIG_SHOPKEEPER_GREETING = {
    DEFAULT = {"欢迎。","你说什么，非猪人？","你找什么东西？","我有你要的货物。","你今天要买东西吗？"},
    pigman_mayor_shopkeep = {"你想要一座房子吗？", "需要护卫吗？", "你想要住在这儿吗？",},
    pigman_beautician = {"看看我的药品。", "你需要药品吗？", "需要啵-啵的东西吗？"},
    pigman_mechanic = {"你有什么药修的东西吗？", "我会修理。", "我修理损坏的东西。", "你要配件吗？"},
    pigman_miner = {"买石头吗？", "我喜欢石头。", "卖给我一些石头吧。",},
    pigman_collector = {"你有什么奇怪的东西吗", "我处理那些奇怪的小玩意儿。", "你想买奇怪的东西吗？"},
    pigman_banker = {"你有珠宝吗？", "我可以为你的珠宝付钱。", "我喜欢闪亮的珠宝。"},
    pigman_florist = {"你需要种子吗？", "需要植物的肥料吗？", "你想要‘噗通’吗？", "你有花瓣吗？"},
    pigman_erudite = {"要魔法材料吗？", "我出售魔法材料。", "我这里有噩梦燃料。"},
    pigman_hatmaker = {"帽子，你要帽子吗？", "需要什么东西盖住你的头吗？", "从我这儿买帽子吧。"},
    pigman_professor = {"有那些古老的东西吗？", "我喜欢那些遗物。", "你有遗物吗？",},
    pigman_hunter = {"要武器吗？", "我卖的东西很强。", "你想要大杀一场吗？"},
}

--"WELCOME","LOOKING FOR THING?","I HAVE WARES","YOU BUY TODAY?"},

STRINGS.CITY_PIG_SHOPKEEPER_CLOSING = {"到打烊时间了。","明天再来吧。","我要关店了。", "再见。","再见，记住我。", "我要下场了。"}

STRINGS.CITY_PIG_COLLECTOR_TRADE = "奇物"
STRINGS.CITY_PIG_BANKER_TRADE = "珠宝"
STRINGS.CITY_PIG_BEAUTICIAN_TRADE = "羽毛"
STRINGS.CITY_PIG_FLORIST_TRADE = "花瓣"
STRINGS.CITY_PIG_ERUDITE_TRADE = "噩梦燃料"
STRINGS.CITY_PIG_HUNTER_TRADE = "狗牙"
STRINGS.CITY_PIG_MAYOR_TRADE = "金子"
STRINGS.CITY_PIG_MECHANIC_TRADE = "精炼货物"
STRINGS.CITY_PIG_PROFESSOR_TRADE = "遗物"
STRINGS.CITY_PIG_HATMAKER_TRADE = "蜘蛛丝"
STRINGS.CITY_PIG_QUEEN_TRADE = "皇室物品"
--STRINGS.CITY_PIG_GUARD_TRADE = "SPEARS"
STRINGS.CITY_PIG_STOREOWNER_TRADE = "碎叶"
STRINGS.CITY_PIG_FARMER_TRADE = "草"
STRINGS.CITY_PIG_MINER_TRADE = "石头"
STRINGS.CITY_PIG_SHOPKEEP_TRADE = "货物"
STRINGS.CITY_PIG_USHER_TRADE = "浆果"


STRINGS.CITYPIGNAMES=
{
    UNISEX = {
        "墨尔本",
        "皮尔",
        "德比",
        "帕默斯顿",
        "格莱斯顿",
        "迪斯雷利",
        "索尔兹伯里",
        "肯辛顿",
        "康罗伊",
        "格雷维尔",
        "哈斯丁",
        "阿伯丁",
        "塔尔伯特",
        "泰晤士",
        "斯托克顿",
        "达灵顿",
    },

    FEMALE =
    {
        "伊丽莎白",
        "亚历山德里娜",
        "爱丽丝",
        "艾格尼斯",
        "阿拉贝拉",
        "贝尔",
        "贝丽尔",
        "石楠",
        "贝娅特丽丝",
        "凯萨琳",
        "夏洛特",
        "黛拉",
        "艾芭",
        "伊迪斯",
        "芙洛拉",
        "弗罗伦丝",
        "乔吉特",
        "亨利埃塔",
        "卢埃拉",
        "莉莲",
        "露易丝",
        "奥蒂莉厄",
        "奥菲利娅",
        "索弗洛尼亚",
    },
    MALE =
    {
        "威廉",
        "克拉伦斯",
        "弗雷德里克",
        "爱德华",
        "乔治",
        "查尔斯",
        "利奥波德",
        "艾伯特",
        "艾尔弗雷德",
        "亚瑟",
        "尤尔特",
        "赫伯特",
        "亨利",
        "查理",
        "道格拉斯",
        "爱迪生",
        "埃德蒙顿",
        "拉金",
        "奥利弗",
        "梅里特",
        "斯特林",
        "特斯拉",
        "撒迪厄斯",
        "惠灵顿",
        "格列佛",
    },
}

STRINGS.CITY_PIG_TALK_FIESTA = {
    DEFAULT = {"HUZZAH! HOORAY", "TIS SWINE FIESTA DAYS!", "BAD GUYS GO-ETH AWAY", "PIGGIES COME OUT-ETH TO PLAY!"},
    pigman_beautician = {"HUZZAH! HOORAY", "TIS SWINE FIESTA DAYS!", "BAD GUYS GO-ETH AWAY", "PIGGIES COME OUT-ETH TO PLAY!"},
    pigman_mechanic = {"HUZZAH! HOORAY", "TIS SWINE FIESTA DAYS!", "BAD GUYS GO-ETH AWAY", "PIGGIES COME OUT-ETH TO PLAY!"},
    pigman_mayor = {"HUZZAH! HOORAY", "TIS SWINE FIESTA DAYS!", "BAD GUYS GO-ETH AWAY", "PIGGIES COME OUT-ETH TO PLAY!"},
    pigman_shopkeep = {"HUZZAH! HOORAY", "TIS SWINE FIESTA DAYS!", "BAD GUYS GO-ETH AWAY", "PIGGIES COME OUT-ETH TO PLAY!"},
    pigman_storeowner = {"HUZZAH! HOORAY", "TIS SWINE FIESTA DAYS!", "BAD GUYS GO-ETH AWAY", "PIGGIES COME OUT-ETH TO PLAY!"},
    pigman_farmer = {"HUZZAH! HOORAY", "TIS SWINE FIESTA DAYS!", "BAD GUYS GO-ETH AWAY", "PIGGIES COME OUT-ETH TO PLAY!"},
    pigman_miner = {"HUZZAH! HOORAY", "TIS SWINE FIESTA DAYS!", "BAD GUYS GO-ETH AWAY", "PIGGIES COME OUT-ETH TO PLAY!"},
    pigman_collector = {"HUZZAH! HOORAY", "TIS SWINE FIESTA DAYS!", "BAD GUYS GO-ETH AWAY", "PIGGIES COME OUT-ETH TO PLAY!"},
    pigman_banker = {"HUZZAH! HOORAY", "TIS SWINE FIESTA DAYS!", "BAD GUYS GO-ETH AWAY", "PIGGIES COME OUT-ETH TO PLAY!"},
    pigman_florist = {"HUZZAH! HOORAY", "TIS SWINE FIESTA DAYS!", "BAD GUYS GO-ETH AWAY", "PIGGIES COME OUT-ETH TO PLAY!"},
    pigman_erudite = {"HUZZAH! HOORAY", "TIS SWINE FIESTA DAYS!", "BAD GUYS GO-ETH AWAY", "PIGGIES COME OUT-ETH TO PLAY!"},
    pigman_hatmaker = {"HUZZAH! HOORAY", "TIS SWINE FIESTA DAYS!", "BAD GUYS GO-ETH AWAY", "PIGGIES COME OUT-ETH TO PLAY!"},
    pigman_professor = {"HUZZAH! HOORAY", "TIS SWINE FIESTA DAYS!", "BAD GUYS GO-ETH AWAY", "PIGGIES COME OUT-ETH TO PLAY!"},
    pigman_hunter = {"HUZZAH! HOORAY", "TIS SWINE FIESTA DAYS!", "BAD GUYS GO-ETH AWAY", "PIGGIES COME OUT-ETH TO PLAY!"},
}

STRINGS.CITY_PIG_TALK_POOPTIP = {
    DEFAULT = {"OUT, DAMNED PLOP", "HUMBLE THANKS, KIND UNPIG", "MY THANKS"},
    pigman_beautician = {"TAKEST THEE THY COIN", "HERE BE YOUR OUTRAGEOUS FORTUNE", "THANK YE, UNPIG"},
    pigman_mechanic = {"OUT, DAMNED PLOP！", "FAIR PRICE, FAIR UNPIG?", "LET-EST ME PAY FOR THYST HELP"},
    pigman_mayor = {"IS THAT PLOP I SEE BEFORE THEE?", "HONEST UNPIG", "KINDEST UNPIG"},
    pigman_shopkeep = {"UNPIG IS AN HONORABLE UNPIG", "I GIVE EVERY PLOP MY OINC", "FAIR TERMS"},
    pigman_storeowner = {"FOR THY PLOP PICKING", "MOST EXCELLENT PICKING", "HONORABLE UNPIG"},
    pigman_farmer = {"FOR THY HONEST MANURING", "TAKEST THOU WHAT THOU'ST OWED", "HONEST OINC FOR UNPIG"},
    pigman_miner = {"'TIS FOUL", "IS A JUST PAYMENT?", "'TIS WORTHY DEED"},
    pigman_collector = {"HERE BE OINC FOR THOUST MANURE", "ALAS POOR UNPIG", "FORTUNE SMILES ONST THEE"},
    pigman_banker = {"AN OINC FOR THY TROUBLE", "A TAX FOR THY PLOP PICKING", "MANY THANKS"},
    pigman_florist = {"WE WILLST PAY FOR THY PLOPPING", "IS POO, UNPIG?", "ME PAYEST FOR PLOP PICKING"},
    pigman_erudite = {"FAIR PRICE FOR FOUL DEED", "THY PLOP-PICKING IS MOST PROFESSIONALS", "FOR PLOP OF PIGGY MAN"},
    pigman_hatmaker = {"I GIVE THE UNPIG ITS DUE", "WHAT PIECE OF WORK IS UNPIG", "YOU'ST PAID FOR PLOP OF PIG"},
    pigman_professor = {"THOUST MILK OF UNPIG KINDNESS", "SUCH STUFF AS PLOP IS MADE ON", "FOR THY "},
    pigman_hunter = {"PLOP AND CIRCUMSTANCE", "FOR POUND OF PLOP", "HAVE OINCS THRUST UPON THEE"},
}

STRINGS.CITY_PIG_TALK_PAYTAX = {
    DEFAULT = {"TAKETH THINE TAX","NEED'ST THOU MINE TAX", "TAKEST THOU MINE TAX", "MANY THANKS UNTO YOU, UNPIG MAYOR"},
    pigman_beautician = {"TAKETH THINE TAX","NEED'ST THOU MINE TAX", "TAKEST THOU MINE TAX", "MANY THANKS UNTO YOU, UNPIG MAYOR"},
    pigman_mechanic = {"TAKETH THINE TAX","NEED'ST THOU MINE TAX", "TAKEST THOU MINE TAX", "MANY THANKS UNTO YOU, UNPIG MAYOR"},
    pigman_mayor = {"TAKETH THINE TAX","NEED'ST THOU MINE TAX", "TAKEST THOU MINE TAX", "MANY THANKS UNTO YOU, UNPIG MAYOR"},
    pigman_shopkeep = {"TAKETH THINE TAX","NEED'ST THOU MINE TAX", "TAKEST THOU MINE TAX", "MANY THANKS UNTO YOU, UNPIG MAYOR"},
    pigman_storeowner = {"TAKETH THINE TAX","NEED'ST THOU MINE TAX", "TAKEST THOU MINE TAX", "MANY THANKS UNTO YOU, UNPIG MAYOR"},
    pigman_farmer = {"TAKETH THINE TAX","NEED'ST THOU MINE TAX", "TAKEST THOU MINE TAX", "MANY THANKS UNTO YOU, UNPIG MAYOR"},
    pigman_miner = {"TAKETH THINE TAX","NEED'ST THOU MINE TAX", "TAKEST THOU MINE TAX", "MANY THANKS UNTO YOU, UNPIG MAYOR"},
    pigman_collector = {"TAKETH THINE TAX","NEED'ST THOU MINE TAX", "TAKEST THOU MINE TAX", "MANY THANKS UNTO YOU, UNPIG MAYOR"},
    pigman_banker = {"TAKETH THINE TAX","NEED'ST THOU MINE TAX", "TAKEST THOU MINE TAX", "MANY THANKS UNTO YOU, UNPIG MAYOR"},
    pigman_florist = {"TAKETH THINE TAX","NEED'ST THOU MINE TAX", "TAKEST THOU MINE TAX", "MANY THANKS UNTO YOU, UNPIG MAYOR"},
    pigman_erudite = {"TAKETH THINE TAX","NEED'ST THOU MINE TAX", "TAKEST THOU MINE TAX", "MANY THANKS UNTO YOU, UNPIG MAYOR"},
    pigman_hatmaker = {"TAKETH THINE TAX","NEED'ST THOU MINE TAX", "TAKEST THOU MINE TAX", "MANY THANKS UNTO YOU, UNPIG MAYOR"},
    pigman_professor = {"TAKETH THINE TAX","NEED'ST THOU MINE TAX", "TAKEST THOU MINE TAX", "MANY THANKS UNTO YOU, UNPIG MAYOR"},
    pigman_hunter = {"TAKETH THINE TAX","NEED'ST THOU MINE TAX", "TAKEST THOU MINE TAX", "MANY THANKS UNTO YOU, UNPIG MAYOR"},
}

STRINGS.CITY_PIG_TALK_DAILYGIFT = {
    DEFAULT = {"WARE FOR ART THOU", "THY HUMBL'ST PIGGY SERVANT", "REMEMBER'ST ME", "GIFT FOR'ST YOU", "WITH MINE HUMBLEST GRATITUDE","TAKEST THEE MINE GIFT, YOUR MAJESTY"},
    pigman_beautician = {"WARE FOR ART THOU", "THY HUMBL'ST PIGGY SERVANT", "REMEMBER'ST ME", "GIFT FOR'ST YOU", "WITH MINE HUMBLEST GRATITUDE","TAKEST THEE MINE GIFT, YOUR MAJESTY"},
    pigman_mechanic = {"WARE FOR ART THOU", "THY HUMBL'ST PIGGY SERVANT", "REMEMBER'ST ME", "GIFT FOR'ST YOU", "WITH MINE HUMBLEST GRATITUDE","TAKEST THEE MINE GIFT, YOUR MAJESTY"},
    pigman_mayor = {"WARE FOR ART THOU", "THY HUMBL'ST PIGGY SERVANT", "REMEMBER'ST ME", "GIFT FOR'ST YOU", "WITH MINE HUMBLEST GRATITUDE","TAKEST THEE MINE GIFT, YOUR MAJESTY"},
    pigman_shopkeep = {"WARE FOR ART THOU", "THY HUMBL'ST PIGGY SERVANT", "REMEMBER'ST ME", "GIFT FOR'ST YOU", "WITH MINE HUMBLEST GRATITUDE","TAKEST THEE MINE GIFT, YOUR MAJESTY"},
    pigman_storeowner = {"WARE FOR ART THOU", "THY HUMBL'ST PIGGY SERVANT", "REMEMBER'ST ME", "GIFT FOR'ST YOU", "WITH MINE HUMBLEST GRATITUDE","TAKEST THEE MINE GIFT, YOUR MAJESTY"},
    pigman_farmer = {"WARE FOR ART THOU", "THY HUMBL'ST PIGGY SERVANT", "REMEMBER'ST ME", "GIFT FOR'ST YOU", "WITH MINE HUMBLEST GRATITUDE","TAKEST THEE MINE GIFT, YOUR MAJESTY"},
    pigman_miner = {"WARE FOR ART THOU", "THY HUMBL'ST PIGGY SERVANT", "REMEMBER'ST ME", "GIFT FOR'ST YOU", "WITH MINE HUMBLEST GRATITUDE","TAKEST THEE MINE GIFT, YOUR MAJESTY"},
    pigman_collector = {"WARE FOR ART THOU", "THY HUMBL'ST PIGGY SERVANT", "REMEMBER'ST ME", "GIFT FOR'ST YOU", "WITH MINE HUMBLEST GRATITUDE","TAKEST THEE MINE GIFT, YOUR MAJESTY"},
    pigman_banker = {"WARE FOR ART THOU", "THY HUMBL'ST PIGGY SERVANT", "REMEMBER'ST ME", "GIFT FOR'ST YOU", "WITH MINE HUMBLEST GRATITUDE","TAKEST THEE MINE GIFT, YOUR MAJESTY"},
    pigman_florist = {"WARE FOR ART THOU", "THY HUMBL'ST PIGGY SERVANT", "REMEMBER'ST ME", "GIFT FOR'ST YOU", "WITH MINE HUMBLEST GRATITUDE","TAKEST THEE MINE GIFT, YOUR MAJESTY"},
    pigman_erudite = {"WARE FOR ART THOU", "THY HUMBL'ST PIGGY SERVANT", "REMEMBER'ST ME", "GIFT FOR'ST YOU", "WITH MINE HUMBLEST GRATITUDE","TAKEST THEE MINE GIFT, YOUR MAJESTY"},
    pigman_hatmaker = {"WARE FOR ART THOU", "THY HUMBL'ST PIGGY SERVANT", "REMEMBER'ST ME", "GIFT FOR'ST YOU", "WITH MINE HUMBLEST GRATITUDE","TAKEST THEE MINE GIFT, YOUR MAJESTY"},
    pigman_professor = {"WARE FOR ART THOU", "THY HUMBL'ST PIGGY SERVANT", "REMEMBER'ST ME", "GIFT FOR'ST YOU", "WITH MINE HUMBLEST GRATITUDE","TAKEST THEE MINE GIFT, YOUR MAJESTY"},
    pigman_hunter = {"WARE FOR ART THOU", "THY HUMBL'ST PIGGY SERVANT", "REMEMBER'ST ME", "GIFT FOR'ST YOU", "WITH MINE HUMBLEST GRATITUDE","TAKEST THEE MINE GIFT, YOUR MAJESTY"},
}

STRINGS.NAMES.ANTMAN = "蚁人"
STRINGS.NAMES.antman_warrior = "蚁人战士"

STRINGS.CHARACTERS.GENERIC.DESCRIBE.ANTMAN =
{
			GENERIC = "这么大一只虫子！",
			SLEEPING = "一只虫子在睡觉，一直在睡觉。",
			DEAD = "灭虫成功。",
}

STRINGS.CHARACTERS.GENERIC.DESCRIBE.antman_warrior =
{
			GENERIC = "这么大一只虫子！",
			SLEEPING = "一只虫子在睡觉，一直在睡觉。",
			DEAD = "灭虫成功。",
}

STRINGS.NAMES.ANCIENT_HERALD = "远古先驱"
STRINGS.CHARACTERS.GENERIC.DESCRIBE.ANCIENT_HERALD = "远古先驱."
