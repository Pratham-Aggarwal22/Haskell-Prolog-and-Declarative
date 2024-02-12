/* APPEND : */

append([],Y,Y).
append([H|T],Y,[H|Z]) :- append(T,Y,Z).

    ?- append([1,2], [3,4], [1,2,3,4]).   % mode: (+,+,+)   Solution: yes
    ?- append([1,2], [3,4], Z).           % mode: (+,+,-)   Solution: Z = [1,2,3,4]
    ?- append([1,2], Y, [1,2,3,4]).       % mode: (+,-,+)   Solution: Y = [3,4]
    ?- append(X, [3,4], [1,2,3,4]).       % mode: (-,+,+)   Solution: X = [1,2]
    ?- append(X, Y, [1,2]).               % mode: (-,-,+)   Solutions: X = [], Y = [1,2]; X = [1], Y = [2]; X = [1,2], Y = []



/* ALTER */
alte([],[],[]).
alte([A],[A],[]).
alte([A1,A2|As],[A1|Bs],[A2|Zs]):- alte(As,Bs,Zs).

% mode (+,-,-)
% ?-alte([1,2,3,4,5,6,7,8,9,10],Ys,Zs).                        ->Solution: Ys = [1, 3, 5, 7, 9],
                                                                    %   Zs = [2, 4, 6, 8, 10]  
% mode (-,+,+)
% ?-alte(Xs,[1,3,5],[2,4]).                                 ->Solution: Xs = [1, 2, 3, 4, 5]

% mode (+,-,+)
% ?-alte([1,2,3,4,5,6],Ys,[2,4,5]).                         ->Solution: false

% mode (+,+,-).
% ?-alte([1,2,3,4,5,6],[1,3,5],Zs).                         ->Solution: Zs = [2, 4, 6]


/*MERGE SORT*/
alte([],[],[]).
alte([A],[A],[]).
alte([A1,A2|As],[A1|Bs],[A2|Zs]):- alte(As,Bs,Zs).

merg(Xs,[],Xs).
merg([],Ys,Ys).
merg([X|Xs],[Y|Ys],[X,Y|Zs]):- X=Y, merg(Xs,Ys,Zs).
merg([X|Xs],[Y|Ys],[X|Zs]):- X<Y, merg(Xs,[Y|Ys],Zs).
merg([X|Xs],[Y|Ys],[Y|Zs]):- X>Y, merg([X|Xs],Ys,Zs).

merge_sort([],[]).
merge_sort([X],[X]).
merge_sort([X,Y|Zs],Sorted):-
    alte([X,Y|Zs],L1,L2),
	merge_sort(L1,Sorted1), 
	merge_sort(L2,Sorted2), 
	merg(Sorted1,Sorted2,Sorted).

% mode (+,-)
% ?-merge_sort([1,21,7,20,8,10],Sorted).               -> Solution : Sorted = [1, 7, 8, 10, 20, 21]
% mode (+,+)
% ?-merge_sort([1,6,3,2,7,6,5],[1,7,4,7,88]).           -> Solution : false


/*CONS SNOC */
cons(A,nil,snoc(nil,A)).
cons(A,snoc(Xs,X),snoc(Zs,X)):- cons(A,Xs,Zs).

% mode (+,+,-)
% ?-cons(1,snoc(2,snoc(3,nil)),Zs).                 -> Solution : false
% mode (-,+,-)
% ?-cons(A,snoc(snoc(nil,2),3),Zs).                 -> Solution : Zs = snoc(snoc(snoc(nil,A),2),3)
% mode (+,-,+)
% ?-cons(3,Xs,snoc(snoc(snoc(nil, A), 2), 3)).       -> Solution : A = 3,
                                                        % Xs = snoc(snoc(nil,2),3)

% mode (-,-,+)
% ?-cons(A,Xs,snoc(snoc(snoc(nil, 1), 2), 3)).      -> Solution : A = 1,
                                                        %Xs = snoc(snoc(nil,2),3)        


/*BLIST*/
to_Blist([],nil).
to_Blist([A|As],cons(A,Zs)):- to_Blist(As,Zs).

