# ###########################################################
# bot methods

# start dialog
start <- function(bot, update) {
  
  # 
  
  # Send query
  bot$sendMessage(update$message$chat_id, 
                  text = "����� ��� ���")
  
  # ����������� ��������� ������� � ����� �������� ����� �����
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
                  text = paste0(uname, ", ������� ������������, � ���!"))
  
  # ���������� ��� � ���������� ����������
  #username <<- uname
  set_chat_data(update$message$chat_id, 'name', uname) 
  
  # ����������� �������
  bot$sendMessage(update$message$chat_id, 
                  text = "������� ���� ���?")
  
  # ������ ��������� �� �������� ����� �����
  set_state(chat_id = update$message$chat_id, state = 'wait_age')
  
}

# enter user age
enter_age <- function(bot, update) {
  
  uage <- as.numeric(update$message$text)
  
  # ��������� ���� ������� ����� ��� ���
  if ( is.na(uage) ) {
    
    # ���� ������� �� ����� �� �������������� �������
    bot$sendMessage(update$message$chat_id, 
                    text = "�� ��� ������������ ������, ����� �����")
    
  } else {
    
    # ���� ������� ����� �������� ��� ������� ������
    bot$sendMessage(update$message$chat_id, 
                    text = "��, ������� ������")
    
    # ���������� ���������� ���������� � ���������
    #userage <<- uage
    set_chat_data(update$message$chat_id, 'age', uage) 
    
    # �������� ����� ������ ���� �������
    username <- get_chat_data(update$message$chat_id, 'name')
    userage  <- get_chat_data(update$message$chat_id, 'age')
    
    bot$sendMessage(update$message$chat_id, 
                    text = paste0("���� ����� ", username, " � ���� ", userage, " ���. ����� �������"))
    
    # ���������� ������ � �������� ���������
    set_state(chat_id = update$message$chat_id, state = 'start')
  }
  
}
