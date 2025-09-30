

#Taro Katayama

setwd("C:/Users/tkatayama/OneDrive - DOI/Documents/Projects/R/Invasives_Data_Entry")
library(shiny)
#install.packages("openxlsx")
library(openxlsx)


# Define UI
ui <- fluidPage(
  titlePanel("Invasive Species Data Entry"),
  
  sidebarLayout(
    sidebarPanel(
      dateInput("date", "Survey Date:", value = Sys.Date(), format = "mm/dd/yyyy"),
      
      selectInput("Site", "Site:",
                  choices = c("Select site", "BT", "CR", "OT", "Gunmount", "HS", "CA", "TS")),
      
      numericInput("Site Number", "Site Number:", value = 1, min = 1),
      
      numericInput("Total Time", "Total Time:", value =0, min = 0),
                  
      numericInput("# of People", "# of People:", value = 1, min = 1),
      
      numericInput("Acres Treated", "Acres Treated:", value = 0, min = 0),
      
      numericInput("Trim Hours", "Trim Hours:", value =0, min = 0),
      
      selectInput("Target Species 1", "Target Species 1:",
                  choices = c("Select species", "ATRSEM", "BRODIA", "BRORUB", "CENMEL", "FESMYU", "FESPER", "HORMUR", "MESCRY",
                              "MESNOD", "PARINIC", "SAL spp.", "SONASP", "SONOLE")),
      selectInput("Target Species 2", "Target Species 2:",
                  choices = c("Select species", "ATRSEM", "BRODIA", "BRORUB", "CENMEL", "FESMYU", "FESPER", "HORMUR", "MESCRY",
                              "MESNOD", "PARINIC", "SAL spp.", "SONASP", "SONOLE")),
      selectInput("Target Species 3", "Target Species 3:",
                  choices = c("Select species", "ATRSEM", "BRODIA", "BRORUB", "CENMEL", "FESMYU", "FESPER", "HORMUR", "MESCRY",
                              "MESNOD", "PARINIC", "SAL spp.", "SONASP", "SONOLE")),
      selectInput("Target Species 4", "Target Species 4:",
                  choices = c("Select species", "ATRSEM", "BRODIA", "BRORUB", "CENMEL", "FESMYU", "FESPER", "HORMUR", "MESCRY",
                              "MESNOD", "PARINIC", "SAL spp.", "SONASP", "SONOLE")),
      selectInput("Target Species 5", "Target Species 5:",
                  choices = c("Select species", "ATRSEM", "BRODIA", "BRORUB", "CENMEL", "FESMYU", "FESPER", "HORMUR", "MESCRY",
                              "MESNOD", "PARINIC", "SAL spp.", "SONASP", "SONOLE")),
      selectInput("Target Species 6", "Target Species 6:",
                  choices = c("Select species", "ATRSEM", "BRODIA", "BRORUB", "CENMEL", "FESMYU", "FESPER", "HORMUR", "MESCRY",
                              "MESNOD", "PARINIC", "SAL spp.", "SONASP", "SONOLE")),
      selectInput("Target Species 7", "Target Species 7:",
                  choices = c("Select species", "ATRSEM", "BRODIA", "BRORUB", "CENMEL", "FESMYU", "FESPER", "HORMUR", "MESCRY",
                              "MESNOD", "PARINIC", "SAL spp.", "SONASP", "SONOLE")),
      numericInput("# of Truckloads", "# of Truckloads:", value = 0, min = 0),
      
      numericInput("# of Bags", "# of Bags:", value = 0, min = 0),
      
      textInput("Initials", "Enter Initials:", placeholder = "Type here"),
      
      actionButton("submit", "Submit"),
      actionButton("removeLast", "Remove Last Entry"),
      downloadButton("downloadData", "Download Excel Yurrrrrr")
    ),
    
    mainPanel(
      textOutput("status"),
      h4("Last 5 Entries:"),
      tableOutput("recentDataTable"),
      hr(),
      h4("Monthly Summary:"),
      tableOutput("monthlySummary"),
      hr(),
      h4("Quarterly Summary:"),
      tableOutput("quarterlySummary"),
      hr(),
      h4("All Recorded Data:"),
      tableOutput("dataTable")
    )
  )
)

