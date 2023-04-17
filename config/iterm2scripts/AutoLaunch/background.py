#!/usr/bin/env python3.7

import iterm2

async def main(connection):
    app = await iterm2.async_get_app(connection)

    async def setProfile(name):
        partialProfiles = await iterm2.PartialProfile.async_query(connection)
        for partial in partialProfiles:
            if partial.name == name:
                profile = await partial.async_get_full_profile()
                await app.current_terminal_window.current_tab.current_session.async_set_profile(profile)
                f = open("/Users/kassioborges/.cache/iterm_profile", "w")
                f.write(name)
                f.close()
                return

    @iterm2.RPC
    async def darkBackground():
        await setProfile("dark")

    await darkBackground.async_register(connection)

    @iterm2.RPC
    async def lightBackground():
        await setProfile("light")

    await lightBackground.async_register(connection)

iterm2.run_forever(main)
