# Azure Data Engineer Take-Home Assignment

## Overview

In this project, I built an end-to-end data pipeline using the API provided. The pipeline follows a medallion architecture approach with Bronze, Silver, and Gold layers.

The goal was to ingest data from multiple API endpoints, clean and transform it, and finally create a structured dataset for analysis.

---

## Approach

### Bronze Layer (Ingestion)

I fetched data from all the available API endpoints such as orders, order_items, customers, products, sellers, and payments.

* Implemented pagination to handle large data
* Added retry logic for API failures (401, 429, 500)
* Stored raw data as CSV files
* Added `_ingested_at` and `_source` columns for tracking

---

### Silver Layer (Cleaning & Validation)

In this layer, I cleaned and standardized the data.

* Removed duplicate records
* Handled null values (replaced with "unknown")
* Added an `is_valid` column to track bad records
* Marked records invalid where:

  * price is negative
  * delivery date is before purchase date

---

### Gold Layer (Data Modeling)

I created a simple star schema for analysis.

* Fact table: `fact_order_items`
* Dimension tables:

  * `dim_customers`
  * `dim_products`
  * `dim_sellers`

I joined the required tables and generated surrogate keys using categorical encoding.

---

## SQL Analysis

### Query 1

Calculated monthly revenue and ranked products within each month.

### Query 2 (Optional)

Created a basic seller performance summary using total orders and revenue.

---

## Error Handling

* Handled token expiration by re-authenticating
* Added retry logic for API errors
* Ensured safe file writes by creating directories if not present

---

## Assumptions

* Missing values are replaced with "unknown"
* Missing payment values are treated as 0
* Invalid records are flagged instead of removed

---

## Improvements

If I had more time, I would:

* Use PySpark instead of Pandas for better scalability
* Add orchestration using Airflow
* Implement incremental data loading
* Deploy on Azure services (ADF / Fabric)
* Add logging and monitoring

---

## Summary

This project demonstrates a basic but complete data pipeline from ingestion to analytics using a structured approach. I focused on keeping the solution simple, readable, and reliable.


Output files are not committed as the pipeline dynamically fetches data from the API.