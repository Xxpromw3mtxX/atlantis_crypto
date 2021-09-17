fx_version 'cerulean'
game 'gta5'

name 'atlantis_crypto'
author 'lilfraae'
description 'Atlantis Crypto Script'
version '1.0'

client_scripts {
    'client/cl_script.lua'
}

server_script {
    'server/sv_script.lua'
}

shared_scripts {
    '@es_extended/locale.lua',
    'locales/*.lua',
    'shared/config.lua'
}