test_that("Test that the theming app works as expected", {
  
  expect_snapshot(pickerInput("test_id", "Test", choices = c("A", "B")))
  
})

testServer()