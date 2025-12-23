# ============================================================================
#                     Project Directory Setup Script
# ============================================================================


# === OUTPUT FOLDER ===

DATA_PROCESSED <- here("data", "processed")
if (!dir.exists(DATA_PROCESSED)) {
  response <- readline(prompt = paste0("Processed data directory not found at: ", DATA_PROCESSED, "\nCreate it? (y/n): "))
  if (tolower(response) == "y") {
    dir.create(DATA_PROCESSED, recursive = TRUE)
    message("Created processed data directory: ", DATA_PROCESSED)
  } else {
    stop("Processed data directory does not exist. Please create it manually or choose 'y' to create automatically.")
  }
}

# === FUNCTIONAL/UTILITIES R SCRIPTS ===

SCRIPTS_DIR <- here("R")
if (!dir.exists(SCRIPTS_DIR)) {
  message("R scripts not found at: ", SCRIPTS_DIR)
  SCRIPTS_DIR <- file.choose()
  message("Selected folder: ", SCRIPTS_DIR)
}


# === FIGURES FOLDER ===

FIGURES_DIR <- here("figures")
if (!dir.exists(FIGURES_DIR)) {
  response <- readline(prompt = paste0("Figures directory not found at: ", FIGURES_DIR, "\nCreate it? (y/n): "))
  if (tolower(response) == "y") {
    dir.create(FIGURES_DIR, recursive = TRUE)
    message("Created figures directory: ", FIGURES_DIR)
  } else {
    stop("Figures directory does not exist. Please create it manually or choose 'y' to create automatically.")
  }
}
