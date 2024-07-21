# Hands On AWS Certified Data Engineer - Associate (DEA-C01) Practice 

# Contents 

# Introduction 

# Setup

The set-code.yaml contains code to be executed using Amazon CloudFormation. The code creates the base networking artefacts and S3 Bucket required to complete the remaining sections of the course. The S3 Bucket will require a name which is globally unique to AWS to be entered before executing the stack. 

The following artefacts are created by the code; 
- VPC 
- Two public Subnets 
- Security Groups 
- Routing Table 
- S3 Bucket

After the code has been executed the following steps need to be executed on the console. 

1. Create a `rawData` data folder in the S3 bucket.  
2. Create a `processedData` folder in the S3 bucket.
3. Create a `scriptLocation` folder in the S3 bucket.
4. Create a `tmpDir` folder in the S3 bucket.
5. Create a `athena` folder in the S3 bucket.
6. Upload source data into the `rawData` folder maintaining folder structure of customers, employees, and orders, .  

The S3 bucket should have the follow structure once set up; 

```
└── S3-Bucket-Name
    ├── athena
    ├── processedData
    ├── rawData
    │   ├── customers 
    │   │   └──  customers.csv 
    │   ├── employees 
    │   │   └──  employees.csv 
    │   └── orders
    │       └── orders.csv 
    ├── scriptLocation    
    └──  tmpDir
```

# AWS Glue 

## AWS Glue Introduction

AWS Glue is a serverless data integration service that makes it easier to discover, prepare, and combine data for analytics, machine learning (ML), and application development. AWS Glue provides all the capabilities needed for data integration, so you can start analyzing your data and putting it to use in minutes instead of months. AWS Glue provides both visual and code-based interfaces to make data integration easier. Users can more easily find and access data using the AWS Glue Data Catalog. Data engineers and ETL (extract, transform, and load) developers can visually create, run, and monitor ETL workflows in a few steps in AWS Glue Studio. Data analysts and data scientists can use AWS Glue DataBrew to visually enrich, clean, and normalize data without writing code.

