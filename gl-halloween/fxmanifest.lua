--[[ FX Information ]] --
fx_version 'cerulean'
use_experimental_fxv2_oal 'yes'
lua54 'yes'
game 'gta5'

--[[ Resource Information ]] --
name 'gl-halloween'
description 'Przerobiona wersja skryptu Kallocka - https://forum.cfx.re/t/free-trick-or-treat-script/4769297'
version '1.0.1'
author 'Katakume, Kallock'

--[[ Manifest ]] --
shared_scripts {
    '@es_extended/imports.lua',
    '@ox_lib/init.lua',
    'shared.lua'
}

client_scripts {
    'client.lua'
}

server_scripts {
    '@oxmysql/lib/MySQL.lua',
    'server.lua'
}

dependencies {
    'oxmysql',
    'Astro-NotifySystem',
    'ox_lib',
    'es_extended'
}
