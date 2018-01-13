set.seed(1834)

time_now <- Sys.time()
time_later <- time_now + 100*60*60

df_sample <- data.frame(machine_name = rep("mixer_1",6001),
                        ds = seq.POSIXt(from = (time_now), to = (time_later), 60),
                        y = rnorm(6001,20,6)+rnorm(6001,0,1))

fit <-prophet::prophet(df_sample)

future <- make_future_dataframe(fit, period = 10, freq = 60*60)

forecast <- predict(fit, future)

forecast %>% tail(1)
plot(fit, forecast)
prophet_plot_components(fit, forecast)


prophet_prediction <- function(df, time_stamp = ds, response = y, period = 10, freq = 60*60) {
  history <- cbind( ds = df$time_stamp, y = df$response )
  m <- prophet(history)
  future <- make_future_dataframe(m, periods = 1)
  forecast <- predict(m, future) %>% tail(1)
  list(
    lower = forecast$yhat_lower,
    upper = forecast$yhat_upper
  )
}

prophet_prediction <- function(df, time_stamp = "ds", response = "y", period = 10, freq = 60*60) {
  history <- df %>% 
    select_(.dots = c(time_stamp, response))
  head(history)}
prophet_prediction(df_sample, time_stamp = "ds", response = "y")

