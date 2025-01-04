# CarSales Real-Time Data Project

## Project Overview
This project demonstrates the development of a scalable, real-time data pipeline leveraging Microsoft Azure's cloud capabilities. The pipeline is designed to efficiently handle **incremental data loads** within defined time windows, ensuring seamless data ingestion, transformation, and reporting for real-time analytics.

The solution adopts the **Medallion Architecture**, a widely recognized framework in data engineering, which organizes data into distinct layers to streamline processing and ensure data quality:

- **Bronze Layer**: Raw, unprocessed data ingested from various sources.
- **Silver Layer**: Data undergoes cleansing, validation, and transformation for intermediate analysis.
- **Gold Layer**: Fully transformed, aggregated data ready for advanced analytics and reporting.

This architecture is implemented using **Azure Data Factory (ADF)** for data ingestion and orchestration, **Azure Databricks** for advanced transformations, and **Azure Data Lake** for efficient storage. By leveraging these services, the solution ensures scalability, performance, and robust automation tailored to the CarSales domain.

---

## Data Architecture
The CarSales Real-Time Data Pipeline adopts a modern, scalable, and modular architecture, leveraging **Medallion Architecture** principles for efficient data handling. Below is a detailed breakdown:

### Data Flow Diagram
![Data Architecture Diagram](https://github.com/Adez017/CarSales-End-to-End-Project/blob/main/data%20architecture%2002.png)

---

### **Stage I: Data Ingestion**
This stage focuses on ingesting and preparing raw data for processing:

- **Data Sources**:  
  - **GitHub**: The data files are stored in a GitHub repository and fetched into the pipeline.  
  - **SQL Database**: Data from GitHub is loaded into a structured SQL database for initial staging.  

- **Technology Stack**:  
  - **Azure Data Factory (ADF)** orchestrates the flow from GitHub to SQL and into the data lake.  
  - SQL serves as the staging area, where data is consolidated before further processing.  

- **Incremental Load Mechanism**:  
  - The **stored procedure** in SQL tracks the **last successful data load timestamp**, ensuring only new or updated data is processed.  
  - **ADF Parameters** dynamically retrieve and pass the timestamp during each pipeline execution to load only the incremental data into the **Bronze Layer**.
 
  ![Pipeline Structure](https://github.com/Adez017/CarSales-End-to-End-Project/blob/main/Dynamic%20pipeline.png)

---

### **Stage II: Data Processing**
The processing layer is implemented in **Azure Databricks**, following the **Medallion Architecture** with the following layers:

#### **1. Raw Data Layer (Bronze)**  
- **Input**: Data from the SQL staging area is loaded into **Azure Data Lake Gen 2** in **Parquet format**.  
- **Purpose**: Acts as the single source of truth for raw, unprocessed data.  
- Preserves original data integrity for traceability.  

#### **2. Transformed Data Layer (Silver)**  
- **Processes**: Cleanses and validates data to remove duplicates, ensure consistency, and enforce data quality standards.  
- **Delta Lake**: Utilizes Delta Lake for ACID compliance, schema evolution, and efficient data handling.  
- **Output**: Data is standardized and stored in a **Big Table structure** for downstream processing.

#### **3. Serving Layer (Gold)**  
- **Star Schema Design**: Implements dimensional modeling optimized for analytical queries.  
- **Purpose**: Aggregates data for business reporting and visualization.  
- **Output**: Final, analytics-ready data consumed by reporting tools like **Power BI**.

---

### **Stage III: Reporting and Analytics**
- The **Gold Layer** is consumed by **Power BI** to create interactive, real-time dashboards and reports.  
- Enables **self-service analytics** for stakeholders, delivering actionable insights.  

---

## Ensuring Incremental Load

Efficient incremental data handling is critical for real-time pipeline performance. The following mechanisms are used:

1. **Data Consolidation in SQL**:  
   - Data files from **GitHub** are fetched into a **SQL staging database**, consolidating them into a structured format.  
   - SQL ensures that the data is ready for incremental processing.  

2. **Tracking Last Processed Data**:  
   - A **stored procedure** in SQL tracks the **last successful load timestamp**.  
   - During each pipeline run, this timestamp identifies and fetches only new or updated records.  

3. **Parameterization in ADF**:  
   - **ADF Pipeline parameters** dynamically pass the last load timestamp to ensure only incremental data is ingested.  
   - This eliminates redundant data processing and ensures optimal performance.  

4. **Delta Lake for Incremental Processing**:  
   - The **MERGE functionality** in Delta Lake is used for efficient upserts (inserts/updates) into the **Bronze Layer**.  
   - Delta’s transaction logs track changes, ensuring consistency and minimizing data processing overhead.  


---

## Key Features  

- **GitHub Integration**: Automates the fetching of raw data files from GitHub.  
- **SQL Staging**: Consolidates and preprocesses data before ingestion into the pipeline.  
- **Incremental Processing**: Combines stored procedures, ADF parameters, and Delta Lake for efficient incremental loads.  
- **Data Quality Assurance**: Maintains data integrity through validation and cleansing in the Silver Layer.  
- **Scalability**: Handles large datasets and supports real-time updates with ease.  

---

## Technical Stack Summary  

- **Storage**: Azure Data Lake Gen 2.  
- **Processing**: Azure Databricks and Delta Lake.  
- **Ingestion**: Azure Data Factory with GitHub and SQL database integration.  
- **Reporting**: Power BI.  
- **File Formats**: Parquet and Delta.  
- **Schema Design**: Star Schema in the Gold Layer.

---

## Performance Considerations  

- **Optimized Incremental Loads**: Ensures only new or updated data is processed, reducing latency and improving efficiency.  
- **Efficient Querying**: Star schema design and optimized indexing for analytical workloads.  
- **Parallel Processing**: Databricks enables distributed and parallel execution for faster transformations.  

---
