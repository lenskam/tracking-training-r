
# Install packages --------------------------------------------------------

pacman::p_load(
  shiny,
  shinyjs,
  googlesheets4,
  waiter,
  googledrive,
  bslib,
  shinybusy,
  shinyalert
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



subdomain_choices <- list(
  "HTS" = c(
    "A.1 Implement index Case Testing",
    "A.2 Implement strategies to screen known positives who come for retesting and re-engage them in care (do not count them as HTS_TST_POS)",
    "A.3 Scale-up SNS to all sites providing services to KPs",
    "A.4 Implement targeted community testing strategies to close the gaps in men, children, adolescents and KPs",
    "A.5 Scale-up HIV self-testing to all eligible sub-groups",
    "A.6 Implement innovative strategies like use of influencers, social media and mobile technology, focus group discussions to identify barriers & enablers of HTS and media campaigns for index testing",
    "A.7 Implement targeted testing at facility entry points using the register form of the screening tool",
    "A.8 Actively and timely Link all newly identified PLHIV to optimized ART",
    "A.9 Reports on HIV recency testing offered in designated facilities",
    "A.10 Collaborate with satellite sites not offering HIV care and treatment to identify and refer suspect cases to project sites for testing and enrollment into care"
  ),
  "ADULT CARE AND TREATMENT" = c(
    "B.1 Implement the Men Star Approach",
    "B.2 Roll out of the new HIV Guidelines",
    "B.4 Enhance patient tracking",
    "B.5 Scale up DSD models in both rural and urban settings",
    "B.6 Enhance community ART partnership for treatment referral",
    "B.7 Integrate NCD and AHD management for PLHIV",
    "B.8 Expand management of patient with HVL including HIV-DR"
  ),
  "VIRAL LOAD" = c(
    "C.4 Improve on VL sample collection, packaging, storage and referrals"
  ),
  "PMTCT" = c(
    "D.2 Longitudinal Cohort monitoring of mother-infant pair up to 24 months of final outcome",
    "D.3 Improve EID Testing by 2 months",
    "D.4 Implement Operation Triple Zero plus to meet the prevention, treatment and care needs for PBF-AGYW",
    "D.8 Tripple elimination for HIV, syphillis & Hepatitis B"
  ),
  "PEDIATRIC AND ADOLESCENT" = c(
    "E.1 Improve Case finding for children and Adolescents And Implementation of a Pediatric surge",
    "E.2 Scaleup implementation of PTCE through the District Approach and provide pediatric package of services",
    "E.4 Implement the Operation Triple Zero strategy",
    "E.5 Scale up implementation of DSD service delivery models for children and adolescents"
  ),
  "PRIORITY POPULATION (ADOLESCENT GIRLS AND YOUNG WOMEN)" = c(
    "F.1 Implement AGYW strategy"
  ),
  "TB/HIV" = c(
    "G.1 Systematic TB screening in all facility entry points and link all presumptive TB cases to HIV and TB testing",
    "G.2 Support PEPFAR-supported stand-alone HIV sites to intensify TB case finding in all entry points and optimize follow-up of TB presumptive cases",
    "G.3 Integrate TB screening in facility outreach and routine community health workers’ activities in supported districts",
    "G.4 Intensify pediatric TB case finding in all facility entry points",
    "G.6 Intensify contact tracing of household contacts below 5 years of PLHIV with confirmed pulmonary TB",
    "G.7 Support TB sample collection and strengthen integrated sample transport system for HIV and TB",
    "G.8 Implement TPT catchup plans to cover all eligible PLHIV",
    "G.10 Support implementation of the one-stop-shop model of HIV/TB service delivery at TB diagnostic and treatment centers (DTCs)",
    "G.11 Strengthen HIV/TB coordination and collaborative activities at facility, district and regional levels",
    "G.12 Support national TOT, regional trainings and site level mentoring on TB/HIV"
  ),
  "SI&E and CQI" = c(
    "I.2 Data review/validation meetings: weekly at site, Monthly at district and regional levels"
  ),
  "Lab" = c(
    "J.2 Collaborate with Lab IP to support orientation sessions on testing at entry points and enrollment of supported sites into QA programs including PPT for HIV, EID and lab",
    "J.3 Enhance Sample Transport Network/Systems"
  ),
  "Key Population" = c(
    "K.3 Implementation of friendly services, including flexible testing schedule for males, adolescents and KPs at facilities, including weekends",
    "K.7 PrEP implementation and adherence support for client on PrEP"
  ),
  "Sustainability" = c(
    "L.2 Build local partner staff and MOH staff capacity at site and above site levels and start transitioning some roles and responsibilities"
  )
)


saveData <- function(data) {
  data <- data %>% as.list() %>% data.frame()
  # Add the data as a new row
  sheet_append("1izYrfx6VXcJ3XcoQG2102hvvM7_KG-ipMRGwe8VwShE", data)
}



folder_id <- as_id("1jJNdHaPp6uX5otS9v4i3KAHx7TnUQaJW")

API_key <- "AIzaSyCxlJPtLmJsB0XaMEH9l8BbPDzYTezjsbU"


