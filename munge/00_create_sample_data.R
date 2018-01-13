set.seed(1834)

time_now <- Sys.time()
time_later <- time_now + 60*100*60

df_sample <- data.frame(machine_name = "mixer_1",
                        ds = seq(as.POSIXct(time_now), as.POSIXct(time_later), by="hour"),
                        y = rnorm(101,20,1))


prophet_prediction <- function(y) {
  history <- data.frame(ds = seq.Date(
    from = as.Date("1970-01-01"),
    by = "secs", length.out = length(y)), y = y)
  m <- prophet(history)
  future <- make_future_dataframe(m, periods = 1)
  forecast <- predict(m, future) %>% tail(1)
  list(
    lower = forecast$yhat_lower,
    upper = forecast$yhat_upper
  )
}

fit <-prophet::prophet(df_sample)
