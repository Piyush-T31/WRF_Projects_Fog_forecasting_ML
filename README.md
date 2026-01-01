# ML-Enhanced Fog Forecasting using WRF Post-Processing

This repository accompanies the research manuscript:

**"Weather Research and Forecasting (WRF) model and machine learning algorithms to improve marine fog predictions at two coastal locations in Atlantic Canada"**

The project demonstrates how lightweight machine learning (ML) models can be used as a *post-processing layer* on Numerical Weather Prediction (NWP) output to significantly improve hourly fog forecasts out to 24 hours, without modifying physical parameterizations within the Weather Research and Forecasting (WRF) model.

---

## 📌 Research Overview

Marine fog remains difficult to predict using traditional NWP due to challenges in representing microphysics, boundary-layer turbulence, and air–sea interactions. WRF often overpredicts surface liquid water content, leading to persistent false fog events.

This study reframes fog prediction as a **binary classification problem** and applies ML models to correct systematic WRF biases at station scale. The approach was evaluated at two fog-prone coastal sites in Atlantic Canada:

* **St John’s, Newfoundland and Labrador**
* **Yarmouth, Nova Scotia**

Using 12 years of reanalysis-based training data and independent pseudo-operational WRF forecasts for summer 2024, ML post-processing consistently outperformed a WRF-only fog diagnostic.

---

## 🧠 Key Contributions

* Hybrid **physics-informed ML post-processing** framework
* **24-hour hourly fog forecasts**, exceeding typical ML nowcasting horizons
* Comparison of tree-based ensembles and deep learning approaches
* Robust statistical evaluation including McNemar’s test and bootstrap confidence intervals
* Operationally interpretable results suitable for decision support

---

## 🧪 Machine Learning Framework

Fog occurrence is defined using visibility observations (≤ 1 km) and modeled as an imbalanced binary classification problem.

### Models Evaluated

* **ExtraTrees Classifier (ETClassifier)** - primary operational model
* **XGBoost Classifier**
* **Bidirectional LSTM (biLSTM)**

Tree-based ensemble methods were found to be more robust and interpretable than deep learning, with comparable or better performance.

---

## 🌍 Data Sources

### Training Data (2012–2023)

* **ERA5 reanalysis** (hourly)

  * 2 m temperature (T2)
  * 2 m relative humidity (RH2)
  * 10 m wind components (U10, V10)
  * Surface pressure (P_sfc)
* **NAV CANADA visibility observations**

### Forecast Data (2024)

* **WRF v4.5.2 pseudo-operational simulations**
* Initialized using **GFS 0.25° forecasts**
* 36 h daily runs with 12 h spin-up

---

## 🧩 Feature Engineering

Features used by ML models include:

* Meteorological variables at forecast time
* 1-hour lagged predictors to capture persistence
* Time-based features (hour, month)

Feature importance analysis shows **relative humidity and its persistence** dominate fog predictability, with wind direction playing a secondary role.

---

## 📊 Evaluation Metrics

Model performance is assessed using:

* Precision
* Recall
* F1-score
* Confusion matrices
* McNemar’s statistical test
* Bootstrap-derived 95% confidence intervals

ML post-processing improved F1-score by:

* **+13% at St John’s**
* **+18% at Yarmouth**

relative to WRF liquid-water-based fog detection.

---

## 📈 Key Results

* ETClassifier achieved the most balanced skill across sites
* ML models reduced both false alarms and missed fog events
* Forecast skill remained stable across the full 24-hour horizon
* Statistically significant improvement over WRF (p < 0.05)

---

## 🧠 ML Perspective

This work positions ML as a **bias-correction tool**, not a replacement for physical modeling. Results show that:

* Feature selection matters more than model complexity
* Ensemble tree methods outperform deep learning when inputs are physically meaningful
* ML post-processing is computationally efficient and operationally deployable

---

## 📁 Repository Structure

```text
fog-ml-wrf/
├── data/
├── WRF_Files/   # configurations used for preprocessing ERA5 data and running WRF + extracting the variables
├── Python_scripts/
│   ├── extratrees.py        # preprocessing and training models (ETClassifier) + evaluating metrics
│   └── bilstm.py       # Using neural nets as another option
├── Paper_figures/  # contains all the plots used in manuscript
└── README.md
```

---

## ⚙️ Environment

* Python ≥ 3.9
* scikit-learn
* xgboost
* tensorflow / keras
* numpy, pandas, matplotlib
* Linux-based HPC to run WRF
* NCL scripts 


---

## 🚀 Operational Relevance

The proposed workflow is well-suited for:

* Aviation and marine decision support
* Hourly fog alerts with extended lead time
* Integration into existing NWP-based forecasting systems

---

## 📖 Citation

If you use this work, please cite:

> Teeloku, P., Chen, Z., Taylor, P., & Chen, Y. (2025).  
> *Weather Research and Forecasting (WRF) model and machine learning algorithms to improve marine fog predictions at two coastal locations in Atlantic Canada.*  
> Under review.

---

## 📬 Contact

For questions or collaboration inquiries:

> **Author:** Piyush Teeloku

> **Email:** piyush31@yorku.ca

---

## 📝 License

This project is intended for academic and research use. 
