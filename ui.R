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
    title = "Training Information",
    width = 350,
    # Fields to collect textual data
    textInput("name", "Training Name", placeholder = "Enter the name of the training"),
    selectInput("domain", "Domain", choices = names(subdomain_choices)),
    selectInput("subdomain", "Sub-domain", choices = NULL),
    textInput("location", "Training Location"),
    selectInput("level", "Training Level", choices = c("Littoral and South", 
                                                       "Regional level", 
                                                       "District level", 
                                                       "Cluster level", 
                                                       "Site Level", 
                                                       "National Level")),
    selectInput("type", "Training Type", choices = c("New training", 
                                                     "Refresher Training", 
                                                     "Technical assistance/Capacity", 
                                                     "Restitution", 
                                                     "Technical assistance/Capacity")),
    dateInput("training_date", "Training Date"),
    
    # Reporter information section
    hr(),
    h4("Reporter Information", class = "sidebar-title"),
    textInput("reporter_name", "Reporter Name", placeholder = "Enter your full name"),
    textInput("reporter_email", "Reporter Email", placeholder = "example@organization.org"),
    textInput("reporter_function", "Function", placeholder = "Your position or role"),
    
    # Submit form button
    add_busy_spinner(spin = "fading-circle"),
    actionButton("submit", "Submit", class = "btn-primary btn-lg w-100 mt-3", 
                 icon = icon("save"))
  ),
  layout_columns(
    navset_card_underline(
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
                    numericInput("participants_invited_aps", 
                                 "APS", 
                                 value = 0, 
                                 min = 0),
                    numericInput("participants_invited_experts", 
                                 "Expert Clients", 
                                 value = 0, 
                                 min = 0),
                    numericInput("participants_invited_doctors", 
                                 "Doctors", 
                                 value = 0, 
                                 min = 0),
                    numericInput("participants_invited_nurses", 
                                 "Nurses", 
                                 value = 0, 
                                 min = 0),
                    numericInput("participants_invited_acrr", 
                                 "ACRR / Data Team", 
                                 value = 0, 
                                 min = 0),
                    numericInput("participants_invited_lab", 
                                 "Lab Technicians", 
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
                    numericInput("participants_attended_aps", 
                                 "APS", 
                                 value = 0, 
                                 min = 0),
                    numericInput("participants_attended_experts", 
                                 "Expert Clients", 
                                 value = 0, 
                                 min = 0),
                    numericInput("participants_attended_doctors", 
                                 "Doctors", 
                                 value = 0, 
                                 min = 0),
                    numericInput("participants_attended_nurses", 
                                 "Nurses", 
                                 value = 0, 
                                 min = 0),
                    numericInput("participants_attended_acrr", 
                                 "ACRR / Data Team", 
                                 value = 0, 
                                 min = 0),
                    numericInput("participants_attended_lab", 
                                 "Lab Technicians", 
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
                    numericInput("participants_invited_moh", 
                                 "MOH", 
                                 value = 0, 
                                 min = 0),
                    numericInput("participants_invited_asdf", 
                                 "ASDF", 
                                 value = 0, 
                                 min = 0),
                    numericInput("participants_invited_egpaf", 
                                 "EGPAF", 
                                 value = 0, 
                                 min = 0),
                    numericInput("participants_invited_non_pepfar", 
                                 "NON PEPFAR SITES STAFF", 
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
                    numericInput("participants_attended_moh", 
                                 "MOH", 
                                 value = 0, 
                                 min = 0),
                    numericInput("participants_attended_asdf", 
                                 "ASDF", 
                                 value = 0, 
                                 min = 0),
                    numericInput("participants_attended_egpaf", 
                                 "EGPAF", 
                                 value = 0, 
                                 min = 0),
                    numericInput("participants_attended_non_pepfar", 
                                 "NON PEPFAR SITES STAFF", 
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
                  numericInput("facilitators_invited_moh", "MOH", value = 0, min = 0),
                  numericInput("facilitators_invited_asdf", "ASDF", value = 0, min = 0),
                  numericInput("facilitators_invited_egpaf", "EGPAF", value = 0, min = 0),
                  numericInput("facilitators_invited_non_pepfar", "NON PEPFAR SITES STAFF", value = 0, min = 0)
                )
              ),
              # Attended facilitators
              card(
                card_header(h4("Attended", class = "mb-0 text-success")),
                card_body(
                  numericInput("facilitators_attended", "Total facilitators who attended", value = 0, min = 0),
                  hr(),
                  h5("Facilitator Affiliations", class = "text-muted"),
                  numericInput("facilitators_attended_moh", "MOH", value = 0, min = 0),
                  numericInput("facilitators_attended_asdf", "ASDF", value = 0, min = 0),
                  numericInput("facilitators_attended_egpaf", "EGPAF", value = 0, min = 0),
                  numericInput("facilitators_attended_non_pepfar", "NON PEPFAR SITES STAFF", value = 0, min = 0)
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
                      placeholder = "No files selected"))))
      
    )
    
    
  )
)















