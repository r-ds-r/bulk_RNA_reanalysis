## ========================================================================
##                FUNCTIONS FOR BULK RNA SEQ ANALYSIS 
#  ========================================================================

# === EXTRACTING GENE LISTS FROM RESULTS === 

extract_genes_from_results <- function(results, gene_list, list_name = "") {
  stats <- results[rownames(results) %in% gene_list, ]
  
  if(nrow(stats) > 0) {
    cat("\n=== ", list_name, " ===\n")
    cat("Total genes found:", nrow(stats), "\n")
    cat("Significant (padj < 0.05):", sum(stats$adj.P.Val < 0.05, na.rm = TRUE), "\n")
    cat("Upregulated:", sum(stats$adj.P.Val < 0.05 & stats$logFC > 0, na.rm = TRUE), "\n")
    cat("Downregulated:", sum(stats$adj.P.Val < 0.05 & stats$logFC < 0, na.rm = TRUE), "\n")
  }
  
  return(stats)
}

# === LOADING NASTER LIST OF GENES OF INTEREST ===

load_master_gene_lists <- function() {
  
  # Ask the user if they want to load the master gene list
  answer <- readline(prompt = "Load master gene list? (y/n): ")
  
  if (tolower(answer) != "y") {
    message("Skipping list of genes of interest.")
    return(invisible(NULL))  # safely exit the function
  }
  
  # If yes, open file browser
  file <- file.choose()
  
  # Read and return the RDS
  readRDS(file)
}

## === SAVING EXCEL FILES OF PROCESSED DATA ===

save_xlsx <- function(df, filename_base) {
  
  # Full path to workbook
  wb_file <- file.path(DATA_PROCESSED, filename_base)
  
  # Generate timestamp for the sheet name
  timestamp <- format(Sys.time(), "%Y%m%d_%H%M%S")
  
  # Load workbook if exists, else create new
  if (file.exists(wb_file)) {
    wb <- loadWorkbook(wb_file)
  } else {
    wb <- createWorkbook()
  }
  
  # Add new sheet with just time stamp as name
  addWorksheet(wb, timestamp)
  writeData(wb, sheet = timestamp, x = df)
  
  # Save workbook (overwrite = TRUE updates existing file)
  saveWorkbook(wb, wb_file, overwrite = TRUE)
  
  message("Saved sheet '", timestamp, "' to workbook '", wb_file, "'")
}

# === SAVING PNG VERSIONS OF PLOTS ===

save_png <- function(filename, 
                     width = FIG_WIDTH, 
                     height = FIG_HEIGHT, 
                     res = FIG_RES, 
                     units = FIG_UNITS) {
  filepath <- file.path(FIGURES_DIR, filename)
  png(filepath, width = width, height = height, units = units, res = res)
  message("Saving figure to:", filepath)
}

