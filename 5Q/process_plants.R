# טעינת חבילות דרושות
library(dplyr)
library(ggplot2)

# קריאת קובץ ה-CSV
df <- read.csv("/app/New_name.csv")

# 1. קבוצות לפי סוג וצורך בממוצע משקל
mean_weight <- df %>%
  group_by(Species) %>%
  summarise(Mean_Weight = mean(Weight))

# 2. קבוצות לפי סוג וצורך במשקל כולל
total_weight <- df %>%
  group_by(Species) %>%
  summarise(Total_Weight = sum(Weight))

# 3. מיון הנתונים לפי משקל
sorted_data <- df %>%
  arrange(Weight)

# 4. הצגת התפלגות המשקל לפי מין (יצירת תמונה)
ggplot(df, aes(x = Weight, fill = Sex)) + 
  geom_histogram(binwidth = 5, alpha = 0.5) + 
  labs(title = "Weight Distribution by Sex", x = "Weight", y = "Frequency") +
  ggsave("/app/weight_distribution_by_sex.png")

# כתיבת התוצאות לקובצי טקסט
write.table(mean_weight, "/app/mean_weight_by_species.txt", row.names = FALSE)
write.table(total_weight, "/app/total_weight_by_species.txt", row.names = FALSE)
write.table(sorted_data, "/app/sorted_data_by_weight.txt", row.names = FALSE)
