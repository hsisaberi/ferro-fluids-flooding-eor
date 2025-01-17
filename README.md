# Performance Evaluation of Ferro-Fluids Flooding in Enhanced Oil Recovery Operations Using Machine Learning

This repository contains the code and models discussed in the research article [Performance Evaluation of Ferro-Fluids Flooding in Enhanced Oil Recovery Operations Based on Machine Learning](https://www.sciencedirect.com/science/article/abs/pii/S0952197624000666), published in *Engineering Applications of Artificial Intelligence*. The study uses multiple machine learning and AI techniques to predict the efficiency of ferro-fluids in enhanced oil recovery (EOR) in carbonate and sandstone reservoirs.

## Key Features

- **Classification Model:** Support Vector Machine (SVM) for categorizing EOR efficiency into three performance levels (Good, Excellent, and Great).
- **Regression Models:** 
  - Multilayer Perceptron (MLP)
  - Radial Basis Function Neural Network (RBF)
  - Adaptive Neuro-Fuzzy Inference System (ANFIS) with three variants:
    - Grid Partitioning
    - Subtractive Clustering
    - Fuzzy C-Means Clustering
- **Dataset:** Includes 1260 data points with 14 key features, covering reservoir properties and ferro-fluid specifications.

## Requirements

- Python 3.8 or higher
- Libraries: `scikit-learn`, `numpy`, `matplotlib`, `tensorflow`, `scipy`
- MATLAB 2016a (or later versions)

## Installation

Clone the repository:
   ```bash
   git clone https://github.com/hsisaberi/ferro-fluids-flooding-eor.git
   cd ferro-fluids-flooding-eor
   ```

## Usage

1. **Run Classification Model (SVM):**
   Navigate to the SVM classification folder and execute:
   ```bash
   python svmproj.py
   ```
   Adjust kernel parameters (`RBF`, `Polynomial`, `Sigmoid`) in the script as needed.

2. **Run Regression Models:**
   - **MLP Model:**
     Navigate to the `MLP` folder and run:
     ```bash
     MLP.m
     ```
   - **RBF Model:**
     Navigate to the `RBF` folder and run:
     ```bash
     RBF.m
     ```
   - **ANFIS Models:**
     Navigate to the `ANFIS` folder and choose the respective model:
     ```bash
     GENFIS1.m
     GENFIS2.m
     GENFIS3.m
     ```

## Dataset

The dataset includes 14 input features and 1 output (EOR efficiency). Key features:
- Ferro-fluid type, concentration, and size
- Rock properties (porosity, permeability, type)
- Environmental conditions (temperature, salinity)
- Recovery factor (EOR after nano-flooding)

Refer to the article for detailed data preprocessing steps and parameter ranges.

## Results

- **SVM Classification:** Achieved high accuracy with an optimized RBF kernel.
- **MLP Regression:** Delivered an R² of 0.9957, with low MSE and RMSE values.
- **ANFIS Models:** Demonstrated excellent performance, with the Grid Partitioning variant being the simplest and most efficient.

## Citation

If you use this repository, please cite the original article:
```bibtex
@article{saberi2024performance,
  title={Performance Evaluation of Ferro-Fluids Flooding in Enhanced Oil Recovery Operations Based on Machine Learning},
  author={Saberi, Hossein and Karimian, Milad and Esmaeilnezhad, Ehsan},
  journal={Engineering Applications of Artificial Intelligence},
  volume={132},
  pages={107908},
  year={2024},
  publisher={Elsevier}
}
```

## Contact

For questions or contributions, contact **[Hossein Saberi](mailto:e.esmailnezhad@hsu.ac.ir)**.
