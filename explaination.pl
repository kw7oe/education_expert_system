% can_ask shows how to query the user for various types of goal patterns

can_ask(av(Attr, Val), Hist) :-
  not asked(av(Attr, _)),
  askable(Attr, Menu, Edit, Prompt),
  query_user(Attr,Prompt, Menu,Edit,Hist),
  asserta(asked(av(Attr, _)) ).

% answer the how question at the top level, to explain how an answer was
% derived. It can be called successive times to get the whole proof.

how([]) :-
  write('Goal?'), read_line(X), nl,
  pretty(Goal, X),
  how(Goal).

how(X) :-
  pretty(Goal, X),
  nl,
  how(Goal).
how(not Goal) :-
  fact(Goal, CG, Rules),
  CG < -20,
  pretty(not, Goal, PG),
  write_line([PG, was, derived, from,'rules: '|Rules]),
  nl,
  list_rules(Rules),
  fail.
how(Goal) :-
  fact(Goal, CF, Rules),
  CF > 20,
  pretty(Goal, PG),
  write_line([PG, was, derived, from,'rules: '|Rules]),
  nl,
  list_rules(Rules),
  fail.
how(_).

list_rules([]).
list_rules([R|X]) :-
  list_rule(R),
  % how_lhs(R),
  list_rules(X).