In this section we will learn how to register data in the [Glue Data Catalog](#AWS-Glue-Data-Catalog) so we can perform ETL on the raw data that we uploaded in the [set up section](#setup). We will use Glue Visual ETL editor to create an script which will be executed on demand, and via a schedule, from the AWS Glue console. 

## Data
Below is the schema for the table that wil be created in the Glue Data Catalog which includes a sample of the data.

**Customers**
| Customerid      | Firstname | Lastname| Fullname |
| ----------- | ----------- |-----------|-----------|
|  293 | Catherine                | Abel                   | Catherine Abel                 |
|  295 | Kim                      | Abercrombie            | Kim Abercrombie                |
|  297 | Humberto                 | Acevedo                | Humberto Acevedo               |

## AWS Glue Data Catalog 

The AWS Glue Data Catalog is your persistent technical metadata store. It is a managed service that you can use to store, annotate, and share metadata in the AWS Cloud.

In this section we will catalog the data we uplaoded to S3 during the setup stage. 

The accompanying youtube video details what the Glue Data Catalog is. 

## Glue Crawler 
You can use an AWS Glue crawler to populate the AWS Glue Data Catalog with databases and tables. This is the primary method used by most AWS Glue users. A crawler can crawl multiple data stores in a single run. Upon completion, the crawler creates or updates one or more tables in your Data Catalog. Extract, transform, and load (ETL) jobs that you define in AWS Glue use these Data Catalog tables as sources and targets. The ETL job reads from and writes to the data stores that are specified in the source and target Data Catalog tables.

The accompanying youtube video details how this can be done. 

## Adding Databases and Tables Manually Through The AWS Console

The accompanying youtube video details how databases and tables can be manually added to the AWS Glue Data Catalog. 

## AWS Glue Connections

A Data Catalog object that contains the properties that are required to connect to a particular data store. Glue Connections can be used to connect to RDS, Redshift, S3, and other datastores. The connections can be used repeatedly throughout ETL code to avoid hard coding connection string details into scripts. 

## AWS Glue ETL 
An AWS Glue job encapsulates a script that connects to your source data, processes it, and then writes it out to your data target. Typically, a job runs extract, transform, and load (ETL) scripts. Jobs can run scripts designed for Apache Spark and Ray runtime environments. Jobs can also run general-purpose Python scripts (Python shell jobs.) AWS Glue triggers can start jobs based on a schedule or event, or on demand. You can monitor job runs to understand runtime metrics such as completion status, duration, and start time.

You can use scripts that AWS Glue generates or you can provide your own. With a source schema and target location or schema, the AWS Glue Studio code generator can automatically create an Apache Spark API (PySpark) script. You can use this script as a starting point and edit it to meet your goals.

AWS Glue can write output files in several data formats. Each job type may support different output formats. For some data formats, common compression formats can be written.

In this section of the accompaning video we will look at how we can author an ETL scipt using the visual editor on the AWS Glue Console. 

## Scheduling An AWS Glue Job 

### AWS Glue Scheduler 
The AWS Glue Scheduler initiates an ELT job. Triggers can be defined based on a scheduled time or event. 

In this section of the accompaning video we will look at how we can schedule jobs use the AWS Glue Scheduler. 

### AWS Glue Workflows 
AWS Glue Workflows is an orchestration tool involving multiple crawlers, jobs and triggers. Each workflow manages the execution and monitoring of all its jobs and crawlers. A workflow runs each component, it records execution progress and status. This provides you with an overview of the larger task and the details of each step.

In this section of the accompaning video we will look at how we can schedule jobs use AWS Glue Workflows. 

### Other Methods of Scheduling a Glue Job

#### Managed Workflows For Apache Airflow 
Amazon Managed Workflows for Apache Airflow is a managed orchestration service for Apache Airflow that you can use to setup and operate data pipelines in the cloud at scale. Apache Airflow is an open-source tool used to programmatically author, schedule, and monitor sequences of processes and tasks referred to as workflows. With Amazon MWAA, you can use Apache Airflow and Python to create workflows without having to manage the underlying infrastructure for scalability, availability, and security. Amazon MWAA automatically scales its workflow execution capacity to meet your needs, Amazon MWAA integrates with AWS security services to help provide you with fast and secure access to your data.

You will be expected to know how MWAA can be used to schedule AWS Glue and other aws services. 

#### AWS Step Functions 
Step Functions is a visual workflow service that helps developers use AWS services to build distributed applications, automate processes, orchestrate microservices, and create data and machine learning (ML) pipelines. https://docs.aws.amazon.com/step-functions/latest/dg/connect-glue.html

You will be expected to know how AWS Step Functions  can be used to schedule AWS Glue and other aws services. 

#### Amazon Event Bridge 
EventBridge is a serverless service that uses events to connect application components together, making it easier for you to build scalable event-driven applications. Event-driven architecture is a style of building loosely-coupled software systems that work together by emitting and responding to events. Event-driven architecture can help you boost agility and build reliable, scalable applications.

Use EventBridge to route events from sources such as home-grown applications, AWS services, and third-party software to consumer applications across your organization. EventBridge provides simple and consistent ways to ingest, filter, transform, and deliver events so you can build applications quickly.

https://aws.amazon.com/about-aws/whats-new/2021/07/announcing-availability-event-driven-workflows-aws-glue-amazon-eventbridge/

You will be expected to know how Amazon Event Bridge can be used to schedule AWS Glue and other aws services. 

## AWS Glue Data Quality 

AWS Glue Data Quality allows you to measure and monitor the quality of your data so that you can make good business decisions. Built on top of the open-source DeeQu framework, AWS Glue Data Quality provides a managed, serverless experience. AWS Glue Data Quality works with Data Quality Definition Language (DQDL), which is a domain specific language that you use to define data quality rules.

In this section of the youtube video we cover things you may need to know Amazon Glue Data Brew do for the AWS Certified Data Engineer - Associate (DEA-C01). We will use the data we have registered in the Glue Data Catalog to build our own Glue Data Qaulity Rules. 

## AWS Glue Data Brew 

AWS Glue DataBrew is a visual data preparation tool that makes it easier for data analysts and data scientists to clean and normalize data to prepare it for analytics and machine learning (ML). You can choose from over 250 prebuilt transformations to automate data preparation tasks, all without the need to write any code. You can automate filtering anomalies, converting data to standard formats and correcting invalid values, and other tasks. 

In this section of the youtube video we cover things you may need to know Amazon Glue Data Brew do for the AWS Certified Data Engineer - Associate (DEA-C01). We will use the data we have registered in the Glue Data Catalog and explore it using AWS Glue Data Brew. 

## Other AWS Glue Things you should Know

In this section of the youtube video we cover other things you may need to know about AWS Glue for the AWS Certified Data Engineer - Associate (DEA-C01). 

Glue Bookmarks tracks data that has already been processed during a previous run of an ETL job by persisting state information from the job run. This persisted state information is called a job bookmark. 

A single standard DPU provides 4 vCPU and 16 GB of memory whereas a high-memory DPU (M-DPU) provides 4 vCPU and 32 GB of memory.

# Amazon Athena 

## Amazon Athena Introduction
Amazon Athena is a serverless, interactive analytics service built on open-source frameworks, supporting open-table and file formats. Athena provides a simplified, flexible way to analyze petabytes of data where it lives. Analyze data or build applications from an Amazon Simple Storage Service (S3) data lake and 30 data sources, including on-premises data sources or other cloud systems using SQL or Python. Athena is built on open-source Trino and Presto engines and Apache Spark frameworks, with no provisioning or configuration effort required.

As part of the exam you will have to know some basic SQL functuions which will be covered in this section. 

## Data
Below are the schemas for the tables that wil be created in the Glue Data Catalog. They also include a small sample of data to aid the explaination of the coding syntax.

**Customers**
| Customerid      | Firstname | Lastname| Fullname |
| ----------- | ----------- |-----------|-----------|
|  293 | Catherine                | Abel                   | Catherine Abel                 |
|  295 | Kim                      | Abercrombie            | Kim Abercrombie                |
|  297 | Humberto                 | Acevedo                | Humberto Acevedo               |

**Orders**

|  SalesOrderID |  SalesOrderDetailID |  OrderDate |  DueDate  | ShipDate | EmployeeID | CustomerID | SubTotal | TaxAmt | Freight | TotalDue | ProductID | OrderQty | UnitPrice | UnitPriceDiscount | LineTotal |
|---------------|---------------|---------------|---------------|---------------|---------------|---------------|---------------|---------------|---------------|---------------|---------------|---------------|---------------|---------------|---------------|
| 71782 | 110667 | 5/1/2014   | 5/13/2014  | 5/8/2014  | 276 |  293 |   33319.986 |  3182.8264 |  994.6333 | 37497.4457 | 714 |  3 |    29.994 |    0 |      89.982 |
| 44110 |   1732 | 8/1/2011   | 8/13/2011  | 8/8/2011  | 277 |  295 |  16667.3077 |  1600.6864 |  500.2145 |  18768.2086 | 765 |  2 |  419.4589 |    0 |    838.9178 |
| 44131 |   2005 | 8/1/2011   | 8/13/2011  | 8/8/2011  | 275 |  297 |  20514.2859 |  1966.5222 |  614.5382 |  23095.3463 | 709 |  6 |       5.7 |    0 |        34.2 |

**Employees**

| EmployeeID | ManagerID | FirstName | LastName | FullName  | JobTitle | OrganizationLevel | MaritalStatus  | Gender | Territory | Country | Group |      
|------------|------------|------------|------------|------------|------------|------------|------------|------------|------------|------------|------------|
| 276 |  274 | Linda   | Mitchell          | Linda Mitchell           | Sales Representative         | 3 | M | F | Southwest      | US   | North America |
| 277 |  274 | Jillian | Carson            | Jillian Carson           | Sales Representative         | 3 | S | F | Central        | US   | North America |
| 275 |  274 | Michael | Blythe            | Michael Blythe           | Sales Representative         | 3 | S | M | Northeast      | US   | North America |

## Set Up 
1. We will use three data sets uploaded in the main setup section
2. Run the athena.yaml script in Cloudformation. Athena will need a location to store results in S3. We Will use the `athena` folder created in the initial setup which we will enter as a results location when running the Cloudformation script. 
3. We will create a new databse in the Athena Query editor to use. 
```
CREATE DATABASE demo_data; 
```

## Main Tutorial 
1. Create Customer Table
```
CREATE EXTERNAL TABLE IF NOT EXISTS customers(
  customerid BIGINT, 
  fistname STRING,
  lastname STRING,
  fullname STRING
  )
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
STORED AS TEXTFILE
LOCATION 's3://table-data-location/'; 
```
2. Select all rows from cusomters table 
```
SELECT * FROM customers;
```
3. select a column from customer table 
```
SELECT Firstname FROM customers;
```
4. column alais 
```
SELECT Firstname as f_name FROM customers;
```
5. Concat two columns of the same data type and alais 
```
SELECT CONCAT(firstname,lastname) AS full_name FROM customer;
```
6. Use a WHERE clause to filter data 
```
SELECT Firstname FROM customers WHERE firstname = 'John' ;
```
7. Use an AND/OR clause to filter data 
```
SELECT * FROM customers WHERE firstname = 'John'  AND lastname = 'Arthur';

SELECT * FROM customers WHERE firstname = 'John' or lastname = 'Arthur';
```
8. Use an in clause to filter data 
```
SELECT * FROM customers WHERE Customerid in (371) 

SELECT * FROM customers WHERE Customerid in (371, 377);
```
9.  Wild Cards
```
SELECT * FROM customers WHERE Fullname like 'J%'; 
```
10. Union 
```
SELECT Firstname FROM customers WHERE Customerid in (371) 
UNION
SELECT Firstname FROM customers WHERE Customerid in (371, 377);
```
11. INSERT A ROW
```
INSERT INTO customers (customerid, firstname, lastname, fullname) values (1221,'John', 'Doe', 'John Doe'); 
```
12. DISTINCT 
```
SELECT DISTINCT firstname FROM customers WHERE firstname like 'J%';
```
13. COUNT 
```
SELECT count(firstname) FROM customers WHERE firstname like 'J%';
```
14. COUNT DISTINCT
```
SELECT count(DISTINCT firstname) FROM customers WHERE firstname like 'J%';
```
15. GROUP BY 
```
SELECT firstname FROM customers WHERE firstname like 'J%' group by firstname;
```
16. NESTED QUERIES
```
SELECT * FROM customers WHERE customerid in (SELECT customerid from customers);
```
17. COMMON TABLE EXPRESSIONS (cte's)
```
with cte as 
(
SELECT firstname, lastname, CONCAT(firstname,' ',lastname)
FROM customers
)
SELECT * 
FROM customers; 
```
18. INNER JOIN
```
CREATE EXTERNAL TABLE IF NOT EXISTS employees(
employeeid  bigint,
managerid bigint,
firstname string,
lastname string , 
fullname  string,
jobtitle string,    
organizationlevel int   , 
maritalstatus string, 
gender string,
territory string,
country string,
group string 
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
STORED AS TEXTFILE
LOCATION 's3://table-data-location/'; 
```
```
CREATE EXTERNAL TABLE IF NOT EXISTS orders(
salesorderid bigint,
salesorderdetailid int,
orderdate string,
duedate string,
shipdate string,
employeeid bigint,
customerid bigint,
subtotal decimal(17,4),
taxamt decimal(17,4),
freight decimal(17,4),
totaldue decimal(17,4),
productid  int,
orderqty int,
unitprice decimal(17,4),
unitpricediscount decimal(17,4),
linetotal decimal(17,4)
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
STORED AS TEXTFILE
LOCATION 's3://table-data-location/'; 
```
```
SELECT * FROM customers INNER JOIN orders on customers.customerid = orders.customerid; 
```
19. LEFT JOIN 
```
SELECT * FROM order LEFT JOIN customers on customers.customerid = orders.customerid; 
```

# Amazon Redshift

## Amazon Redshift Intro and Architecture 
Amazon Redshift is a fast, fully managed, petabyte-scale data warehouse service that makes it simple and cost-effective to efficiently analyze all your data using your existing business intelligence tools. It is optimized for datasets ranging from a few hundred gigabytes to a petabyte or more and costs less than $1,000 per terabyte per year, a tenth the cost of most traditional data warehousing solutions.

Amazon Redshift is designed for Online Analytical Processing (OLTP) workloads and can give up to 10x better performance than other data warehousing solutions by scaling up/down on demand with built in replication and backups. Amazon Redshift can be queried using Structured Query Language (SQL) using the online query editor via the AWS console and/or your own preferred client using JDBC and ODBC. Amazon Redshift can be monitored through Amazon Cloudwatch and Amazon Cloudtrail. 

Common Usecases; 

- Analytical workloads 
- Unifying Data Warehouse 
- Stock Analysis 
- Gaming Data 
- Social Trends 

## Amazon Redshift Theory 

### Amazon Redshift Durability and Scaling 
Data is replicated within an Amazon Redshift Cluster making it highly durable and can also be backed up to S3 with automated snapshots. This S3 snapshot can also be asynchronously replicated to another AWS regions for disaster recovery. A Redshift cluster is limited to a single AZ, except when running on the RA3 instance type. 

Amazon Redshift can be scaled both horizontally and vertically. There are 3 main way to resize a redshift cluster. 

1/ Elastic Resizing. This quickly adds or removes nodes of the same instance type from a Amazon Redshift cluster. Typically a cluster is only down for a few minutes during this resizing operation and Amazon Redshift attempts to maintain open connections. The number of nodes present in a cluster for some DC2 and RA2 node types can only be doubled/halved. 

2/ Classic Resize. This allows for both a change in instance type (vertical scaling) and a change in overall node count (horizontal scaling). This process can take several hours and even days. During this time the cluster is only available in read only mode. 

3/ Snapshot and Restore. In order to keep your cluster available a user can take a snapshot of the cluster and restore this to a new cluster which is configured the same as this existing cluster. All traffic can then be sent to the new Amazon Redshift cluster. A classic resize can then be executed on the original cluster which will enter a read only mode. Once the resize is complete traffic can be switched back to the original cluster which has now been successfully resized. The second cluster can be span down. 

### Amazon Redshift Key Distribution 
When a table is created in Amazon Redshift there are four possible row distribution styles to be designated from; Auto, Even, Key, All. Each distribution style has its advantages and disadvantages, therefore careful consideration should be given. 

1/ AUTO distribution. Amazon Redshift assigns the optimal distribution style for the table and will change this overtime based on the nature of the data which is being ingested into the table. For example, if a small number of rows are ingested at when the table is initially created then Amazon Redshift may use the ALL distribution style. Overtime as the volume of data, and rows, in the table increases Amazon Redshift may change the distribution style to Key or Even. Amazon Redshift implements this change in the background with minimal impact to user queries. 

2/ EVEN distribution. The rows are distributed across the slices in a round robin fashion regardless of any values stored in the columns. This is an appropriate choice when the table does not participate in joins, or there is no clear choice between KEY and ALL distributions. 

3/ KEY distribution. The rows are distributed according to the values in one column. Column which contain the same value are placed on the same slice and are stored together physically on disk. KEY distribution should be chosen when a table is not small and is used to perform joins. 

4/ ALL distribution. The table is copied in full to every node of the Amazon Redshift cluster. This should be used when the data in tables is slow moving, as it takes significantly longer to load, update, and insert data into a table which has the ALL distribution applied. ALL distribution ensures that all the table data is collated on a single node for joins. 

### Redshift Data Ingest/Export and Copy/Unload Command 
The COPY command is the most common way to ingest data into Amazon Redshift as it can load data using parallelisation. The COPY command loads data into a table from data files or from an Amazon DynamoDB table. The files can be located in an Amazon Simple Storage Service (Amazon S3) bucket, an Amazon EMR cluster, or a remote host that is accessed using a Secure Shell (SSH) connection. The COPY command can decrypt the data and unzip files when loading into tables. The COPY Command will also automatically compress the data as it is stored on Amazon Redshift. The parallelisation functionality allows the COPY command to ingest large volumes of data into a Redshift Table by loading multiple files at once. N.B. When a table is narrow, i.e. consists of limit columns, but has a large volume of rows a single COPY command should be issued to load the data and parallelisation should be ignored. 
```
COPY table-name 
[ column-list ]
FROM data_source
authorization
[ [ FORMAT ] [ AS ] data_format ] 
[ parameter [ argument ] [, ... ] ]
```
Data can be automatically ingested from S3 using the Auto Copy from S3 feature. A COPY command is triggered when a new file is added to S3 automating the ingest process. 

Zero ETL from Aurora RDS to Amazon Redshift removes the need for a user to create and maintain ETL pipelines. Data is automatically ingested from Aurora to Amazon Redshift without the use of any self managed ETL infrastructure. 

Data can also be streamed into Amazon Redshift from Amazon Kinesis and Amazon MSK. 

Data can also be copied from Amazon Redshift Cluster in one region to an Amazon Redshift Cluster in a different region. (N.B. This comes up on the exam a lot - you should know the process to carry this out). 1/ Create a KMS key in the destination region. 2/ Specify a unique name for your snapshot copy grant in the destination region. 3/ Specify the KMS Key ID for which you are creating for the Copy grant in your destination region. 4/ In the source region enable copying of snapshots to the copy grant you just created. 

Data can be exported from Amazon Redshift using the UNLOAD command. The command unloads the result of a query to one or more text, JSON, or Apache Parquet files on Amazon S3, using Amazon S3 server-side encryption (SSE-S3). You can also specify server-side encryption with an AWS Key Management Service key (SSE-KMS) or client-side encryption with a customer managed key.
```
UNLOAD ('select-statement')
TO 's3://object-path/name-prefix'
authorization
[ option, ...] 

where authorization is
IAM_ROLE { default | 'arn:aws:iam::<AWS account-id-1>:role/<role-name>[,arn:aws:iam::<AWS account-id-2>:role/<role-name>][,...]' }
            
where option is
| [ FORMAT [ AS ] ] CSV | PARQUET | JSON
| PARTITION BY ( column_name [, ... ] ) [ INCLUDE ]
| MANIFEST [ VERBOSE ]
| HEADER
| DELIMITER [ AS ] 'delimiter-char'
| FIXEDWIDTH [ AS ] 'fixedwidth-spec'
| ENCRYPTED [ AUTO ]
| BZIP2
| GZIP
| ZSTD
| ADDQUOTES
| NULL [ AS ] 'null-string'
| ESCAPE
| ALLOWOVERWRITE
| CLEANPATH
| PARALLEL [ { ON | TRUE } | { OFF | FALSE } ]
| MAXFILESIZE [AS] max-size [ MB | GB ]
| ROWGROUPSIZE [AS] size [ MB | GB ]
| REGION [AS] 'aws-region' }
| EXTENSION 'extension-name'

```

### Redshift Integrations
Redshift integrates with other AWS services such as S3, DynamoDB, EMR, and EC2. 

### Redshift Vacuum
The Amazon Redshift Vacuum command recovers space from deleted rows. There are four Vacuum commands. 

1/ Vacuum Full. This command recovers space from deleted rows and resorts the rows.  
2/Vacuum Delete Only. This command recovers space from delete rows only. 
3/ Vacuum Sort Only. This command resorts rows only. 
4/ Vacuum ReIndex. Sorts Key columns from an index. 


### Redshift Workload Management (WLM) 
Amazon Redshift workload management (WLM) enables users to flexibly manage priorities within workloads so that short, fast-running queries won't get stuck in queues behind long-running queries.

When users run queries in Amazon Redshift, the queries are routed to query queues. Each query queue contains a number of query slots. Each queue is allocated a portion of the cluster's available memory. A queue's memory is divided among the queue's query slots. You can enable Amazon Redshift to manage query concurrency with automatic WLM or manually configure WLM. 

Automatic WLM determines the amount of resources that queries need and adjusts the concurrency based on the workload. When queries requiring large amounts of resources are in the system (for example, hash joins between large tables), the concurrency is lower. When lighter queries (such as inserts, deletes, scans, or simple aggregations) are submitted, concurrency is higher. Up to 8 queues can be created and fof each queue Priority, Concurrency scaling mode, User groups, Query groups, and Query monitoring rules can be configured. Automatic WLM is the recommended approach over Manual WLM. 

Manual Workload Management has one default queue with a concurrency level of 5 and super user queue with a currency level of 1. Up to 8 queues can be defined with a maximum concurrency level of 50. With manual WLM, a user specifies the way that memory is allocated among slots and how queries can be routed to specific queues at runtime. You can also configure WLM properties to cancel long-running queries.

Short query acceleration (SQA) prioritizes selected short-running queries ahead of longer-running queries. SQA runs short-running queries in a dedicated space, so that SQA queries aren't forced to wait in queues behind longer queries. SQA only prioritizes queries that are short-running and are in a user-defined queue. With SQA, short-running queries begin running more quickly and users see results sooner.

If you enable SQA, you can reduce workload management (WLM) queues that are dedicated to running short queries. In addition, long-running queries don't need to contend with short queries for slots in a queue, so you can configure your WLM queues to use fewer query slots. When you use lower concurrency, query throughput is increased and overall system performance is improved for most workloads.SQA works with Create Tables as (CTAS), read only queries, uses machine learning to predict query execution time and can config short in seconds. 

Concurrency Scaling feature, you can support thousands of concurrent users and concurrent queries, with consistently fast query performance. When you turn on concurrency scaling, Amazon Redshift automatically adds additional cluster capacity to process an increase in both read and write queries. Users see the most current data, whether the queries run on the main cluster or a concurrency-scaling cluster.You can manage which queries are sent to the concurrency-scaling cluster by configuring WLM queues. When you turn on concurrency scaling, eligible queries are sent to the concurrency-scaling cluster instead of waiting in a queue.


### RA3 Nodes
RA3 nodes allow for compute to be independently scaled from storage. As a result, a user can scale the  number of nodes based on performance requirements, and only pay for the managed storage that is used. This gives the flexibility to size your RA3 cluster based on the amount of data you process daily without increasing your storage costs.

### Redshift Machine Learning 
Machine learning models can be created by issuing SQL commands. This is a managed feature which can be used to create, train, and deploy machine learning models in Amazon SageMaker from the Amazon Redshift Data Warehouse. 

### Redshift Data Sharing / Data Shares
Amazon Redshift Data Sharing allows for access to live data across Amazon Redshift Clusters, Workgroups, AWS accounts and AWS Regions without manually moving or copying the data. This removes the need for complicated ETL pipelines. This is done via a producer/consumer architecture where the producer controls access to the datashare and the consumer pays for the charges related to consuming the data. To share data the cluster must use the RA3 node type. 

### Redshift Lambda UDF 
Amazon Redshift allows the use of custom AWS Lambda Function inside SQL syntax. Scalar Lambda functions can be wrote in the support languages such as; Java, Go, PowerShell, Node.js, C#, Python, and Ruby. Redshift must have permission to invoke these lambda functions, and there may be additional charges when invoking a lambda function. 

Example SQL code for invoking a Lambda function for Amazon Redshift. 
```
SELECT a, b FROM t1 WHERE lambda_multiply(a, b) = 64; SELECT a, b FROM t1 WHERE a*b = lambda_multiply(2, 32)
```

### Redshift Federated Queries
Amazon Redshift Redshift Queries allow your Redshift Cluster to access data from Amazon RDS instances. This is done by creating an external schema in Amazon Redshift which is a representation of the schema in the RDS database. Amazon Redshift can then access the data stored in the RDS instance by using credentials stored in Amazon Secrets Manager. 

Below is an example of how to connect to an Amazon PostgreSQL Aurora database. 
```
CREATE EXTERNAL SCHEMA apg
FROM POSTGRES
DATABASE 'database-1' SCHEMA 'myschema'
URI 'endpoint to aurora hostname'
IAM_ROLE 'arn:aws:iam::123456789012:role/Redshift-SecretsManager-RO'
SECRET_ARN 'arn:aws:secretsmanager:us-west-2:123456789012:secret:federation/test/dataplane-apg-creds-YbVKQw';
```

### Redshift System Tables and System Views
Amazon Redshift has many system tables and views that contain information about how the system is functioning. You can query these system tables and views the same way that you would query any other database tables

Types of system tables and views; 

- SVV views contain information about database objects with references to transient STV tables.
- SYS views are used to monitor query and workload usage for provisioned clusters and serverless workgroups.
- STL views are generated from logs that have been persisted to disk to provide a history of the system.
- STV tables are virtual system tables that contain snapshots of the current system data. They are based on transient in-memory data and are not persisted to disk-based logs or regular tables.
- SVCS views provide details about queries on both the main and concurrency scaling clusters.
- SVL views provide details about queries on main clusters.

Example of access a system table
```
select * from stv_exec_state
where currenttime > (select max(currenttime) from stv_exec_state)
```

### Redshift Serverless
Amazon Redshift Serverless runs your workloads without the need to provision the underlying servers. Redshift Severless automatically scales for your workloads without the need for human interaction using machine learning to maintain performance. Redshift Severless makes it easy to provision development and test environments. As there is no severs, resource scaling is based on Redshift Processing Units (RPUs). There are no WLM or public endpoints available on Redshift Severless. 

### Redshift Spectrum 
Amazon Redshift Spectrum allows data which is held in S3 to be queried by dedicated Amazon Redshift server which are independent of your Amazon Redshift cluster. The AWS Glue Data Catalog can be used to register data which is stored in S3 as external tables. Tables can be created in the AWS Glue Data Catalog directly from Amazon Redshift using Data Definition Language (DDL) commands as well as any other toolset which can connect to the AWS Glue Data Catalog. 

## Redshift Tutorial 

### Data
Below are the schemas for the tables that wil be created in Amazon Reshift. They also include a small sample of data to aid the explaination of the coding syntax.

**Customers**
| Customerid      | Firstname | Lastname| Fullname |
| ----------- | ----------- |-----------|-----------|
|  293 | Catherine                | Abel                   | Catherine Abel                 |
|  295 | Kim                      | Abercrombie            | Kim Abercrombie                |
|  297 | Humberto                 | Acevedo                | Humberto Acevedo               |

**Orders**

|  SalesOrderID |  SalesOrderDetailID |  OrderDate |  DueDate  | ShipDate | EmployeeID | CustomerID | SubTotal | TaxAmt | Freight | TotalDue | ProductID | OrderQty | UnitPrice | UnitPriceDiscount | LineTotal |
|---------------|---------------|---------------|---------------|---------------|---------------|---------------|---------------|---------------|---------------|---------------|---------------|---------------|---------------|---------------|---------------|
| 71782 | 110667 | 5/1/2014   | 5/13/2014  | 5/8/2014  | 276 |  293 |   33319.986 |  3182.8264 |  994.6333 | 37497.4457 | 714 |  3 |    29.994 |    0 |      89.982 |
| 44110 |   1732 | 8/1/2011   | 8/13/2011  | 8/8/2011  | 277 |  295 |  16667.3077 |  1600.6864 |  500.2145 |  18768.2086 | 765 |  2 |  419.4589 |    0 |    838.9178 |
| 44131 |   2005 | 8/1/2011   | 8/13/2011  | 8/8/2011  | 275 |  297 |  20514.2859 |  1966.5222 |  614.5382 |  23095.3463 | 709 |  6 |       5.7 |    0 |        34.2 |

**Employees**

| EmployeeID | ManagerID | FirstName | LastName | FullName  | JobTitle | OrganizationLevel | MaritalStatus  | Gender | Territory | Country | Group |      
|------------|------------|------------|------------|------------|------------|------------|------------|------------|------------|------------|------------|
| 276 |  274 | Linda   | Mitchell          | Linda Mitchell           | Sales Representative         | 3 | M | F | Southwest      | US   | North America |
| 277 |  274 | Jillian | Carson            | Jillian Carson           | Sales Representative         | 3 | S | F | Central        | US   | North America |
| 275 |  274 | Michael | Blythe            | Michael Blythe           | Sales Representative         | 3 | S | M | Northeast      | US   | North America |


### Redshift Tutorial Set Up 

The Cloudformation script located in the 4.redshift-code directory will spin up all the resources required for this tutorial. This includes a dc2.large type instance at a cost of ~$0.30 an hour. Therefore, dependant on your AWS account and configurations a cost may be incurred. The S3 bucket which was created during the setup-code executiom will be altered to allow Public Access. This is in order for Amazon Redshift to read and load the data from S3. You should deny public access again once the loading is completed. 

Below details the steps taken in the youtube video to set up the resouces for the Amazon Redshift Tutorial. 

1. Run Cloudformation template redshift-cluster.yaml 
2. Allow Public Access to S3 bucket 
3. Add bucket Policy with Updates 
```
  {
	"Version": "2012-10-17",
	"Statement": [
		{
			"Sid": "PublicAccessList",
			"Principal": "*",
			"Effect": "Allow",
			"Action": [
				"s3:ListBucket",
				"s3:GetObject"
			],
			"Resource": [
			    "arn:aws:s3:::<BUCKET-NAME>/*" 
			    ,"arn:aws:s3:::<BUCKET-NAME>"
			    ]
		}
	]
}
  ```
### Create Tables 
The code below will create the three redshift tables we will use in this redshift tutorial. They use the data which we uploaded to S3 during the setup process. 

DDL to create the customers table. 
```
CREATE TABLE public.customers (
    customerid integer NOT NULL ENCODE az64,
    firstname character varying(256) ENCODE lzo,
    lastname character varying(256) ENCODE lzo,
    fullname character varying(256) ENCODE lzo,
    PRIMARY KEY (customerid)
)
DISTSTYLE AUTO;
```
DDL to create the employees table
```
CREATE TABLE public.employees (
    employeeid integer NOT NULL ENCODE az64,
    managerid integer ENCODE az64,
    firstname character varying(256) ENCODE lzo,
    lastname character varying(256) ENCODE lzo,
    fullname character varying(256) ENCODE lzo,
    jobtitle character varying(256) ENCODE lzo,
    organizationlevel integer ENCODE az64,
    maritalstatus character varying(256) ENCODE lzo,
    gender character varying(256) ENCODE lzo,
    territory character varying(256) ENCODE lzo,
    country character varying(256) ENCODE lzo,
    "group" character varying(256) ENCODE lzo,
    PRIMARY KEY (employeeid)
) DISTSTYLE AUTO;
```
DDL Code to create the orders table
```
CREATE TABLE public.orders (
    salesorderid integer NOT NULL ENCODE az64,
    salesorderdetailid integer ENCODE az64,
    orderdate  character varying(256) ENCODE lzo,
    duedate  character varying(256) ENCODE lzo,
    shipdate  character varying(256) ENCODE lzo,
    employeeid integer ENCODE az64,
    customerid integer ENCODE az64,
    subtotal double precision ENCODE raw,
    taxamt double precision ENCODE raw,
    freight double precision ENCODE raw,
    totaldue double precision ENCODE raw,
    productid integer ENCODE az64,
    qrderqty integer ENCODE az64,
    unitprice double precision ENCODE raw,
    unitpricediscount real ENCODE raw,
    linetotal double precision ENCODE raw,
    PRIMARY KEY (salesorderid)
) DISTSTYLE AUTO;

```

### Load Data and Copy Comand 

The below command is the blue print on how to load data from S3 to Amazon Redhshift tables. In the youtube video I will demostrate how to load the data through the Amazon RedShift UI and also via the copy comand below. 
```
COPY dev.public.<redshift-table-name> FROM '<s3-location-of-data>' 
IAM_ROLE '<arn-of-IAM-role>' FORMAT AS CSV DELIMITER ',' QUOTE '"' IGNOREHEADER 1 REGION AS 'eu-west-1'; 
```
### Select From Tables 

Select from Customers Table
```
SELECT * FROM public.customers;
```
Select From Employees Table 
```
SELECT * FROM public.employees;
```
Select from Orders Table
```
SELECT * FROM public.orders; 
```

### Joins 
```
SELECT
        customers.customerid
        ,orders.salesorderid
 FROM customers 
 INNER JOIN orders  on customers.customerID = orders.customerID ;
```

### Create Materialised View 
```
CREATE MATERIALIZED VIEW mv_customer_order
as 
SELECT
        customers.customerid
        ,orders.salesorderid
 FROM customers 
 INNER JOIN orders  on customers.customerID = orders.customerID ; 
```
### System Tables
Use the SVL_QUERY_SUMMARY view to find general information about the execution of a query.
```
select * from svl_query_summary;
```
You can retrieve data about Amazon Redshift database users with the SVL_USER_INFO view.
```
SELECT * FROM SVL_USER_INFO;
```

### Vacumm Comand
Re-sorts rows and reclaims space in either a specified table or all tables in the current database. Amazon Redshift automatically sorts data and runs VACUUM DELETE in the background. This lessens the need to run the VACUUM command. 
```
VACUUM FULL; 
```

# AWS EMR 

## AWS Lambda 

## AWS Data Pipeline 

## Amazon Kinesis

## Amazon OpenSearch

## Containers 

## Storage 

## Migration and Transfer 

## AWS SNS and SQS Appflow and Event bridge: Application integration 

## Amazon SageMaker For Data Analytics  