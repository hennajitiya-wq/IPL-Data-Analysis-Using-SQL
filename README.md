**Project Overview** :- This project focuses on analyzing historical Indian Premier League (IPL) data using SQL to extract meaningful insights about team performance, player contributions, and match trends.
By leveraging structured query techniques, the analysis uncovers patterns such as boundary distribution, top-performing players, and team-wise strengths. The goal is to transform raw cricket data into actionable insights that can support strategic decision-making for teams and enhance understanding of the game.
With this analysis, anyone can get the summary of whole dataset.

**Dataset Description** :- The dataset is sourced from IPL match records and consists of two primary tables:
**1. Matches Dataset:**
Total Records (Raws): 816
Total Columns: 17
Key Columns: id, city, date, player_of_match, venue,
             neutral_venue, team1, team2, 
             toss_winner, toss_decision, winner,
             result, result_margin, eliminator, method,
             player_of_match, umpire1, and umpire2.
**2. Deliveries Dataset:**
Total Records (Raws): 193,468
Total Columns: 17
Key Columns: id, inning, over, ball
             batsman, non-striker, bowler,
             batsman_runs, extra_runs, total_runs,
             is_wicket, dismissal_kind, player_dismissed, extras_type, fielder,
             bowling_team, and batting_team.

**Key Analysis Performed:** This SQL report helps to understand which player is performing better than other players alongwith their contribution towards their team. Also, it helps to know on which location number of boundaries was higher. This report tries to provide all the necessary details about different players and teams so that in upcoming tournaments, these teams and their players can perform better. It also tells us about the top players based on the scores they achieved.

**1. Player Performance Analysis:**
Identified top batsmen based on total runs.
Analyzed bowlers based on wickets taken.
Evaluated player contribution to team success.

**2. Team Performance Analysis:**
Compared team win statistics.
Analyzed toss impact on match results.
Identified strongest teams based on historical data.

**3. Venue & Location Insights:**
Examined boundary frequency across different cities/venues.
Identified high-scoring grounds.

**4. Match Trends Analysis:**
Date-wise match distribution.
Seasonal trends and performance patterns.
Examined boundary frequency across different cities/venues.
Identified high-scoring grounds.

**Skills & Tools Used:**
SQL (Joins, Aggregations, Subqueries, Window Functions)
Data Cleaning & Transformation
Exploratory Data Analysis (EDA)
Relational Database Concepts

**Key Insights:**
1. Certain venues consistently produce higher boundary counts, indicating batting-friendly conditions.
2. A small group of players dominate scoring and match-winning performances.
3. Toss decisions (bat/field) show noticeable influence on match outcomes in specific conditions.
4. Team performance varies significantly based on venue and match context.
   
**INFERENCE** :- We wanted to analyze the key features and trends of IPL Dataset based on which we could determine which team had performed well. In my analysis, I have tried to add knowledge about finding number of boundaries by location, date wise matches, good and bad players and many more. Actually, this analysis is for understanding the SQL language which itself helps to draw a lot of useful insights. And also, helps to know more about different players and teams performance, strategy, etc.

**Conclusion:** This project demonstrates how SQL can be effectively used to analyze large-scale sports datasets and generate meaningful insights. The analysis not only highlights player and team performance but also uncovers hidden trends that can influence match strategies.
Additionally, this project strengthened core SQL skills such as data querying, aggregation, and deriving business insights from structured datasets.
