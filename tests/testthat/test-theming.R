test_that("Test that the theming app works as expected", {
  
  expect_snapshot(pickerInput("test_id", "Test", choices = c("A", "B")))
  
})

# https://shiny.rstudio.com/articles/server-function-testing.html
test_that("Dataset selction works",

          {

testServer(
  themingServer,
  {
    session$setInputs(data_in = "airquality")
    session$setInputs(x_val = "Wind")
    session$setInputs(y_val = "Ozone")
    expect_equal(in_data(), airquality)
    expect_equal(input$x_val, "Wind")
    expect_equal(input$y_val, "Ozone")
    
  }
)

          }

          )