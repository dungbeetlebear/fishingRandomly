return {
  version = "1.1",
  luaversion = "5.1",
  orientation = "orthogonal",
  width = 18,
  height = 18,
  tilewidth = 64,
  tileheight = 64,
  properties = {},
  tilesets = {
    {
      name = "ground",
      firstgid = 1,
      tilewidth = 64,
      tileheight = 64,
      spacing = 0,
      margin = 0,
      image = "../../../../tools/tiled/dont_starve/tiles.png",
      imagewidth = 512,
      imageheight = 384,
      properties = {},
      tiles = {}
    }
  },
  layers = {
    {
      type = "tilelayer",
      name = "BG_TILES",
      x = 0,
      y = 0,
      width = 18,
      height = 18,
      visible = true,
      opacity = 1,
      properties = {},
      encoding = "lua",
      data = {
        1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
        1, 1, 1, 1, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 1, 1, 1, 1,
        1, 1, 1, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 1, 1, 1,
        1, 1, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 1, 1,
        1, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 1,
        1, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 1,
        1, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 1,
        1, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 1,
        1, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 1,
        1, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 1,
        1, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 1,
        1, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 4, 8, 8, 1,
        1, 8, 8, 8, 6, 6, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 1,
        1, 8, 8, 8, 6, 6, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 1,
        1, 1, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 1, 1,
        1, 1, 1, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 1, 1, 1,
        1, 1, 1, 1, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 1, 1, 1, 1,
        1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1
      }
    },
    {
      type = "objectgroup",
      name = "FG_OBJECTS",
      visible = true,
      opacity = 1,
      properties = {},
      objects = {
        {
          name = "蚁狮",
          type = "antlion_spawner",
          shape = "rectangle",
          x = 320,
          y = 320,
          width = 0,
          height = 0,
          visible = true,
          properties = {}
        },
        {
          name = "眼骨",
          type = "chester_eyebone",
          shape = "rectangle",
          x = 320,
          y = 260,
          width = 14,
          height = 12,
          visible = true,
          properties = {}
        },
        {
          name = "龙蝇",
          type = "dragonfly_spawner",
          shape = "rectangle",
          x = 832,
          y = 832,
          width = 0,
          height = 0,
          visible = true,
          properties = {}
        },
        {
          name = "湖泊",
          type = "oasislake",
          shape = "rectangle",
          x = 832,
          y = 320,
          width = 0,
          height = 0,
          visible = true,
          properties = {}
        },
        {
          name = "盒中泰拉",
          type = "terrarium",
          shape = "rectangle",
          x = 320,
          y = 800,
          width = 0,
          height = 0,
          visible = true,
          properties = {}
        },
        {
          name = "鱼缸",
          type = "hutch_fishbowl",
          shape = "rectangle",
          x = 320,
          y = 810,
          width = 0,
          height = 0,
          visible = true,
          properties = {}
        },
        {
          name = "查理舞台",
          type = "statueharp_hedgespawner",
          shape = "rectangle",
          x = 576,
          y = 450,
          width = 0,
          height = 0,
          visible = true,
          properties = {}
        },
        --[[
        {
          name = "陨石刷新点",
          type = "meteorspawner",
          shape = "rectangle",
          x = 921,
          y = 726,
          width = 0,
          height = 0,
          visible = true,
          properties = {}
        },
        ]]
        {
          name = "查理舞台",
          type = "charlie_stage_post",
          shape = "rectangle",
          x = 576,
          y = 700,
          width = 0,
          height = 0,
          visible = true,
          properties = {}
        },
        {
          name = "蜂后",
          type = "beequeenhive",
          shape = "rectangle",
          x = 320,
          y = 832,
          width = 0,
          height = 0,
          visible = true,
          properties = {}
        },
        {
          name = "复活石",
          type = "resurrectionstone",
          shape = "rectangle",
          x = 320,
          y = 576,
          width = 0,
          height = 0,
          visible = true,
          properties = {}
        },
        {
          name = "风滚草区域",
          type = "item_area",
          shape = "rectangle",
          x = 320,
          y = 600,
          width = 0,
          height = 0,
          visible = true,
          properties = {}
        },
      }
    }
  }
}
