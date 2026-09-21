# SQL-Project1
The Analyzed  Version of Airline Data
# SQL-Project1
The Analysis of Customer Ratings of Airline Data 
## Introduction
📊 Dive into the customer ratings of airline data! Focusing on customer ratings of various departments, this project explores customer types with different age groups & preferred class, type of travel, and the no. of satisfied customers.

🔍 SQL queries?

#### Different analysed sections with queries:
Here are some questions that I answered through my analysis…..
**The KPIs section**:
1. What is the no. of customers who travelled with the airline?
2. What is the no. of loyal and disloyal customers?
3. What is the percentage of satisfied customers?
4. What is the no. of on-time arrival/departure flights?

**Distinct Customer Type Section**:
1. What is the number of male & female in each Customer type & class?
2. What is the Highest to lowest travel by age group?
3. What is the no. of customers by age group in each travel distance type?

**Time-based Analysis Section**:

1. No. of delayed arrival/departure flights
2. Minimum & Maximum  time of delay in arrival/departure of flight

**Rating Analysis**:
1. Best to least department  as per the rating
2. No. of customers in the rating category of each department

### Tools I used to analyse
For my deep dive into the Airline data customer ratings, I harnessed the power of several key tools:
- **SQL:** The backbone of my analysis, allowing me to query the database and unearth critical insights.
- **PostgreSQL:** The chosen database management system, ideal for handling the different sections.
- **GitHub:** Essential for version control and sharing my SQL scripts and analysis, ensuring the showcase of my analysis.

## Let's go to the Analysis section to see the Queries…..
# The Analysis
Each query in this project aimed to provide insights and produce a comprehensive analysis report. Here is the  analysis of how I solved  some key findings with the queries:

**Distinct Customer type Section**:
## 1. What is the no. of males & females in each Customer type & class?
To get the number of males & females who preferred each customer type section & also the class. Here  is the query:
**SQL
SELECT 
    class,
    type_of_travel,
    COUNT(CASE WHEN gender = 'Male' THEN 1 END) AS Male,
    COUNT(CASE WHEN gender = 'Female' THEN 1 END) AS Female,
    COUNT(*) AS Total_Travellers
FROM Airline_data
GROUP BY class, type_of_travel
ORDER BY class, type_of_travel;

Here's the result of the given query :

<img width="557" height="251" alt="Screenshot 2026-09-22 003423" src="https://github.com/user-attachments/assets/c1528724-85f7-4448-92c6-3b2e50fa80e9" />


### 2. What is the Highest to lowest travel by age group?

SELECT  
   type_of_travel,
	 class,
	 age_group , 
	 COUNT(CASE WHEN gender = 'Male' THEN 1 END) AS Male,
	 COUNT(CASE WHEN gender = 'Female' THEN 1 END) AS Female, 
	 COUNT(*) AS Total_customer
	 FROM Airline_data
      GROUP BY  type_of_travel,class, age_group
	  ORDER BY  type_of_travel,class, age_group;


### 3.  What is the no. of customers by age group in each travel distance type?

SELECT 
     age_group,
	  flight_distance_type,
	  COUNT(CASE WHEN gender = 'Male' THEN 1 END) AS Male,
	 COUNT(CASE WHEN gender = 'Female' THEN 1 END) AS Female, 
	 COUNT(*) AS Total_customer
	 FROM Airline_data
	  GROUP BY  age_group, flight_distance_type
	  ORDER BY age_group, flight_distance_type;

Here the result of the query:

<img width="722" height="673" alt="Screenshot 2026-09-22 004459" src="https://github.com/user-attachments/assets/76ef099c-8099-4161-9f10-1e75d7e555c7" />


### 4. Minimum & Maximum time of delay in arrival/departure of flight
Exploring the average salaries associated with different skills revealed which skills are the highest paying.

SELECT 
    MAX(departure_Delay_in_Minutes) AS max_departure_delay,
    MIN(departure_Delay_in_Minutes) AS min_departure_delay,
    MAX(Arrival_Delay_in_Minutes)   AS max_arrival_delay,
    MIN(Arrival_Delay_in_Minutes)   AS min_arrival_delay
FROM Airline_data
WHERE departure_Delay_in_Minutes > 1
  AND Arrival_Delay_in_Minutes > 1;

  <img width="740" height="80" alt="Screenshot 2026-09-22 005207" src="https://github.com/user-attachments/assets/8e2b020e-6fd6-47e2-867b-a80bee1edf4f" />


  ### 5.  No. of delayed arrival/departure flights

SELECT category, COUNT(*) AS num_customers
FROM (
    SELECT 'On-time Departure' AS category
    FROM Airline_data
    WHERE Departure_Delay_in_Minutes = 0
  UNION ALL
SELECT 'Departure_delay_in_Minutes'
    FROM Airline_data
    WHERE Departure_delay_in_minutes > 1
UNION ALL
 SELECT 'On-time Arrival'
    FROM Airline_data
    WHERE Arrival_Delay_in_Minutes = 0
 UNION ALL
SELECT 'Arrival Delayed'
    FROM Airline_data
    WHERE Arrival_Delay_in_Minutes > 1
) AS flight_status
GROUP BY category
ORDER BY category;

Here the result of the query:

<img width="412" height="175" alt="Screenshot 2026-09-22 005319" src="https://github.com/user-attachments/assets/e2671a62-1f2a-4a93-9cad-83f233475868" />


