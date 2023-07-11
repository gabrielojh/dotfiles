-- Pull in the wezterm API
local wezterm = require("wezterm")

-- Pull in local dependencies
local theme = require('helpers.theme')
local background = require('helpers.background')

-- This table will hold the configuration.
local config = {}

-- In newer versions of wezterm, use the config_builder which will
-- help provide clearer error messages
if wezterm.config_builder then
  config = wezterm.config_builder()
end

theme.apply_to_config(config)
background.apply_to_config(config)

-- and finally, return the configuration to wezterm
return config
