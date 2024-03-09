:- style_check(-singleton).

classify(SepalLength, SepalWidth, PetalLength, PetalWidth) :-
   PetalLength =< 2.45,
   Class = 'Iris-setosa',
   write(Class).

classify(SepalLength, SepalWidth, PetalLength, PetalWidth) :-
   PetalLength > 2.45,
   PetalLength =< 4.75,
   PetalWidth =< 1.65,
   Class = 'Iris-versicolor',
   write(Class).

classify(SepalLength, SepalWidth, PetalLength, PetalWidth) :-
   PetalLength > 2.45,
   PetalLength =< 4.75,
   PetalWidth > 1.65,
   Class = 'Iris-virginica',
   write(Class).

classify(SepalLength, SepalWidth, PetalLength, PetalWidth) :-
   PetalLength > 4.75,
   PetalWidth =< 1.75,
   PetalLength =< 4.95,
   Class = 'Iris-versicolor',
   write(Class).

classify(SepalLength, SepalWidth, PetalLength, PetalWidth) :-
   PetalLength > 4.75,
   PetalWidth =< 1.75,
   PetalLength > 4.95,
   PetalWidth =< 1.55,
   Class = 'Iris-virginica',
   write(Class).

classify(SepalLength, SepalWidth, PetalLength, PetalWidth) :-
   PetalLength > 4.75,
   PetalWidth =< 1.75,
   PetalLength > 4.95,
   PetalWidth > 1.55,
   SepalLength =< 6.95,
   Class = 'Iris-versicolor',
   write(Class).

classify(SepalLength, SepalWidth, PetalLength, PetalWidth) :-
   PetalLength > 4.75,
   PetalWidth =< 1.75,
   PetalLength > 4.95,
   PetalWidth > 1.55,
   SepalLength > 6.95,
   Class = 'Iris-virginica',
   write(Class).

classify(SepalLength, SepalWidth, PetalLength, PetalWidth) :-
   PetalLength > 4.75,
   PetalWidth > 1.75,
   PetalLength =< 4.85,
   SepalLength =< 5.95,
   Class = 'Iris-versicolor',
   write(Class).

classify(SepalLength, SepalWidth, PetalLength, PetalWidth) :-
   PetalLength > 4.75,
   PetalWidth > 1.75,
   PetalLength =< 4.85,
   SepalLength > 5.95,
   Class = 'Iris-virginica',
   write(Class).

classify(SepalLength, SepalWidth, PetalLength, PetalWidth) :-
   PetalLength > 4.75,
   PetalWidth > 1.75,
   PetalLength > 4.85,
   Class = 'Iris-virginica',
   write(Class).