% mode (+,-)
% ?-to_Blist([1,2,3,4,5],Zs).                                   -> Solution : Zs = cons(1,cons(2,cons(3,cons(4,cons(5,nil)))))
% mode (-,+)
% ?-to_Blist(Xs,cons(1, cons(2, cons(3, nil)))).	            -> Solution : Xs = [1, 2, 3]
% mode (+,+)
% ?-to_Blist([1,2,3,4],cons(1, cons(2, cons(3, nil)))).		    -> Solution : true


/*SNOC*/
snoc([],A,[A]).
snoc([X|Xs],A,[X|Zs]) :- snoc(Xs,A,Zs).

% mode (+,+,-)
% ?-snoc([1,2,3,4],5,A).		                        -> 	Solution : A = [1, 2, 3, 4, 5]
% mode (+,-,+)
% ?-snoc([1,2,3],A,[1,2,3,4,5,6]).		                -> 	Solution : false
% mode (-,-,+)
% ?-snoc(Xs,A,[1,2,3,4,5,6]).				            -> Solution : A = 6,
										                    %Xs = [1, 2, 3, 4, 5]

/*FROM BLIST*/
from_blist(nil,[]).
from_blist(snoc(As,A),[A|Zs]):- from_blist(As,Zs).

% mode (+,-)
% ?-from_blist(snoc(snoc(snoc(nil,2),3),4),N).                  ->  Solution : N = [4, 3, 2]


/*NUM EMPTY*/
num_emp(empty,1).
num_emp(node(_,L,R),N):- 
    num_emp(L,NL),
    num_emp(R,NR),
    N is NL + NR.

% mode (+,-)                
% ?-num_emp(node(1,node(2,empty,empty),empty),N)                 -> Solution : N = 3


/*NUM NODES*/
num_nodes(empty,0).
num_nodes(node(_,L,R),N):-
    num_nodes(L,NL),
    num_nodes(R,NR),
    N is NL + NR + 1.

% mode (+,-)
% ?-num_nodes(node(1,node(2,empty,empty),node(3,empty,empty)),N)			->Solution : N = 3


/*SUM NODES*/
sum_nodes(empty,0).
sum_nodes(node(A,L,R),N):-
    sum_nodes(L,NL),
    sum_nodes(R,NR),
    N is A + NL + NR.

% mode (+,-)
% ?-sum_nodes(node(1,node(2,empty,empty),node(3,empty,empty)),N)			->Solution : N = 6



/*INSERT LEFT*/
insert_left(empty,A,node(A,empty,empty)).
insert_left(node(E,L,R),A,node(E,T,R)):-
    insert_left(L,A,T).

% mode (+,+,-)
% ?-insert_left(node(1,node(3,empty,empty),node(5,empty,empty)),7,T)						 ->Solution: node(
																											1,
																											node(3,node(7,empty,empty),empty),
																											node(5,empty,empty))
                                                                                                            

% mode (-,-,+)
% ?- insert_left(X,A,node(1,node(2,node(9,empty,empty),empty),node(3,empty,empty)))					-> Solution : A = 9,
																										X = node(1,node(2,empty,empty),node(3,empty,empty))



/*INSERT RIGHT*/
insert_right(empty,X,node(X,empty,empty)).
insert_right(node(E,L,R),X,node(E,L,T)):-
    insert_right(R,X,T).

% mode (-,-,+)
% ?-insert_right(Y,A,node(1, node(2, node(9, empty, empty), empty), node(3, empty, empty)))				->Soltion : A = 3,
																											Y = node(1,node(2,node(9,empty,empty),empty),empty)
% mode (-,+,+)
% ?- insert_right(Y,3,node(1, node(2, node(9, empty, empty), empty), node(3, empty, empty)))				-> Solution :
                                                                                                                 Y = node(1,node(2,node(9,empty,empty),empty),empty)

% mode (+,-,+)
% ?- insert_right(node(1, node(2, node(9, empty, empty), empty), empty),A,node(1, node(2, node(9, empty, empty), empty), node(3, empty, empty)))					
                                                                                                            -> Solution : A = 3



/*INORDER*/
inorder(empty,[]).
inorder(node(_,L,_),X) :- inorder(L,X).
inorder(node(X,_,_),X).
inorder(node(_,_,R),X) :- inorder(R,X).

%mode (+,-)
% ?-inorder(node(1,node(2,node(3,empty,empty),empty),node(4,empty,empty)),X)

SOLUTION :
X = []
X = 3
X = []
X = 2
X = []
X = 1
X = []
X = 4
X = []



