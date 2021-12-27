test_that("Test that the theming app works as expected", {
  
  expect_snapshot(pickerInput("test_id", "Test", choices = c("A", "B")))
  
})


# test_that("Dataset selction works",
#           
#           {
#             
# testServer(
#   themingServer,
#   {
#     dataset <- session$getReturned()
#     
#     session$setInputs(data_in = "mtcars")
#     
#     expect_equal(dataset(), mtcars)
#   }
# )            
#             
#           }
#           
#           )