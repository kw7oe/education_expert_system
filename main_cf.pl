main :-
  intro,
  reset_answers,
  find_degree(Degree, CF),
  describe(Degree, CF), nl.

intro :-
  write('Which course should I take?'), nl,
  write('To answer, input the number shown next to each answer, followed by a dot (.)'), nl, nl.

find_degree(Degree, CF) :-
  degree(Degree, CF), !.

% Store user answers to be able to track his progress
:- dynamic(progress/2).

% Clear stored user progress
% reset_answers must always return true; because retract can return either true
% or false, we fail the first and succeed with the second.
reset_answers :-
  retract(progress(_, _)),
  fail.
reset_answers.

% =====
% Rules
% ===== 
logical_thinking(CF) :- 
  logic(CF1),
  rational(CF2),
  calculate_cf(CF1, CF2, 100, RulesCF).

% =======
% Subject
% =======
degree(computing, RulesCF) :-
  logical_thinking(CF1),
  solving_problem(CF2),
  calculate_cf(CF1, CF2, 100, RulesCF).

degree(computing, RulesCF) :-
  logical_thinking(CF1),
  solving_problem(CF2),
  calculate_cf(CF1, CF2, 100, RulesCF).

degree(business, RulesCF) :-
  logical_thinking(CF1)
  calculate_cf(CF1, CF2, 90, RulesCF).


% ===========
% Uncertainty
% ===========
calculate_cf(CF1, CF2, CF3, RulesCF) :-
  Min is min(CF1, CF2),
  RulesCF is div(Min * 20 * CF3, 100).

% =========
% Questions
% =========
question(logic) :-
  write('Are you a person of logic?'), nl.
question(imagination) :-
  write('Are you a person of imagination?'), nl.
question(rational) :-
  write('Are u a rational person?'), nl.
question(solving_problem) :-
  write('Rate 1 to 5, where 1 refers to weak and 5 refers to excellent, '), nl,
  write('How good your problem solving skill is?'), nl.


% ========
% Answers
% ========
answer(strongly_disagree) :-
  write('Strongly disagree.').

answer(disagree) :-
  write('Disagree.').

answer(neutral) :-
  write('Neutral').

answer(agree) :-
  write('Agree.').

answer(strongly_agree) :-
  write('Strongly agree.').

% ==========================
% Assign Answer to Questions
% ==========================

logic(Answer) :-
  progress(logic, Answer).
logic(Answer) :-
  \+ progress(logic, _),
  ask_with_cf(logic, Answer, [strongly_disagree, disagree, neutral, agree, strongly_agree]).

imagination(Answer) :-
  progress(imagination, Answer).
imagination(Answer) :-
  \+ progress(imagination, _),
  ask_with_cf(imagination, Answer, [strongly_disagree, disagree, neutral, agree, strongly_agree]).

rational(Answer) :-
  progress(rational, Answer).
rational(Answer) :-
  \+ progress(rational, _),
  ask_with_cf(rational, Answer, [strongly_disagree, disagree, neutral, agree, strongly_agree]).

solving_problem(Answer) :-
  progress(solving_problem, Answer).
solving_problem(Answer) :-
  \+ progress(solving_problem, _),
  ask_with_cf(solving_problem, Answer, [strongly_disagree, disagree, neutral, agree, strongly_agree]).  


% ============
% Explaination
% ============

% Language descriptions for the knowledge base
describe(computing, CF) :-
  write('Recommendation: Computer Science'), 
  write('(cf '), write(CF), write(')'), nl.

describe(information_technology, CF) :-
  write('Recommendation: Information Technology'),
  write('(cf '), write(CF), write(')'), nl.

describe(business, CF) :-
  write('Recommendation: Business Management'),
  write('(cf '), write(CF), write(')'), nl.

describe(gap_year, _) :-
  write('Gap Year'), nl.

% Outputs a nicely formatted list of answers
% [First|Rest] is the Choices list, Index is the index of First in Choices
answers([], _).
answers([First|Rest], Index) :-
  write(Index), write(' '), answer(First), nl,
  NextIndex is Index + 1,
  answers(Rest, NextIndex).

% Asks the Question to the user and saves the Answer
ask_with_cf(Question, Answer, Choices) :-
  question(Question),
  answers(Choices, 1),
  read(Index),
  asserta(progress(Question, Index)),
  Index = Answer.