--[[
    # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
    #         __  .__                 __  .__                                          __           #
    # _____ _/  |_|  | _____    _____/  |_|__| ______     ___________ ___.__.______  _/  |_  ____   #
    # \__  \\   __\  | \__  \  /    \   __\  |/  ___/   _/ ___\_  __ <   |  |\____ \ \   __\/  _ \  #
    #  / __ \|  | |  |__/ __ \|   |  \  | |  |\___ \    \  \___|  | \/\___  ||  |_> > |  | (  <_> ) #
    # (____  /__| |____(____  /___|  /__| |__/____  >____\___  >__|   / ____||   __/  |__|  \____/  #
    #      \/               \/     \/             \/_____/   \/       \/     |__|                   #
    # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
]]
Config = {}

-- Language settings
Config.Locale = 'it'

-- TickTime
Config.TickTime = 1000

-- Generic coin item name
Config.CryptoCoin = 'crypto_coin'

-- Possible coin after mining // Always item names!
Config.ProcessedCoin = {
    [0] = 'btc',
    [1] = 'shiba'
}

-- Delays
Config.Delays = {
    Farming = 5000,
    Processing = 15000
}

Config.CryptoStation = {
    Farming = {
        Points = vector3(566.1, -3124.8, 18.8)
    },

    Processing = {
        Points = vector3(1275.3, -1710.5, 54.8)
    }
}