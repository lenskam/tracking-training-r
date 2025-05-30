
# server ------------------------------------------------------------------

server <- function(input,output,session){
  
# Credentials check -------------------------------------------------------

  auth_output <- secure_server(
    check_credentials = check_credentials(credentials)
  )
  
  # Get user information
  res_auth <- reactive({
    reactiveValuesToList(auth_output)
  })
  
  observeEvent(input$nav_tabs, {
    if (input$nav_tabs == "Dashboard"|input$nav_tabs == "Modify a record"|input$nav_tabs == "Data table") {
      # Toggle the sidebar when Dashboard tab is selected
      toggle_sidebar(id = "sidebar_toogle",open = "closed")
    } else {
      toggle_sidebar(id = "sidebar_toogle",open = "open")
    }
  })
  
  # Hide the dashboard tab for non-admin users
  observe({
    req(res_auth())
    user_data <- res_auth()
    
    # Déterminer si l'utilisateur est un administrateur
    is_admin <- FALSE
    
    # Vérifier différents formats possibles des données utilisateur
    if (is.data.frame(user_data$user) && "admin" %in% names(user_data$user)) {
      is_admin <- isTRUE(user_data$user$admin)
    } else if (is.list(user_data$user) && "admin" %in% names(user_data$user)) {
      is_admin <- isTRUE(user_data$user$admin)
    } else {
      # Recherche dans les credentials
      current_user <- user_data$user
      if (is.character(current_user) && exists("credentials")) {
        user_row <- which(credentials$user == current_user)
        if (length(user_row) > 0 && "admin" %in% names(credentials)) {
          is_admin <- isTRUE(credentials$admin[user_row])
        }
      }
    }
    
    # Ajuster la visibilité des onglets selon le statut
    if (is_admin) {
      # Pour administrateurs: montrer Dashboard, cacher les autres
      hideTab("nav_tabs", target = "Participants")
      hideTab("nav_tabs", target = "Facilitators")
      hideTab("nav_tabs", target = "Costs")
      hideTab("nav_tabs", target = "Documents")
      hideTab("nav_tabs", target = "Modify a record")
      showTab("nav_tabs", target = "Dashboard")
      showTab("nav_tabs", target = "Data table")
      
      toggle_sidebar(id = "sidebar_toogle",open = "closed")
      shinyjs::runjs("document.querySelector('.sidebar').style.display = 'none';")
      
    } else {
      # Pour utilisateurs normaux: cacher Dashboard, montrer les autres
      hideTab("nav_tabs", target = "Dashboard")
      hideTab("nav_tabs", target = "Data table")
      showTab("nav_tabs", target = "Participants")
      showTab("nav_tabs", target = "Facilitators")
      showTab("nav_tabs", target = "Costs")
      showTab("nav_tabs", target = "Documents")
      showTab("nav_tabs", target = "Modify a record")
      
      # Afficher la sidebar pour les utilisateurs standards
      shinyjs::runjs("document.querySelector('.sidebar').style.display = 'block';")
    }
  })
 
  ## Data entry part -----------------------------
  
  observeEvent(input$domain, {
    updateSelectInput(session, "subdomain",
                      choices = drop_down %>% 
                        filter(Strategies == input$domain) %>% 
                        pull(`Program domain`) %>% 
                        unique()
                        )
  })
  
  observeEvent(input$subdomain, {
    updateSelectInput(session, "priority_area",
                      choices = drop_down %>% 
                        filter(`Program domain` == input$subdomain) %>% 
                        pull(`Priority area`) %>% 
                        unique()
    )
  })
 
  observeEvent(input$submit, {
    
    Sys.sleep(3)  
    
    # Sidebar inputs
    rv$name <- input$name
    rv$domain <- input$domain
    rv$subdomain <- input$subdomain
    rv$priority_area <- input$priority_area
    rv$location <- input$location
    rv$level <- input$level
    rv$type <- input$type
    rv$training_date <- input$training_date
    rv$reporter_name <- input$reporter_name
    rv$reporter_email <- input$reporter_email
    rv$reporter_function <- input$reporter_function
    
    # Participants - Invited
    rv$participants_invited <- input$participants_invited
    rv$participants_invited_program_mentors <- input$participants_invited_program_mentors
    rv$participants_invited_districts_mentors <- input$participants_invited_districts_mentors
    rv$participants_invited_doctors <- input$participants_invited_doctors
    rv$participants_invited_nurses <- input$participants_invited_nurses
    rv$participants_invited_meo <- input$participants_invited_meo
    rv$participants_invited_mem <- input$participants_invited_mem
    rv$participants_invited_lab <- input$participants_invited_lab
    rv$participants_invited_stockmgmt <- input$participants_invited_stockmgmt
    rv$participants_invited_dataclerk <- input$participants_invited_dataclerk
    rv$participants_invited_aps <- input$participants_invited_aps
    rv$participants_invited_facilities_staff <- input$participants_invited_facilities_staff
    rv$participants_invited_districts_staff <- input$participants_invited_districts_staff
    rv$participants_invited_other_org_staff <- input$participants_invited_other_org_staff
    rv$participants_invited_cbo <- input$participants_invited_cbo
    rv$participants_invited_chw <- input$participants_invited_chw
    rv$participants_invited_mothers_mentors <- input$participants_invited_mothers_mentors
    rv$participants_invited_expert_client <- input$participants_invited_expert_client
    rv$participants_invited_adolescent_champion <- input$participants_invited_adolescent_champion
    
    # Participants - Attended
    rv$participants_attended <- input$participants_attended
    rv$participants_attended_program_mentors <- input$participants_attended_program_mentors
    rv$participants_attended_districts_mentors <- input$participants_attended_districts_mentors
    rv$participants_attended_doctors <- input$participants_attended_doctors
    rv$participants_attended_nurses <- input$participants_attended_nurses
    rv$participants_attended_meo <- input$participants_attended_meo
    rv$participants_attended_mem <- input$participants_attended_mem
    rv$participants_attended_lab <- input$participants_attended_lab
    rv$participants_attended_stockmgmt <- input$participants_attended_stockmgmt
    rv$participants_attended_dataclerk <- input$participants_attended_dataclerk
    rv$participants_attended_aps <- input$participants_attended_aps
    rv$participants_attended_facilities_staff <- input$participants_attended_facilities_staff
    rv$participants_attended_districts_staff <- input$participants_attended_districts_staff
    rv$participants_attended_other_org_staff <- input$participants_attended_other_org_staff
    rv$participants_attended_cbo <- input$participants_attended_cbo
    rv$participants_attended_chw <- input$participants_attended_chw
    rv$participants_attended_mothers_mentors <- input$participants_attended_mothers_mentors
    rv$participants_attended_expert_client <- input$participants_attended_expert_client
    rv$participants_attended_adolescent_champion <- input$participants_attended_adolescent_champion
    
    # Participants Affiliations - Invited
    rv$participants_invited_moh_central <- input$participants_invited_moh_central
    rv$participants_invited_moh_regional <- input$participants_invited_moh_regional
    rv$participants_invited_moh_district <- input$participants_invited_moh_district
    rv$participants_invited_moh_facility <- input$participants_invited_moh_facility
    rv$participants_invited_shac_staff <- input$participants_invited_shac_staff
    rv$participants_invited_community_staff <- input$participants_invited_community_staff
    
    # Participants Affiliations - Attended
    rv$participants_attended_moh_central <- input$participants_attended_moh_central
    rv$participants_attended_moh_regional <- input$participants_attended_moh_regional
    rv$participants_attended_moh_district <- input$participants_attended_moh_district
    rv$participants_attended_moh_facility <- input$participants_attended_moh_facility
    rv$participants_attended_shac_staff <- input$participants_attended_shac_staff
    rv$participants_attended_community_staff <- input$participants_attended_community_staff
    
    # Facilitators - Invited
    rv$facilitators_invited <- input$facilitators_invited
    rv$facilitators_invited_moh_central <- input$facilitators_invited_moh_central
    rv$facilitators_invited_moh_regional <- input$facilitators_invited_moh_regional
    rv$facilitators_invited_moh_district <- input$facilitators_invited_moh_district
    rv$facilitators_invited_moh_facility <- input$facilitators_invited_moh_facility
    rv$facilitators_invited_shac <- input$facilitators_invited_shac
    rv$facilitators_invited_community_staff <- input$facilitators_invited_community_staff
    rv$facilitators_invited_other_organization <- input$facilitators_invited_other_organization
    
    # Facilitators - Attended
    rv$facilitators_attended <- input$facilitators_attended
    rv$facilitators_attended_moh_central <- input$facilitators_attended_moh_central
    rv$facilitators_attended_moh_regional <- input$facilitators_attended_moh_regional
    rv$facilitators_attended_moh_district <- input$facilitators_attended_moh_district
    rv$facilitators_attended_moh_facility <- input$facilitators_attended_moh_facility
    rv$facilitators_attended_shac <- input$facilitators_attended_shac
    rv$facilitators_attended_community_staff <- input$facilitators_attended_community_staff
    rv$facilitators_attended_other_organization <- input$facilitators_attended_other_organization
    
    # Costs
    rv$cost_material <- input$cost_material
    rv$cost_hall <- input$cost_hall
    rv$cost_food <- input$cost_food
    rv$cost_lodging <- input$cost_lodging
    rv$cost_travel <- input$cost_travel
    rv$cost_transport <- input$cost_transport
    rv$cost_facilitation <- input$cost_facilitation
    
    # Handle the files separately since they might be empty
    if (!is.null(input$files) && nrow(input$files) > 0) {
      rv$files <- paste(input$files$name, collapse = ", ")
    } else {
      rv$files <- NA_character_  # Use NA if no files
    }
    
    
    if(rv$name == "") {
      shinyalert("Missing Information", "Please provide the training name.", type = "warning")
      return()
    }
    
    if(is.null(input$files) || is.null(input$files$datapath)) {
      shinyalert("Missing File", "Please upload the required document.", type = "warning")
      return()
    }
    
    
    
    # Create data frame with all variables
    df_training <- data.frame(
      # Sidebar inputs
      name = rv$name,
      domain = rv$domain,
      subdomain = rv$subdomain,
      priority_area = rv$priority_area,
      location = rv$location,
      level = rv$level,
      type = rv$type,
      training_date = rv$training_date,
      reporter_name = rv$reporter_name,
      reporter_email = rv$reporter_email,
      reporter_function = rv$reporter_function,
      
      # Participants - Invited
      participants_invited = rv$participants_invited,
      participants_invited_program_mentors = rv$participants_invited_program_mentors,
      participants_invited_districts_mentors = rv$participants_invited_districts_mentors,
      participants_invited_doctors = rv$participants_invited_doctors,
      participants_invited_nurses = rv$participants_invited_nurses,
      participants_invited_meo = rv$participants_invited_meo,
      participants_invited_mem = rv$participants_invited_mem,
      participants_invited_lab = rv$participants_invited_lab,
      participants_invited_stockmgmt = rv$participants_invited_stockmgmt,
      participants_invited_dataclerk = rv$participants_invited_dataclerk,
      participants_invited_aps = rv$participants_invited_aps,
      participants_invited_facilities_staff = rv$participants_invited_facilities_staff,
      participants_invited_districts_staff = rv$participants_invited_districts_staff,
      participants_invited_other_org_staff = rv$participants_invited_other_org_staff,
      participants_invited_cbo = rv$participants_invited_cbo,
      participants_invited_chw = rv$participants_invited_chw,
      participants_invited_mothers_mentors = rv$participants_invited_mothers_mentors,
      participants_invited_expert_client = rv$participants_invited_expert_client,
      participants_invited_adolescent_champion = rv$participants_invited_adolescent_champion,
      
      # Participants - Attended
      participants_attended = rv$participants_attended,
      participants_attended_program_mentors = rv$participants_attended_program_mentors,
      participants_attended_districts_mentors = rv$participants_attended_districts_mentors,
      participants_attended_doctors = rv$participants_attended_doctors,
      participants_attended_nurses = rv$participants_attended_nurses,
      participants_attended_meo = rv$participants_attended_meo,
      participants_attended_mem = rv$participants_attended_mem,
      participants_attended_lab = rv$participants_attended_lab,
      participants_attended_stockmgmt = rv$participants_attended_stockmgmt,
      participants_attended_dataclerk = rv$participants_attended_dataclerk,
      participants_attended_aps = rv$participants_attended_aps,
      participants_attended_facilities_staff = rv$participants_attended_facilities_staff,
      participants_attended_districts_staff = rv$participants_attended_districts_staff,
      participants_attended_other_org_staff = rv$participants_attended_other_org_staff,
      participants_attended_cbo = rv$participants_attended_cbo,
      participants_attended_chw = rv$participants_attended_chw,
      participants_attended_mothers_mentors = rv$participants_attended_mothers_mentors,
      participants_attended_expert_client = rv$participants_attended_expert_client,
      participants_attended_adolescent_champion = rv$participants_attended_adolescent_champion,
      
      # Participants Affiliations - Invited
      participants_invited_moh_central = rv$participants_invited_moh_central,
      participants_invited_moh_regional = rv$participants_invited_moh_regional,
      participants_invited_moh_district = rv$participants_invited_moh_district,
      participants_invited_moh_facility = rv$participants_invited_moh_facility,
      participants_invited_shac_staff = rv$participants_invited_shac_staff,
      participants_invited_community_staff = rv$participants_invited_community_staff,
      
      # Participants Affiliations - Attended
      participants_attended_moh_central = rv$participants_attended_moh_central,
      participants_attended_moh_regional = rv$participants_attended_moh_regional,
      participants_attended_moh_district = rv$participants_attended_moh_district,
      participants_attended_moh_facility = rv$participants_attended_moh_facility,
      participants_attended_shac_staff = rv$participants_attended_shac_staff,
      participants_attended_community_staff = rv$participants_attended_community_staff,
      
      # Facilitators - Invited
      facilitators_invited =  rv$facilitators_invited, 
      facilitators_invited_moh_central = rv$facilitators_invited_moh_central, 
      facilitators_invited_moh_regional = rv$facilitators_invited_moh_regional,
      facilitators_invited_moh_district = rv$facilitators_invited_moh_district, 
      facilitators_invited_moh_facility = rv$facilitators_invited_moh_facility, 
      facilitators_invited_shac = rv$facilitators_invited_shac,
      facilitators_invited_community_staff = rv$facilitators_invited_community_staff, 
      facilitators_invited_other_organization = rv$facilitators_invited_other_organization, 
      
      # Facilitators - Attended
      facilitators_attended = rv$facilitators_attended,
      facilitators_attended_moh_central = rv$facilitators_attended_moh_central,
      facilitators_attended_moh_regional = rv$facilitators_attended_moh_regional, 
      facilitators_attended_moh_district = rv$facilitators_attended_moh_district, 
      facilitators_attended_moh_facility = rv$facilitators_attended_moh_facility,
      facilitators_attended_shac = rv$facilitators_attended_shac,
      facilitators_attended_community_staff = rv$facilitators_attended_community_staff, 
      facilitators_attended_other_organization = rv$facilitators_attended_other_organization,
      # Costs
      cost_material = rv$cost_material, 
      cost_hall = rv$cost_hall, 
      cost_food = rv$cost_food, 
      cost_lodging = rv$cost_lodging, 
      cost_travel = rv$cost_travel, 
      cost_transport = rv$cost_transport,
      cost_facilitation = rv$cost_facilitation,
      files = rv$files,
      stringsAsFactors = FALSE
    )
    
    
    saveData(df_training)
    
    
    if (!is.null(input$files) && nrow(input$files) > 0) {
      tryCatch({
        # Create a folder name with date and training name format
        training_date_formatted <- format(as.Date(rv$training_date), "%Y-%m-%d")
        folder_name <- paste0(training_date_formatted, "-", rv$name)
        
        # Check if this folder already exists in Google Drive
        existing_folder <- drive_find(pattern = folder_name, type = "folder")
        
        if (nrow(existing_folder) == 0) {
          # Create a new folder for this training session
          new_folder <- drive_mkdir(folder_name, path = folder_id) 
          subfolder_id <- new_folder$id
        } else {
          # Use the existing folder
          subfolder_id <- existing_folder$id[1]
        }
        
        # Upload each file to the training-specific folder
        mapply(function(datapath, name) {
          drive_upload(
            media = datapath,
            name = name,
            path = subfolder_id  # Use the training-specific folder
          )
        },
        input$files$datapath,
        input$files$name)
        
        # Delete the temporary files
        if (all(file.exists(input$files$datapath))) {
          file.remove(input$files$datapath)
        }
        
      }, error = function(e) {
        # Handle errors during Google Drive operations
        showNotification(
          paste("Error uploading files:", e$message), 
          type = "error", 
          duration = 10
        )
      })
    }
    
    
    shinyalert(
      title = "Success", 
      text = paste0("The form has been created successfully!"), 
      type = "success"
    )
    
    
    # Assuming these are the select inputs that need to be reinitialized
    updateTextInput(session, "name", value = "")
    updateTextInput(session, "reporter_name", value = "")
    updateTextInput(session, "reporter_email", value = "")
    updateTextInput(session, "reporter_function", value = "")
    
    # Update Select Inputs
    updateSelectInput(session, "domain", selected = unique(drop_down$Strategies)[1])
    updateSelectInput(session, "subdomain", selected = "")
    updateSelectInput(session, "priority_area", selected = "")
    updateSelectInput(session, "location", selected = "")
    updateSelectInput(session, "level", selected = "National level")
    updateSelectInput(session, "type", selected = "New training")
    
    # Update Date Input
    updateDateInput(session, "training_date", value = Sys.Date())
    
    # Update Numeric Inputs - Participants Invited
    updateNumericInput(session, "participants_invited", value = 0)
    updateNumericInput(session, "participants_invited_program_mentors", value = 0)
    updateNumericInput(session, "participants_invited_districts_mentors", value = 0)
    updateNumericInput(session, "participants_invited_doctors", value = 0)
    updateNumericInput(session, "participants_invited_nurses", value = 0)
    updateNumericInput(session, "participants_invited_meo", value = 0)
    updateNumericInput(session, "participants_invited_mem", value = 0)
    updateNumericInput(session, "participants_invited_lab", value = 0)
    updateNumericInput(session, "participants_invited_stockmgmt", value = 0)
    updateNumericInput(session, "participants_invited_dataclerk", value = 0)
    updateNumericInput(session, "participants_invited_aps", value = 0)
    updateNumericInput(session, "participants_invited_facilities_staff", value = 0)
    updateNumericInput(session, "participants_invited_districts_staff", value = 0)
    updateNumericInput(session, "participants_invited_other_org_staff", value = 0)
    updateNumericInput(session, "participants_invited_cbo", value = 0)
    updateNumericInput(session, "participants_invited_chw", value = 0)
    updateNumericInput(session, "participants_invited_mothers_mentors", value = 0)
    updateNumericInput(session, "participants_invited_expert_client", value = 0)
    updateNumericInput(session, "participants_invited_adolescent_champion", value = 0)
    
    # Update Numeric Inputs - Participants Attended
    updateNumericInput(session, "participants_attended", value = 0)
    updateNumericInput(session, "participants_attended_program_mentors", value = 0)
    updateNumericInput(session, "participants_attended_districts_mentors", value = 0)
    updateNumericInput(session, "participants_attended_doctors", value = 0)
    updateNumericInput(session, "participants_attended_nurses", value = 0)
    updateNumericInput(session, "participants_attended_meo", value = 0)
    updateNumericInput(session, "participants_attended_mem", value = 0)
    updateNumericInput(session, "participants_attended_lab", value = 0)
    updateNumericInput(session, "participants_attended_stockmgmt", value = 0)
    updateNumericInput(session, "participants_attended_dataclerk", value = 0)
    updateNumericInput(session, "participants_attended_aps", value = 0)
    updateNumericInput(session, "participants_attended_facilities_staff", value = 0)
    updateNumericInput(session, "participants_attended_districts_staff", value = 0)
    updateNumericInput(session, "participants_attended_other_org_staff", value = 0)
    updateNumericInput(session, "participants_attended_cbo", value = 0)
    updateNumericInput(session, "participants_attended_chw", value = 0)
    updateNumericInput(session, "participants_attended_mothers_mentors", value = 0)
    updateNumericInput(session, "participants_attended_expert_client", value = 0)
    updateNumericInput(session, "participants_attended_adolescent_champion", value = 0)
    
    # Update Numeric Inputs - Participants Affiliations Invited
    updateNumericInput(session, "participants_invited_moh_central", value = 0)
    updateNumericInput(session, "participants_invited_moh_regional", value = 0)
    updateNumericInput(session, "participants_invited_moh_district", value = 0)
    updateNumericInput(session, "participants_invited_moh_facility", value = 0)
    updateNumericInput(session, "participants_invited_shac_staff", value = 0)
    updateNumericInput(session, "participants_invited_community_staff", value = 0)
    
    # Update Numeric Inputs - Participants Affiliations Attended
    updateNumericInput(session, "participants_attended_moh_central", value = 0)
    updateNumericInput(session, "participants_attended_moh_regional", value = 0)
    updateNumericInput(session, "participants_attended_moh_district", value = 0)
    updateNumericInput(session, "participants_attended_moh_facility", value = 0)
    updateNumericInput(session, "participants_attended_shac_staff", value = 0)
    updateNumericInput(session, "participants_attended_community_staff", value = 0)
    
    # Update Numeric Inputs - Facilitators Invited
    updateNumericInput(session, "facilitators_invited", value = 0)
    updateNumericInput(session, "facilitators_invited_moh_central", value = 0)
    updateNumericInput(session, "facilitators_invited_moh_regional", value = 0)
    updateNumericInput(session, "facilitators_invited_moh_district", value = 0)
    updateNumericInput(session, "facilitators_invited_moh_facility", value = 0)
    updateNumericInput(session, "facilitators_invited_shac", value = 0)
    updateNumericInput(session, "facilitators_invited_community_staff", value = 0)
    updateNumericInput(session, "facilitators_invited_other_organization", value = 0)
    
    # Update Numeric Inputs - Facilitators Attended
    updateNumericInput(session, "facilitators_attended", value = 0)
    updateNumericInput(session, "facilitators_attended_moh_central", value = 0)
    updateNumericInput(session, "facilitators_attended_moh_regional", value = 0)
    updateNumericInput(session, "facilitators_attended_moh_district", value = 0)
    updateNumericInput(session, "facilitators_attended_moh_facility", value = 0)
    updateNumericInput(session, "facilitators_attended_shac", value = 0)
    updateNumericInput(session, "facilitators_attended_community_staff", value = 0)
    updateNumericInput(session, "facilitators_attended_other_organization", value = 0)
    
    # Update Numeric Inputs - Costs
    updateNumericInput(session, "cost_material", value = 0)
    updateNumericInput(session, "cost_hall", value = 0)
    updateNumericInput(session, "cost_food", value = 0)
    updateNumericInput(session, "cost_lodging", value = 0)
    updateNumericInput(session, "cost_travel", value = 0)
    updateNumericInput(session, "cost_transport", value = 0)
    updateNumericInput(session, "cost_facilitation", value = 0)
    
    reset('files')
    
    showNotification(
      "Form successfully submitted and reset.",
      type = "message",
      duration = 5
    )
    
  })
  
  
  # Edit reactive
  
  observeEvent(input$edit_domain, {
    updateSelectInput(session, "edit_subdomain",
                      choices = drop_down %>% 
                        filter(Strategies == input$edit_domain) %>% 
                        pull(`Program domain`) %>% 
                        unique()
    )
  })
  
  observeEvent(input$edit_subdomain, {
    updateSelectInput(session, "edit_priority_area",
                      choices = drop_down %>% 
                        filter(`Program domain` == input$edit_subdomain) %>% 
                        pull(`Priority area`) %>% 
                        unique()
    )
  })
  
  

## Edit a specific row --------------------------------

  # Define a reactive value to store the data
  data_table <- reactiveVal()
  
  # Load initial data when app starts
  observe({
    data_table(readData() %>%
                 select(name, domain, subdomain, priority_area,training_date,location, participants_invited,
                        participants_attended, facilitators_invited, facilitators_attended, starts_with("cost")) %>%
                 mutate(total_cost = rowSums(across(starts_with("cost")), na.rm = TRUE)) %>%
                 select(-starts_with("cost")) %>%
                 rename(
                   "Training Name" = name,
                   "Strategies" = domain,
                   "Program domain" = subdomain,
                   "Priority Area" = priority_area,
                   "Location" = location,
                   "Date"     = training_date,
                   "Participants Invited" = participants_invited,
                   "Participants Attended" = participants_attended,
                   "Facilitators Invited" = facilitators_invited,
                   "Facilitators Attended" = facilitators_attended,
                   "Total Cost (XAF)" = total_cost
                 ))
  })
  
  # Refresh when button is clicked
  observeEvent(input$refresh_table, {
    data_table(readData() %>%
                 select(name, domain, subdomain, priority_area, training_date,location, participants_invited,
                        participants_attended, facilitators_invited, facilitators_attended, starts_with("cost")) %>%
                 mutate(total_cost = rowSums(across(starts_with("cost")), na.rm = TRUE)) %>%
                 select(-starts_with("cost")) %>%
                 rename(
                   "Training Name" = name,
                   "Strategies" = domain,
                   "Program domain" = subdomain,
                   "Priority Area" = priority_area,
                   "Location" = location,
                   "Date"     = training_date,
                   "Participants Invited" = participants_invited,
                   "Participants Attended" = participants_attended,
                   "Facilitators Invited" = facilitators_invited,
                   "Facilitators Attended" = facilitators_attended,
                   "Total Cost (XAF)" = total_cost
                 ))
  })
  
  # Render the table
  output$table <- DT::renderDataTable({
    req(data_table())
    DT::datatable(data_table() %>% 
                    arrange(desc(Date)), 
                  selection = 'single', options = list(pageLength = 10),
                  rownames = FALSE
                  )
  })
  
  
  
  
  
  
  observeEvent(input$table_rows_selected,{
    
       req(input$table_rows_selected)
    
    # Get the selected row index
      row_index <- input$table_rows_selected
    # Get all the data
      all_data <- readData()
      
    # Get the corresponding row from the full dataset
      
      selected_row <- all_data[row_index, ]
    
      
      # Create a modal dialog with form inputs pre-filled with the selected row's data
      showModal(
        modalDialog(
          title = "Edit Training Record",
          
          tabsetPanel(
            # Basic Info Tab
            tabPanel("Basic Info",
                  fluidRow(
                     textInput("edit_name", "Training Name", value = selected_row$name),
                     selectInput("edit_domain", "Strategies",choices = unique(drop_down$Strategies) ,selected = selected_row$domain),
                     selectInput("edit_subdomain", "Program Domain",choices = unique(drop_down$`Program domain`), selected = selected_row$subdomain),
                     selectInput("edit_priority_area", "Priority Area", choices = unique(drop_down$`Priority area`) , selected = selected_row$priority_area),
                     textInput("edit_location", "Location", value = selected_row$location),
                     selectInput("edit_level", "Level", 
                                 choices = c("National level","Zonal","Regional level","District level","Site Level"),
                                 selected = selected_row$level),
                     selectInput("edit_type", "Type", 
                                 choices = c("New training","Refresher Training"),
                                 selected = selected_row$type),
                     dateInput("edit_training_date", "Training Date", value = selected_row$training_date),
                     textInput("edit_reporter_name", "Reporter Name", value = selected_row$reporter_name),
                     textInput("edit_reporter_email", "Reporter Email", value = selected_row$reporter_email),
                     textInput("edit_reporter_function", "Reporter Function", value = selected_row$reporter_function)
            )
        ),
            
            # Participants - Invited Tab
            tabPanel("Participants - Invited",
                     numericInput("edit_participants_invited", "Total Participants Invited", value = selected_row$participants_invited),
                   fluidRow(  
                     h4("By Role"),
                     numericInput("edit_participants_invited_program_mentors", "Program Mentors", value = selected_row$participants_invited_program_mentors),
                     numericInput("edit_participants_invited_districts_mentors", "District Mentors", value = selected_row$participants_invited_districts_mentors),
                     numericInput("edit_participants_invited_doctors", "Doctors", value = selected_row$participants_invited_doctors),
                     numericInput("edit_participants_invited_nurses", "Nurses", value = selected_row$participants_invited_nurses),
                     numericInput("edit_participants_invited_meo", "M&E Officers", value = selected_row$participants_invited_meo),
                     numericInput("edit_participants_invited_mem", "M&E Managers", value = selected_row$participants_invited_mem),
                     numericInput("edit_participants_invited_lab", "Lab Staff", value = selected_row$participants_invited_lab),
                     numericInput("edit_participants_invited_stockmgmt", "Stock Management", value = selected_row$participants_invited_stockmgmt),
                     numericInput("edit_participants_invited_dataclerk", "Data Clerks", value = selected_row$participants_invited_dataclerk),
                     numericInput("edit_participants_invited_aps", "APS", value = selected_row$participants_invited_aps),
                     numericInput("edit_participants_invited_facilities_staff", "Facility Staff", value = selected_row$participants_invited_facilities_staff),
                     numericInput("edit_participants_invited_districts_staff", "District Staff", value = selected_row$participants_invited_districts_staff),
                     numericInput("edit_participants_invited_other_org_staff", "Other Org Staff", value = selected_row$participants_invited_other_org_staff),
                     numericInput("edit_participants_invited_cbo", "CBO", value = selected_row$participants_invited_cbo),
                     numericInput("edit_participants_invited_chw", "CHW", value = selected_row$participants_invited_chw),
                     numericInput("edit_participants_invited_mothers_mentors", "Mother Mentors", value = selected_row$participants_invited_mothers_mentors),
                     numericInput("edit_participants_invited_expert_client", "Expert Clients", value = selected_row$participants_invited_expert_client),
                     numericInput("edit_participants_invited_adolescent_champion", "Adolescent Champions", value = selected_row$participants_invited_adolescent_champion),
            ),
            fluidRow(
                     h4("By Affiliation"),
                     numericInput("edit_participants_invited_moh_central", "MOH Central", value = selected_row$participants_invited_moh_central),
                     numericInput("edit_participants_invited_moh_regional", "MOH Regional", value = selected_row$participants_invited_moh_regional),
                     numericInput("edit_participants_invited_moh_district", "MOH District", value = selected_row$participants_invited_moh_district),
                     numericInput("edit_participants_invited_moh_facility", "MOH Facility", value = selected_row$participants_invited_moh_facility),
                     numericInput("edit_participants_invited_shac_staff", "SHAC Staff", value = selected_row$participants_invited_shac_staff),
                     numericInput("edit_participants_invited_community_staff", "Community Staff", value = selected_row$participants_invited_community_staff)
            )
            ),
            
            # Participants - Attended Tab
            tabPanel("Participants - Attended",
                     
                     numericInput("edit_participants_attended", "Total Participants Attended", value = selected_row$participants_attended),
                 fluidRow(    
                     h4("By Role"),
                     numericInput("edit_participants_attended_program_mentors", "Program Mentors", value = selected_row$participants_attended_program_mentors),
                     numericInput("edit_participants_attended_districts_mentors", "District Mentors", value = selected_row$participants_attended_districts_mentors),
                     numericInput("edit_participants_attended_doctors", "Doctors", value = selected_row$participants_attended_doctors),
                     numericInput("edit_participants_attended_nurses", "Nurses", value = selected_row$participants_attended_nurses),
                     numericInput("edit_participants_attended_meo", "M&E Officers", value = selected_row$participants_attended_meo),
                     numericInput("edit_participants_attended_mem", "M&E Managers", value = selected_row$participants_attended_mem),
                     numericInput("edit_participants_attended_lab", "Lab Staff", value = selected_row$participants_attended_lab),
                     numericInput("edit_participants_attended_stockmgmt", "Stock Management", value = selected_row$participants_attended_stockmgmt),
                     numericInput("edit_participants_attended_dataclerk", "Data Clerks", value = selected_row$participants_attended_dataclerk),
                     numericInput("edit_participants_attended_aps", "APS", value = selected_row$participants_attended_aps),
                     numericInput("edit_participants_attended_facilities_staff", "Facility Staff", value = selected_row$participants_attended_facilities_staff),
                     numericInput("edit_participants_attended_districts_staff", "District Staff", value = selected_row$participants_attended_districts_staff),
                     numericInput("edit_participants_attended_other_org_staff", "Other Org Staff", value = selected_row$participants_attended_other_org_staff),
                     numericInput("edit_participants_attended_cbo", "CBO", value = selected_row$participants_attended_cbo),
                     numericInput("edit_participants_attended_chw", "CHW", value = selected_row$participants_attended_chw),
                     numericInput("edit_participants_attended_mothers_mentors", "Mother Mentors", value = selected_row$participants_attended_mothers_mentors),
                     numericInput("edit_participants_attended_expert_client", "Expert Clients", value = selected_row$participants_attended_expert_client),
                     numericInput("edit_participants_attended_adolescent_champion", "Adolescent Champions", value = selected_row$participants_attended_adolescent_champion),
                     
                     h4("By Organization"),
                     numericInput("edit_participants_attended_moh_central", "MOH Central", value = selected_row$participants_attended_moh_central),
                     numericInput("edit_participants_attended_moh_regional", "MOH Regional", value = selected_row$participants_attended_moh_regional),
                     numericInput("edit_participants_attended_moh_district", "MOH District", value = selected_row$participants_attended_moh_district),
                     numericInput("edit_participants_attended_moh_facility", "MOH Facility", value = selected_row$participants_attended_moh_facility),
                     numericInput("edit_participants_attended_shac_staff", "SHAC Staff", value = selected_row$participants_attended_shac_staff),
                     numericInput("edit_participants_attended_community_staff", "Community Staff", value = selected_row$participants_attended_community_staff)
            )),
            
            # Facilitators - Invited Tab
            tabPanel("Facilitators - Invited",
                     numericInput("edit_facilitators_invited", "Total Facilitators Invited", value = selected_row$facilitators_invited),
                    fluidRow( 
                     h4("By Organization"),
                     numericInput("edit_facilitators_invited_moh_central", "MOH Central", value = selected_row$facilitators_invited_moh_central),
                     numericInput("edit_facilitators_invited_moh_regional", "MOH Regional", value = selected_row$facilitators_invited_moh_regional),
                     numericInput("edit_facilitators_invited_moh_district", "MOH District", value = selected_row$facilitators_invited_moh_district),
                     numericInput("edit_facilitators_invited_moh_facility", "MOH Facility", value = selected_row$facilitators_invited_moh_facility),
                     numericInput("edit_facilitators_invited_shac", "SHAC", value = selected_row$facilitators_invited_shac),
                     numericInput("edit_facilitators_invited_community_staff", "Community Staff", value = selected_row$facilitators_invited_community_staff),
                     numericInput("edit_facilitators_invited_other_organization", "Other Organizations", value = selected_row$facilitators_invited_other_organization)
            )),
            
            # Facilitators - Attended Tab
            tabPanel("Facilitators - Attended",
                     numericInput("edit_facilitators_attended", "Total Facilitators Attended", value = selected_row$facilitators_attended),
                     
                     h4("By Organization"),
                    fluidRow(
                     numericInput("edit_facilitators_attended_moh_central", "MOH Central", value = selected_row$facilitators_attended_moh_central),
                     numericInput("edit_facilitators_attended_moh_regional", "MOH Regional", value = selected_row$facilitators_attended_moh_regional),
                     numericInput("edit_facilitators_attended_moh_district", "MOH District", value = selected_row$facilitators_attended_moh_district),
                     numericInput("edit_facilitators_attended_moh_facility", "MOH Facility", value = selected_row$facilitators_attended_moh_facility),
                     numericInput("edit_facilitators_attended_shac", "SHAC", value = selected_row$facilitators_attended_shac),
                     numericInput("edit_facilitators_attended_community_staff", "Community Staff", value = selected_row$facilitators_attended_community_staff),
                     numericInput("edit_facilitators_attended_other_organization", "Other Organizations", value = selected_row$facilitators_attended_other_organization)
            )),
            
            # Costs Tab
            tabPanel("Costs",
                    fluidRow(
                     numericInput("edit_cost_material", "Materials Cost", value = selected_row$cost_material),
                     numericInput("edit_cost_hall", "Hall Rental Cost", value = selected_row$cost_hall),
                     numericInput("edit_cost_food","Food & Water",value = selected_row$cost_food),
                     numericInput("edit_cost_lodging", "Lodging",value = selected_row$cost_lodging),
                     numericInput("edit_cost_travel", "Travel & Per diem",value = selected_row$cost_travel),
                     numericInput("edit_cost_transport", "Transport Reimbursement",value = selected_row$cost_transport),
                     numericInput("edit_cost_facilitation", "Facilitation Fees",value = selected_row$cost_facilitation),
                     
            )),
         tabPanel("Upload documents",
                  fileInput("edit_files", "Select training documents",
                            multiple = TRUE,
                            accept = c(".pdf", ".docx", ".xlsx", ".csv", ".jpg", ".png", ".pptx"),
                            buttonLabel = "Browse...",
                            placeholder = "No files selected")
                  )
          ),
          footer = tagList(
            add_busy_spinner(spin = "fading-circle"),
            actionButton("save_changes", "Save Changes", class = "btn-primary"),
            modalButton("Cancel")
          ),
          size = "l",
          easyClose = TRUE
          
        )
        
    )
    
    
  })
  
# Handle saving the edited record
  
 observeEvent(input$save_changes, {
    # Get the selected row index
    row_index <- input$table_rows_selected
    
    # Get all data
    all_data <- readData()
    
   
    # Update basic info
    all_data[row_index, "name"] <- input$edit_name
    all_data[row_index, "domain"] <- input$edit_domain
    all_data[row_index, "subdomain"] <- input$edit_subdomain
    all_data[row_index, "priority_area"] <- input$edit_priority_area
    all_data[row_index, "location"] <- input$edit_location
    all_data[row_index, "level"] <- input$edit_level
    all_data[row_index, "type"] <- input$edit_type
    all_data[row_index, "training_date"] <- input$edit_training_date
    
    # Update reporter info
    all_data[row_index, "reporter_name"] <- input$edit_reporter_name
    all_data[row_index, "reporter_email"] <- input$edit_reporter_email
    all_data[row_index, "reporter_function"] <- input$edit_reporter_function
    
    # Update participants invited
    all_data[row_index, "participants_invited"] <- input$edit_participants_invited
    all_data[row_index, "participants_invited_program_mentors"] <- input$edit_participants_invited_program_mentors
    all_data[row_index, "participants_invited_districts_mentors"] <- input$edit_participants_invited_districts_mentors
    all_data[row_index, "participants_invited_doctors"] <- input$edit_participants_invited_doctors
    all_data[row_index, "participants_invited_nurses"] <- input$edit_participants_invited_nurses
    all_data[row_index, "participants_invited_meo"] <- input$edit_participants_invited_meo
    all_data[row_index, "participants_invited_mem"] <- input$edit_participants_invited_mem
    all_data[row_index, "participants_invited_lab"] <- input$edit_participants_invited_lab
    all_data[row_index, "participants_invited_stockmgmt"] <- input$edit_participants_invited_stockmgmt
    all_data[row_index, "participants_invited_dataclerk"] <- input$edit_participants_invited_dataclerk
    all_data[row_index, "participants_invited_aps"] <- input$edit_participants_invited_aps
    all_data[row_index, "participants_invited_facilities_staff"] <- input$edit_participants_invited_facilities_staff
    all_data[row_index, "participants_invited_districts_staff"] <- input$edit_participants_invited_districts_staff
    all_data[row_index, "participants_invited_other_org_staff"] <- input$edit_participants_invited_other_org_staff
    all_data[row_index, "participants_invited_cbo"] <- input$edit_participants_invited_cbo
    all_data[row_index, "participants_invited_chw"] <- input$edit_participants_invited_chw
    all_data[row_index, "participants_invited_mothers_mentors"] <- input$edit_participants_invited_mothers_mentors
    all_data[row_index, "participants_invited_expert_client"] <- input$edit_participants_invited_expert_client
    all_data[row_index, "participants_invited_adolescent_champion"] <- input$edit_participants_invited_adolescent_champion
    all_data[row_index, "participants_invited_moh_central"] <- input$edit_participants_invited_moh_central
    all_data[row_index, "participants_invited_moh_regional"] <- input$edit_participants_invited_moh_regional
    all_data[row_index, "participants_invited_moh_district"] <- input$edit_participants_invited_moh_district
    all_data[row_index, "participants_invited_moh_facility"] <- input$edit_participants_invited_moh_facility
    all_data[row_index, "participants_invited_shac_staff"] <- input$edit_participants_invited_shac_staff
    all_data[row_index, "participants_invited_community_staff"] <- input$edit_participants_invited_community_staff
    
    # Update participants attended
    all_data[row_index, "participants_attended"] <- input$edit_participants_attended
    all_data[row_index, "participants_attended_program_mentors"] <- input$edit_participants_attended_program_mentors
    all_data[row_index, "participants_attended_districts_mentors"] <- input$edit_participants_attended_districts_mentors
    all_data[row_index, "participants_attended_doctors"] <- input$edit_participants_attended_doctors
    all_data[row_index, "participants_attended_nurses"] <- input$edit_participants_attended_nurses
    all_data[row_index, "participants_attended_meo"] <- input$edit_participants_attended_meo
    all_data[row_index, "participants_attended_mem"] <- input$edit_participants_attended_mem
    all_data[row_index, "participants_attended_lab"] <- input$edit_participants_attended_lab
    all_data[row_index, "participants_attended_stockmgmt"] <- input$edit_participants_attended_stockmgmt
    all_data[row_index, "participants_attended_dataclerk"] <- input$edit_participants_attended_dataclerk
    all_data[row_index, "participants_attended_aps"] <- input$edit_participants_attended_aps
    all_data[row_index, "participants_attended_facilities_staff"] <- input$edit_participants_attended_facilities_staff
    all_data[row_index, "participants_attended_districts_staff"] <- input$edit_participants_attended_districts_staff
    all_data[row_index, "participants_attended_other_org_staff"] <- input$edit_participants_attended_other_org_staff
    all_data[row_index, "participants_attended_cbo"] <- input$edit_participants_attended_cbo
    all_data[row_index, "participants_attended_chw"] <- input$edit_participants_attended_chw
    all_data[row_index, "participants_attended_mothers_mentors"] <- input$edit_participants_attended_mothers_mentors
    all_data[row_index, "participants_attended_expert_client"] <- input$edit_participants_attended_expert_client
    all_data[row_index, "participants_attended_adolescent_champion"] <- input$edit_participants_attended_adolescent_champion
    all_data[row_index, "participants_attended_moh_central"] <- input$edit_participants_attended_moh_central
    all_data[row_index, "participants_attended_moh_regional"] <- input$edit_participants_attended_moh_regional
    all_data[row_index, "participants_attended_moh_district"] <- input$edit_participants_attended_moh_district
    all_data[row_index, "participants_attended_moh_facility"] <- input$edit_participants_attended_moh_facility
    all_data[row_index, "participants_attended_shac_staff"] <- input$edit_participants_attended_shac_staff
    all_data[row_index, "participants_attended_community_staff"] <- input$edit_participants_attended_community_staff
    
    # Update facilitators invited
    all_data[row_index, "facilitators_invited"] <- input$edit_facilitators_invited
    all_data[row_index, "facilitators_invited_moh_central"] <- input$edit_facilitators_invited_moh_central
    all_data[row_index, "facilitators_invited_moh_regional"] <- input$edit_facilitators_invited_moh_regional
    all_data[row_index, "facilitators_invited_moh_district"] <- input$edit_facilitators_invited_moh_district
    all_data[row_index, "facilitators_invited_moh_facility"] <- input$edit_facilitators_invited_moh_facility
    all_data[row_index, "facilitators_invited_shac"] <- input$edit_facilitators_invited_shac
    all_data[row_index, "facilitators_invited_community_staff"] <- input$edit_facilitators_invited_community_staff
    all_data[row_index, "facilitators_invited_other_organization"] <- input$edit_facilitators_invited_other_organization
    
    # Update facilitators attended
    all_data[row_index, "facilitators_attended"] <- input$edit_facilitators_attended
    all_data[row_index, "facilitators_attended_moh_central"] <- input$edit_facilitators_attended_moh_central
    all_data[row_index, "facilitators_attended_moh_regional"] <- input$edit_facilitators_attended_moh_regional
    all_data[row_index, "facilitators_attended_moh_district"] <- input$edit_facilitators_attended_moh_district
    all_data[row_index, "facilitators_attended_moh_facility"] <- input$edit_facilitators_attended_moh_facility
    all_data[row_index, "facilitators_attended_shac"] <- input$edit_facilitators_attended_shac
    all_data[row_index, "facilitators_attended_community_staff"] <- input$edit_facilitators_attended_community_staff
    all_data[row_index, "facilitators_attended_other_organization"] <- input$edit_facilitators_attended_other_organization
    
    # Update cost columns
    all_data[row_index, "cost_material"] <- as.numeric(input$edit_cost_material %||% 0)
    all_data[row_index, "cost_hall"] <- as.numeric(input$edit_cost_hall %||% 0)
    all_data[row_index, "cost_food"] <- as.numeric(input$edit_cost_food %||% 0)
    all_data[row_index, "cost_lodging"] <- as.numeric(input$edit_cost_lodging %||% 0)
    all_data[row_index, "cost_travel"] <- as.numeric(input$edit_cost_travel %||% 0)
    all_data[row_index, "cost_transport"] <- as.numeric(input$edit_cost_transport %||% 0)
    all_data[row_index, "cost_facilitation"] <- as.numeric(input$edit_cost_facilitation %||% 0)
    
    # Save the updated data
    
    
    editData(data = all_data)
    
    if (!is.null(input$edit_files) && nrow(input$edit_files) > 0) {
      tryCatch({
        # Create a folder name with date and training name format
        training_date_formatted <- format(as.Date(rv$training_date), "%Y-%m-%d")
        folder_name <- paste0(training_date_formatted, "-", input$edit_name)
        
        # Check if this folder already exists in Google Drive
        existing_folder <- drive_find(pattern = folder_name, type = "folder")
        
        if (nrow(existing_folder) == 0) {
          # Create a new folder for this training session
          new_folder <- drive_mkdir(folder_name, path = folder_id) 
          subfolder_id <- new_folder$id
        } else {
          # Use the existing folder
          subfolder_id <- existing_folder$id[1]
        }
        
        # Upload each file to the training-specific folder
        mapply(function(datapath, name) {
          drive_upload(
            media = datapath,
            name = name,
            path = subfolder_id  # Use the training-specific folder
          )
        },
        input$edit_files$datapath,
        input$edit_files$name)
        
        # Delete the temporary files
        if (all(file.exists(input$edit_files$datapath))) {
          file.remove(input$edit_files$datapath)
        }
        
      }, error = function(e) {
        # Handle errors during Google Drive operations
        showNotification(
          paste("Error uploading files:", e$message), 
          type = "error", 
          duration = 10
        )
      })
    }
    
    
    # Close the modal
    removeModal()
    
    # Display a success message
    
    shinyalert(
      title = "Success", 
      text = paste0("Record updated successfully"), 
      type = "success"
    )
    
    
})
 
 
 
  
  
  
  
  
  
}
