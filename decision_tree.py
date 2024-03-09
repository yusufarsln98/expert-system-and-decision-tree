import pandas as pd
from sklearn import tree
from sklearn.model_selection import train_test_split

# Load the CSV file into a pandas DataFrame
data = pd.read_csv('iris.csv')

# Separate the features from the target
X = data[['sepalLength', 'sepalWidth', 'petalLength', 'petalWidth']]
y = data['class'] # Target

# Split the data into training and testing sets
X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.2, random_state=42)

# Create the decision tree classifier and fit it to the training data
clf = tree.DecisionTreeClassifier()
clf = clf.fit(X_train, y_train)

# Print the decision tree to the console
r = tree.export_text(clf, feature_names=['sepalLength', 'sepalWidth', 'petalLength', 'petalWidth'])
print(r)
