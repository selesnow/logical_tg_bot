# ###########################################################
# message state filters

# фильтр сообщение в состо€нии ожидани€ имени
MessageFilters$wait_name <- BaseFilter(function(message) {
  get_state( message$chat_id )  == "wait_name"
}
)

# фильтр сообщение в состо€нии ожидани€ возраста
MessageFilters$wait_age <- BaseFilter(function(message) {
  get_state( message$chat_id )   == "wait_age"
}
)