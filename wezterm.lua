-- Pull in the wezterm API
local wezterm = require 'wezterm'

-- This will hold the configuration.
local config = wezterm.config_builder()

-- This is where you actually apply your config choices
config.enable_tab_bar = false
--window_background_opacity = .90
-- For example, changing the color scheme:
config.color_scheme = 'Rosé Pine (base16)'
config.show_tabs_in_tab_bar = false
config.use_fancy_tab_bar = false
config.show_new_tab_button_in_tab_bar = false
config.window_decorations = "RESIZE"
config.font = wezterm.font('IosevkaNerdFont', { weight= 'Bold',italic = true})

local wezterm = require 'wezterm'

function recompute_padding(window)
  local window_dims = window:get_dimensions()
  local overrides = window:get_config_overrides() or {}

  if not window_dims.is_full_screen then
    if not overrides.window_padding then
      -- not changing anything
      return
    end
    overrides.window_padding = nil
  else
    -- Use only the middle 33%
    local third = math.floor(window_dims.pixel_width / 3)
    local new_padding = {
      left = third,
      right = third,
      top = 0,
      bottom = 0,
    }
    if
      overrides.window_padding
      and new_padding.left == overrides.window_padding.left
    then
      -- padding is same, avoid triggering further changes
      return
    end
    overrides.window_padding = new_padding
  end
  window:set_config_overrides(overrides)
end

wezterm.on('window-resized', function(window, pane)
  recompute_padding(window)
end)

wezterm.on('window-config-reloaded', function(window)
  recompute_padding(window)
end)


--config.window_background_opacity =0
--config.text_background_opacity = 0.85
--config.background= {
 -- {
  --  source = {'/home/hhgsxdesktop/Downloads/wallhaven-85vypy.jpg}'
  --},
   -- opacity = 0.9 ,
--}
-- and finally, return the configuration to wezterm
return config

