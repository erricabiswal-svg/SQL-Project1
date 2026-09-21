---DATA EXPLORETION

--Sample Data

SELECT * FROM Airline_data
LIMIT 5;

--Finding Null Values

SELECT * FROM Airline_data
WHERE gender IS NULL
OR  customer_type IS NULL OR age IS NULL OR type_of_travel IS NULL OR class IS NULL
OR flight_distance IS NULL OR inflight_wifi_service IS NULL
OR departure_arrival_time_convenient IS NULL OR ease_of_online_booking IS NULL
OR gate_location IS NULL
OR food_and_drink IS NULL
OR online_boarding IS NULL
OR seat_comfort IS NULL
OR inflight_entertainment IS NULL
OR onboard_service IS NULL
OR leg_room_service IS NULL
OR baggage_handling IS NULL
OR checkin_service IS NULL
OR cleanliness IS NULL
OR departure_delay_in_minutes IS NULL
OR arrival_delay_in_minutes IS NULL
OR satisfaction IS NULL;


--updating NULL values

UPDATE Airline_data
SET arrival_delay_in_minutes =0
WHERE arrival_delay_in_minutes IS NULL;


 ---- Add new column as Age_Group

ALTER TABLE Airline_data ADD COLUMN age_group VARCHAR(20);

UPDATE Airline_data
SET age_group = CASE 
        WHEN age < 13 THEN 'Child'
        WHEN age BETWEEN 13 AND 19 THEN 'Teenager'
        WHEN age BETWEEN 20 AND 35 THEN 'Young Adult'
        WHEN age BETWEEN 36 AND 55 THEN 'Adult'
        WHEN age > 55 THEN 'Senior'
        ELSE 'Unknown'
    END;

--No. of travellers in late departure flights

SELECT 
     departure_delay_in_minutes, COUNT(*) AS Total
     FROM Airline_data
     GROUP BY departure_delay_in_minutes;

--No. of travellers in late arrival flights

SELECT 
      arrival_delay_in_minutes, COUNT(*) AS Total
      FROM Airline_data
      GROUP BY arrival_delay_in_minutes;
 
--KPIs

--count of Traveller
SELECT COUNT(*) AS Total_traveller FROM Airline_data;

--No of male & female
SELECT  
   gender,
   COUNT(*) FROM Airline_data
   GROUP BY gender;

--no of customer_type
SELECT  
    customer_type,
	COUNT(*) FROM Airline_data
    GROUP BY customer_type;

--preferred type_of_travel
SELECT 
      type_of_travel,
	  COUNT(*) FROM Airline_data
      GROUP BY type_of_travel;


--preferred class
SELECT 
    class,
	COUNT(*) FROM Airline_data
    GROUP BY class;

--no of customers by flight_distance
SELECT  
     flight_distance, 
	 COUNT(*) FROM Airline_data
     GROUP BY flight_distance;

--Adding new column as flight distance type

ALTER TABLE Airline_data
  ADD COLUMN flight_distance_type VARCHAR(50)

  UPDATE Airline_data
  SET flight_distance_type =
   CASE  WHEN Flight_Distance <=1000    THEN 'Normal'
         WHEN Flight_Distance BETWEEN 1001 AND 2500   THEN 'Average'
		 WHEN Flight_Distance BETWEEN 2501 AND 3499   THEN 'Long'
		 WHEN Flight_Distance BETWEEN 3500 AND 5000   THEN 'Very Long'
	ELSE 'Unknown'
 END;

---- Customer type analysis

 --No of customers in each flight_distance_category
 
 SELECT  
    flight_distance_type, 
	age_group,
	COUNT(*) FROM Airline_data
    GROUP BY flight_distance_type, age_group
	ORDER BY age_group ASC;

 
--no of customers by type_of_travel & class

SELECT 
    class,
    type_of_travel,
    COUNT(CASE WHEN gender = 'Male' THEN 1 END) AS Male,
    COUNT(CASE WHEN gender = 'Female' THEN 1 END) AS Female,
    COUNT(*) AS Total_Customer
FROM Airline_data
GROUP BY class, type_of_travel
ORDER BY class, type_of_travel;


--Class preferred by gender

SELECT  
     class,
	 gender,
	 COUNT(*) AS total_traveller FROM Airline_data
      GROUP BY class, gender;

--Preferred travel type by age group

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

-- no. of customers by age group in each travel distance type
 
SELECT 
     age_group,
	 flight_distance_type,
	  COUNT(CASE WHEN gender = 'Male' THEN 1 END) AS Male,
	 COUNT(CASE WHEN gender = 'Female' THEN 1 END) AS Female, 
	 COUNT(*) AS Total_customer
	 FROM Airline_data
	  GROUP BY  age_group, flight_distance_type
	  ORDER BY age_group, flight_distance_type;


-- --RATING ANALYSIS

-- No. of satisfied customers
   SELECT 
     gender,
	 satisfaction,
	 COUNT(*) FROM Airline_data
     GROUP BY gender, satisfaction;


