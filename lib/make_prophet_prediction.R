#Make Predictions function
library(prophet)

make_prophet_prediction <- function(df, time_stamp = "ds", response = "y", periods = 10, freq = 60*60) {
  history <- df %>% 
    select_(.dots = c(time_stamp, response))
  m <- prophet(history)
  future <- make_future_dataframe(m, periods = periods, freq = freq)
  forecast <- predict(m, future) %>% tail(1)
  list(
    lower = forecast$yhat_lower,
    upper = forecast$yhat_upper
  )
}


# fit <- make_prophet_prediction(df_sample, time_stamp = "ds", response = "y")