/*NUM OF ELEMENTS*/
num_elts(leaf(_),1).
num_elts(node2(_,L,R),X):-
    num_elts(L,NL),
    num_elts(R,NR),
    X is NL + NR + 1.

% mode (+,-)
% ?-num_elts(node2(4,leaf(1),leaf(3)),X) 			-> SOLUTION : X=3


/*SUM NODES*/
sum_nodes2(leaf(E),E).
sum_nodes2(node2(A,L,R),S):-
    sum_nodes2(L,NL),
    sum_nodes2(R,NR),
    S is A + NL + NR.

% mode (+,-)
%?- sum_nodes2(node2(4,leaf(3),leaf(13)),S).			-> Solution S = 20


/*INORDER*/
inorder2(leaf(E),[E]).
inorder2(node2(_,L,_),X) :- inorder2(L,X).
inorder2(node2(X,_,_),X).
inorder2(node2(_,_,R),X) :- inorder2(R,X).
% mode (+,-)
% ?-inorder2(node2(6,leaf(1),node2(4,leaf(9),leaf(7))),X).


Solution :
X = [1]
X = 6
X = [9]
X = 4
X = [7]


/*CONV*/
 conv12(leaf(A),node(A,empty,empty)).
conv12(node2(E1,L2,R2),node(E1,L1,R1)):-
    conv12(L2,L1),
    conv12(R2,R1).

% mode (+,-)
% ?-conv12(node2(6,leaf(1),node2(3,leaf(9),leaf(4))),T).

 -> SOLUTION:
 node(6,node(1,empty,empty),node(3,node(9,empty,empty),node(4,empty,empty)))





            /*Iterators*/   


my_sum([],X,X).
my_sum([H|T], A, S) :- 
    A2 is A + H, 
    my_sum(T,A2,S).

% mode (+,+,-)
% ?-my_sum([1,2,3,4,5,6,7],0,S).  			solution -> S = 28


my_prod([],X,X).
my_prod([H|T],A,P):-
    PR is A * H,
    my_prod(T,PR,P).

% mode (+,-)
% ?-my_prod([1,2,3,4,5,6,7],1,S).					-> Solution -> S = 5040


/*APPEND*/
appe([],As,As).
appe([B|Bs],As,[B|Zs]):-
    appe(Bs,As,Zs).

% mode (+,+,-)
% ?-appe([1,2,3],[4,5,6,7,8],Zs).						->Solution -> Zs = [1, 2, 3, 4, 5, 6, 7, 8]

% mode (-,-,+)
% ?-appe(Xs,Ys,[1,2,3,4,5,6,7]).

% Solution:
% Xs = [],
Ys = [1, 2, 3, 4, 5, 6, 7]
Xs = [1],
Ys = [2, 3, 4, 5, 6, 7]
Xs = [1, 2],
Ys = [3, 4, 5, 6, 7]
Xs = [1, 2, 3],
Ys = [4, 5, 6, 7]
Xs = [1, 2, 3, 4],
Ys = [5, 6, 7]
Xs = [1, 2, 3, 4, 5],
Ys = [6, 7]
Xs = [1, 2, 3, 4, 5, 6],
Ys = [7]
Xs = [1, 2, 3, 4, 5, 6, 7],
Ys = []

% mode (+,-,+)
% ?-appe([1,2,3],Ys,[1,2,3,4,5,6]).							->Solution : Ys = [4, 5, 6]


my_rev([],X,X).
my_rev([X|Xs],A,R):-
    my_rev(Xs,A,[X|R]).

% mode (+,-,+)
% ?-my_rev([1,2,3,4,6,7],A,[]).					-> Solution -> A = [7, 6, 4, 3, 2, 1]	
% mode (-,-,+)
% ?-my_rev(X,A,[4,3,2,1]).						-> Solution -> my_rev(X,A,[4,3,2,1])


my_and(_,false,false).
my_and(false,_,false).
my_and(true,true,true).

% mode(+,+,-), (+,-,+), (-,+,+), (-,-,+)
% ?-my_and(A,B,true). 				            -> Solution : A = B, B = true

my_or(_,true,true).
my_or(true,_,true).
my_or(false,false,false).

% mode(+,+,-), (+,-,+), (-,+,+), (-,-,+)
% ?-my_or(A,B,true).				            -> Solution : B = true
										        %A = true 


