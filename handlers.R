# ###########################################################
# handlers

# command handlers
start_h <- CommandHandler('start', start)
state_h <- CommandHandler('state', state)
reset_h <- CommandHandler('reset', reset)

# message handlers
## !MessageFilters$command - означает что команды данные обработчики не обрабатывают, 
## только текстовые сообщения
wait_age_h  <- MessageHandler(enter_age,  MessageFilters$wait_age  & !MessageFilters$command)
wait_name_h <- MessageHandler(enter_name, MessageFilters$wait_name & !MessageFilters$command)
