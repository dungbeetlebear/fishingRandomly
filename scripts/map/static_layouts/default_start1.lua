return {
  version = "1.1",
  luaversion = "5.1",
  orientation = "orthogonal",
  width = 14,
  height = 14,
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
      width = 14,
      height = 14,
      visible = true,
      opacity = 1,
      properties = {},
      encoding = "lua",
      --[[
      data = {
        1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
        1, 1, 1, 8, 8, 8, 8, 8, 8, 1, 1, 1,
        1, 1, 8, 8, 8, 8, 8, 8, 8, 8, 1, 1,
        1, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 1,
        1, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 1,
        1, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 1,
        1, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 1,
        1, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 1,
        1, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 1,
        1, 1, 8, 8, 8, 8, 8, 8, 8, 8, 1, 1,
        1, 1, 1, 8, 8, 8, 8, 8, 8, 1, 1, 1,
        1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1
      }
      ]]
      data = {
        1, 1, 1, 1, 1, 1, 8, 8, 1, 1, 1, 1, 1, 1,
        1, 1, 1, 1, 1, 1, 8, 8, 1, 1, 1, 1, 1, 1,
        1, 1, 1, 1, 1, 1, 8, 8, 1, 1, 1, 1, 1, 1,
        1, 1, 1, 1, 1, 1, 8, 8, 1, 1, 1, 1, 1, 1,
        1, 1, 1, 1, 1, 1, 8, 8, 1, 1, 1, 1, 1, 1,
        1, 1, 1, 1, 1, 1, 8, 8, 1, 1, 1, 1, 1, 1,
        1, 1, 1, 1, 1, 1, 8, 8, 1, 1, 1, 1, 1, 1,
        1, 1, 1, 1, 1, 1, 8, 8, 1, 1, 1, 1, 1, 1,
        1, 8, 8, 8, 1, 1, 8, 8, 1, 1, 8, 8, 8, 1,
        8, 8, 8, 8, 8, 1, 8, 8, 1, 8, 8, 8, 8, 8,
        8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8,
        8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8,
        8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8,
        1, 8, 8, 8, 1, 8, 8, 8, 8, 1, 8, 8, 8, 1
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
          name = "大门",
          type = "multiplayer_portal",
          shape = "rectangle",
          x = 448,
          y = 704,
          width = 34,
          height = 32,
          visible = true,
          properties = {}
        },
        {
          name = "大门",
          type = "spawnpoint_master",
          shape = "rectangle",
          x = 448,
          y = 704,
          width = 34,
          height = 32,
          visible = true,
          properties = {}
        },
        {
          name = "复活石",
          type = "resurrectionstone",
          shape = "rectangle",
          x = 192,
          y = 704,
          width = 31,
          height = 31,
          visible = true,
          properties = {}
        },
        {
          name = "复活石",
          type = "resurrectionstone",
          shape = "rectangle",
          x = 704,
          y = 704,
          width = 34,
          height = 33,
          visible = true,
          properties = {}
        },
        {
          name = "舞台",
          type = "stagehand",
          shape = "rectangle",
          x = 448,
          y = 640,
          width = 20,
          height = 18,
          visible = true,
          properties = {}
        },
        {
          name = "主副世界传送门",
          type = "migration_portal",
          shape = "rectangle",
          x = 448,
          y = 768,
          width = 20,
          height = 18,
          visible = true,
          properties = {}
        },
      }
    }
  }
}
