name = "海钓随机物品"
description = [[
当玩家空钩时，将能够随机钓起物品。
1.1.8 起始地区换为空白房间，添加中庭、月亮石、Boss等岛屿
1.1.9 初始时或换人时，可以获得一个特殊海钓竿,调整中庭岛。
1.2.8 添加猴岛，月亮石岛添加盒中泰拉，调整一下物品概率，修改了海钓竿绑定问题，新增钓起事件
1.2.10 更改瓶中信可以查看其他岛屿位置，其他调整
1.2.11 单向生命链接bug的修复，兼容神话岛，使其能被瓶中信查看到
1.2.14 修复bug，新添加混乱岛，控制天体科技的材料数量尽量维持一组
1.2.15 添加海钓风格
1.2.19 添加新mod设置,移除部分mod设置
4/2添加了分滚草，删除若干岛屿，平衡性修改
西伯利亚鼠修改
]]
author = "月(西伯利亚鼠修改)"

version = "1.2.14"

api_version = 10

all_clients_require_mod = true
client_only_mod = false
dst_compatible = true

forumthread = ""

priority = -9998 -- 优先级


icon_atlas = "fishingrod.xml"
icon = "fishingrod.tex"

-- mod设置选项
configuration_options = {
	{
		name = "minmap",
		label = "地图生成大小",
		hover = "根据需要选择",
		options =
		{
			{description = "150超级小", data = 150, hover = ""},
			{description = "160", data = 160, hover = ""},
			{description = "170", data = 170, hover = ""},
			{description = "180", data = 180, hover = ""},
			{description = "190", data = 190, hover = ""},
			{description = "200", data = 200, hover = ""},
			{description = "250", data = 250, hover = ""},
			{description = "300", data = 300, hover = ""},
			{description = "400", data = 400, hover = ""},
		},
		default = 150,
	},
	{
		name = "atriumgate",
		label = "远古大门冷却时间",
		hover = "远古大门默认是20天冷却期",
		options =
		{
			{description = "5天", data = 5, hover = ""},
			{description = "10天", data = 10, hover = ""},
			{description = "20天", data = 20, hover = ""},
			{description = "30天", data = 30, hover = ""},
			{description = "40天", data = 40, hover = ""},
		},
		default = 5,
	},
	{
		name = "sleeper",
		label = "生物是否睡眠",
		hover = "一般生物被钓起时是否处于睡眠状态",
		options =
		{
			{description = "开启(ON)", data = false, hover = ""},
			{description = "关闭(OFF)", data = true, hover = ""},
		},
		default = false,
	},
	{
		name = "build",
		label = "海上建筑",
		hover = "建筑物最终被钓起到岸上，还是钓起在海面上",
		options =
		{
			{description = "开启(ON)", data = true, hover = "在海上"},
			{description = "关闭(OFF)", data = false, hover = "在岸上"},
		},
		default = true,
	},
	{
		name = "no_crafting",
		label = "玩家没有科技",
		hover = "玩家没有左侧科技,没有则无法制作, 开启赌狗模式",
		options =
		{
			{description = "开启(ON)", data = true, hover = ""},
			{description = "关闭(OFF)", data = false, hover = ""},
		},
		default = false,
	},
	{
		name = "suffering",
		label = "受难模式",
		hover = "调整怪物掉落物品",
		options =
		{
			{description = "开启(ON)", data = true, hover = ""},
			{description = "关闭(OFF)", data = false, hover = ""},
		},
		default = true,		
	},
	{--风滚草可捕捉
	name = "cancatch_tumbleweed_switch",
	label = "捕捉风滚草",
	hover = "风滚草是否能像蝴蝶一样可捕捉",
	options =
	{
		{description = "Open", data = true, hover = "能"},
		{description = "Close", data = false, hover = "不能"},
	},
	default = false,
},
}