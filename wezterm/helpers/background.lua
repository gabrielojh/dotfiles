local wezterm = require 'wezterm'

local module = {}

function module.apply_to_config(config)
  config.background = {
    {
      source = {
        File = '/Users/gabriel/.config/wezterm/assets/xeno-minimalist-background.jpeg',
      },
      height = '100%',
      width = '100%',
      hsb = {
        brightness = 0.3,
      },
    },
  }
end

return module

