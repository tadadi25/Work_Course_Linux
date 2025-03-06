# טעינת חבילות
library(dplyr)
library(ggplot2)

# קריאת ה-CSV
df <- read.csv("/app/New_name.csv")

# קובץ הפלט
output_file <- "/app/txt.outputs_R_5"
write("", file = output_file)  # ריקון בתחילת ריצה

# פונקציות לפעולות
group_and_mean_weight <- function() {
    result <- df %>%
        group_by(Species) %>%
        summarise(Mean_Weight = mean(Weight, na.rm = TRUE))
    write("1. Group by Species and Calculate Mean Weight", file = output_file, append = TRUE)
    write.table(result, file = output_file, append = TRUE, row.names = FALSE)
}

total_weight_by_species <- function() {
    result <- df %>%
        group_by(Species) %>%
        summarise(Total_Weight = sum(Weight, na.rm = TRUE))
    write("2. Total Weight by Species", file = output_file, append = TRUE)
    write.table(result, file = output_file, append = TRUE, row.names = FALSE)
}

sort_by_weight <- function() {
    result <- df %>% arrange(Weight)
    write("3. Sorted Data by Weight", file = output_file, append = TRUE)
    write.table(result, file = output_file, append = TRUE, row.names = FALSE)
}

plot_weight_distribution <- function() {
    plot <- ggplot(df, aes(x = Weight, fill = Sex)) +
        geom_histogram(binwidth = 5, alpha = 0.5) +
        labs(title = "Weight Distribution by Sex", x = "Weight", y = "Frequency")
    ggsave("/app/weight_distribution_by_sex.png", plot = plot)
}

count_records_per_species <- function() {
    result <- df %>%
        group_by(Species) %>%
        summarise(Count = n())
    write("5. Count the Number of Records per Species", file = output_file, append = TRUE)
    write.table(result, file = output_file, append = TRUE, row.names = FALSE)
}

count_males_and_females <- function() {
    result <- df %>%
        group_by(Sex) %>%
        summarise(Count = n())
    write("6. Count Males and Females", file = output_file, append = TRUE)
    write.table(result, file = output_file, append = TRUE, row.names = FALSE)
}

filter_by_species <- function() {
    cat("Enter species name to filter: ")
    species <- readLines("stdin", n = 1)
    result <- df %>% filter(Species == species)
    write(paste("7. Filtered Data for Species:", species), file = output_file, append = TRUE)
    write.table(result, file = output_file, append = TRUE, row.names = FALSE)
}

# תפריט רץ בלולאה
repeat {
    cat("\nChoose Action:\n")
    cat("1 - Group by Species and Calculate Mean Weight\n")
    cat("2 - Calculate the Total Weight by Species\n")
    cat("3 - Sorting the Data by Weight\n")
    cat("4 - Plotting Weight Distribution by Sex (PNG)\n")
    cat("5 - Count the Number of Records per Species\n")
    cat("6 - Count the Number of Males and Females\n")
    cat("7 - Filter Data by Species\n")
    cat("8 - Exit\n")
    cat("Enter choice: ")

    choice <- as.integer(readLines("stdin", n = 1))

    if (choice == 1) {
        group_and_mean_weight()
    } else if (choice == 2) {
        total_weight_by_species()
    } else if (choice == 3) {
        sort_by_weight()
    } else if (choice == 4) {
        plot_weight_distribution()
    } else if (choice == 5) {
        count_records_per_species()
    } else if (choice == 6) {
        count_males_and_females()
    } else if (choice == 7) {
        filter_by_species()
    } else if (choice == 8) {
        cat("Exiting...\n")
        break
    } else {
        cat("Invalid choice. Try again.\n")
    }
}
