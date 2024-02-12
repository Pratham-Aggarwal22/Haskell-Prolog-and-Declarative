/* Part 1: Grammars*/


% Define nouns and their representations.
noun(N,[man|X],X,man(N)).
noun(N,[woman|X],X,woman(N)).
noun(N,[child|X],X,child(N)).


% Define names and their representations.
name([john|X],X,john).
name([mary|X],X,mary).
name([bob|X],X,bob).
name([sally|X],X,sally).


% Define transitive verbs and their representations.
transVerb(S,O,[loves|X],X,loves(S,O)).
transVerb(S,O,[knows|X],X,knows(S,O)).


% Define intransitive verbs and their representations.
intrasVerb(S,[lives|X],X,lives(S)).
intrasVerb(S,[runs|X],X,runs(S)).


% Define determiners and their representations.
determiner(S,P1,P2,[every|X],X,all(S,imply(P1,P2))).
determiner(S,P1,P2,[a|X],X,exists(S,imply(P1,P2))).


% Define the main sentence structure.
sentence(X0,X,P):-
	nounPhrase(N,P1,X0,X1,P),
	verbPhrase(N,X1,X,P1).


% Define noun phrases and their representations.
nounPhrase(N,P1,X0,X,P):-
	determiner(N,P2,P1,X0,X1,P),
	noun(N,X1,X2,P3),
	relClause(N,P3,X2,X,P2).

nounPhrase(N,P1,X0,X,P1):-
	name(X0,X,N).
	

% Define verb phrases and their representations.
verbPhrase(S,X0,X,R):-
    nounPhrase(O,_,X0,X1,_),
    transVerb(O,S,X1,X,R).

verbPhrase(S,X0,X,R):-
	transVerb(S,O,X0,X1,P1),
	nounPhrase(O,P1,X1,X,R).

verbPhrase(S,X0,X,R):-
	intrasVerb(S,X0,X,R).


% Define relative clauses and their representations.
relClause(S,P1,[who|X1],X,and(P1,P2)):-
	verbPhrase(S,X1,X,P2).

relClause(_,P1,X,X,P1).

/*Examples:-

#?- sentence([every, woman, who, loves, john, lives],[],Out).

Out = all(_1728,imply(and(woman(_1728),loves(_1728,john)),lives(_1728)))




?- sentence([every, man, who, loves, mary, knows, a, child, who, runs],[],Out).

Out = all(_1752,imply(and(man(_1752),loves(_1752,mary)),exists(_1780,imply(and(child(_554),runs(_554)),knows(_526,_554)))))

*/

