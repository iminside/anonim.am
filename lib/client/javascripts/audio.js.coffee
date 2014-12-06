Nali.extend AudioNotice:

  initialize: ->
    @supported = if typeof Audio is 'function' then true else false

  list: [
    { name: 'Без звука',          file: null                  }
    { name: 'Капля воды 1',       file: 'water_droplet_2'     }
    { name: 'Капля воды 2',       file: 'water_droplet'       }
    { name: 'Капля воды 3',       file: 'water_droplet_3'     }
    { name: 'Пивная пробка',      file: 'beer_can_opening'    }
    { name: 'Колокольчик',        file: 'bell_ring'           }
    { name: 'Сухая ветка',        file: 'branch_break'        }
    { name: 'Переключатель',      file: 'button_click'        }
    { name: 'Клавиатура',         file: 'button_click_on'     }
    { name: 'Кнопка',             file: 'button_push'         }
    { name: 'Маленькая кнопка',   file: 'button_tiny'         }
    { name: 'Фотозатвор 1',       file: 'camera_flashing'     }
    { name: 'Фотозатвор 2',       file: 'camera_flashing_2'   }
    { name: 'CD-лоток',           file: 'cd_tray'             }
    { name: 'Ошибка',             file: 'computer_error'      }
    { name: 'Звонок',             file: 'door_bell'           }
    { name: 'Стук двери',         file: 'door_bump'           }
    { name: 'Стекло',             file: 'glass'               }
    { name: 'Клавиатурный лоток', file: 'keyboard_desk'       }
    { name: 'Лампочка разбилась', file: 'light_bulb_breaking' }
    { name: 'Лист металла 1',     file: 'metal_plate'         }
    { name: 'Лист металла 2',     file: 'metal_plate_2'       }
    { name: 'Пробка шампанского', file: 'pop_cork'            }
    { name: 'Щелчок',             file: 'snap'                }
    { name: 'Степлер',            file: 'staple_gun'          }
    { name: 'Стук',               file: 'tap'                 }
  ]

  play: ( index ) ->
    sound = @list[ +index ]
    if sound.file? and @supported
      unless sound.player?
        sound.player     = new Audio
        sound.player.src = '/sounds/' + sound.file + @ext()
        sound.player.load()
      if sound.player.readyState
        sound.player.pause()
        sound.player.currentTime = 0
      sound.player.play()
    else @Notice.error 'Извините, но ваш браузер не поддерживает воспроизведение звука'

  ext: ->
    switch ( new Audio ).canPlayType( 'audio/mpeg' )
      when 'probably', 'maybe' then '.mp3'
      else                          '.ogg'
