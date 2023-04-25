#!/usr/bin/env python3.7

import iterm2
import os

async def main(connection):
    app = await iterm2.async_get_app(connection)

    def home(str):
      return "{}/{}".format(os.environ["HOME"], str)

    def writeCache(name):
        f = open(home(".cache/iterm_profile"), "w")
        f.write(name)
        f.close()

    def updateNvimSessions(name):
        bin = home(".dotfiles/bin/for-each-nvim 'set bg={}'").format(name)
        os.system(bin)

    async def setProfile(name):
        partialProfiles = await iterm2.PartialProfile.async_query(connection)

        for partial in partialProfiles:
            if partial.name == name:
                profile = await partial.async_get_full_profile()
                for tab in app.current_terminal_window.tabs:
                    await tab.current_session.async_set_profile(profile)
                updateNvimSessions(name)
                writeCache(name)
                return

    @iterm2.RPC
    async def profileDark():
        await setProfile("dark")

    await profileDark.async_register(connection)

    @iterm2.RPC
    async def profileLight():
        await setProfile("light")

    await profileLight.async_register(connection)

iterm2.run_forever(main)
