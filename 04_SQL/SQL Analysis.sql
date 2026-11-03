
-- SQL Analysis — Australian International Aviation Intelligence

-- 1. Data Import into PostgreSQL
-- 1.1 Create a table to store monthly international passenger traffic
CREATE TABLE city_pair (       -- CREATE TABLE: Creates a new table
    month DATE,                -- DATE: Stores dates
    australian_port TEXT,      -- TEXT: Stores text
    foreign_port TEXT,
    country TEXT,
    passengers_in NUMERIC,     -- NUMERIC: Stores numbers
    passengers_out NUMERIC,
    total_passengers NUMERIC
);                             -- ; Ends the SQL statement

-- Improt the data in our table from csv file

-- Check the table structure and contents
SELECT *                       -- SELECT: Retrieves data | *: All columns
FROM city_pair;                -- FROM: Specifies the source table


-- 1.2 Create a table to store international flights and seat capacity
CREATE TABLE flights_seats (           -- CREATE TABLE: Creates a new table
    month DATE,                        -- DATE: Stores dates
    australian_port TEXT,              -- TEXT: Stores airport names
    foreign_port TEXT,
    in_flights_exclusive NUMERIC,       -- NUMERIC: Stores numbers
    in_flights_all NUMERIC,
    out_flights_exclusive NUMERIC,
    out_flights_all NUMERIC,
    in_seats_min NUMERIC,
    in_seats_max NUMERIC,
    out_seats_min NUMERIC,
    out_seats_max NUMERIC
);                                     -- ; Ends the statement

-- Improt the data in our table from csv file

-- View all imported flight and seat capacity records
SELECT *
FROM flights_seats;


-- 1.3 Create a table to store airline passenger traffic by country
CREATE TABLE airlines_country (       -- CREATE TABLE: Creates a new table
    month DATE,                       -- DATE: Stores dates
    airline TEXT,                     -- TEXT: Stores airline names
    country TEXT,
    passengers_in NUMERIC,            -- NUMERIC: Stores passenger counts
    passengers_out NUMERIC
);                                    -- ; Ends the SQL statement

-- Improt the data in our table from csv file

-- Display all airline passenger records
SELECT *                              -- SELECT: Retrieves data | *: All columns
FROM airlines_country;               -- FROM: Source table


-- 2. Passenger Traffic Analysis
-- 2.1 Annual International Passenger Traffic

-- Calculate annual arrivals, departures, and total passengers
SELECT
    EXTRACT(YEAR FROM month) AS year,       -- EXTRACT: Gets year from date
    SUM(passengers_in) AS arrivals,         -- SUM: Adds passenger counts
    SUM(passengers_out) AS departures,
    SUM(total_passengers) AS total_traffic  -- AS: Names the output column
FROM city_pair                             -- FROM: Source table
GROUP BY EXTRACT(YEAR FROM month)          -- GROUP BY: Combines rows by year
ORDER BY year;                             -- ORDER BY: Sorts years ascending

-- Key Finding: Traffic grew from 24.41M (2009) to 44.85M (2025), despite a sharp COVID-19 decline, surpassing 2019 levels by 5.5%.

-- 2.2 Year-over-Year Passenger Growth
-- Calculate annual traffic and percentage change from the previous year
WITH annual_traffic AS (                  -- WITH: Creates a temporary named result (CTE)
    SELECT
        EXTRACT(YEAR FROM month) AS year,
        SUM(total_passengers) AS total_traffic
    FROM city_pair
    GROUP BY EXTRACT(YEAR FROM month)
)
SELECT
    year,
    total_traffic,
    LAG(total_traffic) OVER (ORDER BY year) AS previous_year,  -- LAG: Gets previous year's total
    ROUND(
        100.0 * (total_traffic - LAG(total_traffic) OVER (ORDER BY year))
        / NULLIF(LAG(total_traffic) OVER (ORDER BY year), 0), 2
    ) AS growth_pct                        -- ROUND: 2 decimals | NULLIF: Prevents division by zero
FROM annual_traffic
WHERE year <= 2025                        -- WHERE: Excludes incomplete 2026
ORDER BY year;

-- Key Finding: Traffic fell 78.12% in 2020 and 83.28% in 2021, then rebounded 1,126.65% in 2022 and continued growing through 2025.

-- 2.3 Monthly Passenger Traffic Trends
-- Calculate average passenger traffic for each calendar month
SELECT
    EXTRACT(MONTH FROM month) AS month_number,   -- EXTRACT: Gets month (1–12)
    TO_CHAR(month, 'Month') AS month_name,       -- TO_CHAR: Converts date to month name
    ROUND(AVG(monthly_total), 0) AS avg_passengers -- AVG: Calculates average
