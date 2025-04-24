library(shiny)
library(shinyjs)
library(bslib)

# User interface ----------------------------------------------------------
ui <- page_sidebar(
  title = div(style = "font-size:50px;",tags$img(src = "shac_icon.png", 
                       height = "60px", 
                       alt = "Tracker Logo"),"Training Tracker"),
  theme = my_theme,
  useShinyjs(),
  # Sidebar
  sidebar = sidebar(
    id = "sidebar_toogle",
    title = "Training Information",
    width = 350,
    # Fields to collect textual data
    textInput("name", "Training Name", placeholder = "Enter the name of the training"),
    selectInput("domain", "Strategies", choices = unique(drop_down$Strategies)),
    selectInput("subdomain", "Program domain", choices = NULL),
    selectInput("priority_area", "Priority area", choices = NULL),
    textInput("location", "Training Location"),
    selectInput("level", "Training Level", choices = c("National level", 
                                                       "Zonal", 
                                                       "Regional level", 
                                                       "District level", 
                                                       "Site Level")),
    selectInput("type", "Training Type", choices = c("New training", 
                                                     "Refresher Training")),
    dateInput("training_date", "Training Date"),
    
    # Reporter information section
    hr(),
    h4("Reporter Information", class = "sidebar-title"),
    textInput("reporter_name", "Reporter Name", placeholder = "Enter your full name"),
    textInput("reporter_email", "Reporter Email", placeholder = "example@shwarihealth.org"),
    textInput("reporter_function", "Function", placeholder = "Your position or role"),
    
    # Submit form button
    add_busy_spinner(spin = "fading-circle"),
    actionButton("submit", "Submit", class = "btn-primary btn-lg w-100 mt-3", 
                 icon = icon("save"))
  ),
  layout_columns(
    navset_card_underline(
      id = "nav_tabs",
      nav_panel(
        width = 12,
        title = "Participants",
        icon = icon("users"),
        card(
          height = "1800px",
          card_header(
            h3("Participants", class = "mb-0 text-primary")
          ),
          card_body(
            # First section: Invited vs Attended participation numbers
            fluidRow(
              class = "mb-4",
              
              # Left column: Invited participants
              column(
                width = 6,
                card(
                  card_header(h4("Invited", class = "mb-0 text-info")),
                  card_body(
                    numericInput("participants_invited", 
                                 "Total invited participants", 
                                 value = 0, 
                                 min = 0),
                    hr(),
                    h5("Participant Types", class = "text-muted"),
                    numericInput("participants_invited_program_mentors", 
                                 "Program mentors", 
                                 value = 0, 
                                 min = 0),
                    numericInput("participants_invited_districts_mentors", 
                                 "District mentors", 
                                 value = 0, 
                                 min = 0),
                    numericInput("participants_invited_doctors", 
                                 "facilities Doctors", 
                                 value = 0, 
                                 min = 0),
                    numericInput("participants_invited_nurses", 
                                 "Nurses", 
                                 value = 0, 
                                 min = 0),
                    numericInput("participants_invited_meo", 
                                 "ME officers", 
                                 value = 0, 
                                 min = 0),
                    numericInput("participants_invited_mem", 
                                 "ME mentors", 
                                 value = 0, 
                                 min = 0),
                    numericInput("participants_invited_lab", 
                                 "Lab Techs", 
                                 value = 0, 
                                 min = 0),
                    numericInput("participants_invited_stockmgmt", 
                                 "Stock management", 
                                 value = 0, 
                                 min = 0),
                    numericInput("participants_invited_dataclerk", 
                                 "Data clerk/ACRR", 
                                 value = 0, 
                                 min = 0),
                    numericInput("participants_invited_aps", 
                                 "APS", 
                                 value = 0, 
                                 min = 0),
                    numericInput("participants_invited_facilities_staff", 
                                 "Facilities MoH staff", 
                                 value = 0, 
                                 min = 0),
                    numericInput("participants_invited_districts_staff", 
                                 "District staff", 
                                 value = 0, 
                                 min = 0),
                    numericInput("participants_invited_other_org_staff", 
                                 "Staff from other organization", 
                                 value = 0, 
                                 min = 0),
                    numericInput("participants_invited_cbo", 
                                 "CBO", 
                                 value = 0, 
                                 min = 0),
                    numericInput("participants_invited_chw", 
                                 "CHW", 
                                 value = 0, 
                                 min = 0),
                    numericInput("participants_invited_mothers_mentors", 
                                 "Mothers mentors", 
                                 value = 0, 
                                 min = 0),
                    numericInput("participants_invited_expert_client", 
                                 "Expert client", 
                                 value = 0, 
                                 min = 0),
                    numericInput("participants_invited_adolescent_champion", 
                                 "Adolescent champion", 
                                 value = 0, 
                                 min = 0)
                  )
                )
              ),
              
              # Right column: Attended participants
              column(
                width = 6,
                card(
                  card_header(h4("Attended", class = "mb-0 text-success")),
                  card_body(
                    numericInput("participants_attended", 
                                 "Total participants who attended", 
                                 value = 0, 
                                 min = 0),
                    hr(),
                    h5("Participant Types", class = "text-muted"),
                    numericInput("participants_attended_program_mentors", 
                                 "Program mentors", 
                                 value = 0, 
                                 min = 0),
                    numericInput("participants_attended_districts_mentors", 
                                 "District mentors", 
                                 value = 0, 
                                 min = 0),
                    numericInput("participants_attended_doctors", 
                                 "facilities Doctors", 
                                 value = 0, 
                                 min = 0),
                    numericInput("participants_attended_nurses", 
                                 "Nurses", 
                                 value = 0, 
                                 min = 0),
                    numericInput("participants_attended_meo", 
                                 "ME officers", 
                                 value = 0, 
                                 min = 0),
                    numericInput("participants_attended_mem", 
                                 "ME mentors", 
                                 value = 0, 
                                 min = 0),
                    numericInput("participants_attended_lab", 
                                 "Lab Techs", 
                                 value = 0, 
                                 min = 0),
                    numericInput("participants_attended_stockmgmt", 
                                 "Stock management", 
                                 value = 0, 
                                 min = 0),
                    numericInput("participants_attended_dataclerk", 
                                 "Data clerk/ACRR", 
                                 value = 0, 
                                 min = 0),
                    numericInput("participants_attended_aps", 
                                 "APS", 
                                 value = 0, 
                                 min = 0),
                    numericInput("participants_attended_facilities_staff", 
                                 "Facilities MoH staff", 
                                 value = 0, 
                                 min = 0),
                    numericInput("participants_attended_districts_staff", 
                                 "District staff", 
                                 value = 0, 
                                 min = 0),
                    numericInput("participants_attended_other_org_staff", 
                                 "Staff from other organization", 
                                 value = 0, 
                                 min = 0),
                    numericInput("participants_attended_cbo", 
                                 "CBO", 
                                 value = 0, 
                                 min = 0),
                    numericInput("participants_attended_chw", 
                                 "CHW", 
                                 value = 0, 
                                 min = 0),
                    numericInput("participants_attended_mothers_mentors", 
                                 "Mothers mentors", 
                                 value = 0, 
                                 min = 0),
                    numericInput("participants_attended_expert_client", 
                                 "Expert client", 
                                 value = 0, 
                                 min = 0),
                    numericInput("participants_attended_adolescent_champion", 
                                 "Adolescent champion", 
                                 value = 0, 
                                 min = 0)
                  )
                )
              )
            ),
            
            # Section divider
            hr(),
            
            # Second section: Participant Affiliations
            h4("Participant Affiliations", class = "mb-3 text-primary"),
            fluidRow(
              class = "mb-3",
              
              # Left column: Invited affiliations
              column(
                width = 6,
                card(
                  card_header(h5("Invited", class = "mb-0 text-info")),
                  card_body(
                    numericInput("participants_invited_moh_central", 
                                 "MOH Central level", 
                                 value = 0, 
                                 min = 0),
                    numericInput("participants_invited_moh_regional", 
                                 "MOH regional level", 
                                 value = 0, 
                                 min = 0),
                    numericInput("participants_invited_moh_district", 
                                 "MOH district level", 
                                 value = 0, 
                                 min = 0),
                    numericInput("participants_invited_moh_facility", 
                                 "MOH facility level", 
                                 value = 0, 
                                 min = 0),
                    numericInput("participants_invited_shac_staff", 
                                 "SHWARI STAFF", 
                                 value = 0, 
                                 min = 0),
                    numericInput("participants_invited_community_staff", 
                                 "COMMUNITY  STAFF (CBO,CHW,Mothers mentors,clients experts, adolescent champions)", 
                                 value = 0, 
                                 min = 0)
                  )
                )
              ),
              
              # Right column: Attended affiliations
              column(
                width = 6,
                card(
                  card_header(h5("Attended", class = "mb-0 text-success")),
                  card_body(
                    numericInput("participants_attended_moh_central", 
                                 "MOH Central level", 
                                 value = 0, 
                                 min = 0),
                    numericInput("participants_attended_moh_regional", 
                                 "MOH regional level", 
                                 value = 0, 
                                 min = 0),
                    numericInput("participants_attended_moh_district", 
                                 "MOH district level", 
                                 value = 0, 
                                 min = 0),
                    numericInput("participants_attended_moh_facility", 
                                 "MOH facility level", 
                                 value = 0, 
                                 min = 0),
                    numericInput("participants_attended_shac_staff", 
                                 "SHWARI STAFF", 
                                 value = 0, 
                                 min = 0),
                    numericInput("participants_attended_community_staff", 
                                 "COMMUNITY  STAFF (CBO,CHW,Mothers mentors,clients experts, adolescent champions)", 
                                 value = 0, 
                                 min = 0)
                  )
                )
              )
            )
          )
        )
      ),
      nav_panel(
        width = 12,
        title = "Facilitators",
        icon = icon("chalkboard-teacher"),
        card(
          height = "1300px",
          card_header(
            h3("Facilitators", class = "mb-0 text-primary")
          ),
          card_body(
            layout_column_wrap(
              width = 1/2,
              # Invited facilitators
              card(
                card_header(h4("Invited", class = "mb-0 text-info")),
                card_body(
                  numericInput("facilitators_invited", "Total invited facilitators", value = 0, min = 0),
                  hr(),
                  h5("Facilitator Affiliations", class = "text-muted"),
                  numericInput("facilitators_invited_moh_central", "MOH Central Level", value = 0, min = 0),
                  numericInput("facilitators_invited_moh_regional", "MOH Regional Level", value = 0, min = 0),
                  numericInput("facilitators_invited_moh_district", "MOH District Level", value = 0, min = 0),
                  numericInput("facilitators_invited_moh_facility", "MOH Facility Level", value = 0, min = 0),
                  numericInput("facilitators_invited_shac", "SHWARI STAFF", value = 0, min = 0),
                  numericInput("facilitators_invited_community_staff", "COMMUNITY  STAFF", value = 0, min = 0),
                  numericInput("facilitators_invited_other_organization", "Other organization", value = 0, min = 0)
                )
              ),
              # Attended facilitators
              card(
                card_header(h4("Attended", class = "mb-0 text-success")),
                card_body(
                  numericInput("facilitators_attended", "Total facilitators who attended", value = 0, min = 0),
                  hr(),
                  h5("Facilitator Affiliations", class = "text-muted"),
                  numericInput("facilitators_attended_moh_central", "MOH Central Level", value = 0, min = 0),
                  numericInput("facilitators_attended_moh_regional", "MOH Regional Level", value = 0, min = 0),
                  numericInput("facilitators_attended_moh_district", "MOH District Level", value = 0, min = 0),
                  numericInput("facilitators_attended_moh_facility", "MOH Facility Level", value = 0, min = 0),
                  numericInput("facilitators_attended_shac", "SHWARI STAFF", value = 0, min = 0),
                  numericInput("facilitators_attended_community_staff", "COMMUNITY  STAFF", value = 0, min = 0),
                  numericInput("facilitators_attended_other_organization", "Other organization", value = 0, min = 0)
                )
              )
            )
          )
        )
        
      ),
      nav_panel(
        title = "Costs",
        icon = icon("money-bill"),
        card(
          card_header(
            h3("Training Costs", class = "mb-0 text-primary")
          ),
          card_body(
            layout_column_wrap(
              width = 1/2,
              card(
                card_header(h4("Material & Logistics", class = "mb-0")),
                card_body(
                  numericInput("cost_material", "Training Material", value = 0, min = 0, 
                               width = "100%"),
                  numericInput("cost_hall", "Hall Rental", value = 0, min = 0, 
                               width = "100%"),
                  numericInput("cost_food", "Food & Water", value = 0, min = 0, 
                               width = "100%"),
                  numericInput("cost_lodging", "Lodging", value = 0, min = 0, 
                               width = "100%")
                )
              ),
              card(
                card_header(h4("Travel & Compensation", class = "mb-0")),
                card_body(
                  numericInput("cost_travel", "Travel & Per diem", value = 0, min = 0, 
                               width = "100%"),
                  numericInput("cost_transport", "Transport Reimbursement", value = 0, min = 0, 
                               width = "100%"),
                  numericInput("cost_facilitation", "Facilitation Fees", value = 0, min = 0, 
                               width = "100%")
                )
              )
            )
          )
        )
      ),
      nav_panel(
        title = "Documents",
        icon = icon("file-pdf"),
        card(
          card_header(
            h3("Training Documents", class = "mb-0 text-primary")
          ),
          card_body(
            fileInput("files", "Select training documents",
                      multiple = TRUE,
                      accept = c(".pdf", ".docx", ".xlsx", ".csv", ".jpg", ".png", ".pptx"),
                      buttonLabel = "Browse...",
                      placeholder = "No files selected")),
          div(
            class = "alert alert-warning",
            style = "margin-bottom: 20px;",
            div(
              class = "d-flex",
              tags$i(class = "fa fa-file-upload me-3", style = "font-size: 24px; margin-top: 2px;"),
              div(
                tags$h4("Required Documentation", style = "margin-top: 0; font-weight: 600;"),
                tags$p("Please ensure you have the following documents ready for upload:"),
                tags$ol(
                  tags$li(tags$strong("Service Note:"), " Official documentation of the training service"),
                  tags$li(tags$strong("Attendance Sheets:"), " Signed record of all participants"),
                  tags$li(tags$strong("Training Reports:"), " Comprehensive summary of training activities and outcomes"),
                  tags$li(tags$strong("Visual Documentation:"), " Photographs from the training session")
                ),
                tags$p(class = "mb-0", style = "font-style: italic;", "All documents must be in PDF, DOC, or DOCX format. Images should be JPG or PNG.")
              )
            )
          )
          
          )),
      nav_panel(
        title = "Modify a record",
        icon = icon("edit"),
        div(
          class = "alert alert-info",
          style = "margin-bottom: 20px;",
          div(
            class = "d-flex",
            tags$i(class = "fa fa-info-circle me-3", style = "font-size: 24px; margin-top: 2px;"),
            div(
              tags$h4("How to Modify a Record", style = "margin-top: 0;"),
              tags$ol(
                tags$li("Use the search box below to locate the training session you wish to modify."),
                tags$li("Click on the row containing the record you want to edit."),
                tags$li("A dialog box will appear with the current record details."),
                tags$li("Make your desired changes to the information."),
                tags$li("Click the 'Save Changes' button to update the record.")
              ),
              "Your changes will be saved immediately in the database."
            )
          )
        ),
        DT::dataTableOutput("table")
      ),
      nav_panel(
        title = "Dashoard",
        icon = icon("dashboard")
      )
      
    )
    
    
  )
)







