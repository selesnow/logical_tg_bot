# ###########################################################
# Function for work bot with database

# get current chat state
get_state <- function(chat_id) {
  
  con <- dbConnect(SQLite(), cfg$db_settings$db_path)
  
  chat_state <- dbGetQuery(con, str_interp("SELECT state FROM chat_state WHERE chat_id == ${chat_id}"))$state
  
  return(unlist(chat_state))
  
  dbDisconnect(con)
}

# set current chat state
set_state <- function(chat_id, state) {
  
  con <- dbConnect(SQLite(), cfg$db_settings$db_path)
  
  # upsert состояние чата
  dbExecute(con, 
            str_interp("
            INSERT INTO chat_state (chat_id, state)
                VALUES(${chat_id}, '${state}') 
                ON CONFLICT(chat_id) 
                DO UPDATE SET state='${state}';
            ")
  )
  
  dbDisconnect(con)
  
}

# write chat data
set_chat_data <- function(chat_id, field, value) {
  
  
  con <- dbConnect(SQLite(), cfg$db_settings$db_path)
  
  # upsert состояние чата
  dbExecute(con, 
            str_interp("
            INSERT INTO chat_data (chat_id, ${field})
                VALUES(${chat_id}, '${value}') 
                ON CONFLICT(chat_id) 
                DO UPDATE SET ${field}='${value}';
            ")
  )
  
  dbDisconnect(con)
  
}

# read chat data
get_chat_data <- function(chat_id, field) {
  
  
  con <- dbConnect(SQLite(), cfg$db_settings$db_path)
  
  # upsert состояние чата
  data <- dbGetQuery(con, 
                     str_interp("
            SELECT ${field}
            FROM chat_data
            WHERE chat_id = ${chat_id};
            ")
  )
  
  dbDisconnect(con)
  
  return(data[[field]])
  
}