FROM (
    -- First calculate total passenger traffic for each month and year
    SELECT
        DATE_TRUNC('month', month) AS month,      -- DATE_TRUNC: Groups dates by month
        SUM(total_passengers) AS monthly_total   -- SUM: Adds passenger counts
    FROM city_pair
    WHERE month < '2020-01-01'                   -- WHERE: Uses pre-pandemic years
    GROUP BY DATE_TRUNC('month', month)
) AS monthly_traffic                            -- AS: Names the temporary result
GROUP BY EXTRACT(MONTH FROM month), TO_CHAR(month, 'Month')
ORDER BY month_number;                          -- ORDER BY: January to December

-- Key Finding: December (3.24M) and January (3.18M) had the highest average monthly traffic during 2009–2019, while May was the quietest (2.44M).

-- 2.4 Australian Airport Performance
SELECT
    australian_port,
    SUM(total_passengers) AS total_traffic  -- SUM: Adds passenger counts
FROM city_pair
WHERE EXTRACT(YEAR FROM month) NOT BETWEEN 2020 AND 2022
  AND month < '2026-01-01'                 -- Excludes incomplete 2026
GROUP BY australian_port                   -- Groups passengers by airport
ORDER BY total_traffic DESC NULLS LAST    -- Busiest airports first
LIMIT 10;                                  -- Top 10 airports

-- Key Finding: Sydney led international passenger traffic with 199.48M passengers, followed by Melbourne (125.20M), Brisbane (73.85M), and Perth (56.74M), excluding 2020–2022 and 2026.

-- 2.5 Top International Destination Countries
-- Identify the top 10 international passenger markets
SELECT
    country,
    SUM(total_passengers) AS total_traffic  -- SUM: Adds passengers by country
FROM city_pair
WHERE EXTRACT(YEAR FROM month) NOT BETWEEN 2020 AND 2022
  AND month < '2026-01-01'                 -- Excludes incomplete 2026
GROUP BY country                           -- GROUP BY: Combines records by country
ORDER BY total_traffic DESC NULLS LAST    -- Highest traffic first
LIMIT 10;        

-- Key Finding: New Zealand (89.20M) and Singapore (72.07M) were Australia's largest international passenger markets, followed by the UAE (39.96M), Indonesia (39.32M), and USA (37.08M), excluding 2020–2022 and 2026.

-- 2.6 Top International Airport Routes
-- Identify the 10 busiest international airport routes
SELECT
    australian_port,
    foreign_port,
    country,
    SUM(total_passengers) AS total_traffic  -- SUM: Adds passengers for each route
FROM city_pair                             -- FROM: Source table
WHERE EXTRACT(YEAR FROM month) NOT BETWEEN 2020 AND 2022
  AND month < '2026-01-01'                 -- Excludes incomplete 2026
GROUP BY australian_port, foreign_port, country -- Combines records by route
ORDER BY total_traffic DESC NULLS LAST     -- Highest traffic first
LIMIT 10;                                  -- Returns the top 10 routes

-- Key Finding: Sydney–Auckland was the busiest international route (20.30M passengers), followed by Sydney–Singapore (19.79M), with Singapore appearing in 4 of the top 10 routes.

-- 2.7 Annual International Passenger Arrivals vs Departures
-- Compare arrivals and departures for each year
SELECT
    EXTRACT(YEAR FROM month) AS year,           -- EXTRACT: Gets the year
    SUM(passengers_in) AS total_arrivals,       -- SUM: Adds arrivals
    SUM(passengers_out) AS total_departures,    -- SUM: Adds departures
    SUM(passengers_in) - SUM(passengers_out)
        AS passenger_difference,               -- AS: Names the difference
    ROUND(
        100.0 * (SUM(passengers_in) - SUM(passengers_out))
        / NULLIF(SUM(passengers_out), 0),
        2
    ) AS difference_pct                        -- ROUND: Percentage to 2 decimals
FROM city_pair
WHERE month < '2026-01-01'                     -- Excludes incomplete 2026
GROUP BY EXTRACT(YEAR FROM month)              -- Groups records by year
ORDER BY year;                                 -- Sorts oldest to newest

-- Key Finding: Arrivals exceeded departures in every year except 2021, when departures were 17.57% higher; by 2025, the difference had narrowed to 1.09% in favour of arrivals.


