# PECARN TBI Analysis Project

## Overview
This project analyzes the PECARN traumatic brain injury (TBI) dataset to develop predictive models for CT scan decision-making and identify factors associated with severe TBI outcomes, with a focus on applying various data wrangling techniques.

## Data Wrangling Steps

### Initial Data Processing
- **Special Value Recoding**: Implemented custom functions to recode numerical codes into meaningful categorical variables
- **Missing Value Handling**: Applied domain-specific strategies for handling missing values based on clinical context
- **Variable Transformation**: Converted raw clinical variables into analysis-ready formats

### Feature Engineering
- **Age Categorization**: Transformed continuous age variables into clinically meaningful groups
- **Risk Level Derivation**: Created PECARN risk categories based on complex clinical criteria
- **Binary Indicators**: Generated binary flags for key clinical events (e.g., CT scan receipt)
- **Symptom Classification**: Standardized symptom reporting with consistent categories (Present, Absent, Unable to assess, Not documented)

### Dataset Preparation
- **Subset Creation**: Developed specialized datasets for different modeling approaches
- **Feature Selection**: Identified relevant variables for each analysis component
- **Data Partitioning**: Created appropriate training and testing splits while maintaining class distributions
- **Threshold Optimization**: Customized classification thresholds to align with clinical priorities

### Text Processing (NLP Analysis)
- **Entity Extraction**: Identified clinical findings and anatomical locations from unstructured text
- **Relationship Mapping**: Associated clinical findings with their anatomical contexts
- **Negation Detection**: Implemented context-aware negation detection to distinguish presence vs. absence
- **Severity Assessment**: Extracted modifiers that indicate clinical significance

## Analysis Components

### 1. CT Decision Model
Machine learning model to predict CT scan decisions with feature importance analysis revealing key predictors.

### 2. GCS & Neurological Deficits Analysis
Investigation of Glasgow Coma Scale effectiveness compared to neurological deficit indicators.

### 3. NLP Analysis of CT Reports
Extraction of clinically meaningful information from radiology reports using advanced text processing.

## Technical Approach
The data wrangling process incorporates:
- Domain-specific knowledge application
- Systematic handling of special codes
- Creating derived variables that capture clinical decision logic
- Maintaining data provenance through the transformation pipeline
- Custom functions for reproducible data transformations
- Integration of structured and unstructured data sources

This project demonstrates how effective data wrangling can transform raw clinical data into structured, analysis-ready datasets that enable development of accurate predictive models for clinical decision support.
