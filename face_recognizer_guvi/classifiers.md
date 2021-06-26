## Clasifiers

Say mere ko apple and oranges me pehchanna seekhana hai,
what i will do in traditional programming is like this:

```py

def detect_colors(image):
    // lots of code

def detect_edges(image):
    // lots of code

def analyze_shapes(image):
    // lots of code

def guess_texture(image):
    // lots of code

def define_fruit():
    // lots of code

def handle_probability():
    // lots of code

```

**Is there a better way to do this ?**
The answer is _Classifiers_

Classifiers help classify the apples from the oranges.

Apple Image -> Classifier -> Apple
Mail -> Classifier -> Spam

Can also be said as "Supervised learning"

Supervised learning learns from examples

Collect data -> Classify -> Make prediction

**Label** is the result

```py
from sklearn import tree

features = [[140,1],[130,1],[150,0],[170,0]]       # pairs of (weight, is_bumpy_or_smooth)

labels = [0,0,1,1]      # what they really are, orange or apple respectively

# classifier
clf = tree.DecisionTreeClasifier()  # this creates a decision tree for us

clf = clf.fit(features, labels)     # fit means we are training it

clf.predict( [[150,0]] )   # should give apple (1)
                            # we passed ARRAY of data (ie. pairs here)
```
