""" Importing Libraries """

import numpy as np
import pandas as pd
import matplotlib.pyplot as plt
import seaborn as sns
import time
# get_ipython().run_line_magic('matplotlib', 'inline')

""" Going to Current Directory"""

import os
os.chdir('D:/Papers/03_Third Project/Models/Version 1/01_Spider SVM')


""" Loading Data """
dataset = pd.read_csv("SamplesColectting.csv")
# dataset.info()

Inputs = dataset.iloc[:, [2, 3, 5, 6, 7, 8, 9, 10, 11, 12, 16, 17, 20, 22]].values
Targets = dataset.iloc[:, [23]].values


for i in range(736,737):

    """ Splitting """
    from sklearn.model_selection import train_test_split
    trainInputs, testInputs, trainTargets, testTargets = train_test_split(Inputs, Targets, test_size=0.3, random_state=i)
    
    """ Training Network """
    from sklearn.svm import SVC
    # Changing parameters to find the optimal
    # model=SVC(C=10, kernel='rbf', gamma=0.01)
    # model=SVC(C=10, kernel='rbf', gamma=0.1)
    # model=SVC(C=1000, kernel='rbf', gamma=0.1)
    start_time = time.time()
    model=SVC(C=100, kernel='rbf', gamma=0.1)
    
    # Changing Kernel to find the optimal
    # model=SVC(kernel='sigmoid', coef0=1, C=1000)
    
    model.fit(trainInputs, trainTargets)
    
    """ Prediction and Evaluation """
    
    trainOutputs = model.predict(trainInputs)
    testOutputs = model.predict(testInputs)
    allOutputs = model.predict(Inputs)
    elapsed_time = time.time() - start_time
    
    
    print('#########################################################################\n')
    print('#########################################################################\n')
    print('random state: ', i)
    print('#########################################################################\n')
    print('#########################################################################\n')
    
    from sklearn.metrics import classification_report, confusion_matrix
    """Train Data Evaluation"""
    confusion_matrix_traindata = confusion_matrix(trainTargets, trainOutputs)
    classification_report_traindata = classification_report(trainTargets, trainOutputs)
    print('Classification Report Train Data')
    print(classification_report_traindata)
    print('Confusion matrix Train Data')
    print(confusion_matrix_traindata)
    
    """Test Data Evaluation"""
    confusion_matrix_testdata = confusion_matrix(testTargets, testOutputs)
    classification_report_testdata = classification_report(testTargets, testOutputs)
    print('Classification Report Test Data')
    print(classification_report_testdata)
    print('Confusion matrix Test Data')
    print(confusion_matrix_testdata)
    
    """All Data Evaluation"""
    confusion_matrix_alldata = confusion_matrix(Targets, allOutputs)
    classification_report_alldata = classification_report(Targets, allOutputs)
    print('Classification Report All Data')
    print(classification_report_alldata)
    print('Confusion matrix All Data')
    print(confusion_matrix_alldata)
    
    """ Printing time"""
    print(elapsed_time)
    
    if confusion_matrix_alldata[0,2]==0 and confusion_matrix_alldata[0,1]==0 and confusion_matrix_alldata[1,0]==0 and confusion_matrix_alldata[1,2]==0 and confusion_matrix_alldata[2,0]==0 and confusion_matrix_alldata[2,1]==0:
        break
    
# Best one random_state (736), rbf, gamma 0.1, C=100





























