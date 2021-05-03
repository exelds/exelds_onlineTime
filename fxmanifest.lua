fx_version 'adamant'
games { 'gta5' }

description 'ExeLds Play Time Counter'

client_scripts {
    'client.lua'
}

server_scripts {
    '@mysql-async/lib/MySQL.lua',
    'server.lua'
}