# Define server logic
server <- function(input, output, session) {
  
  # File path for the Excel file
  excel_file_path <- "invasive_species_data.xlsx"
  
  # Function to save data with summaries to Excel
  save_data_with_summaries <- function(data_to_save) {
    # Create workbook
    wb <- createWorkbook()
    
    # Add main data sheet (original data without extra columns)
    addWorksheet(wb, "Data")
    writeData(wb, "Data", data_to_save)
    
    if (nrow(data_to_save) > 0) {
      # Create a COPY for calculations (don't modify original)
      calc_data <- data_to_save
      
      # Calculate monthly summary
      calc_data$Date <- as.Date(calc_data$SurveyDate, format = "%m/%d/%Y")
      calc_data$YearMonth <- format(calc_data$Date, "%Y-%m")
      calc_data$Year <- format(calc_data$Date, "%Y")
      calc_data$Quarter <- paste0("Q", ceiling(as.numeric(format(calc_data$Date, "%m")) / 3))
      calc_data$YearQuarter <- paste(calc_data$Year, calc_data$Quarter, sep = "-")
      
      monthly <- aggregate(cbind(NumberOfPeople, AcresTreated, NumberOfTruckloads, NumberOfBags, TotalTime, TrimHours) ~ YearMonth, 
                           data = calc_data, FUN = sum, na.rm = TRUE)
      monthly$Month <- format(as.Date(paste0(monthly$YearMonth, "-01")), "%B %Y")
      monthly_summary <- monthly[c("Month", "NumberOfPeople", "AcresTreated", "NumberOfTruckloads", "NumberOfBags", "TotalTime", "TrimHours")]
      names(monthly_summary) <- c("Month", "Total_People", "Total_Acres", "Total_Truckloads", "Total_Bags", "Total_Time", "Total_Trim_Hours")
      
      # Calculate quarterly summary
      quarterly <- aggregate(cbind(NumberOfPeople, AcresTreated, NumberOfTruckloads, NumberOfBags, TotalTime, TrimHours) ~ YearQuarter, 
                             data = calc_data, FUN = sum, na.rm = TRUE)
      names(quarterly) <- c("Quarter", "Total_People", "Total_Acres", "Total_Truckloads", "Total_Bags", "Total_Time", "Total_Trim_Hours")
      
      # Add monthly summary sheet
      addWorksheet(wb, "Monthly_Summary")
      writeData(wb, "Monthly_Summary", monthly_summary)
      
      # Add quarterly summary sheet
      addWorksheet(wb, "Quarterly_Summary")
      writeData(wb, "Quarterly_Summary", quarterly)
    }
    # Add this right before saveWorkbook line
    print(paste("Worksheets in workbook:", paste(names(wb), collapse=", ")))
    
    # Save workbook
    saveWorkbook(wb, excel_file_path, overwrite = TRUE)
    print("Workbook saved successfully")
  }
  
  # Load existing data or create empty dataframe
  if (file.exists(excel_file_path)) {
    existing_data <- read.xlsx(excel_file_path, sheet = "Data")
  } else {
    existing_data <- data.frame(SurveyDate = character(),
                                Site = character(),
                                SiteNumber = numeric(),
                                NumberOfPeople = numeric(),
                                AcresTreated = numeric(),
                                TargetSpecies1 = character(),
                                TargetSpecies2 = character(),
                                TargetSpecies3 = character(),
                                TargetSpecies4 = character(),
                                TargetSpecies5 = character(),
                                TargetSpecies6 = character(),
                                TargetSpecies7 = character(),
                                NumberOfTruckloads = numeric(),
                                NumberOfBags = numeric(),
                                TotalTime = numeric(),
                                TrimHours = numeric(),
                                Initials = character(),
                                stringsAsFactors = FALSE)
  }
  
  # Reactive value to store data
  data <- reactiveVal(existing_data)
  
  # Reactive value to store the last selected site
  lastSite <- reactiveVal("Select site")
  
  observeEvent(input$submit, {
    # Create a new row of data
    new_data <- data.frame(SurveyDate = format(input$date, "%m/%d/%Y"),
                           Site = input$Site,
                           SiteNumber = input$`Site Number`,
                           NumberOfPeople = input$`# of People`,
                           AcresTreated = input$`Acres Treated`,
                           TargetSpecies1 = ifelse(input$`Target Species 1` == "Select species", "", input$`Target Species 1`),
                           TargetSpecies2 = ifelse(input$`Target Species 2` == "Select species", "", input$`Target Species 2`),
                           TargetSpecies3 = ifelse(input$`Target Species 3` == "Select species", "", input$`Target Species 3`),
                           TargetSpecies4 = ifelse(input$`Target Species 4` == "Select species", "", input$`Target Species 4`),
                           TargetSpecies5 = ifelse(input$`Target Species 5` == "Select species", "", input$`Target Species 5`),
                           TargetSpecies6 = ifelse(input$`Target Species 6` == "Select species", "", input$`Target Species 6`),
                           TargetSpecies7 = ifelse(input$`Target Species 7` == "Select species", "", input$`Target Species 7`),
                           NumberOfTruckloads = input$`# of Truckloads`,
                           NumberOfBags = input$`# of Bags`,
                           TotalTime = input$`Total Time`,
                           TrimHours = input$`Trim Hours`,
                           Initials = input$Initials,
                           stringsAsFactors = FALSE)
    
    # Append new data
    updated_data <- rbind(data(), new_data)
    data(updated_data)
    
    # Save to Excel file with summaries (with error handling)
    tryCatch({
      save_data_with_summaries(updated_data)
      lastSite(input$Site)
      output$status <- renderText("Data submitted successfully!")
    }, error = function(e) {
      output$status <- renderText(paste("Error:", e$message))
      print(paste("Full error:", e))  # Shows in R console
      print(str(updated_data))  # Shows data structure
    })
    
    # Reset inputs
    updateSelectInput(session, "Target Species 1", selected = "Select species")
    updateSelectInput(session, "Target Species 2", selected = "Select species")
    updateSelectInput(session, "Target Species 3", selected = "Select species")
    updateSelectInput(session, "Target Species 4", selected = "Select species")
    updateSelectInput(session, "Target Species 5", selected = "Select species")
    updateSelectInput(session, "Target Species 6", selected = "Select species")
    updateSelectInput(session, "Target Species 7", selected = "Select species")
    updateNumericInput(session, "Site Number", value = 1)
    updateNumericInput(session, "# of People", value = 1)
    updateNumericInput(session, "Acres Treated", value = 0)
    updateNumericInput(session, "# of Truckloads", value = 0)
    updateNumericInput(session, "# of Bags", value = 0)
    updateNumericInput(session, "Total Time", value = 0)
    updateNumericInput(session, "Trim Hours", value = 0)
    # Keep the site from the last entry
    updateSelectInput(session, "Site", selected = lastSite())
  })
  
  # Remove the last entry
  observeEvent(input$removeLast, {
    current_data <- data()
    if (nrow(current_data) > 0) {
      # Remove the last row
      updated_data <- current_data[-nrow(current_data), ]
      data(updated_data)
      
      # Save to Excel file with summaries (with error handling)
      tryCatch({
        save_data_with_summaries(updated_data)
        output$status <- renderText("Last entry removed successfully!")
      }, error = function(e) {
        output$status <- renderText(paste("Error removing entry:", e$message))
        print(paste("Full error:", e))
      })
      
      # Update lastSite
      if (nrow(updated_data) > 0) {
        lastSite(updated_data$Site[nrow(updated_data)])
      } else {
        lastSite("Select site")
      }
    } else {
      output$status <- renderText("No entries to remove.")
    }
  })
  
  # Display the most recent 5 entries
  output$recentDataTable <- renderTable({
    current_data <- data()
    if (nrow(current_data) > 0) {
      start_idx <- max(1, nrow(current_data) - 4)
      recent_data <- current_data[start_idx:nrow(current_data), ]
      recent_data <- recent_data[nrow(recent_data):1, ]
      return(recent_data)
    } else {
      return(data.frame(Message = "No data entered yet"))
    }
  }, rownames = FALSE)
  
  # Display all submitted data
  output$dataTable <- renderTable({
    data()
  }, rownames = TRUE)
  
  # Monthly summary
  output$monthlySummary <- renderTable({
    current_data <- data()
    if (nrow(current_data) > 0) {
      # Convert date and extract year-month
      current_data$Date <- as.Date(current_data$SurveyDate, format = "%m/%d/%Y")
      current_data$YearMonth <- format(current_data$Date, "%Y-%m")
      
      # Calculate monthly totals
      monthly <- aggregate(cbind(NumberOfPeople, AcresTreated, NumberOfTruckloads, NumberOfBags, TotalTime, TrimHours) ~ YearMonth, 
                           data = current_data, FUN = sum, na.rm = TRUE)
      
      # Add month name for readability
      monthly$Month <- format(as.Date(paste0(monthly$YearMonth, "-01")), "%B %Y")
      
      # Reorder columns
      monthly <- monthly[c("Month", "NumberOfPeople", "AcresTreated", "NumberOfTruckloads", "NumberOfBags", "TotalTime", "TrimHours")]
      names(monthly) <- c("Month", "Total People", "Total Acres", "Total Truckloads", "Total Bags", "Total Time", "Total Trim Hours")
      
      return(monthly[order(monthly$Month, decreasing = TRUE), ])
    } else {
      return(data.frame(Message = "No data available for summary"))
    }
  }, rownames = FALSE)
  
  # Quarterly summary
  output$quarterlySummary <- renderTable({
    current_data <- data()
    if (nrow(current_data) > 0) {
      # Convert date and extract year-quarter
      current_data$Date <- as.Date(current_data$SurveyDate, format = "%m/%d/%Y")
      current_data$Year <- format(current_data$Date, "%Y")
      current_data$Quarter <- paste0("Q", ceiling(as.numeric(format(current_data$Date, "%m")) / 3))
      current_data$YearQuarter <- paste(current_data$Year, current_data$Quarter, sep = "-")
      
      quarterly <- aggregate(cbind(NumberOfPeople, AcresTreated, NumberOfTruckloads, NumberOfBags, TotalTime, TrimHours) ~ YearQuarter, 
                             data = current_data, FUN = sum, na.rm = TRUE)
      
      names(quarterly) <- c("Quarter", "Total People", "Total Acres", "Total Truckloads", "Total Bags", "Total Time", "Total Trim Hours")
      
      return(quarterly[order(quarterly$Quarter, decreasing = TRUE), ])
    } else {
      return(data.frame(Message = "No data available for summary"))
    }
  }, rownames = FALSE)
  
  # Download handler for Excel
  output$downloadData <- downloadHandler(
    filename = function() {
      paste("invasive_species_data_", Sys.Date(), ".xlsx", sep = "")
    },
    content = function(file) {
      # Create a temporary workbook with all sheets
      wb <- createWorkbook()
      
      # Add main data
      addWorksheet(wb, "Data")
      writeData(wb, "Data", data())
      
      current_data <- data()
      if (nrow(current_data) > 0) {
        # Monthly summary
        current_data$Date <- as.Date(current_data$SurveyDate, format = "%m/%d/%Y")
        current_data$YearMonth <- format(current_data$Date, "%Y-%m")
        current_data$Year <- format(current_data$Date, "%Y")
        current_data$Quarter <- paste0("Q", ceiling(as.numeric(format(current_data$Date, "%m")) / 3))
        current_data$YearQuarter <- paste(current_data$Year, current_data$Quarter, sep = "-")
        
        monthly <- aggregate(cbind(NumberOfPeople, AcresTreated, NumberOfTruckloads, NumberOfBags, TotalTime, TrimHours) ~ YearMonth, 
                             data = current_data, FUN = sum, na.rm = TRUE)
        monthly$Month <- format(as.Date(paste0(monthly$YearMonth, "-01")), "%B %Y")
        monthly_summary <- monthly[c("Month", "NumberOfPeople", "AcresTreated", "NumberOfTruckloads", "NumberOfBags", "TotalTime", "TrimHours")]
        names(monthly_summary) <- c("Month", "Total_People", "Total_Acres", "Total_Truckloads", "Total_Bags", "Total_Time", "Total_Trim_Hours")
        
        quarterly <- aggregate(cbind(NumberOfPeople, AcresTreated, NumberOfTruckloads, NumberOfBags, TotalTime, TrimHours) ~ YearQuarter, 
                               data = current_data, FUN = sum, na.rm = TRUE)
        names(quarterly) <- c("Quarter", "Total_People", "Total_Acres", "Total_Truckloads", "Total_Bags", "Total_Time", "Total_Trim_Hours")
        
        addWorksheet(wb, "Monthly_Summary")
        writeData(wb, "Monthly_Summary", monthly_summary)
        
        addWorksheet(wb, "Quarterly_Summary")
        writeData(wb, "Quarterly_Summary", quarterly)
      }
      
      saveWorkbook(wb, file, overwrite = TRUE)
    }
  )
}
#run application
shinyApp(ui = ui, server = server)