/* SUM NODES*/
sum_nodes_it(T, N) :- sum_help([T], 0, N).
sum_help([], A, A).
sum_help([empty|Ts], A, N) :- sum_help(Ts, A, N).
sum_help([node(E,L,R)|Ts], A, N) :- AE is A + E, sum_help([L,R|Ts], AE, N).

% mode (+,-)
% ?- sum_nodes_it(node(2,node(3,empty,empty),node(4,empty,empty)),N).			-> Solution: N = 9

/*toBList*/
toBList_it(T,N) :- toBList_help(T, nil, N).
toBList_help([], A, A).
toBList_help([T|Ts],A,N) :- toBList_help(Ts,snoc(A,T),N).

% mode (+,-)
% ? -toBList_it([1,2,3],N).
% mode (-,+)
% ?-toBList_it(T,snoc(snoc(snoc(nil,2),3),4)).				-> Solution : T = [2, 3, 4]

/*from B list*/
fromBList_it(T,N):- fromBList_help(T,[],N).
fromBList_help(nil,A,A).
fromBList_help(snoc(Xs,X),A,N):- fromBList_help(Xs,[X|A],N).

% mode (+,-)
% ?- fromBList_it(snoc(snoc(snoc(nil,1),3),5),N).		-> Solution : T = snoc(snoc(snoc(nil,1),5),7)
% mode (-,+)
% ?-fromBList_it(T,[1,5,7]).							-> Solution : T = snoc(snoc(snoc(nil,1),5),7)

/*NUM EMPTIES*/
num_empties1(T,N):- sum_help1([T],0,N).
sum_help1([empty|Ts],A,N):- X is A + 1, sum_help1(Ts,X,N).
sum_help1([],A,A).
sum_help1([node(_,L,R)|Ts],A,N):-
    sum_help1([L,R|Ts],A,N).

% mode (+,-)
% ?-num_empties1(node(2,node(3,empty,empty),node(4,node(7,empty,empty),empty)),N).			-> N = 5
																								%false
% num_empties1(node(2,empty,empty),N).	                                                    -> N=2

/*NUM NODES*/
num_nodes1(T,N):- sum_help2([T],0,N).
sum_help2([],A,A).
sum_help2([empty|Ts],A,N):- sum_help2(Ts,A,N).
sum_help2([node(_,L,R)|Ts],A,N):-
    X is A + 1,
    sum_help2([L,R|Ts],X,N).

% mode (+,-)
% ?-num_nodes1(node(4,node(6,empty,empty),node(7,node(8,empty,empty),empty)),N).			SOLUTION:	-> N = 4		
																								%false

/*NUM NODES*/
num_nodes2(T,N):- sum_help3([T],0,N).
sum_help3([], A, A).
sum_help3([leaf(_)|Ts], A, N) :- sum_help3(Ts, A, N).
sum_help3([node2(E,L,R)|Ts],A,N):-
    AE is A + E,
    sum_help3([L,R|Ts],AE,N).

% mode (+,-)
% ?-num_nodes2(node2(6,leaf(1),leaf(9)),N).			-SOLUTION : N = 6



% BST

lesthan(neg,pos).
lesthan(neg,fin(_)).
lesthan(fin(_),pos).
lesthan(fin(N),fin(M)):- N < M.

grtthan(pos,neg).
grtthan(fin(_),neg).
grtthan(pos,fin(_)).
grtthan(fin(N),fin(M)):- N > M.



bst(T) :- bst_hlp(T,neg,pos).
bst_hlp(empty,_,_).
bst_hlp(node(N,L,R),Min,Max):-
	grtthan(fin(N),Min),				

                                            ->Solution : L = R, R = empty,
Max = pos,
Min = neg
	lesthan(fin(N),Max),
	bst_hlp(L,Min,fin(E)),
	bst_hlp(R,fin(E),Max).

	
bst2(T) :- bst2_hlp(T,neg,pos).
bst2_hlp(leaf(E),Min,Max):-
	grtthan(fin(E),Min),			%Solution : Max = pos,
												%Min = neg
	lesthan(fin(E),Max).
bst2_hlp(node2(N,L,R),Min,Max):-
	grtthan(fin(N),Min),
	lesthan(fin(N),Max),
	bst2_hlp(L,Min,fin(N)),
	bst2_hlp(R,fin(N),Max).