ui <- secure_app(
    ui,
    id = "auth",
    tags_top = tags$div(
      class = "auth-top",
      tags$img(
        src = "shac_icon.png",
        height = 80,
        class = "auth-logo"
      ),
      tags$h2(
        "Training Tracker",
        class = "auth-title"
      ),
      tags$p(
        "To monitor all the training in the program",
        class = "auth-subtitle"
      )
    ),
    
    # Enhanced bottom section
    tags_bottom = tags$div(
      class = "auth-bottom",
      tags$p(
        class = "contact-info",
        "For any question please contact the",
        tags$a(
          href = "mailto:aureolngako@yahoo.fr?Subject=Shiny%20aManager",
          target = "_top",
          "administrator"
        )
      )
    ),
    
    background = "auth-background",
    
    head_auth = tags$head(
      tags$style(HTML("
    /* Base styles with new background */
    body {
      margin: 0;
      padding: 0;
      min-height: 100vh;
      background: linear-gradient(135deg, #1a5276 0%, #2980b9 100%) !important;  /* Deep blue gradient */
      position: relative;
      overflow-x: hidden;
    }

    /* Add animated background pattern */
    body::before {
      content: '';
      position: fixed;
      width: 200%;
      height: 200%;
      top: -50%;
      left: -50%;
      z-index: 0;
      background: 
        radial-gradient(circle at center, rgba(255,255,255,0.05) 0%, transparent 3%) 0 0,
        radial-gradient(circle at center, rgba(255,255,255,0.05) 0%, transparent 3%) 25px 25px;
      background-size: 50px 50px;
      animation: backgroundMove 30s linear infinite;
      opacity: 0.5;
    }

    @keyframes backgroundMove {
      0% { transform: rotate(0deg); }
      100% { transform: rotate(360deg); }
    }

    .container-fluid {
      position: relative;
      z-index: 1;
      min-height: 100vh;
      display: flex;
      justify-content: center;
      align-items: center;
    }

    .auth-background {
      position: relative;
      min-height: 100vh;
      width: 100vw;
      display: flex;
      align-items: center;
      justify-content: center;
    }

    /* Main wrapper */
    .wrapper {
      width: min(90%, 400px);
      margin: auto;
      padding: 1rem;
      position: relative;
      z-index: 2;
    }

    /* Panel styling */
    .panel {
      background: white;
      border-radius: 12px;
      box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
      padding: 2rem;
      width: 100%;
    }

    /* Rest of your existing styles... */
    .auth-top {
      text-align: center;
      margin-bottom: 1.5rem;
    }

    .auth-logo {
      max-width: 100%;
      height: auto;
      margin-bottom: 1rem;
    }

    .auth-title {
      color: #2c3e50;
      font-size: 2rem;
      margin-bottom: 0.5rem;
    }

    .auth-subtitle {
      color: #7f8c8d;
      font-size: 1.5rem;
    }

    .form-group {
      margin-bottom: 1rem;
    }

    .form-control {
  width: 100% !important;
  padding: 0.75rem !important;
  border: 1px solid #ddd !important;
  border-radius: 6px !important;
  font-size: 1.1rem !important;  /* Increased from 0.9rem */
}

/* Add styles for the labels */
.form-group label {
  font-size: 1.1rem !important;  /* Increased text size for labels */
  color: #2c3e50 !important;
  margin-bottom: 0.5rem !important;
  display: block !important;
  font-weight: 500 !important;
}

/* Style for placeholder text */
.form-control::placeholder {
  font-size: 1.1rem !important;  /* Match input text size */
  color: #95a5a6 !important;
}

    .btn-primary {
      width: 100%;
      padding: 0.75rem;
      margin-top: 1rem;
      border-radius: 6px;
      font-size: 0.9rem;
      background-color: #2980b9;
      border: none;
      transition: all 0.3s ease;
    }

    .btn-primary:hover {
      background-color: #1a5276;
      transform: translateY(-2px);
      box-shadow: 0 5px 15px rgba(41, 128, 185, 0.3);
    }

    .auth-bottom {
      text-align: center;
      margin-top: 1.5rem;
      font-size: 0.85rem;
    }

    .contact-info {
      margin-bottom: 1rem;
    }

    .contact-info a {
      color: #2980b9;
      text-decoration: none;
    }

    .demo-credentials {
      background: #f8f9fa;
      padding: 1rem;
      border-radius: 6px;
      text-align: left;
    }

    .demo-credentials ul {
      list-style: none;
      padding-left: 0;
      margin: 0.5rem 0 0;
    }

    .demo-credentials li {
      margin-bottom: 0.25rem;
    }

    @media (max-width: 480px) {
      .wrapper {
        width: 95%;
        padding: 0.5rem;
      }

      .panel {
        padding: 1.9rem;
      }
    }

    @media (max-height: 600px) {
      .wrapper {
        margin: 1rem auto;
      }

      .auth-logo {
        height: 60px;
      }
    }
    "))
    ),
    
    theme = shinytheme("flatly"),
    language = "en"
  )









