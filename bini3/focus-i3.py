#!/usr/bin/python3.6

import i3ipc

# Create the Connection object that can be used to send commands and subscribe
# to events.
i3 = i3ipc.Connection()
print("i3-focus started now.")


# Dynamically change border for active window
def on_window_focus(i3, e):
    focused = i3.get_tree().find_focused()
    print("Focused on:" + focused.name)
    if focused.name:
        # i3.command('[class="[.]*"] border pixel 0')
        i3.command('[class="[.]*"] border pixel 5')
        i3.command('border normal')
        # i3.command("gaps outer current minus 4")F
        # i3.command("gaps inner current minus 4")


# else:
#    print("not focused")
#    i3.command("border pixel 0")
#    i3.command("gaps outer current plus 4")
#    i3.command("gaps inner current plus 4")

# Subscribe to events
i3.on("window::focus", on_window_focus)

# Start the main loop and wait for events to come in.
i3.main()
