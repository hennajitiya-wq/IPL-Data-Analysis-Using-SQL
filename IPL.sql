/*CREATING TABLE NAMED matches*/
CREATE TABLE matches(id INT,
	                city VARCHAR,
					date DATE,
					player_of_match VARCHAR,
					venue VARCHAR,
					neutral_venue INT,
					team1 VARCHAR,
					team2 VARCHAR,
					toss_winner VARCHAR,
					toss_decision VARCHAR,
					winner VARCHAR,
					result VARCHAR,
					result_margin INT,
					eliminator VARCHAR,
					method VARCHAR,
					umpire1 VARCHAR,
					umpire2 VARCHAR);

/*CREATING TABLE NAMED deliveries*/
CREATE TABLE deliveries(id INT,
	                inning INT,
					over INT,
					ball INT,
					batsman VARCHAR,
					non_striker VARCHAR,
					bowler VARCHAR,
					batsman_runs INT,
					extra_runs INT,
					total_runs INT,
					is_wicket INT,
					dismissal_kind VARCHAR,
					player_dismissed VARCHAR,
					fielder VARCHAR,
					extras_type VARCHAR,
					batting_team VARCHAR,
					bowling_team VARCHAR);
					
/*LOADING DATA FROM CSV FILE TO matches TABLE*/
SET datestyle = dmy
COPY matches
FROM 'D:\Bitan\IIAS\internshala_videos\Data_for_final_project_IPL\matches.csv' CSV HEADER;

/*LOADING DATA FROM CSV FILE TO deliveries TABLE*/
COPY deliveries
FROM 'D:\Bitan\IIAS\internshala_videos\Data_for_final_project_IPL\deliveries.csv' CSV HEADER;

/*VIEWING deliveries TABLE UPTO 20 ROWS*/
SELECT *
FROM deliveries
LIMIT 20;

/*VIEWING matches TABLE UPTO 20 ROWS*/
SELECT *
FROM matches
LIMIT 20;

/*VIEWING DATA OF matches TABLE ON 2013-05-02*/
SELECT *
FROM matches
WHERE date = '2013-05-02';

/*VIEWING matches TABLE DATA WHERE result_margin IS GREATER THAN 100*/
SELECT *
FROM matches
WHERE result_margin > 100;

/*VIEWINNG matches TABLE DATA WHERE result IS tied ON 2020-10-18*/
SELECT *
FROM matches
WHERE result = 'tie' AND date = '2020-10-18'
ORDER BY date DESC;

/*VIEWING DIFFERENT CITY WHERE MMATCHES WERE HELD*/
SELECT COUNT(DISTINCT city)
FROM matches;

/*CREATING TABLE deliveries_v02 WHERE BALL_RESULT TYPE IS ADDED ALONGWITH DATA OF deliveries TABLE*/
CREATE TABLE deliveries_v02 AS
SELECT *
FROM deliveries

ALTER TABLE deliveries_v02
ADD COLUMN ball_result VARCHAR;

UPDATE deliveries_v02
SET ball_result = 'boundary'
WHERE total_runs >= 4;

UPDATE deliveries_v02
SET ball_result = 'dot'
WHERE total_runs = 0;

UPDATE deliveries_v02
SET ball_result = 'others'
WHERE NOT total_runs >= 4 AND NOT total_runs = 0;

/*VIEWING NUMBER OF BOUNDARIES AND NUMBER OF DOTS ON THE BASIS OF BOUNDARY AS ball_result*/
SELECT COUNT(ball_result) AS NO_OF_BOUNDARIES,
       (SELECT COUNT(ball_result) AS NO_OF_DOTS
		FROM deliveries_v02
		WHERE ball_result = 'dot')
FROM deliveries_v02
WHERE ball_result = 'boundary';

/*VIEWING TEAM NAME AND NUMBER OF BOUNDARIES ON THE BASIS OF BOUNDARY GROUP BY BATTING TEAM AND ORDER BY NUMBER OF BOUNDARIES*/
SELECT batting_team AS team_name, COUNT(ball_result) AS no_of_boundaries
FROM deliveries_v02
WHERE ball_result = 'boundary'
GROUP BY batting_team
ORDER BY no_of_boundaries DESC;

