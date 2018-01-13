#MAke some sample data to test tghe function

set.seed(1834)

time_now <- Sys.time()
time_later <- time_now + 100*60*60

df_sample <- data.frame(machine_name = rep("mixer_1",6001),
                        ds = seq.POSIXt(from = (time_now), to = (time_later), 60),
                        y = rnorm(6001,20,6)+rnorm(6001,0,1))

