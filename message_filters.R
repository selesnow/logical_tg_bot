# ###########################################################
# message state filters

# ������ ��������� � ��������� �������� �����
MessageFilters$wait_name <- BaseFilter(function(message) {
  get_state( message$chat_id )  == "wait_name"
}
)

# ������ ��������� � ��������� �������� ��������
MessageFilters$wait_age <- BaseFilter(function(message) {
  get_state( message$chat_id )   == "wait_age"
}
)