library(telegram.bot)
library(tidyverse)
library(RSQLite)
library(DBI)
library(configr)

# work directory
setwd(Sys.getenv('TG_BOT_PATH'))

# read config
cfg <- read.config('config.cfg')

# bot instance
updater <- Updater(cfg$bot_settings$bot_token)

# loading R code
source('db_bot_function.R') # read db functions
source('bot_methods.R')     # read bot methods
source('message_filters.R') # message state filters
source('handlers.R') # message state filters

# dispetcher
updater <- updater +
  start_h +
  wait_age_h +
  wait_name_h +
  state_h +
  reset_h

# run bot
updater$start_polling()