-- 3. Airline Performance Analysis
-- 3.1 Top Airlines by International Passenger Traffic
SELECT
    airline,
    SUM(passengers_in) AS total_arrivals,       -- SUM: Adds arriving passengers
    SUM(passengers_out) AS total_departures,    -- SUM: Adds departing passengers
    SUM(passengers_in) + SUM(passengers_out)
        AS total_traffic                        -- AS: Names the calculated column
FROM airlines_country
WHERE EXTRACT(YEAR FROM month) NOT BETWEEN 2020 AND 2022
  AND month < '2026-01-01'                      -- Excludes incomplete 2026
GROUP BY airline                               -- GROUP BY: Combines records by airline
ORDER BY total_traffic DESC NULLS LAST         -- Highest passenger traffic first
LIMIT 10;                                      -- Returns top 10 airlines

-- Key Finding: Qantas led international passenger traffic with 83.55M passengers, followed by Jetstar (46.40M) and Singapore Airlines (43.03M), excluding 2020–2022 and 2026.

-- 3.2 Airline Market Share Analysis
-- Calculate the top 10 airlines and their passenger market share
SELECT
    airline,
    SUM(passengers_in) + SUM(passengers_out)
        AS total_traffic,

    ROUND(
        100.0 * (SUM(passengers_in) + SUM(passengers_out))
        / SUM(SUM(passengers_in) + SUM(passengers_out)) OVER (),
        2
    ) AS market_share_pct

FROM airlines_country
WHERE EXTRACT(YEAR FROM month) NOT BETWEEN 2020 AND 2022
  AND month < '2026-01-01'
GROUP BY airline
ORDER BY total_traffic DESC NULLS LAST
LIMIT 10;

-- Key Finding: Qantas led international airline market share at 16.99%, followed by Jetstar (9.44%) and Singapore Airlines (8.75%); Qantas and Jetstar together accounted for 26.43%.


-- 4. Flight and Seat Capacity Analysis
-- 4.1 Busiest Australian Airports by International Flights
SELECT
    australian_port,
    SUM(in_flights_all) AS arriving_flights,     -- SUM: Total inbound flights
    SUM(out_flights_all) AS departing_flights,   -- SUM: Total outbound flights
    SUM(in_flights_all) + SUM(out_flights_all)
        AS total_flights
FROM flights_seats
WHERE EXTRACT(YEAR FROM month) NOT BETWEEN 2020 AND 2022
  AND month < '2026-01-01'                      -- Excludes incomplete 2026
GROUP BY australian_port                       -- Groups flights by airport
ORDER BY total_flights DESC NULLS LAST         -- Highest flight movements first
LIMIT 10;                                      -- Top 10 airports

-- Key Finding: Sydney led international flight activity with 1.28M movements, followed by Melbourne (741K), Brisbane (521K), and Perth (353K), excluding 2020–2022 and 2026.

-- 4.2 International Seat Capacity by Australian Airport
-- Calculate minimum and maximum international seat capacity
SELECT
    australian_port,
    SUM(in_seats_min + out_seats_min) AS min_seats,  -- Minimum reported capacity
    SUM(in_seats_max + out_seats_max) AS max_seats   -- Maximum reported capacity
FROM flights_seats
WHERE EXTRACT(YEAR FROM month) NOT BETWEEN 2020 AND 2022
  AND month < '2026-01-01'
GROUP BY australian_port                           -- Combines records by airport
ORDER BY max_seats DESC NULLS LAST                  -- Highest capacity first
LIMIT 10;                                           -- Top 10 airports

-- Key Finding: Sydney led international seat capacity (239.02M–360.69M seats), followed by Melbourne (141.53M–206.00M), with Adelaide ranking above Cairns despite fewer flights.

-- 4.3 Average Seat Capacity per International Flight
SELECT
    australian_port,

    ROUND(
        SUM(in_seats_min + out_seats_min)
        / NULLIF(SUM(in_flights_all + out_flights_all), 0),
        0
    ) AS avg_min_seats_per_flight,

    ROUND(
        SUM(in_seats_max + out_seats_max)
        / NULLIF(SUM(in_flights_all + out_flights_all), 0),
        0
    ) AS avg_max_seats_per_flight

FROM flights_seats
WHERE EXTRACT(YEAR FROM month) NOT BETWEEN 2020 AND 2022
  AND month < '2026-01-01'
GROUP BY australian_port
ORDER BY SUM(in_flights_all + out_flights_all) DESC NULLS LAST
LIMIT 10;

-- Key Finding: Perth had the highest estimated minimum seats per flight among the four busiest airports (224), while Sydney had the highest maximum (282).


