:- dynamic path/3.

% place(ID)
place('Admin Office').
place('Engineering Bld.').
place('Library').
place('Lecture Hall A').
place('Institute Y').
place('Cafeteria').
place('Social Sciences Bld.').
place('Institute X').


% edge(Place1, Place2, Weight); where Weight is the time it would take to travel from Place1 to Place2.
edge('Admin Office', 'Engineering Bld.', 3).
edge('Admin Office', 'Library', 1).
edge('Admin Office', 'Cafeteria', 4).
edge('Engineering Bld.', 'Admin Office', 3).
edge('Engineering Bld.', 'Library', 5).
edge('Engineering Bld.', 'Lecture Hall A', 2).
edge('Lecture Hall A', 'Engineering Bld.', 2).
edge('Lecture Hall A', 'Institute Y', 3).
edge('Institute Y', 'Lecture Hall A', 3).
edge('Institute Y', 'Library', 3).
edge('Library', 'Admin Office', 1).
edge('Library', 'Engineering Bld.', 5).
edge('Library', 'Institute Y', 3).
edge('Library', 'Social Sciences Bld.', 2).
edge('Library', 'Cafeteria', 5).
edge('Cafeteria', 'Admin Office', 4).
edge('Cafeteria', 'Library', 5).
edge('Cafeteria', 'Social Sciences Bld.', 2).
edge('Social Sciences Bld.', 'Cafeteria', 2).
edge('Social Sciences Bld.', 'Library', 2).
edge('Social Sciences Bld.', 'Institute X', 8).
edge('Institute X', 'Social Sciences Bld.', 8).


% delivery_person(ID, Capacity, WorkHours, CurrentDeliveryJob, CurrentLocation)
delivery_person(delivery_person_1, 10, [4, 8, 12, 16], none, 'Library').
delivery_person(delivery_person_2, 15, [8, 12, 16], none, 'Engineering Bld.').
delivery_person(delivery_person_3, 20, [0, 4], object_1, 'Admin Office').


% object(ID, Weight, PickUpPlace, DropOffPlace, Urgency, IDofDeliveryPerson)
object(object_1, 5, 'Admin Office', 'Institute Y', low, delivery_person_3).
object(object_2, 10, 'Library', 'Social Sciences Bld.', high, none).
object(object_3, 15, 'Cafeteria', 'Institute X', low, none).
object(object_4, 20, 'Engineering Bld.', 'Social Sciences Bld.', high, none).
object(object_5, 25, 'Institute Y', 'Admin Office', low, none).


% expert system queries:

% helpers
path(PickUpPlace, DropOffPlace, Path) :-
   dfs(PickUpPlace, DropOffPlace, [PickUpPlace], Q), % find a path from PickUpPlace to DropOffPlace
   reverse(Q, Path). % reverse the path to get the correct order

dfs(DropOffPlace, DropOffPlace, Path, Path). % base case
dfs(Node, DropOffPlace, Visited, Path) :- % recursive case
   edge(Node, Next, _), % find the next node
   \+ member(Next, Visited), % make sure we don't visit the same node twice
   dfs(Next, DropOffPlace, [Next | Visited], Path). % add the next node to the visited list

total_time(Path, TotalTime) :-
   total_time(Path, 0, TotalTime).

total_time([_], Time, Time).
total_time([Place1, Place2 | Rest], Acc, TotalTime) :-
   edge(Place1, Place2, Time),
   NewAcc is Acc + Time,
   total_time([Place2 | Rest], NewAcc, TotalTime).

combine_paths(Path1, Path2, CombinedPath) :-
  append(Path1, Path2, CombinedPath).

find_path(PersonID, ObjectID, CombinedPath) :-
   delivery_person(PersonID, _, _, _, CurrentLocation),
   object(ObjectID, _, PickUpPlace, DropOffPlace, _, _),
   path(CurrentLocation, PickUpPlace, Path1),
   path(PickUpPlace, DropOffPlace, Path2),
   delete(Path2, PickUpPlace, Path2WithoutPickUp), % remove duplicated node
   combine_paths(Path1, Path2WithoutPickUp, CombinedPath).

delivery_available(ObjectID) :-
    object(ObjectID, _, _, _, _, DeliveryPersonID),
    DeliveryPersonID \= none, % this means that the object is already in delivery
    write('Object is already in delivery by: '), write(DeliveryPersonID), nl.

delivery_available(ObjectID) :-
    object(ObjectID, Weight, _, _, _, none),
    findall(DeliveryPersonID, 
            (delivery_person(DeliveryPersonID, Capacity, _, none, _),
            Capacity >= Weight),
            AvailableDeliveryPeople),
    AvailableDeliveryPeople \= [],
    % for each available delivery person, find one path, and print it
    forall(member(DeliveryPersonID, AvailableDeliveryPeople),
           (find_path(DeliveryPersonID, ObjectID, Path),
            total_time(Path, TotalTime),
            write('Delivery person: '), write(DeliveryPersonID), nl,
            write('Path: '), write(Path), nl,
            write('Total time: '), write(TotalTime), nl, nl)).
