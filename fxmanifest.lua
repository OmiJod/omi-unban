fx_version 'cerulean'
game 'gta5'

description 'omi-unban'
author 'NullValue🌙#6848'
version '1.0.0'

client_script {
    'client.lua',
}

server_scripts {
    '@oxmysql/lib/MySQL.lua',
    'server/*.lua',
}

shared_scripts {
    '@ox_lib/init.lua',
}

lua54 'yes'