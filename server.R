
# server ------------------------------------------------------------------

server <- function(input,output,session){
  
  observeEvent(input$domain, {
    updateSelectInput(session, "subdomain",
                      choices = subdomain_choices[[input$domain]])
  })
  
  # Initialize form values
  
  rv <- reactiveValues(
    name = NULL,
    domain = NULL,
    subdomain = NULL,
    location = NULL,
    level = NULL,
    type = NULL,
    training_date = NULL,
    reporter_name = NULL,
    reporter_email = NULL,
    reporter_function = NULL,
    participants_invited = NULL,
    participants_invited_aps = NULL,
    participants_invited_experts = NULL,
    participants_invited_doctors = NULL,
    participants_invited_nurses = NULL,
    participants_invited_acrr = NULL,
    participants_invited_lab = NULL,
    participants_attended = NULL,
    participants_attended_aps = NULL,
    participants_attended_experts = NULL,
    participants_attended_doctors = NULL,
    participants_attended_nurses = NULL,
    participants_attended_acrr = NULL,
    participants_attended_lab = NULL,
    participants_invited_moh = NULL,
    participants_invited_asdf = NULL,
    participants_invited_egpaf = NULL,
    participants_invited_non_pepfar = NULL,
    participants_attended_moh = NULL,
    participants_attended_asdf = NULL,
    participants_attended_egpaf = NULL,
    participants_attended_non_pepfar = NULL,
    facilitators_invited = NULL,
    facilitators_invited_moh = NULL,
    facilitators_invited_asdf = NULL,
    facilitators_invited_egpaf = NULL,
    facilitators_invited_non_pepfar = NULL,
    facilitators_attended = NULL,
    facilitators_attended_moh = NULL,
    facilitators_attended_asdf = NULL,
    facilitators_attended_egpaf = NULL,
    facilitators_attended_non_pepfar = NULL,
    cost_material = NULL,
    cost_hall = NULL,
    cost_food = NULL,
    cost_lodging = NULL,
    cost_travel = NULL,
    cost_transport = NULL,
    cost_facilitation = NULL,
    files = NULL
  )
  
 
  
observeEvent(input$submit, {
  
    Sys.sleep(3)  
    
    rv$name <- input$name
    rv$domain <- input$domain
    rv$subdomain <- input$subdomain
    rv$location <- input$location
    rv$level <- input$level
    rv$type <- input$type
    rv$training_date <- input$training_date
    rv$reporter_name <- input$reporter_name
    rv$reporter_email <- input$reporter_email
    rv$reporter_function <- input$reporter_function
    rv$participants_invited <- input$participants_invited
    rv$participants_invited_aps <- input$participants_invited_aps
    rv$participants_invited_experts <- input$participants_invited_experts
    rv$participants_invited_doctors <- input$participants_invited_doctors
    rv$participants_invited_nurses <- input$participants_invited_nurses
    rv$participants_invited_acrr <- input$participants_invited_acrr
    rv$participants_invited_lab <- input$participants_invited_lab
    rv$participants_attended <- input$participants_attended
    rv$participants_attended_aps <- input$participants_attended_aps
    rv$participants_attended_experts <- input$participants_attended_experts
    rv$participants_attended_doctors <- input$participants_attended_doctors
    rv$participants_attended_nurses <- input$participants_attended_nurses
    rv$participants_attended_acrr <- input$participants_attended_acrr
    rv$participants_attended_lab <- input$participants_attended_lab
    rv$participants_invited_moh <- input$participants_invited_moh
    rv$participants_invited_asdf <- input$participants_invited_asdf
    rv$participants_invited_egpaf <- input$participants_invited_egpaf
    rv$participants_invited_non_pepfar <- input$participants_invited_non_pepfar
    rv$participants_attended_moh <- input$participants_attended_moh
    rv$participants_attended_asdf <- input$participants_attended_asdf
    rv$participants_attended_egpaf <- input$participants_attended_egpaf
    rv$participants_attended_non_pepfar <- input$participants_attended_non_pepfar
    rv$facilitators_invited <- input$facilitators_invited
    rv$facilitators_invited_moh <- input$facilitators_invited_moh
    rv$facilitators_invited_asdf <- input$facilitators_invited_asdf
    rv$facilitators_invited_egpaf <- input$facilitators_invited_egpaf
    rv$facilitators_invited_non_pepfar <- input$facilitators_invited_non_pepfar
    rv$facilitators_attended <- input$facilitators_attended
    rv$facilitators_attended_moh <- input$facilitators_attended_moh
    rv$facilitators_attended_asdf <- input$facilitators_attended_asdf
    rv$facilitators_attended_egpaf <- input$facilitators_attended_egpaf
    rv$facilitators_attended_non_pepfar <- input$facilitators_attended_non_pepfar
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
    
    df_training <- data.frame(
      name = rv$name,
      domain = rv$domain,
      subdomain = rv$subdomain,
      location = rv$location,
      level = rv$level,
      type = rv$type,
      training_date = rv$training_date,
      reporter_name = rv$reporter_name,
      reporter_email = rv$reporter_email,
      reporter_function = rv$reporter_function,
      participants_invited = rv$participants_invited,
      participants_invited_aps = rv$participants_invited_aps,
      participants_invited_experts = rv$participants_invited_experts,
      participants_invited_doctors = rv$participants_invited_doctors,
      participants_invited_nurses = rv$participants_invited_nurses,
      participants_invited_acrr = rv$participants_invited_acrr,
      participants_invited_lab = rv$participants_invited_lab,
      participants_attended = rv$participants_attended,
      participants_attended_aps = rv$participants_attended_aps,
      participants_attended_experts = rv$participants_attended_experts,
      participants_attended_doctors = rv$participants_attended_doctors,
      participants_attended_nurses = rv$participants_attended_nurses,
      participants_attended_acrr = rv$participants_attended_acrr,
      participants_attended_lab = rv$participants_attended_lab,
      participants_invited_moh = rv$participants_invited_moh,
      participants_invited_asdf = rv$participants_invited_asdf,
      participants_invited_egpaf = rv$participants_invited_egpaf,
      participants_invited_non_pepfar = rv$participants_invited_non_pepfar,
      participants_attended_moh = rv$participants_attended_moh,
      participants_attended_asdf = rv$participants_attended_asdf,
      participants_attended_egpaf = rv$participants_attended_egpaf,
      participants_attended_non_pepfar = rv$participants_attended_non_pepfar,
      facilitators_invited = rv$facilitators_invited,
      facilitators_invited_moh = rv$facilitators_invited_moh,
      facilitators_invited_asdf = rv$facilitators_invited_asdf,
      facilitators_invited_egpaf = rv$facilitators_invited_egpaf,
      facilitators_invited_non_pepfar = rv$facilitators_invited_non_pepfar,
      facilitators_attended = rv$facilitators_attended,
      facilitators_attended_moh = rv$facilitators_attended_moh,
      facilitators_attended_asdf = rv$facilitators_attended_asdf,
      facilitators_attended_egpaf = rv$facilitators_attended_egpaf,
      facilitators_attended_non_pepfar = rv$facilitators_attended_non_pepfar,
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
    
    # Update all the fields
    
    updateTextInput(session, "name", value = "")
    updateSelectInput(session, "domain", selected = "")
    updateSelectInput(session, "subdomain", selected = "")
    updateTextInput(session, "location", value = "")
    updateSelectInput(session, "level", selected = "")
    updateSelectInput(session, "type", selected = "")
    updateDateInput(session, "training_date", value = "")
    updateTextInput(session, "reporter_name", value = "")
    updateTextInput(session, "reporter_email", value = "")
    updateTextInput(session, "reporter_function", value = "")
    
    updateNumericInput(session, "participants_invited", value = 0)
    updateNumericInput(session, "participants_invited_aps", value = 0)
    updateNumericInput(session, "participants_invited_experts", value = 0)
    updateNumericInput(session, "participants_invited_doctors", value = 0)
    updateNumericInput(session, "participants_invited_nurses", value = 0)
    updateNumericInput(session, "participants_invited_acrr", value = 0)
    updateNumericInput(session, "participants_invited_lab", value = 0)
    
    updateNumericInput(session, "participants_attended", value = 0)
    updateNumericInput(session, "participants_attended_aps", value = 0)
    updateNumericInput(session, "participants_attended_experts", value = 0)
    updateNumericInput(session, "participants_attended_doctors", value = 0)
    updateNumericInput(session, "participants_attended_nurses", value = 0)
    updateNumericInput(session, "participants_attended_acrr", value = 0)
    updateNumericInput(session, "participants_attended_lab", value = 0)
    
    updateNumericInput(session, "participants_invited_moh", value = 0)
    updateNumericInput(session, "participants_invited_asdf", value = 0)
    updateNumericInput(session, "participants_invited_egpaf", value = 0)
    updateNumericInput(session, "participants_invited_non_pepfar", value = 0)
    updateNumericInput(session, "participants_attended_moh", value = 0)
    updateNumericInput(session, "participants_attended_asdf", value = 0)
    updateNumericInput(session, "participants_attended_egpaf", value = 0)
    updateNumericInput(session, "participants_attended_non_pepfar", value = 0)
    
    updateNumericInput(session, "facilitators_invited", value = 0)
    updateNumericInput(session, "facilitators_invited_moh", value = 0)
    updateNumericInput(session, "facilitators_invited_asdf", value = 0)
    updateNumericInput(session, "facilitators_invited_egpaf", value = 0)
    updateNumericInput(session, "facilitators_invited_non_pepfar", value = 0)
    updateNumericInput(session, "facilitators_attended", value = 0)
    updateNumericInput(session, "facilitators_attended_moh", value = 0)
    updateNumericInput(session, "facilitators_attended_asdf", value = 0)
    updateNumericInput(session, "facilitators_attended_egpaf", value = 0)
    updateNumericInput(session, "facilitators_attended_non_pepfar", value = 0)
    
    updateNumericInput(session, "cost_material", value = 0)
    updateNumericInput(session, "cost_hall", value = 0)
    updateNumericInput(session, "cost_food", value = 0)
    updateNumericInput(session, "cost_lodging", value = 0)
    updateNumericInput(session, "cost_travel", value = 0)
    updateNumericInput(session, "cost_transport", value = 0)
    updateNumericInput(session, "cost_facilitation", value = 0)
    
    runjs("document.getElementById('files').value = '';")
    
    
    
  })
  
 

  
}
