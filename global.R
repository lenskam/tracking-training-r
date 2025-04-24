
# Install packages --------------------------------------------------------

pacman::p_load(
  shiny,
  shinyjs,
  googlesheets4,
  waiter,
  googledrive,
  bslib,
  shinybusy,
  shinymanager,
  here,
  rio,
  shinythemes,
  dplyr,
  shinyalert,
  DT
)


# Définir un dossier pour stocker les jetons d'authentification
options(gargle_oauth_cache = ".secrets")

# Procéder à l'authentification interactive

googledrive::drive_auth(email = "aureollerocher@gmail.com", cache = ".secrets")



# App theme ---------------------------------------------------------------

# Create the theme first with bs_theme
my_theme <- bs_theme(bootswatch = "flatly")

# Then add the custom CSS rules
my_theme <- bs_add_rules(my_theme, "
  .navbar {
    background: linear-gradient(to right, #2c3e50, #4CA1AF) !important;
  }
  .navbar-brand, .navbar .bslib-page-title {
    color: white !important;
  }

")



# Import the dropdown list table ------------------------------------------


drop_down <- here("www","drop.xlsx") %>% 
              import()


rv <- reactiveValues(
  # Sidebar inputs
  name = NULL,
  domain = NULL,
  subdomain = NULL,
  priority_area = NULL,
  location = NULL,
  level = NULL,
  type = NULL,
  training_date = NULL,
  reporter_name = NULL,
  reporter_email = NULL,
  reporter_function = NULL,
  
  # Participants - Invited
  participants_invited = NULL,
  participants_invited_program_mentors = NULL,
  participants_invited_districts_mentors = NULL,
  participants_invited_doctors = NULL,
  participants_invited_nurses = NULL,
  participants_invited_meo = NULL,
  participants_invited_mem = NULL,
  participants_invited_lab = NULL,
  participants_invited_stockmgmt = NULL,
  participants_invited_dataclerk = NULL,
  participants_invited_aps = NULL,
  participants_invited_facilities_staff = NULL,
  participants_invited_districts_staff = NULL,
  participants_invited_other_org_staff = NULL,
  participants_invited_cbo = NULL,
  participants_invited_chw = NULL,
  participants_invited_mothers_mentors = NULL,
  participants_invited_expert_client = NULL,
  participants_invited_adolescent_champion = NULL,
  
  # Participants - Attended
  participants_attended = NULL,
  participants_attended_program_mentors = NULL,
  participants_attended_districts_mentors = NULL,
  participants_attended_doctors = NULL,
  participants_attended_nurses = NULL,
  participants_attended_meo = NULL,
  participants_attended_mem = NULL,
  participants_attended_lab = NULL,
  participants_attended_stockmgmt = NULL,
  participants_attended_dataclerk = NULL,
  participants_attended_aps = NULL,
  participants_attended_facilities_staff = NULL,
  participants_attended_districts_staff = NULL,
  participants_attended_other_org_staff = NULL,
  participants_attended_cbo = NULL,
  participants_attended_chw = NULL,
  participants_attended_mothers_mentors = NULL,
  participants_attended_expert_client = NULL,
  participants_attended_adolescent_champion = NULL,
  
  # Participants Affiliations - Invited
  participants_invited_moh_central = NULL,
  participants_invited_moh_regional = NULL,
  participants_invited_moh_district = NULL,
  participants_invited_moh_facility = NULL,
  participants_invited_shac_staff = NULL,
  participants_invited_community_staff = NULL,
  
  # Participants Affiliations - Attended
  participants_attended_moh_central = NULL,
  participants_attended_moh_regional = NULL,
  participants_attended_moh_district = NULL,
  participants_attended_moh_facility = NULL,
  participants_attended_shac_staff = NULL,
  participants_attended_community_staff = NULL,
  
  # Facilitators - Invited
  facilitators_invited = NULL,
  facilitators_invited_moh_central = NULL,
  facilitators_invited_moh_regional = NULL,
  facilitators_invited_moh_district = NULL,
  facilitators_invited_moh_facility = NULL,
  facilitators_invited_shac = NULL,
  facilitators_invited_community_staff = NULL,
  facilitators_invited_other_organization = NULL,
  
  # Facilitators - Attended
  facilitators_attended = NULL,
  facilitators_attended_moh_central = NULL,
  facilitators_attended_moh_regional = NULL,
  facilitators_attended_moh_district = NULL,
  facilitators_attended_moh_facility = NULL,
  facilitators_attended_shac = NULL,
  facilitators_attended_community_staff = NULL,
  facilitators_attended_other_organization = NULL,
  
  # Costs
  cost_material = NULL,
  cost_hall = NULL,
  cost_food = NULL,
  cost_lodging = NULL,
  cost_travel = NULL,
  cost_transport = NULL,
  cost_facilitation = NULL,
  
  # Documents
  files = NULL
)




saveData <- function(data) {
  data <- data %>% as.list() %>% data.frame()
  # Add the data as a new row
  sheet_append("1izYrfx6VXcJ3XcoQG2102hvvM7_KG-ipMRGwe8VwShE", data)
}


readData <- function(){
  googlesheets4::read_sheet("1izYrfx6VXcJ3XcoQG2102hvvM7_KG-ipMRGwe8VwShE")
}

editData <- function(data,sheet,range){
  data <- data %>% as.list() %>% data.frame()
  # Modify a specific row
  range_write(
    ss = "1izYrfx6VXcJ3XcoQG2102hvvM7_KG-ipMRGwe8VwShE",
    sheet = "Feuille 1",  # ou ton vrai onglet
    data = data
  )
  
}





## Google drive management ------ 

folder_id <- as_id("1jJNdHaPp6uX5otS9v4i3KAHx7TnUQaJW")

API_key <- "AIzaSyCxlJPtLmJsB0XaMEH9l8BbPDzYTezjsbU"



# App  credentials --------------------------------------------------------


credentials <- data.frame(
  user = c("shac-training-tracker", "shac-training-tracker-dashbaord"),
  password = c("shac_2025", "shac_2025"),
  admin = c(FALSE, TRUE),
  start = c("2025-01-01", "2025-01-01"),
  expire = c("2026-10-01", "2026-10-01"),
  comment = c("Standard user", "Admin user"),
  stringsAsFactors = FALSE
)
