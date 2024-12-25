class GridSearchSVC():
    
    def Calculations(self):
        """ Importing Libraries """
        
        import numpy as np
        import pandas as pd
        import matplotlib.pyplot as plt
        import seaborn as sns
        # get_ipython().run_line_magic('matplotlib', 'inline')
        
        """ Loading Data """
        dataset = pd.read_csv("SamplesColectting.csv")
        # dataset.info()
        
        Inputs = dataset.iloc[:, [2, 3, 5, 6, 7, 8, 9, 10, 11, 12, 16, 17, 20, 22]].values
        Targets = dataset.iloc[:, [23]].values
        
        """ Splitting """
        from sklearn.model_selection import train_test_split
        trainInputs, testInputs, trainTargets, testTargets = train_test_split(Inputs, Targets, test_size=0.3, random_state=20)
        
        
        """ Hyperparameter tuning using Gridsearch """
        
        from sklearn.model_selection import GridSearchCV
        from sklearn.svm import SVC
        # param_grid = {'C':[0.1, 1, 10, 100, 1000], 'gamma':[1, 0.1, 0.01, 0.001, 0.0001], 'kernel':['rbf']}
        # param_grid = {'C':[0.001 , 0.01, 0.1, 1],'coef0':[1000], 'degree':[2], 'kernel':['poly']}
        param_grid = {'C':[0.1, 1, 10, 100, 1000],'coef0':[0.001 , 0.01, 0.1, 1], 'kernel':['sigmoid']}
        """C: by increasing C the accuracy and complexibility of model increased
           gamma (free parameter of the gussian): if increase gamma accuracy would decrease
           but solution reduced a lot"""
        
        grid = GridSearchCV(SVC(), param_grid, refit=True, verbose=3)
        """ verbose 3 show you some comments of calculations"""
        
        grid.fit(trainInputs, trainTargets)
        
        from sklearn.metrics import classification_report, confusion_matrix
        grid_predictions_testdata = grid.predict(testInputs)
        grid_confusion_matrix_testdata = confusion_matrix(testTargets, grid_predictions_testdata)
        grid_classification_report_testdata = classification_report(testTargets, grid_predictions_testdata)
        
        print('Confusion Matrix:')
        print(grid_confusion_matrix_testdata)
        print('Grid Classification Report for Test Data')
        print(grid_classification_report_testdata)
        print('Best Parametes of Grid')
        print(grid.best_params_)
        print('The best estimator of Grid')
        print(grid.best_estimator_)

GridSearchSVC().Calculations()
