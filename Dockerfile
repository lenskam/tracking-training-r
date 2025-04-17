# Base R Shiny image
FROM rocker/shiny

# Make a directory in the container for your app
RUN mkdir /home/Training_tracker

# Install system dependencies required for R packages
RUN apt-get update && apt-get install -y \
    libcurl4-openssl-dev \
    libssl-dev \
    libxml2-dev \
    git \
    && rm -rf /var/lib/apt/lists/*

# Install R package manager and all required dependencies
RUN R -e "install.packages('pacman', repos='http://cran.rstudio.com/')" \
    && R -e "pacman::p_load(shinyjs, googlesheets4, waiter, googledrive, bslib,shinybusy, shinyalert)"

# Copy your application files to the container
COPY . /home/Training_tracker/

# Create the secrets directory in the container
RUN mkdir -p /app/.secrets

# Copy the secrets file - adjust the filename if needed
COPY ./.secrets/7a6077d23f6776ccc63f8f70bc12b214_aureollerocher@gmail.com /app/.secrets/
COPY ./.secrets/c13dc354db9600c8cd9b2bd868d1bf25_aureollerocher@gmail.com /app/.secrets/



# Set appropriate permissions for the secrets file
RUN chmod 600 /app/.secrets/7a6077d23f6776ccc63f8f70bc12b214_aureollerocher@gmail.com
RUN chmod 600 /app/.secrets/c13dc354db9600c8cd9b2bd868d1bf25_aureollerocher@gmail.com



# Set proper permissions
RUN chmod -R 755 /home/Training_tracker

# Expose the port Shiny will run on
EXPOSE 3838

# Run the R Shiny app
CMD ["R", "-e", "shiny::runApp('/home/Training_tracker', host='0.0.0.0', port=3838)"]