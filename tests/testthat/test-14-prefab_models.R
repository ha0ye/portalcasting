context("Test prefab model functions")

# forecast

main = "./testing"

test_that("AutoArima", {
  skip_on_cran() # downloads and casting take too long to run on cran
  fill_data(main = main)
  keepers <- c("moon", "BA", "DM", "DO")
  all <- read_rodents_table(main = main)
  rest_cols <- which(colnames(all) %in% keepers)
  all2 <- all[, rest_cols]
  all2$BA <- 0
  all2$DO <- c(rep(0, nrow(all2) - 1), 1)
  write.csv(all2, file_path(main = main, "data", "rodents_all.csv"), 
             row.names = FALSE)

  keepers <- c("moon", "DM")
  controls <- read_rodents_table(main = main, "controls")
  rest_cols <- which(colnames(controls) %in% keepers)
  controls2 <- controls[, rest_cols]
  write.csv(controls2, file_path(main = main, 
                                 "data", "rodents_controls.csv"), 
            row.names = FALSE)
  expect_message(f_a <- AutoArima(main = main, 
                                  data_set = "All", quiet = FALSE))
  expect_message(f_c <- AutoArima(main = main, 
                                  data_set = "Controls", quiet = FALSE))
  expect_is(f_a, "list")
  expect_is(f_c, "list")
})

test_that("NaiveArima", {
  skip_on_cran() # downloads and casting take too long to run on cran
  expect_message(f_c <- NaiveArima(main = "./testing",  
                                   data_set = "Controls", quiet = FALSE))
  expect_message(f_a <- NaiveArima(main = "./testing", 
                                   data_set = "All", quiet = FALSE))

  expect_is(f_a, "list")
  expect_is(f_c, "list")
})



test_that("ESSS", {
  skip_on_cran() # downloads and casting take too long to run on cran

  keepers <- c("moon", "BA", "DM", "DO")
  all <- read_rodents_table(main = main, "all_interp")
  rest_cols <- which(colnames(all) %in% keepers)
  all2 <- all[, rest_cols]
  all2$BA <- 0
  all2$DO <- c(rep(0, nrow(all2) - 1), 1)
  write.csv(all2, file_path(main = main, "data", "rodents_all_interp.csv"), 
             row.names = FALSE)

  keepers <- c("moon", "DM")
  controls <- read_rodents_table(main = main, "controls_interp")
  rest_cols <- which(colnames(controls) %in% keepers)
  controls2 <- controls[, rest_cols]
  write.csv(controls2, file_path(main = main, 
                                 "data", "rodents_controls_interp.csv"), 
            row.names = FALSE)



  expect_message(f_c <- ESSS(main = "./testing",  
                             data_set = "Controls_interp", quiet = FALSE))
  expect_message(f_a <- ESSS(main = "./testing", 
                             data_set = "All_interp", quiet = FALSE))

  expect_is(f_a, "list")
  expect_is(f_c, "list")
})



test_that("nbGARCH", {
  skip_on_cran() # downloads and casting take too long to run on cran
  expect_message(f_c <- nbGARCH(main = "./testing",  
                                data_set = "Controls_interp", quiet = FALSE))
  expect_message(f_a <- nbGARCH(main = "./testing", 
                                data_set = "All_interp", quiet = FALSE))

  expect_is(f_a, "list")
  expect_is(f_c, "list")
})

test_that("nbsGARCH", {
  skip_on_cran() # downloads and casting take too long to run on cran
  expect_message(f_c <- nbsGARCH(main = "./testing",  
                                 data_set = "Controls_interp", quiet = FALSE))
  expect_message(f_a <- nbsGARCH(main = "./testing", 
                                 data_set = "All_interp", quiet = FALSE))

  expect_is(f_a, "list")
  expect_is(f_c, "list")
})

test_that("pevGARCH", {
  skip_on_cran() # downloads and casting take too long to run on cran
  expect_message(f_c <- pevGARCH(main = "./testing",  
                                 data_set = "Controls_interp", quiet = FALSE))
  expect_message(f_a <- pevGARCH(main = "./testing", 
                                 data_set = "All_interp", quiet = FALSE))

  expect_is(f_a, "list")
  expect_is(f_c, "list")
})

test_that("pevGARCH", {
  skip_on_cran() # downloads and casting take too long to run on cran
  fill_data(main = "./testing", end_moon = 520)

  keepers <- c("moon", "BA", "DM", "DO")
  all <- read_rodents_table(main = main, "all_interp")
  rest_cols <- which(colnames(all) %in% keepers)
  all2 <- all[, rest_cols]
  all2$BA <- 0
  all2$DO <- c(rep(0, nrow(all2) - 1), 1)
  write.csv(all2, file_path(main = main, "data", "rodents_all_interp.csv"), 
             row.names = FALSE)

  keepers <- c("moon", "DM")
  controls <- read_rodents_table(main = main, "controls_interp")
  rest_cols <- which(colnames(controls) %in% keepers)
  controls2 <- controls[, rest_cols]
  write.csv(controls2, file_path(main = main, 
                                 "data", "rodents_controls_interp.csv"), 
            row.names = FALSE)

  expect_message(f_a <- pevGARCH(main = "./testing", lag = 6,
                                  data_set = "all_interp", quiet = FALSE))
  expect_message(f_c <- pevGARCH(main = "./testing", lag = 6, 
                              data_set = "controls_interp", quiet = FALSE))

  expect_is(f_a, "list")
  expect_is(f_c, "list")
})