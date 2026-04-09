#*############################################################################################

## TITLE: Cabrillo National Monument Invasive Plant Data Entry Dashboard
## AUTHOR: T. Katayama
## DATE CREATED: Sep 2025
## LAST MODIFIED: 31 Mar 2026

#*################################################################################################
# Ensure the working directory is set to the main project folder
# This allows "Data/..." paths to work regardless of where the script is run from
getwd()
#setwd("C:/Users/tkatayama/OneDrive - DOI/Documents/Projects/R/Invasives_Data_Entry")

library(shiny)
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
      
      numericInput("Total Time", "Total Time:", value = 0, min = 0),
      
      numericInput("# of People", "# of People:", value = 1, min = 1),
      
      numericInput("Acres Treated", "Acres Treated:", value = 0, min = 0),
      
      numericInput("Trim Hours", "Trim Hours:", value = 0, min = 0),
      
      # Species Dropdowns
      selectizeInput("Target Species 1", "Target Species 1:",
                  choices = c("", "ABUTHE", "ACACYC", "AGAAME", "ALOMAC", "ANTCOT", "APIGRA", "ASPASP", "ATRGLA", "ATRSEM", "AVEBAR", "AVEFAT", "BASHYS", "BIDPIL", "BRADIS", "BRANIG", "BRATOU", "BROCAT",
                              "BRODIA", "BROHOR", "BRORUB", "CARMAC", "CAREDU",  "CENMEL", "CHAFOL", "CHEALB", "COTAUS", "CYCLEP", "CYNDAC", "CYPDIF", "DELOSP spp", "DICMIC", "DIGSAN", "DITGRA", "DYSSAM", "EHRERE", 
                              "ELEIND","EMESPI", "ERIBON", "EROBOT", "EROCIC", "EROMOS", "EUCCAM", "EUPMAC", "EUPPEP", "EUPSER", "FESMYU", "FESPER", "FOEVUL", "FURFOE", "GAMSTA", "GLECOR", "HEDRHA", "HELECH", "HIRINC",
                              "HORMUR", "HYPCAN", "HYPGLA", "LACSER", "LAMAUR", "LEPDID", "LIMPER", "LOBERI", "LOBMAR", "LOGGAL", "LYSARV", "LYTHYS", "MALCRO", "MALPAR", "MATDIS", "MEDPOL", "MELALB", "MELIND", "MELREP",
                              "MESCRY", "MESNOD", "MYOLAE", "MYRT spp", "NICGLA", "ONCPIL", "OXACOR", "OXAPES", "PARINIC", "PENCLA", "PENSET", "PHALAR", "PHOCAN", "POAANN", "POLAVI", "POLMON", "POLTET", "POROLE", "PSELUT", 
                              "RAPSAT", "RICCOM", "RUMCRI", "SAGAPE", "SALORI", "SAL spp.", "SCHBAR", "SILGAL", "SISIRI", "SISORI", "SOLNIG", "SOLLYC", "SOLPHY", "SONASP", "SONOLE","SPEBOC", "SPEVIL", "SPOIND", "STENEG", "STIMIL",
                              "TETTET", "TRIHIR", "VACFAR", "VERARV")),
      selectizeInput("Target Species 2", "Target Species 2:",
                  choices = c("", "ABUTHE", "ACACYC", "AGAAME", "ALOMAC", "ANTCOT", "APIGRA", "ASPASP", "ATRGLA", "ATRSEM", "AVEBAR", "AVEFAT", "BASHYS", "BIDPIL", "BRADIS", "BRANIG", "BRATOU", "BROCAT",
                              "BRODIA", "BROHOR", "BRORUB", "CARMAC", "CAREDU",  "CENMEL", "CHAFOL", "CHEALB", "COTAUS", "CYCLEP", "CYNDAC", "CYPDIF", "DELOSP spp", "DICMIC", "DIGSAN", "DITGRA", "DYSSAM", "EHRERE", 
                              "ELEIND","EMESPI", "ERIBON", "EROBOT", "EROCIC", "EROMOS", "EUCCAM", "EUPMAC", "EUPPEP", "EUPSER", "FESMYU", "FESPER", "FOEVUL", "FURFOE", "GAMSTA", "GLECOR", "HEDRHA", "HELECH", "HIRINC",
                              "HORMUR", "HYPCAN", "HYPGLA", "LACSER", "LAMAUR", "LEPDID", "LIMPER", "LOBERI", "LOBMAR", "LOGGAL", "LYSARV", "LYTHYS", "MALCRO", "MALPAR", "MATDIS", "MEDPOL", "MELALB", "MELIND", "MELREP",
                              "MESCRY", "MESNOD", "MYOLAE", "MYRT spp", "NICGLA", "ONCPIL", "OXACOR", "OXAPES", "PARINIC", "PENCLA", "PENSET", "PHALAR", "PHOCAN", "POAANN", "POLAVI", "POLMON", "POLTET", "POROLE", "PSELUT", 
                              "RAPSAT", "RICCOM", "RUMCRI", "SAGAPE", "SALORI", "SAL spp.", "SCHBAR", "SILGAL", "SISIRI", "SISORI", "SOLNIG", "SOLLYC", "SOLPHY", "SONASP", "SONOLE","SPEBOC", "SPEVIL", "SPOIND", "STENEG", "STIMIL",
                              "TETTET", "TRIHIR", "VACFAR", "VERARV")),
      selectizeInput("Target Species 3", "Target Species 3:",
                  choices = c("", "ABUTHE", "ACACYC", "AGAAME", "ALOMAC", "ANTCOT", "APIGRA", "ASPASP", "ATRGLA", "ATRSEM", "AVEBAR", "AVEFAT", "BASHYS", "BIDPIL", "BRADIS", "BRANIG", "BRATOU", "BROCAT",
                              "BRODIA", "BROHOR", "BRORUB", "CARMAC", "CAREDU",  "CENMEL", "CHAFOL", "CHEALB", "COTAUS", "CYCLEP", "CYNDAC", "CYPDIF", "DELOSP spp", "DICMIC", "DIGSAN", "DITGRA", "DYSSAM", "EHRERE", 
                              "ELEIND","EMESPI", "ERIBON", "EROBOT", "EROCIC", "EROMOS", "EUCCAM", "EUPMAC", "EUPPEP", "EUPSER", "FESMYU", "FESPER", "FOEVUL", "FURFOE", "GAMSTA", "GLECOR", "HEDRHA", "HELECH", "HIRINC",
                              "HORMUR", "HYPCAN", "HYPGLA", "LACSER", "LAMAUR", "LEPDID", "LIMPER", "LOBERI", "LOBMAR", "LOGGAL", "LYSARV", "LYTHYS", "MALCRO", "MALPAR", "MATDIS", "MEDPOL", "MELALB", "MELIND", "MELREP",
                              "MESCRY", "MESNOD", "MYOLAE", "MYRT spp", "NICGLA", "ONCPIL", "OXACOR", "OXAPES", "PARINIC", "PENCLA", "PENSET", "PHALAR", "PHOCAN", "POAANN", "POLAVI", "POLMON", "POLTET", "POROLE", "PSELUT", 
                              "RAPSAT", "RICCOM", "RUMCRI", "SAGAPE", "SALORI", "SAL spp.", "SCHBAR", "SILGAL", "SISIRI", "SISORI", "SOLNIG", "SOLLYC", "SOLPHY", "SONASP", "SONOLE","SPEBOC", "SPEVIL", "SPOIND", "STENEG", "STIMIL",
                              "TETTET", "TRIHIR", "VACFAR", "VERARV")),
      selectizeInput("Target Species 4", "Target Species 4:",
                  choices = c("", "ABUTHE", "ACACYC", "AGAAME", "ALOMAC", "ANTCOT", "APIGRA", "ASPASP", "ATRGLA", "ATRSEM", "AVEBAR", "AVEFAT", "BASHYS", "BIDPIL", "BRADIS", "BRANIG", "BRATOU", "BROCAT",
                              "BRODIA", "BROHOR", "BRORUB", "CARMAC", "CAREDU",  "CENMEL", "CHAFOL", "CHEALB", "COTAUS", "CYCLEP", "CYNDAC", "CYPDIF", "DELOSP spp", "DICMIC", "DIGSAN", "DITGRA", "DYSSAM", "EHRERE", 
                              "ELEIND","EMESPI", "ERIBON", "EROBOT", "EROCIC", "EROMOS", "EUCCAM", "EUPMAC", "EUPPEP", "EUPSER", "FESMYU", "FESPER", "FOEVUL", "FURFOE", "GAMSTA", "GLECOR", "HEDRHA", "HELECH", "HIRINC",
                              "HORMUR", "HYPCAN", "HYPGLA", "LACSER", "LAMAUR", "LEPDID", "LIMPER", "LOBERI", "LOBMAR", "LOGGAL", "LYSARV", "LYTHYS", "MALCRO", "MALPAR", "MATDIS", "MEDPOL", "MELALB", "MELIND", "MELREP",
                              "MESCRY", "MESNOD", "MYOLAE", "MYRT spp", "NICGLA", "ONCPIL", "OXACOR", "OXAPES", "PARINIC", "PENCLA", "PENSET", "PHALAR", "PHOCAN", "POAANN", "POLAVI", "POLMON", "POLTET", "POROLE", "PSELUT", 
                              "RAPSAT", "RICCOM", "RUMCRI", "SAGAPE", "SALORI", "SAL spp.", "SCHBAR", "SILGAL", "SISIRI", "SISORI", "SOLNIG", "SOLLYC", "SOLPHY", "SONASP", "SONOLE","SPEBOC", "SPEVIL", "SPOIND", "STENEG", "STIMIL",
                              "TETTET", "TRIHIR", "VACFAR", "VERARV")),
      selectizeInput("Target Species 5", "Target Species 5:",
                  choices = c("", "ABUTHE", "ACACYC", "AGAAME", "ALOMAC", "ANTCOT", "APIGRA", "ASPASP", "ATRGLA", "ATRSEM", "AVEBAR", "AVEFAT", "BASHYS", "BIDPIL", "BRADIS", "BRANIG", "BRATOU", "BROCAT",
                              "BRODIA", "BROHOR", "BRORUB", "CARMAC", "CAREDU",  "CENMEL", "CHAFOL", "CHEALB", "COTAUS", "CYCLEP", "CYNDAC", "CYPDIF", "DELOSP spp", "DICMIC", "DIGSAN", "DITGRA", "DYSSAM", "EHRERE", 
                              "ELEIND","EMESPI", "ERIBON", "EROBOT", "EROCIC", "EROMOS", "EUCCAM", "EUPMAC", "EUPPEP", "EUPSER", "FESMYU", "FESPER", "FOEVUL", "FURFOE", "GAMSTA", "GLECOR", "HEDRHA", "HELECH", "HIRINC",
                              "HORMUR", "HYPCAN", "HYPGLA", "LACSER", "LAMAUR", "LEPDID", "LIMPER", "LOBERI", "LOBMAR", "LOGGAL", "LYSARV", "LYTHYS", "MALCRO", "MALPAR", "MATDIS", "MEDPOL", "MELALB", "MELIND", "MELREP",
                              "MESCRY", "MESNOD", "MYOLAE", "MYRT spp", "NICGLA", "ONCPIL", "OXACOR", "OXAPES", "PARINIC", "PENCLA", "PENSET", "PHALAR", "PHOCAN", "POAANN", "POLAVI", "POLMON", "POLTET", "POROLE", "PSELUT", 
                              "RAPSAT", "RICCOM", "RUMCRI", "SAGAPE", "SALORI", "SAL spp.", "SCHBAR", "SILGAL", "SISIRI", "SISORI", "SOLNIG", "SOLLYC", "SOLPHY", "SONASP", "SONOLE","SPEBOC", "SPEVIL", "SPOIND", "STENEG", "STIMIL",
                              "TETTET", "TRIHIR", "VACFAR", "VERARV")),
      selectizeInput("Target Species 6", "Target Species 6:",
                  choices = c("", "ABUTHE", "ACACYC", "AGAAME", "ALOMAC", "ANTCOT", "APIGRA", "ASPASP", "ATRGLA", "ATRSEM", "AVEBAR", "AVEFAT", "BASHYS", "BIDPIL", "BRADIS", "BRANIG", "BRATOU", "BROCAT",
                              "BRODIA", "BROHOR", "BRORUB", "CARMAC", "CAREDU",  "CENMEL", "CHAFOL", "CHEALB", "COTAUS", "CYCLEP", "CYNDAC", "CYPDIF", "DELOSP spp", "DICMIC", "DIGSAN", "DITGRA", "DYSSAM", "EHRERE", 
                              "ELEIND","EMESPI", "ERIBON", "EROBOT", "EROCIC", "EROMOS", "EUCCAM", "EUPMAC", "EUPPEP", "EUPSER", "FESMYU", "FESPER", "FOEVUL", "FURFOE", "GAMSTA", "GLECOR", "HEDRHA", "HELECH", "HIRINC",
                              "HORMUR", "HYPCAN", "HYPGLA", "LACSER", "LAMAUR", "LEPDID", "LIMPER", "LOBERI", "LOBMAR", "LOGGAL", "LYSARV", "LYTHYS", "MALCRO", "MALPAR", "MATDIS", "MEDPOL", "MELALB", "MELIND", "MELREP",
                              "MESCRY", "MESNOD", "MYOLAE", "MYRT spp", "NICGLA", "ONCPIL", "OXACOR", "OXAPES", "PARINIC", "PENCLA", "PENSET", "PHALAR", "PHOCAN", "POAANN", "POLAVI", "POLMON", "POLTET", "POROLE", "PSELUT", 
                              "RAPSAT", "RICCOM", "RUMCRI", "SAGAPE", "SALORI", "SAL spp.", "SCHBAR", "SILGAL", "SISIRI", "SISORI", "SOLNIG", "SOLLYC", "SOLPHY", "SONASP", "SONOLE","SPEBOC", "SPEVIL", "SPOIND", "STENEG", "STIMIL",
                              "TETTET", "TRIHIR", "VACFAR", "VERARV")),
      selectizeInput("Target Species 7", "Target Species 7:",
                  choices = c("", "ABUTHE", "ACACYC", "AGAAME", "ALOMAC", "ANTCOT", "APIGRA", "ASPASP", "ATRGLA", "ATRSEM", "AVEBAR", "AVEFAT", "BASHYS", "BIDPIL", "BRADIS", "BRANIG", "BRATOU", "BROCAT",
                              "BRODIA", "BROHOR", "BRORUB", "CARMAC", "CAREDU",  "CENMEL", "CHAFOL", "CHEALB", "COTAUS", "CYCLEP", "CYNDAC", "CYPDIF", "DELOSP spp", "DICMIC", "DIGSAN", "DITGRA", "DYSSAM", "EHRERE", 
                              "ELEIND","EMESPI", "ERIBON", "EROBOT", "EROCIC", "EROMOS", "EUCCAM", "EUPMAC", "EUPPEP", "EUPSER", "FESMYU", "FESPER", "FOEVUL", "FURFOE", "GAMSTA", "GLECOR", "HEDRHA", "HELECH", "HIRINC",
                              "HORMUR", "HYPCAN", "HYPGLA", "LACSER", "LAMAUR", "LEPDID", "LIMPER", "LOBERI", "LOBMAR", "LOGGAL", "LYSARV", "LYTHYS", "MALCRO", "MALPAR", "MATDIS", "MEDPOL", "MELALB", "MELIND", "MELREP",
                              "MESCRY", "MESNOD", "MYOLAE", "MYRT spp", "NICGLA", "ONCPIL", "OXACOR", "OXAPES", "PARINIC", "PENCLA", "PENSET", "PHALAR", "PHOCAN", "POAANN", "POLAVI", "POLMON", "POLTET", "POROLE", "PSELUT", 
                              "RAPSAT", "RICCOM", "RUMCRI", "SAGAPE", "SALORI", "SAL spp.", "SCHBAR", "SILGAL", "SISIRI", "SISORI", "SOLNIG", "SOLLYC", "SOLPHY", "SONASP", "SONOLE","SPEBOC", "SPEVIL", "SPOIND", "STENEG", "STIMIL",
                              "TETTET", "TRIHIR", "VACFAR", "VERARV")),
      selectizeInput("Target Species 8", "Target Species 8:",
                     choices = c("", "ABUTHE", "ACACYC", "AGAAME", "ALOMAC", "ANTCOT", "APIGRA", "ASPASP", "ATRGLA", "ATRSEM", "AVEBAR", "AVEFAT", "BASHYS", "BIDPIL", "BRADIS", "BRANIG", "BRATOU", "BROCAT",
                                 "BRODIA", "BROHOR", "BRORUB", "CARMAC", "CAREDU",  "CENMEL", "CHAFOL", "CHEALB", "COTAUS", "CYCLEP", "CYNDAC", "CYPDIF", "DELOSP spp", "DICMIC", "DIGSAN", "DITGRA", "DYSSAM", "EHRERE", 
                                 "ELEIND","EMESPI", "ERIBON", "EROBOT", "EROCIC", "EROMOS", "EUCCAM", "EUPMAC", "EUPPEP", "EUPSER", "FESMYU", "FESPER", "FOEVUL", "FURFOE", "GAMSTA", "GLECOR", "HEDRHA", "HELECH", "HIRINC",
                                 "HORMUR", "HYPCAN", "HYPGLA", "LACSER", "LAMAUR", "LEPDID", "LIMPER", "LOBERI", "LOBMAR", "LOGGAL", "LYSARV", "LYTHYS", "MALCRO", "MALPAR", "MATDIS", "MEDPOL", "MELALB", "MELIND", "MELREP",
                                 "MESCRY", "MESNOD", "MYOLAE", "MYRT spp", "NICGLA", "ONCPIL", "OXACOR", "OXAPES", "PARINIC", "PENCLA", "PENSET", "PHALAR", "PHOCAN", "POAANN", "POLAVI", "POLMON", "POLTET", "POROLE", "PSELUT", 
                                 "RAPSAT", "RICCOM", "RUMCRI", "SAGAPE", "SALORI", "SAL spp.", "SCHBAR", "SILGAL", "SISIRI", "SISORI", "SOLNIG", "SOLLYC", "SOLPHY", "SONASP", "SONOLE","SPEBOC", "SPEVIL", "SPOIND", "STENEG", "STIMIL",
                                 "TETTET", "TRIHIR", "VACFAR", "VERARV")),
      selectizeInput("Target Species 9", "Target Species 9:",
                     choices = c("", "ABUTHE", "ACACYC", "AGAAME", "ALOMAC", "ANTCOT", "APIGRA", "ASPASP", "ATRGLA", "ATRSEM", "AVEBAR", "AVEFAT", "BASHYS", "BIDPIL", "BRADIS", "BRANIG", "BRATOU", "BROCAT",
                                 "BRODIA", "BROHOR", "BRORUB", "CARMAC", "CAREDU",  "CENMEL", "CHAFOL", "CHEALB", "COTAUS", "CYCLEP", "CYNDAC", "CYPDIF", "DELOSP spp", "DICMIC", "DIGSAN", "DITGRA", "DYSSAM", "EHRERE", 
                                 "ELEIND","EMESPI", "ERIBON", "EROBOT", "EROCIC", "EROMOS", "EUCCAM", "EUPMAC", "EUPPEP", "EUPSER", "FESMYU", "FESPER", "FOEVUL", "FURFOE", "GAMSTA", "GLECOR", "HEDRHA", "HELECH", "HIRINC",
                                 "HORMUR", "HYPCAN", "HYPGLA", "LACSER", "LAMAUR", "LEPDID", "LIMPER", "LOBERI", "LOBMAR", "LOGGAL", "LYSARV", "LYTHYS", "MALCRO", "MALPAR", "MATDIS", "MEDPOL", "MELALB", "MELIND", "MELREP",
                                 "MESCRY", "MESNOD", "MYOLAE", "MYRT spp", "NICGLA", "ONCPIL", "OXACOR", "OXAPES", "PARINIC", "PENCLA", "PENSET", "PHALAR", "PHOCAN", "POAANN", "POLAVI", "POLMON", "POLTET", "POROLE", "PSELUT", 
                                 "RAPSAT", "RICCOM", "RUMCRI", "SAGAPE", "SALORI", "SAL spp.", "SCHBAR", "SILGAL", "SISIRI", "SISORI", "SOLNIG", "SOLLYC", "SOLPHY", "SONASP", "SONOLE","SPEBOC", "SPEVIL", "SPOIND", "STENEG", "STIMIL",
                                 "TETTET", "TRIHIR", "VACFAR", "VERARV")),
      selectizeInput("Target Species 10", "Target Species 10:",
                     choices = c("", "ABUTHE", "ACACYC", "AGAAME", "ALOMAC", "ANTCOT", "APIGRA", "ASPASP", "ATRGLA", "ATRSEM", "AVEBAR", "AVEFAT", "BASHYS", "BIDPIL", "BRADIS", "BRANIG", "BRATOU", "BROCAT",
                                 "BRODIA", "BROHOR", "BRORUB", "CARMAC", "CAREDU",  "CENMEL", "CHAFOL", "CHEALB", "COTAUS", "CYCLEP", "CYNDAC", "CYPDIF", "DELOSP spp", "DICMIC", "DIGSAN", "DITGRA", "DYSSAM", "EHRERE", 
                                 "ELEIND","EMESPI", "ERIBON", "EROBOT", "EROCIC", "EROMOS", "EUCCAM", "EUPMAC", "EUPPEP", "EUPSER", "FESMYU", "FESPER", "FOEVUL", "FURFOE", "GAMSTA", "GLECOR", "HEDRHA", "HELECH", "HIRINC",
                                 "HORMUR", "HYPCAN", "HYPGLA", "LACSER", "LAMAUR", "LEPDID", "LIMPER", "LOBERI", "LOBMAR", "LOGGAL", "LYSARV", "LYTHYS", "MALCRO", "MALPAR", "MATDIS", "MEDPOL", "MELALB", "MELIND", "MELREP",
                                 "MESCRY", "MESNOD", "MYOLAE", "MYRT spp", "NICGLA", "ONCPIL", "OXACOR", "OXAPES", "PARINIC", "PENCLA", "PENSET", "PHALAR", "PHOCAN", "POAANN", "POLAVI", "POLMON", "POLTET", "POROLE", "PSELUT", 
                                 "RAPSAT", "RICCOM", "RUMCRI", "SAGAPE", "SALORI", "SAL spp.", "SCHBAR", "SILGAL", "SISIRI", "SISORI", "SOLNIG", "SOLLYC", "SOLPHY", "SONASP", "SONOLE","SPEBOC", "SPEVIL", "SPOIND", "STENEG", "STIMIL",
                                 "TETTET", "TRIHIR", "VACFAR", "VERARV")),
      selectizeInput("Target Species 11", "Target Species 11:",
                     choices = c("", "ABUTHE", "ACACYC", "AGAAME", "ALOMAC", "ANTCOT", "APIGRA", "ASPASP", "ATRGLA", "ATRSEM", "AVEBAR", "AVEFAT", "BASHYS", "BIDPIL", "BRADIS", "BRANIG", "BRATOU", "BROCAT",
                                 "BRODIA", "BROHOR", "BRORUB", "CARMAC", "CAREDU",  "CENMEL", "CHAFOL", "CHEALB", "COTAUS", "CYCLEP", "CYNDAC", "CYPDIF", "DELOSP spp", "DICMIC", "DIGSAN", "DITGRA", "DYSSAM", "EHRERE", 
                                 "ELEIND","EMESPI", "ERIBON", "EROBOT", "EROCIC", "EROMOS", "EUCCAM", "EUPMAC", "EUPPEP", "EUPSER", "FESMYU", "FESPER", "FOEVUL", "FURFOE", "GAMSTA", "GLECOR", "HEDRHA", "HELECH", "HIRINC",
                                 "HORMUR", "HYPCAN", "HYPGLA", "LACSER", "LAMAUR", "LEPDID", "LIMPER", "LOBERI", "LOBMAR", "LOGGAL", "LYSARV", "LYTHYS", "MALCRO", "MALPAR", "MATDIS", "MEDPOL", "MELALB", "MELIND", "MELREP",
                                 "MESCRY", "MESNOD", "MYOLAE", "MYRT spp", "NICGLA", "ONCPIL", "OXACOR", "OXAPES", "PARINIC", "PENCLA", "PENSET", "PHALAR", "PHOCAN", "POAANN", "POLAVI", "POLMON", "POLTET", "POROLE", "PSELUT", 
                                 "RAPSAT", "RICCOM", "RUMCRI", "SAGAPE", "SALORI", "SAL spp.", "SCHBAR", "SILGAL", "SISIRI", "SISORI", "SOLNIG", "SOLLYC", "SOLPHY", "SONASP", "SONOLE","SPEBOC", "SPEVIL", "SPOIND", "STENEG", "STIMIL",
                                 "TETTET", "TRIHIR", "VACFAR", "VERARV")),
      selectizeInput("Target Species 12", "Target Species 12:",
                     choices = c("", "ABUTHE", "ACACYC", "AGAAME", "ALOMAC", "ANTCOT", "APIGRA", "ASPASP", "ATRGLA", "ATRSEM", "AVEBAR", "AVEFAT", "BASHYS", "BIDPIL", "BRADIS", "BRANIG", "BRATOU", "BROCAT",
                                 "BRODIA", "BROHOR", "BRORUB", "CARMAC", "CAREDU",  "CENMEL", "CHAFOL", "CHEALB", "COTAUS", "CYCLEP", "CYNDAC", "CYPDIF", "DELOSP spp", "DICMIC", "DIGSAN", "DITGRA", "DYSSAM", "EHRERE", 
                                 "ELEIND","EMESPI", "ERIBON", "EROBOT", "EROCIC", "EROMOS", "EUCCAM", "EUPMAC", "EUPPEP", "EUPSER", "FESMYU", "FESPER", "FOEVUL", "FURFOE", "GAMSTA", "GLECOR", "HEDRHA", "HELECH", "HIRINC",
                                 "HORMUR", "HYPCAN", "HYPGLA", "LACSER", "LAMAUR", "LEPDID", "LIMPER", "LOBERI", "LOBMAR", "LOGGAL", "LYSARV", "LYTHYS", "MALCRO", "MALPAR", "MATDIS", "MEDPOL", "MELALB", "MELIND", "MELREP",
                                 "MESCRY", "MESNOD", "MYOLAE", "MYRT spp", "NICGLA", "ONCPIL", "OXACOR", "OXAPES", "PARINIC", "PENCLA", "PENSET", "PHALAR", "PHOCAN", "POAANN", "POLAVI", "POLMON", "POLTET", "POROLE", "PSELUT", 
                                 "RAPSAT", "RICCOM", "RUMCRI", "SAGAPE", "SALORI", "SAL spp.", "SCHBAR", "SILGAL", "SISIRI", "SISORI", "SOLNIG", "SOLLYC", "SOLPHY", "SONASP", "SONOLE","SPEBOC", "SPEVIL", "SPOIND", "STENEG", "STIMIL",
                                 "TETTET", "TRIHIR", "VACFAR", "VERARV")),
      selectizeInput("Target Species 13", "Target Species 13:",
                     choices = c("", "ABUTHE", "ACACYC", "AGAAME", "ALOMAC", "ANTCOT", "APIGRA", "ASPASP", "ATRGLA", "ATRSEM", "AVEBAR", "AVEFAT", "BASHYS", "BIDPIL", "BRADIS", "BRANIG", "BRATOU", "BROCAT",
                                 "BRODIA", "BROHOR", "BRORUB", "CARMAC", "CAREDU",  "CENMEL", "CHAFOL", "CHEALB", "COTAUS", "CYCLEP", "CYNDAC", "CYPDIF", "DELOSP spp", "DICMIC", "DIGSAN", "DITGRA", "DYSSAM", "EHRERE", 
                                 "ELEIND","EMESPI", "ERIBON", "EROBOT", "EROCIC", "EROMOS", "EUCCAM", "EUPMAC", "EUPPEP", "EUPSER", "FESMYU", "FESPER", "FOEVUL", "FURFOE", "GAMSTA", "GLECOR", "HEDRHA", "HELECH", "HIRINC",
                                 "HORMUR", "HYPCAN", "HYPGLA", "LACSER", "LAMAUR", "LEPDID", "LIMPER", "LOBERI", "LOBMAR", "LOGGAL", "LYSARV", "LYTHYS", "MALCRO", "MALPAR", "MATDIS", "MEDPOL", "MELALB", "MELIND", "MELREP",
                                 "MESCRY", "MESNOD", "MYOLAE", "MYRT spp", "NICGLA", "ONCPIL", "OXACOR", "OXAPES", "PARINIC", "PENCLA", "PENSET", "PHALAR", "PHOCAN", "POAANN", "POLAVI", "POLMON", "POLTET", "POROLE", "PSELUT", 
                                 "RAPSAT", "RICCOM", "RUMCRI", "SAGAPE", "SALORI", "SAL spp.", "SCHBAR", "SILGAL", "SISIRI", "SISORI", "SOLNIG", "SOLLYC", "SOLPHY", "SONASP", "SONOLE","SPEBOC", "SPEVIL", "SPOIND", "STENEG", "STIMIL",
                                 "TETTET", "TRIHIR", "VACFAR", "VERARV")),
      selectizeInput("Target Species 14", "Target Species 14:",
                     choices = c("", "ABUTHE", "ACACYC", "AGAAME", "ALOMAC", "ANTCOT", "APIGRA", "ASPASP", "ATRGLA", "ATRSEM", "AVEBAR", "AVEFAT", "BASHYS", "BIDPIL", "BRADIS", "BRANIG", "BRATOU", "BROCAT",
                                 "BRODIA", "BROHOR", "BRORUB", "CARMAC", "CAREDU",  "CENMEL", "CHAFOL", "CHEALB", "COTAUS", "CYCLEP", "CYNDAC", "CYPDIF", "DELOSP spp", "DICMIC", "DIGSAN", "DITGRA", "DYSSAM", "EHRERE", 
                                 "ELEIND","EMESPI", "ERIBON", "EROBOT", "EROCIC", "EROMOS", "EUCCAM", "EUPMAC", "EUPPEP", "EUPSER", "FESMYU", "FESPER", "FOEVUL", "FURFOE", "GAMSTA", "GLECOR", "HEDRHA", "HELECH", "HIRINC",
                                 "HORMUR", "HYPCAN", "HYPGLA", "LACSER", "LAMAUR", "LEPDID", "LIMPER", "LOBERI", "LOBMAR", "LOGGAL", "LYSARV", "LYTHYS", "MALCRO", "MALPAR", "MATDIS", "MEDPOL", "MELALB", "MELIND", "MELREP",
                                 "MESCRY", "MESNOD", "MYOLAE", "MYRT spp", "NICGLA", "ONCPIL", "OXACOR", "OXAPES", "PARINIC", "PENCLA", "PENSET", "PHALAR", "PHOCAN", "POAANN", "POLAVI", "POLMON", "POLTET", "POROLE", "PSELUT", 
                                 "RAPSAT", "RICCOM", "RUMCRI", "SAGAPE", "SALORI", "SAL spp.", "SCHBAR", "SILGAL", "SISIRI", "SISORI", "SOLNIG", "SOLLYC", "SOLPHY", "SONASP", "SONOLE","SPEBOC", "SPEVIL", "SPOIND", "STENEG", "STIMIL",
                                 "TETTET", "TRIHIR", "VACFAR", "VERARV")),
      selectizeInput("Target Species 15", "Target Species 15:",
                     choices = c("", "ABUTHE", "ACACYC", "AGAAME", "ALOMAC", "ANTCOT", "APIGRA", "ASPASP", "ATRGLA", "ATRSEM", "AVEBAR", "AVEFAT", "BASHYS", "BIDPIL", "BRADIS", "BRANIG", "BRATOU", "BROCAT",
                                 "BRODIA", "BROHOR", "BRORUB", "CARMAC", "CAREDU",  "CENMEL", "CHAFOL", "CHEALB", "COTAUS", "CYCLEP", "CYNDAC", "CYPDIF", "DELOSP spp", "DICMIC", "DIGSAN", "DITGRA", "DYSSAM", "EHRERE", 
                                 "ELEIND","EMESPI", "ERIBON", "EROBOT", "EROCIC", "EROMOS", "EUCCAM", "EUPMAC", "EUPPEP", "EUPSER", "FESMYU", "FESPER", "FOEVUL", "FURFOE", "GAMSTA", "GLECOR", "HEDRHA", "HELECH", "HIRINC",
                                 "HORMUR", "HYPCAN", "HYPGLA", "LACSER", "LAMAUR", "LEPDID", "LIMPER", "LOBERI", "LOBMAR", "LOGGAL", "LYSARV", "LYTHYS", "MALCRO", "MALPAR", "MATDIS", "MEDPOL", "MELALB", "MELIND", "MELREP",
                                 "MESCRY", "MESNOD", "MYOLAE", "MYRT spp", "NICGLA", "ONCPIL", "OXACOR", "OXAPES", "PARINIC", "PENCLA", "PENSET", "PHALAR", "PHOCAN", "POAANN", "POLAVI", "POLMON", "POLTET", "POROLE", "PSELUT", 
                                 "RAPSAT", "RICCOM", "RUMCRI", "SAGAPE", "SALORI", "SAL spp.", "SCHBAR", "SILGAL", "SISIRI", "SISORI", "SOLNIG", "SOLLYC", "SOLPHY", "SONASP", "SONOLE","SPEBOC", "SPEVIL", "SPOIND", "STENEG", "STIMIL",
                                 "TETTET", "TRIHIR", "VACFAR", "VERARV")),
      selectizeInput("Target Species 16", "Target Species 16:",
                     choices = c("", "ABUTHE", "ACACYC", "AGAAME", "ALOMAC", "ANTCOT", "APIGRA", "ASPASP", "ATRGLA", "ATRSEM", "AVEBAR", "AVEFAT", "BASHYS", "BIDPIL", "BRADIS", "BRANIG", "BRATOU", "BROCAT",
                                 "BRODIA", "BROHOR", "BRORUB", "CARMAC", "CAREDU",  "CENMEL", "CHAFOL", "CHEALB", "COTAUS", "CYCLEP", "CYNDAC", "CYPDIF", "DELOSP spp", "DICMIC", "DIGSAN", "DITGRA", "DYSSAM", "EHRERE", 
                                 "ELEIND","EMESPI", "ERIBON", "EROBOT", "EROCIC", "EROMOS", "EUCCAM", "EUPMAC", "EUPPEP", "EUPSER", "FESMYU", "FESPER", "FOEVUL", "FURFOE", "GAMSTA", "GLECOR", "HEDRHA", "HELECH", "HIRINC",
                                 "HORMUR", "HYPCAN", "HYPGLA", "LACSER", "LAMAUR", "LEPDID", "LIMPER", "LOBERI", "LOBMAR", "LOGGAL", "LYSARV", "LYTHYS", "MALCRO", "MALPAR", "MATDIS", "MEDPOL", "MELALB", "MELIND", "MELREP",
                                 "MESCRY", "MESNOD", "MYOLAE", "MYRT spp", "NICGLA", "ONCPIL", "OXACOR", "OXAPES", "PARINIC", "PENCLA", "PENSET", "PHALAR", "PHOCAN", "POAANN", "POLAVI", "POLMON", "POLTET", "POROLE", "PSELUT", 
                                 "RAPSAT", "RICCOM", "RUMCRI", "SAGAPE", "SALORI", "SAL spp.", "SCHBAR", "SILGAL", "SISIRI", "SISORI", "SOLNIG", "SOLLYC", "SOLPHY", "SONASP", "SONOLE","SPEBOC", "SPEVIL", "SPOIND", "STENEG", "STIMIL",
                                 "TETTET", "TRIHIR", "VACFAR", "VERARV")),
      selectizeInput("Target Species 17", "Target Species 17:",
                     choices = c("", "ABUTHE", "ACACYC", "AGAAME", "ALOMAC", "ANTCOT", "APIGRA", "ASPASP", "ATRGLA", "ATRSEM", "AVEBAR", "AVEFAT", "BASHYS", "BIDPIL", "BRADIS", "BRANIG", "BRATOU", "BROCAT",
                                 "BRODIA", "BROHOR", "BRORUB", "CARMAC", "CAREDU",  "CENMEL", "CHAFOL", "CHEALB", "COTAUS", "CYCLEP", "CYNDAC", "CYPDIF", "DELOSP spp", "DICMIC", "DIGSAN", "DITGRA", "DYSSAM", "EHRERE", 
                                 "ELEIND","EMESPI", "ERIBON", "EROBOT", "EROCIC", "EROMOS", "EUCCAM", "EUPMAC", "EUPPEP", "EUPSER", "FESMYU", "FESPER", "FOEVUL", "FURFOE", "GAMSTA", "GLECOR", "HEDRHA", "HELECH", "HIRINC",
                                 "HORMUR", "HYPCAN", "HYPGLA", "LACSER", "LAMAUR", "LEPDID", "LIMPER", "LOBERI", "LOBMAR", "LOGGAL", "LYSARV", "LYTHYS", "MALCRO", "MALPAR", "MATDIS", "MEDPOL", "MELALB", "MELIND", "MELREP",
                                 "MESCRY", "MESNOD", "MYOLAE", "MYRT spp", "NICGLA", "ONCPIL", "OXACOR", "OXAPES", "PARINIC", "PENCLA", "PENSET", "PHALAR", "PHOCAN", "POAANN", "POLAVI", "POLMON", "POLTET", "POROLE", "PSELUT", 
                                 "RAPSAT", "RICCOM", "RUMCRI", "SAGAPE", "SALORI", "SAL spp.", "SCHBAR", "SILGAL", "SISIRI", "SISORI", "SOLNIG", "SOLLYC", "SOLPHY", "SONASP", "SONOLE","SPEBOC", "SPEVIL", "SPOIND", "STENEG", "STIMIL",
                                 "TETTET", "TRIHIR", "VACFAR", "VERARV")),
      selectizeInput("Target Species 18", "Target Species 18:",
                     choices = c("", "ABUTHE", "ACACYC", "AGAAME", "ALOMAC", "ANTCOT", "APIGRA", "ASPASP", "ATRGLA", "ATRSEM", "AVEBAR", "AVEFAT", "BASHYS", "BIDPIL", "BRADIS", "BRANIG", "BRATOU", "BROCAT",
                                 "BRODIA", "BROHOR", "BRORUB", "CARMAC", "CAREDU",  "CENMEL", "CHAFOL", "CHEALB", "COTAUS", "CYCLEP", "CYNDAC", "CYPDIF", "DELOSP spp", "DICMIC", "DIGSAN", "DITGRA", "DYSSAM", "EHRERE", 
                                 "ELEIND","EMESPI", "ERIBON", "EROBOT", "EROCIC", "EROMOS", "EUCCAM", "EUPMAC", "EUPPEP", "EUPSER", "FESMYU", "FESPER", "FOEVUL", "FURFOE", "GAMSTA", "GLECOR", "HEDRHA", "HELECH", "HIRINC",
                                 "HORMUR", "HYPCAN", "HYPGLA", "LACSER", "LAMAUR", "LEPDID", "LIMPER", "LOBERI", "LOBMAR", "LOGGAL", "LYSARV", "LYTHYS", "MALCRO", "MALPAR", "MATDIS", "MEDPOL", "MELALB", "MELIND", "MELREP",
                                 "MESCRY", "MESNOD", "MYOLAE", "MYRT spp", "NICGLA", "ONCPIL", "OXACOR", "OXAPES", "PARINIC", "PENCLA", "PENSET", "PHALAR", "PHOCAN", "POAANN", "POLAVI", "POLMON", "POLTET", "POROLE", "PSELUT", 
                                 "RAPSAT", "RICCOM", "RUMCRI", "SAGAPE", "SALORI", "SAL spp.", "SCHBAR", "SILGAL", "SISIRI", "SISORI", "SOLNIG", "SOLLYC", "SOLPHY", "SONASP", "SONOLE","SPEBOC", "SPEVIL", "SPOIND", "STENEG", "STIMIL",
                                 "TETTET", "TRIHIR", "VACFAR", "VERARV")),
      selectizeInput("Target Species 19", "Target Species 19:",
                     choices = c("", "ABUTHE", "ACACYC", "AGAAME", "ALOMAC", "ANTCOT", "APIGRA", "ASPASP", "ATRGLA", "ATRSEM", "AVEBAR", "AVEFAT", "BASHYS", "BIDPIL", "BRADIS", "BRANIG", "BRATOU", "BROCAT",
                                 "BRODIA", "BROHOR", "BRORUB", "CARMAC", "CAREDU",  "CENMEL", "CHAFOL", "CHEALB", "COTAUS", "CYCLEP", "CYNDAC", "CYPDIF", "DELOSP spp", "DICMIC", "DIGSAN", "DITGRA", "DYSSAM", "EHRERE", 
                                 "ELEIND","EMESPI", "ERIBON", "EROBOT", "EROCIC", "EROMOS", "EUCCAM", "EUPMAC", "EUPPEP", "EUPSER", "FESMYU", "FESPER", "FOEVUL", "FURFOE", "GAMSTA", "GLECOR", "HEDRHA", "HELECH", "HIRINC",
                                 "HORMUR", "HYPCAN", "HYPGLA", "LACSER", "LAMAUR", "LEPDID", "LIMPER", "LOBERI", "LOBMAR", "LOGGAL", "LYSARV", "LYTHYS", "MALCRO", "MALPAR", "MATDIS", "MEDPOL", "MELALB", "MELIND", "MELREP",
                                 "MESCRY", "MESNOD", "MYOLAE", "MYRT spp", "NICGLA", "ONCPIL", "OXACOR", "OXAPES", "PARINIC", "PENCLA", "PENSET", "PHALAR", "PHOCAN", "POAANN", "POLAVI", "POLMON", "POLTET", "POROLE", "PSELUT", 
                                 "RAPSAT", "RICCOM", "RUMCRI", "SAGAPE", "SALORI", "SAL spp.", "SCHBAR", "SILGAL", "SISIRI", "SISORI", "SOLNIG", "SOLLYC", "SOLPHY", "SONASP", "SONOLE","SPEBOC", "SPEVIL", "SPOIND", "STENEG", "STIMIL",
                                 "TETTET", "TRIHIR", "VACFAR", "VERARV")),
      selectizeInput("Target Species 20", "Target Species 20:",
                     choices = c("", "ABUTHE", "ACACYC", "AGAAME", "ALOMAC", "ANTCOT", "APIGRA", "ASPASP", "ATRGLA", "ATRSEM", "AVEBAR", "AVEFAT", "BASHYS", "BIDPIL", "BRADIS", "BRANIG", "BRATOU", "BROCAT",
                                 "BRODIA", "BROHOR", "BRORUB", "CARMAC", "CAREDU",  "CENMEL", "CHAFOL", "CHEALB", "COTAUS", "CYCLEP", "CYNDAC", "CYPDIF", "DELOSP spp", "DICMIC", "DIGSAN", "DITGRA", "DYSSAM", "EHRERE", 
                                 "ELEIND","EMESPI", "ERIBON", "EROBOT", "EROCIC", "EROMOS", "EUCCAM", "EUPMAC", "EUPPEP", "EUPSER", "FESMYU", "FESPER", "FOEVUL", "FURFOE", "GAMSTA", "GLECOR", "HEDRHA", "HELECH", "HIRINC",
                                 "HORMUR", "HYPCAN", "HYPGLA", "LACSER", "LAMAUR", "LEPDID", "LIMPER", "LOBERI", "LOBMAR", "LOGGAL", "LYSARV", "LYTHYS", "MALCRO", "MALPAR", "MATDIS", "MEDPOL", "MELALB", "MELIND", "MELREP",
                                 "MESCRY", "MESNOD", "MYOLAE", "MYRT spp", "NICGLA", "ONCPIL", "OXACOR", "OXAPES", "PARINIC", "PENCLA", "PENSET", "PHALAR", "PHOCAN", "POAANN", "POLAVI", "POLMON", "POLTET", "POROLE", "PSELUT", 
                                 "RAPSAT", "RICCOM", "RUMCRI", "SAGAPE", "SALORI", "SAL spp.", "SCHBAR", "SILGAL", "SISIRI", "SISORI", "SOLNIG", "SOLLYC", "SOLPHY", "SONASP", "SONOLE","SPEBOC", "SPEVIL", "SPOIND", "STENEG", "STIMIL",
                                 "TETTET", "TRIHIR", "VACFAR", "VERARV")),
      
      numericInput("# of Truckloads", "# of Truckloads:", value = 0, min = 0),
      
      numericInput("# of Bags", "# of Bags:", value = 0, min = 0),
      
      textInput("Initials", "Enter Initials:", placeholder = "Type here"),
      
      actionButton("submit", "Submit"),
      actionButton("removeLast", "Remove Last Entry")
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
  
  # Updated path to store Excel files in the 'Data' subfolder
  excel_file_path <- "Data/invasive_species_data.xlsx"
  
  # Ensure the Data directory exists
  if (!dir.exists("Data")) {
    dir.create("Data")
  }
  
  # Function to save data with summaries to Excel
  save_data_with_summaries <- function(data_to_save) {
    wb <- createWorkbook()
    addWorksheet(wb, "Data")
    writeData(wb, "Data", data_to_save)
    
    if (nrow(data_to_save) > 0) {
      calc_data <- data_to_save
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
      
      quarterly <- aggregate(cbind(NumberOfPeople, AcresTreated, NumberOfTruckloads, NumberOfBags, TotalTime, TrimHours) ~ YearQuarter, 
                             data = calc_data, FUN = sum, na.rm = TRUE)
      names(quarterly) <- c("Quarter", "Total_People", "Total_Acres", "Total_Truckloads", "Total_Bags", "Total_Time", "Total_Trim_Hours")
      
      addWorksheet(wb, "Monthly_Summary")
      writeData(wb, "Monthly_Summary", monthly_summary)
      addWorksheet(wb, "Quarterly_Summary")
      writeData(wb, "Quarterly_Summary", quarterly)
    }
    
    saveWorkbook(wb, excel_file_path, overwrite = TRUE)
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
                                TargetSpecies8 = character(), 
                                TargetSpecies9 = character(), 
                                TargetSpecies10 = character(), 
                                TargetSpecies11 = character(), 
                                TargetSpecies12 = character(), 
                                TargetSpecies13 = character(), 
                                TargetSpecies14 = character(), 
                                TargetSpecies15 = character(), 
                                TargetSpecies16 = character(), 
                                TargetSpecies17 = character(), 
                                TargetSpecies18 = character(), 
                                TargetSpecies19 = character(), 
                                TargetSpecies20 = character(),
                                NumberOfTruckloads = numeric(),
                                NumberOfBags = numeric(),
                                TotalTime = numeric(),
                                TrimHours = numeric(),
                                Initials = character(),
                                stringsAsFactors = FALSE)
  }
  
  data <- reactiveVal(existing_data)
  lastSite <- reactiveVal("Select site")
  
  observeEvent(input$submit, {
    # VALIDATION: Check if # of bags is 0
    if (input$`# of Bags` <= 0 && input$'Trim Hours' <= 0) {
      output$status <- renderText("ERROR: Submission blocked. You must enter a number of bags greater than 0.")
      return() # Exit the function early without saving
    }
    
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
                           TargetSpecies8 = ifelse(input$`Target Species 8` == "Select species", "", input$`Target Species 8`),
                           TargetSpecies9 = ifelse(input$`Target Species 9` == "Select species", "", input$`Target Species 9`),
                           TargetSpecies10 = ifelse(input$`Target Species 10` == "Select species", "", input$`Target Species 10`),
                           TargetSpecies11 = ifelse(input$`Target Species 11` == "Select species", "", input$`Target Species 11`),
                           TargetSpecies12 = ifelse(input$`Target Species 12` == "Select species", "", input$`Target Species 12`),
                           TargetSpecies13 = ifelse(input$`Target Species 13` == "Select species", "", input$`Target Species 13`),
                           TargetSpecies14 = ifelse(input$`Target Species 14` == "Select species", "", input$`Target Species 14`),
                           TargetSpecies15 = ifelse(input$`Target Species 15` == "Select species", "", input$`Target Species 15`),
                           TargetSpecies16 = ifelse(input$`Target Species 16` == "Select species", "", input$`Target Species 16`),
                           TargetSpecies17 = ifelse(input$`Target Species 17` == "Select species", "", input$`Target Species 17`),
                           TargetSpecies18 = ifelse(input$`Target Species 18` == "Select species", "", input$`Target Species 18`),
                           TargetSpecies19 = ifelse(input$`Target Species 19` == "Select species", "", input$`Target Species 19`),
                           TargetSpecies20 = ifelse(input$`Target Species 20` == "Select species", "", input$`Target Species 20`),
                           NumberOfTruckloads = input$`# of Truckloads`,
                           NumberOfBags = input$`# of Bags`,
                           TotalTime = input$`Total Time`,
                           TrimHours = input$`Trim Hours`,
                           Initials = input$Initials,
                           stringsAsFactors = FALSE)
    
    updated_data <- rbind(data(), new_data)
    data(updated_data)
    
    tryCatch({
      save_data_with_summaries(updated_data)
      lastSite(input$Site)
      output$status <- renderText("Data submitted successfully!")
    }, error = function(e) {
      output$status <- renderText(paste("Error:", e$message))
    })
    
    # Reset inputs after successful submission
    updateSelectInput(session, "Target Species 1", selected = "Select Species")
    updateSelectInput(session, "Target Species 2", selected = "Select Species")
    updateSelectInput(session, "Target Species 3", selected = "Select Species")
    updateSelectInput(session, "Target Species 4", selected = "Select Species")
    updateSelectInput(session, "Target Species 5", selected = "Select Species")
    updateSelectInput(session, "Target Species 6", selected = "Select Species")
    updateSelectInput(session, "Target Species 7", selected = "Select Species")
    updateSelectInput(session, "Target Species 8", selected = "Select Species")
    updateSelectInput(session, "Target Species 9", selected = "Select Species")
    updateSelectInput(session, "Target Species 10", selected = "Select Species")
    updateSelectInput(session, "Target Species 11", selected = "Select Species")
    updateSelectInput(session, "Target Species 12", selected = "Select Species")
    updateSelectInput(session, "Target Species 13", selected = "Select Species")
    updateSelectInput(session, "Target Species 14", selected = "Select Species")
    updateSelectInput(session, "Target Species 15", selected = "Select Species")
    updateSelectInput(session, "Target Species 16", selected = "Select Species")
    updateSelectInput(session, "Target Species 17", selected = "Select Species")
    updateSelectInput(session, "Target Species 18", selected = "Select Species")
    updateSelectInput(session, "Target Species 19", selected = "Select Species")
    updateSelectInput(session, "Target Species 20", selected = "Select Species")
    updateNumericInput(session, "Site Number", value = 1)
    updateNumericInput(session, "# of People", value = 1)
    updateNumericInput(session, "Acres Treated", value = 0)
    updateNumericInput(session, "# of Truckloads", value = 0)
    updateNumericInput(session, "# of Bags", value = 0)
    updateNumericInput(session, "Total Time", value = 0)
    updateNumericInput(session, "Trim Hours", value = 0)
    updateSelectInput(session, "Site", selected = lastSite())
  })
  
  observeEvent(input$removeLast, {
    current_data <- data()
    if (nrow(current_data) > 0) {
      updated_data <- current_data[-nrow(current_data), ]
      data(updated_data)
      tryCatch({
        save_data_with_summaries(updated_data)
        output$status <- renderText("Last entry removed successfully!")
      }, error = function(e) {
        output$status <- renderText(paste("Error removing entry:", e$message))
      })
      
      if (nrow(updated_data) > 0) {
        lastSite(updated_data$Site[nrow(updated_data)])
      } else {
        lastSite("Select site")
      }
    } else {
      output$status <- renderText("No entries to remove.")
    }
  })
  
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
  
  output$dataTable <- renderTable({
    data()
  }, rownames = TRUE)
  
  output$monthlySummary <- renderTable({
    current_data <- data()
    if (nrow(current_data) > 0) {
      current_data$Date <- as.Date(current_data$SurveyDate, format = "%m/%d/%Y")
      current_data$YearMonth <- format(current_data$Date, "%Y-%m")
      monthly <- aggregate(cbind(NumberOfPeople, AcresTreated, NumberOfTruckloads, NumberOfBags, TotalTime, TrimHours) ~ YearMonth, 
                           data = current_data, FUN = sum, na.rm = TRUE)
      monthly$Month <- format(as.Date(paste0(monthly$YearMonth, "-01")), "%B %Y")
      monthly <- monthly[c("Month", "NumberOfPeople", "AcresTreated", "NumberOfTruckloads", "NumberOfBags", "TotalTime", "TrimHours")]
      names(monthly) <- c("Month", "Total People", "Total Acres", "Total Truckloads", "Total Bags", "Total Time", "Total Trim Hours")
      return(monthly[order(monthly$Month, decreasing = TRUE), ])
    } else {
      return(data.frame(Message = "No data available for summary"))
    }
  }, rownames = FALSE)
  
  output$quarterlySummary <- renderTable({
    current_data <- data()
    if (nrow(current_data) > 0) {
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
  
}

# Run application
shinyApp(ui = ui, server = server)