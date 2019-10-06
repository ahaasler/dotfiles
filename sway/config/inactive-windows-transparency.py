#!/usr/bin/python

# Author: Konstantin Kharlamov <Hi-Angel@yandex.ru>
# Modifications: Adrian Haasler <dev@adrianhaasler.com>
# - Add custom transparency settings for specific windows
# License: MIT (licenses/swaywm-sway) and MIT (LICENSE) for modifications

# This script requires i3ipc-python package (install it from a system package manager
# or pip).
# It makes inactive windows transparent. Use `inactive_default_transparency` variable to control
# transparency strength in range of 0…1.

import i3ipc

inactive_default_transparency = '0.8';
active_default_transparency = '0.9';
inactive_transparencies = {
	'vscodium' : '0.78',
	'browser' : '0.9'
}
active_transparencies = {
	'vscodium' : '0.88',
	'browser' : '0.97'
}
ipc              = i3ipc.Connection()
prev_focused     = None

def get_transparency(container, values, default):
	return values.get(container.name,
		values.get(container.window_title,
			values.get(container.window_instance,
				values.get(container.window_class,
					values.get(container.app_id,
						values.get(container.window_role, default)
					)
				)
			)
		)
	)


def get_inactive_transparency(container):
	return get_transparency(container, inactive_transparencies, inactive_default_transparency)

def get_active_transparency(container):
	return get_transparency(container, active_transparencies, active_default_transparency)

for window in ipc.get_tree():
	if window.focused:
		prev_focused = window
		window.command('opacity ' + get_active_transparency(window))
	else:
		window.command('opacity ' + get_inactive_transparency(window))

def on_window_focus(ipc, focused):
	global prev_focused
	if focused.container.id != prev_focused.id: # https://github.com/swaywm/sway/issues/2859
		focused.container.command('opacity ' + get_active_transparency(focused.container))
		prev_focused.command('opacity ' + get_inactive_transparency(prev_focused))
		prev_focused = focused.container

ipc.on("window::focus", on_window_focus)
ipc.main()