--Avg of each rating column

SELECT
    AVG(inflight_wifi_service)           AS AVG_inflight_wifi,
    AVG(departure_arrival_time_convenient) AS avg_departure_arrival_time,
    AVG(Ease_of_Online_booking)          AS AVG_online_booking,
    AVG(Gate_location)                   AS AVG_Gate_location,
    AVG(Food_and_drink)                  AS AVG_Food_and_drink,
    AVG(Online_boarding)                 AS AVG_Online_boarding,
    AVG(Seat_comfort)                    AS AVG_Seat_comfort,
    AVG(Inflight_entertainment)          AS AVG_Inflight_entertainment,
    AVG(Onboard_service)                 AS AVG_Onboard_service,
    AVG(Leg_room_service)                AS AVG_Leg_room_service,
    AVG(Baggage_handling)                AS AVG_Baggage_handling,
    AVG(Checkin_service)                 AS AVG_Checkin_service,
    AVG(Cleanliness)                     AS AVG_Cleanliness
FROM Airline_data;

--Add avg_rating column

  ALTER TABLE Airline_data 
  ADD COLUMN avg_rating DECIMAL(5,2);

--claculation of avg_rating per person

UPDATE Airline_data
SET avg_rating = (
    inflight_wifi_service + departure_arrival_time_convenient + Ease_of_Online_booking +
    Gate_location + Food_and_drink + Online_boarding + Seat_comfort +
    Inflight_entertainment + Onboard_service + Leg_room_service +
    Baggage_handling + Checkin_service + Cleanliness
) / 13.0;

-- --TIME BASED ANALYSIS

-- number of departure delayed flights in DESC order
SELECT COUNT (departure_Delay_in_Minutes) AS departure_delayed_ASC
FROM Airline_data
WHERE departure_Delay_in_Minutes > 1
GROUP BY departure_Delay_in_Minutes
ORDER BY departure_Delay_in_Minutes ASC;


-- number of arrival-delayed flights in DESC order

SELECT COUNT (Arrival_Delay_in_Minutes) AS arrival_delayed_ASC
FROM Airline_data
WHERE Arrival_Delay_in_Minutes > 1
GROUP BY  Arrival_Delay_in_Minutes
ORDER BY  Arrival_Delay_in_Minutes ASC;

--MIN/MAX time of departure/arrival delayed flight

SELECT 
    MAX(departure_Delay_in_Minutes) AS max_departure_delay,
    MIN(departure_Delay_in_Minutes) AS min_departure_delay,
    MAX(Arrival_Delay_in_Minutes)   AS max_arrival_delay,
    MIN(Arrival_Delay_in_Minutes)   AS min_arrival_delay
FROM Airline_data
WHERE departure_Delay_in_Minutes > 1
  AND Arrival_Delay_in_Minutes > 1;

-- No. of Delayed/Arrival Customers

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

--Adding a column for the category of avg_rating 

ALTER TABLE Airline_data
ADD COLUMN rating_category VARCHAR(100);


--Specify category of avg_rating

UPDATE  Airline_data
   SET rating_category = 
      CASE 
	   WHEN avg_rating >= 4.5 THEN 'Very Good'
	   WHEN avg_rating >= 4 THEN 'Good'
	   WHEN avg_rating >= 3 THEN 'Average'
	   WHEN avg_rating >= 2 THEN 'Below Average'
	   WHEN avg_rating < 2 THEN 'Very Bad'
    ELSE 'Unknown'
END;


--No of customers in each rating category ***

SELECT 
    rating_category, 
	COUNT(*) FROM Airline_data
GROUP BY rating_category;


-- Best to least department as per avg_rating

SELECT department, avg_rating
FROM (
    SELECT 'Inflight Wifi Service'         AS department, AVG(inflight_wifi_service)            AS avg_rating FROM Airline_data
    UNION ALL
    SELECT 'Departure/Arrival Time Convenient', AVG(departure_arrival_time_convenient) FROM Airline_data
    UNION ALL
    SELECT 'Ease of Online Booking',        AVG(Ease_of_Online_booking) FROM Airline_data
    UNION ALL
    SELECT 'Gate Location',                 AVG(Gate_location) FROM Airline_data
    UNION ALL
    SELECT 'Food and Drink',                AVG(Food_and_drink) FROM Airline_data
    UNION ALL
    SELECT 'Online Boarding',               AVG(Online_boarding) FROM Airline_data
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


--No of customers in each rating category of each department

 SELECT department, rating, COUNT(*) AS num_customers
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
) AS no_of_customer
GROUP BY department, rating
ORDER BY department, rating;

--Distinct department with the rating details of no of customers

SELECT
    food_and_drink AS rating,
    COUNT(*)     AS num_customers
FROM Airline_data
GROUP BY food_and_drink
ORDER BY food_and_drink DESC;


-- Rearrange the data as rating column as row

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