/*VIEWING TEAM NAME AND NUMBER OF DOTS ON THE BASIS OF DOT GROUP BY BOWLING TEAM AND ORDER BY NUMBER OF DOTS*/
SELECT bowling_team AS team_name, COUNT(ball_result) AS no_of_dots
FROM deliveries_v02
WHERE ball_result = 'dot'
GROUP BY bowling_team
ORDER BY no_of_dots DESC;

/*VIEWING DISMISAL KIND AND NUMBER OF DISMISSALS GROUP BY DISMISSAL KIND AND ORDER BY NUMBER OF DISMISSALS*/
SELECT dismissal_kind, COUNT(is_wicket) AS no_of_dismissals
FROM deliveries_v02
WHERE NOT is_wicket = 0
GROUP BY dismissal_kind
ORDER BY no_of_dismissals DESC;

/*VIEWING TOP 5 BOWLER AND RUNS CONCEEDED GROUP BY BOWLER AND ORDER BY RUNS CONCEEDED*/
SELECT DISTINCT bowler, MAX(extra_runs) AS runs_conceeded
FROM deliveries_v02
GROUP BY bowler
ORDER BY runs_conceeded DESC
LIMIT 5;

/*VIEWING VENUE, MATCH DATE AND ALL THE DATA RELATED TO DELIVERIES*/
CREATE TABLE deliveries_v03 AS
SELECT a.*, 
 	   b.venue,
	   b.date AS match_date
FROM deliveries_v02 AS a
LEFT JOIN matches AS b
ON a.id = b.id;

/*VIEWING VENUE AND TOTAL RUNS SCORED GROUP BY VENUE AND ORDER BY TOTAL RUNS CONCEEDED*/
SELECT venue, SUM(total_runs) AS total_runs_scored
FROM deliveries_V03
GROUP BY venue
ORDER BY total_runs_scored DESC;

/*VIEWING VENUE, YEAR AND TOTAL RUNS SCORED AT EDEN GARDENS GROUP BY MATCH DATE AND ORDER BY TOTAL RUNS CONCEEDED*/
SELECT venue, EXTRACT(year FROM match_date) AS year, SUM(total_runs) AS total_runs_scored
FROM deliveries_V03
WHERE venue = 'Eden Gardens'
GROUP BY match_date, venue
ORDER BY total_runs_scored DESC;
					  
/*CORRECTING TEAM NAMES*/
SELECT DISTINCT team1
FROM matches;

CREATE TABLE matches_corrected AS
SELECT *
FROM matches;

ALTER TABLE matches_corrected
ADD COLUMN team1_corr VARCHAR;

UPDATE matches_corrected
SET team1_corr = REPLACE(team1 , 'Rising Pune Supergiants', 'Rising Pune Supergiant');

ALTER TABLE matches_corrected
ADD COLUMN team2_corr VARCHAR;

UPDATE matches_corrected
SET team2_corr = REPLACE(team2 , 'Rising Pune Supergiants', 'Rising Pune Supergiant');

/*CREATING TABLE deliveries_v04 WITH ball_id column AND ALL OTHER COLUMNS OF deliveries_v03*/
CREATE TABLE deliveries_v04 AS
SELECT id || '-' || inning || '-' || over || '-' || ball AS ball_id, * 
FROM deliveries_v03;

/*VIEWING TOTAL BALL ID AND TOTAL DIFFERENT BALL IDs*/
SELECT COUNT(ball_id) AS total_rows, COUNT(DISTINCT ball_id) AS total_ids
FROM DELIVERIES_V04;

/*CREATING deliveries_v05 TABLE WITH ROW NUMBER AND ALL COLUMNS OF deliveries_v04 TABLE*/
CREATE TABLE deliveries_v05 AS
SELECT ROW_NUMBER() OVER(PARTITION BY ball_id ORDER BY ball_id) AS Row_Number, *  FROM deliveries_v04;

/*VIEWING DETAILS OF deliveries_v05 TABLE WITH ROW NUMBER = 2*/
SELECT *
FROM deliveries_v05
WHERE Row_Number = 2;


SELECT * 
FROM deliveries_v05 
WHERE ball_id IN (SELECT ball_id FROM deliveries_v05 WHERE Row_Number=2);
