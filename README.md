# PECARN TBI Prediction Tool

This repository contains a comprehensive analysis of the Pediatric Emergency Care Applied Research Network (PECARN) Traumatic Brain Injury (TBI) dataset, with machine learning models to predict CT scan decisions and positive CT findings.

## Project Overview

The project aims to:
1. Predict which pediatric head injury patients should receive CT scans
2. Predict which patients receiving CT scans will have positive findings
3. Provide a clinical decision support tool for pediatric emergency providers

## Data and Workflow

### Dataset

The PECARN TBI Public Use Dataset includes information from 43,399 pediatric patients with head trauma, collected from 25 emergency departments. The dataset contains:

- Demographics (age, gender)
- Clinical variables (GCS score, symptoms, neurological status)
- Injury characteristics (mechanism, severity)
- CT scan decisions and results

### Data Preparation Workflow

1. **Initial Data Loading** (`data_preparation.py`)
   ```python
   data_path = '/path/to/TBI PUD 10-08-2013.csv'
   tbi_data = pd.read_csv(data_path)
   ```

2. **Special Code Handling**
   ```python
   # Function for recoding special values
   def recode_special_values(df, var_name, special_codes_map, default_na_value=np.nan):
       # See function definition in code
       # ...
   
   # Apply to key variables
   tbi_clean['Amnesia_cat'] = recode_special_values(tbi_data, 'Amnesia_verb', symptom_map)
   tbi_clean['Headache_cat'] = recode_special_values(tbi_data, 'HA_verb', symptom_map)
   # etc.
   ```

3. **Feature Engineering**
   ```python
   # Age groups
   tbi_clean['Age_Group'] = pd.cut(
       tbi_data['AgeInMonth'],
       bins=[0, 24, 60, 120, 240],
       labels=['<2 years', '2-5 years', '5-10 years', '>10 years']
   )
   
   # PECARN risk categories
   tbi_clean.loc[mask_older & (mask_ams | mask_skull_fx), 'PECARN_Risk'] = 'High risk'
   # etc.
   ```

4. **Dataset Creation**
   ```python
   # CT decision dataset
   ct_decision_data = tbi_clean[ct_decision_vars].copy()
   
   # CT findings dataset (subset with CT scans)
   ct_finding_data = tbi_clean[tbi_clean['Received_CT']][ct_finding_vars].copy()
   ```

5. **Data Persistence**
   ```python
   # Save prepared datasets for modeling
   ct_decision_data.to_csv('./data/ct_decision_data.csv', index=False)
   ct_finding_data.to_csv('./data/ct_finding_data.csv', index=False)
   ```

### Model Development Workflow

1. **CT Decision Model** (`ct_decision_model.py`)
   - Loads prepared decision dataset
   - Creates preprocessing pipeline for categorical and numeric features
   - Trains ensemble model (Random Forest + Gradient Boosting)
   - Optimizes decision threshold for high sensitivity
   - Evaluates model and extracts feature importance

2. **Positive CT Findings Model** (`ct_findings_model.py`)
   - Loads prepared findings dataset
   - Handles class imbalance with SMOTETomek and class weighting
   - Trains Random Forest model with optimized hyperparameters
   - Tunes threshold to balance precision and recall
   - Evaluates model with emphasis on sensitivity

3. **Clinical Decision Support Tool** (future implementation)
   - Combines both models for comprehensive decision support
   - Provides threshold options for different clinical scenarios
   - Visualizes risk scores and predictions

## Running the Code

### Prerequisites

```
pandas>=1.0.0
numpy>=1.18.0
scikit-learn>=0.24.0
matplotlib>=3.0.0
seaborn>=0.11.0
imbalanced-learn>=0.8.0
```

### Execution Sequence

1. Run data preparation:
   ```bash
   python data_preparation.py
   ```

2. Run CT decision model:
   ```bash
   python ct_decision_model.py
   ```

3. Run positive CT findings model:
   ```bash
   python ct_findings_model.py
   ```

## Key Results

### CT Decision Model
- **Accuracy**: 82%
- **Sensitivity**: 87.5% (with optimized threshold)
- **Specificity**: 68.7%
- **Top predictors**: Loss of consciousness, altered mental status, PECARN risk category

### Positive CT Findings Model
- **Sensitivity**: 73.4% (with optimized threshold)
- **Precision**: 11.2%
- **Top predictors**: Injury mechanism severity, GCS score, absence of amnesia

## Project Structure

```
PECARN/
├── data/                       # Data storage directory
│   ├── ct_decision_data.csv    # Prepared decision model dataset
│   └── ct_finding_data.csv     # Prepared findings model dataset
├── models/                     # Saved model files
│   ├── improved_ct_decision_model.pkl
│   └── improved_ct_findings_model.pkl
├── data_preparation.py         # Data wrangling and preparation script
├── ct_decision_model.py        # CT decision prediction model
├── ct_findings_model.py        # Positive CT findings prediction model
└── README.md                   # This file
```
