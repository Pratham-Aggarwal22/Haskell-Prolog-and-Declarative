/* Part 3 - Knight's Tour */

% Part a: Adjust the knight tour program so that it works for a board with N x M dimensions. 

% N is size of rows/columns, T is tour
% N2 is the size of the board, N * M
% m(0,0) is the starting position
% [m(P1,P2)|Pt] is the accumulator
% m(P1,P2) is the position of the knight
% when complete board travered, then return accumulator as the tour


knightTour(N,M,T):- N2 is N*M,
    kT(N,M,N2,[m(0,0)],T).

% get next position from current position
% verify next position is within board dimensions
% next position has not already been covered in tour (\+ is negation)

kT(N,M,N2,T,T):- length(T,N2).

kT(N,M,N2,[m(P1,P2)|Pt],T) :-
    moves(m(P1,P2),m(D1,D2)),
    D1>=0,D2>=0,D1<N,D2<M,
    \+ member(m(D1,D2),Pt),
    kT(N,M,N2,[m(D1,D2),m(P1,P2)|Pt],T).

moves(m(X,Y), m(U,V)):-
    member(m(A,B), [m(1,2), m(1,-2), m(-1,2), m(-1,-2), m(2,1), m(2,-1), m(-2,1), m(-2,-1)]),
    U is X + A,
    V is Y + B.

offsets(N1,N2):-
    member(N,[1,2]),
    member(B1,[1,-1]),
    member(B2,[1,-1]),
    N1 is N*B1,
    N2 is (3-N)*B2.

% Part b --> Closed knights tour

% N is size of rows/columns
% T is tour
% N2 is the size of the board, N * M
% m(0,0) is the starting position
% [m(P1,P2)|Pt] is the accumulator
% m(P1,P2) is the position of the knight
% when complete board travered, then return accumulator as the tour


closed_knightTour(N,M,T):- N2 is N*M,
    kT_new(N,M,N2,[m(0,0)],T).

kT_new(_,_,NM,[m(P1,P2)|Pt],[m(0,0),m(P1,P2)|Pt]):- 
   length([m(P1,P2)|Pt],NM),
   moves_new(m(P1,P2),m(0,0)).

kT_new(_,_,N2,T,T) :- length(T,N2).

kT_new(N,M,N2,[m(P1,P2)|Pt],T) :-
    moves_new(m(P1,P2),m(D1,D2)),
    D1>=0,D2>=0,D1<N,D2<M,
    \+ member(m(D1,D2),Pt),
    kT_new(N,M,N2,[m(D1,D2),m(P1,P2)|Pt],T).

moves_new(m(X,Y), m(U,V)):-
    member(m(A,B), [m(1,2), m(1,-2), m(-1,2), m(-1,-2), m(2,1), m(2,-1), m(-2,1), m(-2,-1)]),
    U is X + A,
    V is Y + B.

offsets_new(N1,N2):-
    member(N,[1,2]),
    member(B1,[1,-1]),
    member(B2,[1,-1]),
    N1 is N*B1,
    N2 is (3-N)*B2.

% ?- closed_knightTour(4,7,T).

/*
RUNNING TIME IS 41 SECONDS FOR THIS SO IT MAY TIME TO SEE THE RESULTS

T = [
m(3,0),
m(1,1),
m(3,2),
m(2,0),
m(0,1),
m(1,3),
m(0,5),
m(2,4),
m(0,3),
m(1,5),
m(3,4),
m(2,2),
m(1,0),
m(3,1),
m(2,3),
m(3,5),
m(1,4),
m(0,2),
m(2,1),
m(3,3),
m(2,5),
m(0,4),
m(1,2),
m(0,0)
]
*/
