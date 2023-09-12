{"metadata":{"kernelspec":{"name":"ir","display_name":"R","language":"R"},"language_info":{"name":"R","codemirror_mode":"r","pygments_lexer":"r","mimetype":"text/x-r-source","file_extension":".r","version":"4.0.5"}},"nbformat_minor":4,"nbformat":4,"cells":[{"cell_type":"code","source":"# This R environment comes with many helpful analytics packages installed\n# It is defined by the kaggle/rstats Docker image: https://github.com/kaggle/docker-rstats\n# For example, here's a helpful package to load\n\nlibrary(tidyverse) # metapackage of all tidyverse packages\n\n# Input data files are available in the read-only \"../input/\" directory\n# For example, running this (by clicking run or pressing Shift+Enter) will list all files under the input directory\n\nlist.files(path = \"../input\")\n\n# You can write up to 20GB to the current directory (/kaggle/working/) that gets preserved as output when you create a version using \"Save & Run All\" \n# You can also write temporary files to /kaggle/temp/, but they won't be saved outside of the current session","metadata":{"_uuid":"051d70d956493feee0c6d64651c6a088724dca2a","_execution_state":"idle","execution":{"iopub.status.busy":"2023-09-12T21:41:16.039251Z","iopub.execute_input":"2023-09-12T21:41:16.041463Z","iopub.status.idle":"2023-09-12T21:41:16.989270Z"},"trusted":true},"execution_count":null,"outputs":[]},{"cell_type":"markdown","source":"# 1. Backgroung\n## 1.1 About the company\nBellabeat, co-founded by Urška Sršen and Sando Mur, is a leading tech company crafting health-focused smart products with a keen aesthetic touch. It empowers women through data on activity, sleep, stress, and reproductive health. Since 2013, Bellabeat has expanded globally, offering products through online retailers and robust digital marketing. In 2016, it opened worldwide offices, emphasizing digital marketing channels like Google Search, social media, and display ads. To further growth, Sršen has tasked the marketing analytics team to analyze smart device usage data, aiming to shape Bellabeat's marketing strategy. This data-driven approach reflects Bellabeat's commitment to enhancing women's well-being.\n\n## 1.2 Characters\n* **Urška Sršen**: Bellabeat’s cofounder and Chief Creative Officer\n* **Sando Mur**: Mathematician and Bellabeat’s cofounder; key member of the Bellabeat executive team \n* **Bellabeat marketing analytics team**: A team of data analysts responsible for collecting, analyzing, and reporting data that helps guide Bellabeat’s marketing strategy. You joined this team six months ago and have been busy learning about Bellabeat’’s mission and business goals — as well as how you, as a junior data analyst,can help Bellabeat achieve them.\n\n\n## 1.3 Products\n* **Bellabeat app**: The Bellabeat app provides users with health data related to their activity, sleep, stress, menstrual cycle, and mindfulness habits. This data can help users better understand their current habits and make healthy decisions. The Bellabeat app connects to their line of smart wellness products.\n* **Leaf**: Bellabeat’s classic wellness tracker can be worn as a bracelet, necklace, or clip. The Leaf tracker connects to the Bellabeat app to track activity, sleep, and stress.\n* **Time**: This wellness watch combines the timeless look of a classic timepiece with smart technology to track user activity, sleep, and stress. The Time watch connects to the Bellabeat app to provide you with insights into your daily wellness.\n* **Spring**: This is a water bottle that tracks daily water intake using smart technology to ensure that you are appropriately hydrated throughout the day. The Spring bottle connects to the Bellabeat app to track your hydration levels.\n\n\n# 2. Ask\n## 2.1 Business Task \nThe primary objective is to gather valuable insights into how consumers utilize smart devices. Through a careful analysis of these devices, we aim to gain a better understanding of user behavior, preferences, and patterns. This will aid in the development of Bellabeat's marketing strategy and open new routes for growth opportunities.\n\n## 2.2 Stakeholders\n* **Urška Sršen**: Bellabeat’s cofounder and Chief Creative Officer.\n* **Sando Mur**: Bellabeat’s cofounder; key member of the Bellabeat executive team.\n* **Bellabeat marketing analytics team.**\n\n# 3. Prepare\n## 3.1 About the dataset\n**Name**: FitBit Fitness Tracker Data\n\n**Source**: kaggle (https://www.kaggle.com/datasets/arashnic/fitbit)\n\n**Content**:This dataset generated by respondents to a distributed survey via Amazon Mechanical Turk \nbetween 03.12.2016-05.12.2016. Thirty eligible Fitbit users consented to the submission of personal tracker data, including minute-level output for physical activity, heart rate, and sleep monitoring. Individual reports can be parsed by export session ID (column A) or timestamp (column B). Variation between output represents use of different types of Fitbit trackers and individual tracking behaviors / preferences.\n\n**Data Integrity**: Given the constraints, such as a limited sample size of 30 users and the absence of demographic details, there's a potential for sampling bias. We cannot guarantee that this sample accurately reflects the entire population. Additionally, the dataset is outdated, and the survey spanned only two months, posing limitations. Consequently, we intend to adopt an operational approach in our case study to address these challenges.\n\n","metadata":{}},{"cell_type":"markdown","source":"# 4. Process\n## 4.1 Loading Packages\nI will be using the tidyverse, lubridate and ggplot2 packages for this analysis.","metadata":{}},{"cell_type":"code","source":"library(tidyverse)\nlibrary(lubridate)\nlibrary(ggplot2)","metadata":{"execution":{"iopub.status.busy":"2023-09-12T21:41:16.993118Z","iopub.execute_input":"2023-09-12T21:41:17.023345Z","iopub.status.idle":"2023-09-12T21:41:17.040529Z"},"trusted":true},"execution_count":null,"outputs":[]},{"cell_type":"markdown","source":"## 4.2 Importing Data\nI will be using the daily data of activity, steps, and sleep, and the hourly data of steps, calories, and intensity. I will also be looking at the weight data.","metadata":{}},{"cell_type":"code","source":"d_act <- read_csv(\"/kaggle/input/fitbit/Fitabase Data 4.12.16-5.12.16/dailyActivity_merged.csv\")\nd_stp <- read_csv(\"/kaggle/input/fitbit/Fitabase Data 4.12.16-5.12.16/dailySteps_merged.csv\")\nd_sle <- read_csv(\"/kaggle/input/fitbit/Fitabase Data 4.12.16-5.12.16/sleepDay_merged.csv\")\nh_stp <- read_csv(\"/kaggle/input/fitbit/Fitabase Data 4.12.16-5.12.16/hourlySteps_merged.csv\")\nh_cal <- read_csv(\"/kaggle/input/fitbit/Fitabase Data 4.12.16-5.12.16/minuteCaloriesNarrow_merged.csv\")\nh_int <- read_csv(\"/kaggle/input/fitbit/Fitabase Data 4.12.16-5.12.16/hourlyIntensities_merged.csv\")\nweight <- read_csv(\"/kaggle/input/fitbit/Fitabase Data 4.12.16-5.12.16/weightLogInfo_merged.csv\")","metadata":{"execution":{"iopub.status.busy":"2023-09-12T21:41:17.044611Z","iopub.execute_input":"2023-09-12T21:41:17.046156Z","iopub.status.idle":"2023-09-12T21:41:18.571731Z"},"trusted":true},"execution_count":null,"outputs":[]},{"cell_type":"markdown","source":"## 4.3 Preview of the data","metadata":{}},{"cell_type":"code","source":"head(d_act)\nhead(d_stp)\nhead(d_sle)\nhead(h_stp)\nhead(h_cal)\nhead(h_int)\nhead(weight)","metadata":{"execution":{"iopub.status.busy":"2023-09-12T21:41:18.574580Z","iopub.execute_input":"2023-09-12T21:41:18.576116Z","iopub.status.idle":"2023-09-12T21:41:18.766454Z"},"trusted":true},"execution_count":null,"outputs":[]},{"cell_type":"markdown","source":"## 4.4 Data Cleaning and Formatting\n### 4.4.1 Checking the Data Sructure","metadata":{}},{"cell_type":"code","source":"str(d_act)\nstr(d_stp)\nstr(d_sle)\nstr(h_stp)\nstr(h_cal)\nstr(h_int)\nstr(weight)","metadata":{"execution":{"iopub.status.busy":"2023-09-12T21:41:18.769130Z","iopub.execute_input":"2023-09-12T21:41:18.770527Z","iopub.status.idle":"2023-09-12T21:41:18.885916Z"},"trusted":true},"execution_count":null,"outputs":[]},{"cell_type":"markdown","source":"### 4.4.2 Checking the sample size","metadata":{}},{"cell_type":"code","source":"dist_d_act <- d_act %>%\n    pull(Id) %>%\n    n_distinct()\nprint(dist_d_act)\n\ndist_d_stp <- d_stp %>%\n    pull(Id) %>%\n    n_distinct()\nprint(dist_d_stp)\n\ndist_d_sle <- d_sle %>%\n    pull(Id) %>%\n    n_distinct()\nprint(dist_d_sle)\n\ndist_h_stp <- h_stp %>%\n    pull(Id) %>%\n    n_distinct()\nprint(dist_h_stp)\n\ndist_h_cal <- h_cal %>%\n    pull(Id) %>%\n    n_distinct()\nprint(dist_h_cal)\n\ndist_h_int <- h_int %>%\n    pull(Id) %>%\n    n_distinct()\nprint(dist_h_int)\n\ndist_weight <- weight %>%\n    pull(Id) %>%\n    n_distinct()\nprint(dist_weight)\n","metadata":{"execution":{"iopub.status.busy":"2023-09-12T21:41:18.889009Z","iopub.execute_input":"2023-09-12T21:41:18.890465Z","iopub.status.idle":"2023-09-12T21:41:19.220706Z"},"trusted":true},"execution_count":null,"outputs":[]},{"cell_type":"markdown","source":"The sample size for the weight variable is too small to accurately represent the entire population. Therefore, we cannot draw conclusions from it.","metadata":{}},{"cell_type":"markdown","source":"### 4.4.3 Cheking for duplicates","metadata":{}},{"cell_type":"code","source":"sum(duplicated(d_act))\nsum(duplicated(d_stp))\nsum(duplicated(d_sle))\nsum(duplicated(h_stp))\nsum(duplicated(h_cal))\nsum(duplicated(h_int))\n","metadata":{"execution":{"iopub.status.busy":"2023-09-12T21:41:19.223308Z","iopub.execute_input":"2023-09-12T21:41:19.224690Z","iopub.status.idle":"2023-09-12T21:41:23.112384Z"},"trusted":true},"execution_count":null,"outputs":[]},{"cell_type":"markdown","source":"The variable d_sle has 3 duplicates that need to be removed.","metadata":{}},{"cell_type":"markdown","source":"### 4.4.4 Removing duplicates","metadata":{}},{"cell_type":"code","source":"d_sle <- d_sle %>%\ndistinct()","metadata":{"execution":{"iopub.status.busy":"2023-09-12T21:41:23.115152Z","iopub.execute_input":"2023-09-12T21:41:23.117338Z","iopub.status.idle":"2023-09-12T21:41:23.134920Z"},"trusted":true},"execution_count":null,"outputs":[]},{"cell_type":"markdown","source":"### 4.4.5 Checking for duplicates\nVerifying if the duplicates were removed","metadata":{}},{"cell_type":"code","source":"sum(duplicated(d_sle))","metadata":{"execution":{"iopub.status.busy":"2023-09-12T21:41:23.138827Z","iopub.execute_input":"2023-09-12T21:41:23.140686Z","iopub.status.idle":"2023-09-12T21:41:23.162216Z"},"trusted":true},"execution_count":null,"outputs":[]},{"cell_type":"markdown","source":"### 4.4.6 Checking for missing values","metadata":{}},{"cell_type":"code","source":"sum(is.na(d_act))\nsum(is.na(d_stp))\nsum(is.na(d_sle))\nsum(is.na(h_stp))\nsum(is.na(h_cal))\nsum(is.na(h_int))","metadata":{"execution":{"iopub.status.busy":"2023-09-12T21:41:23.165997Z","iopub.execute_input":"2023-09-12T21:41:23.167833Z","iopub.status.idle":"2023-09-12T21:41:23.287820Z"},"trusted":true},"execution_count":null,"outputs":[]},{"cell_type":"markdown","source":"There are no missing values.","metadata":{}},{"cell_type":"markdown","source":"### 4.4.7 Formating date columns\nConverting date columns into date format\n","metadata":{}},{"cell_type":"code","source":"d_act <- d_act %>%\n  rename(date = ActivityDate) %>%\n  mutate(date = as_date(date, format = \"%m/%d/%Y\"))\n\nd_stp <- d_stp %>%\n  rename(date = ActivityDay) %>%\n  mutate(date = as_date(date, format = \"%m/%d/%Y\"))\n\nd_sle <- d_sle %>%\n  rename(date = SleepDay) %>%\n  mutate(date = as_date(date, format =\"%m/%d/%Y %I:%M:%S %p\", tz = Sys.timezone()))\n\nh_stp <- h_stp %>% \n  rename(date_time = ActivityHour) %>% \n  mutate(date_time = as.POSIXct(date_time, format =\"%m/%d/%Y %I:%M:%S %p\" , tz=Sys.timezone()))\n\nh_cal <- h_cal %>% \n  rename(date_time = ActivityMinute) %>% \n  mutate(date_time = as.POSIXct(date_time, format =\"%m/%d/%Y %I:%M:%S %p\" , tz=Sys.timezone()))\n\nh_int <- h_int %>% \n  rename(date_time = ActivityHour) %>% \n  mutate(date_time = as.POSIXct(date_time, format =\"%m/%d/%Y %I:%M:%S %p\" , tz=Sys.timezone()))\n","metadata":{"execution":{"iopub.status.busy":"2023-09-12T21:41:23.290578Z","iopub.execute_input":"2023-09-12T21:41:23.292058Z","iopub.status.idle":"2023-09-12T21:41:25.358650Z"},"trusted":true},"execution_count":null,"outputs":[]},{"cell_type":"markdown","source":"### 4.4.8 Verifying if the changes were made","metadata":{}},{"cell_type":"code","source":"head(d_act)\nhead(d_stp)\nhead(d_sle)\nhead(h_stp)\nhead(h_cal)\nhead(h_int)","metadata":{"execution":{"iopub.status.busy":"2023-09-12T21:41:25.361250Z","iopub.execute_input":"2023-09-12T21:41:25.362679Z","iopub.status.idle":"2023-09-12T21:41:25.485896Z"},"trusted":true},"execution_count":null,"outputs":[]},{"cell_type":"markdown","source":"# 5. Analyse\n## 5.1 Summarize and explore the data sets","metadata":{}},{"cell_type":"markdown","source":"### 5.1.1 Amount of sedentary time","metadata":{}},{"cell_type":"code","source":"d_act %>%\n    select(SedentaryMinutes)%>%\n    summary()","metadata":{"execution":{"iopub.status.busy":"2023-09-12T21:41:25.488479Z","iopub.execute_input":"2023-09-12T21:41:25.489878Z","iopub.status.idle":"2023-09-12T21:41:25.511393Z"},"trusted":true},"execution_count":null,"outputs":[]},{"cell_type":"markdown","source":"The participants spent an average of 991.2 minutes or 16.52 hours per day being sedentary, which is alarming.","metadata":{}},{"cell_type":"markdown","source":"### 5.1.2 Amount of daily steps","metadata":{}},{"cell_type":"code","source":"d_stp %>%\n    select(StepTotal)%>%\n    summary()","metadata":{"execution":{"iopub.status.busy":"2023-09-12T21:41:25.513975Z","iopub.execute_input":"2023-09-12T21:41:25.515343Z","iopub.status.idle":"2023-09-12T21:41:25.533972Z"},"trusted":true},"execution_count":null,"outputs":[]},{"cell_type":"markdown","source":"On average, the participants take 7638 steps per day, which is lower than the recommended 10000. However, a study by BBC found that taking at least 4000 steps daily can decrease the risk of premature death from any cause.","metadata":{}},{"cell_type":"markdown","source":"### 5.1.3 Amount of daily sleep","metadata":{}},{"cell_type":"code","source":"d_sle %>%\n    select(TotalMinutesAsleep)%>%\n    summary()","metadata":{"execution":{"iopub.status.busy":"2023-09-12T21:41:25.536551Z","iopub.execute_input":"2023-09-12T21:41:25.537923Z","iopub.status.idle":"2023-09-12T21:41:25.556950Z"},"trusted":true},"execution_count":null,"outputs":[]},{"cell_type":"markdown","source":"The average sleeping time per day is 419,2 minutes, or approximately 7 hours of sleep per night which is below the 8 hours recommended however it's still considered a healthy amout of sleep.","metadata":{}},{"cell_type":"markdown","source":"### 5.1.4 Hourly steps through the day","metadata":{}},{"cell_type":"code","source":"h_stp <- h_stp %>%\n  separate(date_time, into = c(\"date\", \"time\"), sep= \" \") \n\nhead(h_stp)\n\nh_stp <- h_stp %>%\n    group_by(time) %>%\n    drop_na() %>%\nsummarise(mean_t_stp = mean(StepTotal))","metadata":{"execution":{"iopub.status.busy":"2023-09-12T21:41:25.559527Z","iopub.execute_input":"2023-09-12T21:41:25.560902Z","iopub.status.idle":"2023-09-12T21:41:26.104530Z"},"trusted":true},"execution_count":null,"outputs":[]},{"cell_type":"code","source":"ggplot(data = h_stp, aes(x = time, y = mean_t_stp)) + geom_histogram(stat = \"identity\", fill='blue') +\n  theme(axis.text.x = element_text(angle = 90)) +\n  labs(title=\"Average Total Steps by Hour\")\n","metadata":{"execution":{"iopub.status.busy":"2023-09-12T21:41:26.107210Z","iopub.execute_input":"2023-09-12T21:41:26.108612Z","iopub.status.idle":"2023-09-12T21:41:26.627637Z"},"trusted":true},"execution_count":null,"outputs":[]},{"cell_type":"markdown","source":"There is increased activity observed among people between 16h30 and 17h30, although not as high there´s another peak observed between 11h30 and 14h30. The first peak could be attributed to the time when participants finish work, while the second peak is during lunchtime when participants might take a walk.\n","metadata":{}},{"cell_type":"markdown","source":"### 5.1.5 Hourly steps vs. Hourly Calories\nHow does the amount of steps per hour correlate to the amount of calories burnt per hour.","metadata":{}},{"cell_type":"code","source":"ggplot(data = d_act, aes(x = TotalSteps, y= Calories)) +\n    geom_point() + geom_smooth() + labs(title = \"Total Steps vs. Calories\")","metadata":{"execution":{"iopub.status.busy":"2023-09-12T21:41:26.630550Z","iopub.execute_input":"2023-09-12T21:41:26.632210Z","iopub.status.idle":"2023-09-12T21:41:27.961652Z"},"trusted":true},"execution_count":null,"outputs":[]},{"cell_type":"markdown","source":"As we can see by observing the plot, there's a positive correlation between the total of steps taken and the calories burned.","metadata":{}},{"cell_type":"markdown","source":"### 5.1.6 Hourly intensity through the day","metadata":{}},{"cell_type":"code","source":"h_int <- h_int %>%\n  separate(date_time, into = c(\"date\", \"time\"), sep= \" \") \n\nhead(h_int)\n\nh_int <- h_int %>%\n    group_by(time) %>%\n    drop_na() %>%\nsummarise(mean_t_int = mean(TotalIntensity))","metadata":{"execution":{"iopub.status.busy":"2023-09-12T21:41:27.964564Z","iopub.execute_input":"2023-09-12T21:41:27.966098Z","iopub.status.idle":"2023-09-12T21:41:28.323932Z"},"trusted":true},"execution_count":null,"outputs":[]},{"cell_type":"code","source":"ggplot(data = h_int, aes(x = time, y = mean_t_int)) + geom_histogram(stat = \"identity\", fill='green') +\n  theme(axis.text.x = element_text(angle = 90)) +\n  labs(title=\"Average Intensity by Hour\")","metadata":{"execution":{"iopub.status.busy":"2023-09-12T21:41:28.326550Z","iopub.execute_input":"2023-09-12T21:41:28.327995Z","iopub.status.idle":"2023-09-12T21:41:28.671759Z"},"trusted":true},"execution_count":null,"outputs":[]},{"cell_type":"markdown","source":"As we observed previously in the \"Average of total steps by hour\" graph the hours where the users are more active are between 16h30 and 17h30.","metadata":{}},{"cell_type":"markdown","source":"# 6. Share\n## 6.1 Summary of the identified trends\n* Participants are sedentary for more than 16 hours a day, which can harm their health.\n* Participants tend to walk around 7600 steps daily which can reduce some health risks.\n* Average daily sleeping time is below the recommended 8 hours, but it's not far.\n* The most active intervals of time are between 11h30 and 14h30, and between 11h30 and 14h30.\n\n# 7. Act\n## 7.1 Recomendations for the Bellabeat team\n* Collect tracking data from the bellabeat products for better results.\n* Extend the data collection period to better analyze seasonal changes in variables.\n\n\n## 7.2 Recomendations for the Bellabeat app\n* Periodically send notifications reminding about the health benefits of leading a more active lifestyle.\n* Create a daily goal system to encourage the users to walk more. This system could award badges once a goal is reached helping the users feel accomplished once they meet them.\n* Create campaigns and in-app advertisements to motivate individuals to input their weight information.\n","metadata":{}},{"cell_type":"markdown","source":"","metadata":{}},{"cell_type":"code","source":"","metadata":{},"execution_count":null,"outputs":[]}],"kernelspec":{"name":"ir","display_name":"R","language":"R"},"language_info":{"name":"R","codemirror_mode":"r","pygments_lexer":"r","mimetype":"text/x-r-source","file_extension":".r","version":"4.0.5"}}