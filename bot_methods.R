# ###########################################################
# bot methods

# start dialog
start <- function(bot, update) {
  
  # 
  
  # Send query
  bot$sendMessage(update$message$chat_id, 
                  text = "Введи своё имя")
  
  # переключаем состояние диалога в режим ожидания ввода имени
  set_state(chat_id = update$message$chat_id, state = 'wait_name')
  
}

# get current chat state
state <- function(bot, update) {
  
  chat_state <- get_state(update$message$chat_id)
  
  # Send state
  bot$sendMessage(update$message$chat_id, 
                  text = unlist(chat_state))
  
}

# reset dialog state
reset <- function(bot, update) {
  
  set_state(chat_id = update$message$chat_id, state = 'start')
  
}

# enter username
enter_name <- function(bot, update) {
  
  uname <- update$message$text
  
  # Send message with name
  bot$sendMessage(update$message$chat_id, 
                  text = paste0(uname, ", приятно познакомится, я бот!"))
  
  # Записываем имя в глобальную переменную
  #username <<- uname
  set_chat_data(update$message$chat_id, 'name', uname) 
  
  # Справшиваем возраст
  bot$sendMessage(update$message$chat_id, 
                  text = "Сколько тебе лет?")
  
  # Меняем состояние на ожидание ввода имени
  set_state(chat_id = update$message$chat_id, state = 'wait_age')
  
}

# enter user age
enter_age <- function(bot, update) {
  
  uage <- as.numeric(update$message$text)
  
  # проверяем было введено число или нет
  if ( is.na(uage) ) {
    
    # если введено не число то переспрашиваем возраст
    bot$sendMessage(update$message$chat_id, 
                    text = "Ты ввёл некорректные данные, введи число")
    
  } else {
    
    # если введено число сообщаем что возраст принят
    bot$sendMessage(update$message$chat_id, 
                    text = "ОК, возраст принят")
    
    # записываем глобальную переменную с возрастом
    #userage <<- uage
    set_chat_data(update$message$chat_id, 'age', uage) 
    
    # сообщаем какие данные были собраны
    username <- get_chat_data(update$message$chat_id, 'name')
    userage  <- get_chat_data(update$message$chat_id, 'age')
    
    bot$sendMessage(update$message$chat_id, 
                    text = paste0("Тебя зовут ", username, " и тебе ", userage, " лет. Будем знакомы"))
    
    # возвращаем диалог в исходное состояние
    set_state(chat_id = update$message$chat_id, state = 'start')
  }
  
}
