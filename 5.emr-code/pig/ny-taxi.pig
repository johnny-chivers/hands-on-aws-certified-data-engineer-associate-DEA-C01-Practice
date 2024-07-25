DEFINE CSVLoader org.apache.pig.piggybank.storage.CSVLoader();

NY_TAXI = LOAD '$INPUT' USING CSVLoader(',') AS
       (vendor_id:int,
       lpep_pickup_datetime:chararray,
       lpep_dropoff_datetime:chararray,
       store_and_fwd_flag:chararray,
       rate_code_id:int,
       pu_location_id:int,
       do_location_id:int,
       passenger_count:int,
       trip_distance:double,
       fare_amount:double,
       mta_tax:double,
       tip_amount:double,
       tolls_amount:double,
       ehail_fee:double,
       improvement_surcharge:double,
       total_amount:double,
       payment_type:int,
       trip_type:int);

STORE NY_TAXI into '$OUTPUT' USING PigStorage('\t');
