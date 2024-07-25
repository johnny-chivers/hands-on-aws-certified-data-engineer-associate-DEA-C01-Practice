DROP TABLE IF EXISTS ny_taxi;

CREATE EXTERNAL TABLE ny_taxi (
		vendor_id int,
    		lpep_pickup_datetime string,
    		lpep_dropoff_datetime string,
    		store_and_fwd_flag string,
    		rate_code_id smallint,
    		pu_location_id int,
    		do_location_id int,
    		passenger_count int,
    		trip_distance double,
    		fare_amount double,
    		mta_tax double,
    		tip_amount double,
    		tolls_amount double,
    		ehail_fee double,
    		improvement_surcharge double,
    		total_amount double,
    		payment_type smallint,
    		trip_type smallint
	)
	ROW FORMAT DELIMITED
	FIELDS TERMINATED BY ','
	LINES TERMINATED BY '\n'
	STORED AS TEXTFILE
	LOCATION "${INPUT}";

 INSERT OVERWRITE DIRECTORY "${OUTPUT}"
 SELECT * FROM ny_taxi WHERE rate_code_id = 1;