### 6.  Average rating of all departments by customers

SELECT department, avg_rating
FROM (
    SELECT 'Inflight Wifi Service'         
             AS department,
             AVG(inflight_wifi_service)           AS avg_rating FROM Airline_data
    UNION ALL
    SELECT 'Departure/Arrival Time Convenient', AVG(departure_arrival_time_convenient) FROM Airline_data
    UNION ALL
    SELECT 'Ease of Online Booking ’,      AVG(Ease_of_Online_booking) FROM Airline_data
    UNION ALL
    SELECT 'Gate Location',                AVG(Gate_location) FROM Airline_data
    UNION ALL
    SELECT 'Food and Drink',               AVG(Food_and_drink) FROM Airline_data
    UNION ALL
    SELECT 'Online Boarding',              AVG(Online_boarding) FROM Airline_data
    UNION ALL
    SELECT 'Seat Comfort',                  AVG(Seat_comfort) FROM Airline_data
    UNION ALL
    SELECT 'Inflight Entertainment',        AVG(Inflight_entertainment) FROM Airline_data
    UNION ALL
    SELECT 'Onboard Service',               AVG(Onboard_service) FROM Airline_data
    UNION ALL
    SELECT 'Leg Room Service',              AVG(Leg_room_service) FROM Airline_data
    UNION ALL
    SELECT 'Baggage Handling',              AVG(Baggage_handling) FROM Airline_data
    UNION ALL
    SELECT 'Checkin Service',               AVG(Checkin_service) FROM Airline_data
    UNION ALL
    SELECT 'Cleanliness',                   AVG(Cleanliness) FROM Airline_data
) AS dept_ratings
ORDER BY avg_rating DESC;

Here the result:

<img width="477" height="457" alt="Screenshot 2026-09-22 005533" src="https://github.com/user-attachments/assets/c247a5a7-c0a7-4019-9484-d9db84bb852e" />

Graph showing the best to least rating department:

<img width="1527" height="535" alt="Screenshot 2026-09-19 212854" src="https://github.com/user-attachments/assets/a3715782-4b22-4d3b-84ea-653040fd5331" />


## 7. No. of customers in the rating category of each department

SELECT 
    department,
    COUNT(CASE WHEN rating = 0 THEN 1 END) AS  No_rating,
    COUNT(CASE WHEN rating = 1 THEN 1 END) AS rating_1,
    COUNT(CASE WHEN rating = 2 THEN 1 END) AS rating_2,
    COUNT(CASE WHEN rating = 3 THEN 1 END) AS rating_3,
    COUNT(CASE WHEN rating = 4 THEN 1 END) AS rating_4,
    COUNT(CASE WHEN rating = 5 THEN 1 END) AS rating_5
FROM (
    SELECT 'Inflight Wifi Service' AS department, inflight_wifi_service AS rating FROM Airline_data
    UNION ALL
    SELECT 'Departure/Arrival Time Convenient', departure_arrival_time_convenient FROM Airline_data
    UNION ALL
    SELECT 'Ease of Online Booking', Ease_of_Online_booking FROM Airline_data
    UNION ALL
    SELECT 'Gate Location', Gate_location FROM Airline_data
    UNION ALL
    SELECT 'Food and Drink', Food_and_drink FROM Airline_data
    UNION ALL
    SELECT 'Online Boarding', Online_boarding FROM Airline_data
    UNION ALL
    SELECT 'Seat Comfort', Seat_comfort FROM Airline_data
    UNION ALL
    SELECT 'Inflight Entertainment', Inflight_entertainment FROM Airline_data
    UNION ALL
    SELECT 'Onboard Service', Onboard_service FROM Airline_data
    UNION ALL
    SELECT 'Leg Room Service', Leg_room_service FROM Airline_data
    UNION ALL
    SELECT 'Baggage Handling', Baggage_handling FROM Airline_data
    UNION ALL
    SELECT 'Checkin Service', Checkin_service FROM Airline_data
    UNION ALL
    SELECT 'Cleanliness', Cleanliness FROM Airline_data
) AS customer_in_rating
GROUP BY department
ORDER BY department;

Here the result:

<img width="872" height="462" alt="Screenshot 2026-09-22 005836" src="https://github.com/user-attachments/assets/f12cf8be-4561-4d03-ac3c-78d1834c13cb" />


# Conclusions

### Insights
From the analysis, several general insights emerged:

1. **Best to least department rating by customer**: The  Baggage Handling department tops the list with an average rating of 3.6/5, & The Inflight_service hold the lowest position with an average rating of 2.7/5, which suggests the department with the lowest rating needs to be focused on.
2. **Most preferred class to travel**: Business class tops the list as the most preferred class to travel by each age-group category, followed by Economy & Economy Plus, showing Business class as the most preferred class with 62160 / 129880.
3. **The age_group  that travels the most**: Adults age-group travel the most, that indicate the adult group as the most frequent traveller.
4. **The Minimum & Maximum time of delay**: The analysis shows the maximum time of delayed flights; this must be helpful to find out &  reduce the delay time to enhance the airline service quality.

### Closing Thoughts

This project enhanced my SQL skills and provided valuable insights into the  Airline data. The findings from the analysis serve as a guide to prioritizing the departments & focused on the services. The skills that I learned by doing the project is Sub queries, UNION function to get combine the data of multiple rows ,the MIN/MAX function with GROUP BY & ORDER BY function through which I was able to answer all the questions.

