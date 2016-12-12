library(Rfacebook)
library(dplyr)
library(tidyr)
library(reshape2)
library(stringr)
library(ggplot2)

my_oauth <- fbOAuth(app_id = "1445482225484330", app_secret = "bab6070abd17bb3296d88011f0453adb")

save(my_oauth, file = "my_oauth")

load("my_oauth")

me <- getUsers("me", token = my_oauth)
me$name

my_likes <- getLikes(user = "me", token = my_oauth)

logi <- getPage(273503033533, token = my_oauth, n = 2000)
logi_wide <- separate(logi, created_time, c("date, time"), sep = "T")
logi_wid <- cbind(logi, colsplit(logi$created_time, "T", names=c("date", "time")))
logi_wid$time <- substr(logi_wid$time, 1, 5)

logi_wid$date <- as.Date(logi_wid$date)
ggplot(data = logi_wid, aes(x = date, y = likes_count)) +
  geom_point()
pages <- searchPages( string="logitech", token = my_oauth )
