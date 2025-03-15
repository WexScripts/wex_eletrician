fx_version 'cerulean'
games { 'rdr3', 'gta5' }
lua54 'yes'
author 'tobix'
description 'easy eletrician job'
version '1.0.1'

files {
    'locales/*.json'
  }
  
shared_scripts {
    '@ox_lib/init.lua',
    'shared/*.lua'
}
server_scripts {
    'server/*.lua'
}
client_scripts {
    'client/*.lua'
}

dependency 'mx_fixwiring'
