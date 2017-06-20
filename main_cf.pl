main :-
  intro,
  reset_answers,
  find_degree, nl.

intro :-
  write('Which course should I take?'), nl,
  write('To answer, input the number shown next to each answer, followed by a dot (.)'), nl, nl.

find_degree :-
  degree(_), !.

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
logical_thinking(RulesCF) :- 
  logic(CF1),
  rational(CF2),
  calculate_cf([CF1, CF2], 100, RulesCF).

% =======
% Subject
% =======
subject(computing, CombinedCF, E) :-
  logical_thinking(CF1),
  physics(no),
  solving_problem(CF2),
  computer_or_hands(computer),
  work_with_numbers(yes),
  maths(yes),
  calculate_cf([CF1, CF2], 100, CombinedCF),
  E = 'You are a logical person and don\'t like physics. \c 
  However, you are good in maths and solving problems.'.
subject(computing, CombinedCF, E) :-
  solving_problem(CF1),
  work_with_numbers(no),
  maths(yes),
  calculate_cf([CF1], 85, CombinedCF),
  E = 'You are good in maths and solving problems. \c
  You also prefer to work on a computer.'.
subject(computing, CombinedCF, E) :-
  blogs(technology),
  calculate_cf([100], 70, CombinedCF),
  E = 'You perfer working on a computer and like reading \c 
  blogs related to technology.'.

subject(engineering, CombinedCF, E) :-
  logical_thinking(CF1),
  science(yes),
  theory_or_pratical(pratical),
  solving_problem(CF2),
  challenge_yourself(yes),
  work_with_numbers(yes), 
  calculate_cf([CF1, CF2], 100, CombinedCF),
  E = 'You love science \c 
  and like to work with numbers.'.
subject(engineering, CombinedCF, E) :- 
  science(yes),
  blogs(science),
  theory_or_pratical(pratical),
  solving_problem(CF1),
  challenge_yourself(yes),
  calculate_cf([CF1], 90, CombinedCF),
  E = 'You love science \c 
  and like to work with numbers.'.

subject(science, CombinedCF, E) :-
  logical_thinking(CF1),
  science(yes),
  solving_problem(CF2),
  theory_or_pratical(theory),
  work_with_numbers(yes),
  blogs(science),
  calculate_cf([CF1, CF2], 90, CombinedCF),
  E = 'You love science, prefer theory \c 
  and like to work with numbers.'.
subject(science, CombinedCF, E) :-
  science(yes),
  theory_or_pratical(theory),
  calculate_cf([100], 80, CombinedCF),
  E = 'You love science and prefer theory.'.


degree(computer_science) :-
  subject(computing, CF1, E),
  technology(CF2),
  calculate_cf([CF1, CF2], 90, CF),
  write('Recommendation: Computer Science'), 
  write('(cf '), write(CF), write(')'), nl,
  write(E).
degree(computer_science) :-
  subject(computing, CF1, E),
  computer_systems(CF2),
  calculate_cf([CF1, CF2], 90, CF),
  write('Recommendation: Computer Science'), 
  write('(cf '), write(CF), write(')'), nl,
  write(E).
degree(computer_science) :- 
  subject(computing, CF1, E),
  computer_systems(CF2),
  technology(CF3),
  calculate_cf([CF1, CF2, CF3], 100, CF),
  write('Recommendation: Computer Science'), 
  write('(cf '), write(CF), write(')'), nl,
  write(E).

degree(information_technology) :- 
  subject(computing, CF1, E),
  technology(apply),
  like_interact(yes),
  planning(yes),
  calculate_cf([CF1], 100, CF),
  write('Recommendation: Information Technology'), 
  write('(cf '), write(CF), write(')'), nl,
  write(E).
degree(information_technology) :-
  subject(computing, CF1, E),
  calculate_cf([CF1], 90, CF),
  write('Recommendation: Information Technology'), 
  write('(cf '), write(CF), write(')'), nl,
  write(E).

% Engineering
degree(electrical_engineering) :-
  subject(engineering, CF1, E),
  physics(yes),
  circuits(yes),
  calculate_cf([CF1], 90, CF),
  write('Recommendation: Electrical Engineering'), 
  write('(cf '), write(CF), write(')'), nl,
  write(E).
degree(mechanical_engineering) :-
  subject(engineering, CF1, E),
  physics(yes),
  calculate_cf([CF1], 90, CF),
  write('Recommendation: Mechanical Engineering'), 
  write('(cf '), write(CF), write(')'), nl,
  write(E).
degree(chemical_engineering) :-
  subject(engineering, CF1, E),
  chemistry(yes),
  calculate_cf([CF1], 90, CF),
  write('Recommendation: Chemical Engineering'), 
  write('(cf '), write(CF), write(')'), nl,
  write(E).

% Science
degree(biotechnology) :-
  subject(science, CF1, E),
  biology(yes),
  genetic_engineering(yes),
  calculate_cf([CF1], 90, CF),
  write('Recommendation: Computer Science'), 
  write('(cf '), write(CF), write(')'), nl,
  write(E).
degree(pure_science, CF1, E) :- 
  subject(science, CF1, E),
  calculate_cf([CF1], 90, CF),
  write('Recommendation: Computer Science'), 
  write('(cf '), write(CF), write(')'), nl,
  write(E).

% ===========
% Uncertainty
% ===========
calculate_cf(CFList, CF, RulesCF) :-
  min_in_list(CFList, Min),
  RulesCF is div(Min * 20 * CF, 100).

min_in_list([Min],Min). 
min_in_list([H,K|T],M) :-
    H =< K,                            
    min_in_list([H|T],M). 
min_in_list([H,K|T],M) :-
    H > K,                              
    min_in_list([K|T],M).      

% =========
% Questions
% =========

% CF 100
question(physics) :-
  write('Do you enjoy doing Physics?'), nl.
question(maths) :-
  write('Are you good at Maths?'), nl.
question(computer_or_hands) :-
  write('Do you prefer working on a computer or working with your hands?'), nl.
question(work_with_numbers) :-
  write('Do you like working with numbers?'), nl.
question(blogs) :-
  write('If given a choice, which blogs do you prefer to read?'), nl.
question(theory_or_pratical) :-
  write('Do you want to discover the next new element or to build the next big invention?'), nl.
question(challenge_yourself) :-
  write('Do you like to challenge yourself?'), nl.

% CF Unknown
question(logic) :-
  write('Are you a person of logic?'), nl.
question(imagination) :-
  write('Are you a person of imagination?'), nl.
question(rational) :-
  write('Are u a rational person?'), nl.
question(solving_problem) :-
  write('Rate 1 to 5, where 1 refers to weak and 5 refers to excellent, '), nl,
  write('How good your problem solving skill is?'), nl.

% Computer Science
question(computer_systems) :-
  write('I am interested in the details of how computer systems or software works.'), nl.
question(technology) :-
  write('I prefer to develop technology rather than apply technology.'), nl.
% Question for Engineering
question(circuits) :-
  write('Do you like to deal with circuits?'), nl.

question(chemistry) :-
  write('Do you like Chemistry?'), nl.

% Question for Science 
question(biology) :-
  write('Do you like Biology?'), nl.

question(genetic_engineering) :-
  write('Do you find genetic engineering intersting?'), nl.

% Question for Business
question(detail_oriented) :-
  write('Are you detail oriented and pay attention to little things?'), nl.

question(storytelling) :-
  write('Are you good at storytelling?'), nl.

% Question for Arts
question(center_of_attention) :-
  write('I like being the center of attention.'), nl.

question(film_or_perform) :-
  write('Do you prefer shooting film or performing?'), nl.

question(film) :-
  write('Are you interested in the arts of storytelling and the language of film?'), nl.

question(performing) :-
  write('I prefer to convey artistic expression through acting/dancing/singing.'), nl.

% Question for Hospitality
question(cook) :-
  write('Do you enjoy cooking?'), nl.

% ========
% Answers
% ========
answer(computer) :-
  write('I prefer working on a computer.').
answer(hands) :-
  write('I prefer working with your hands.').
answer(yes) :-
  write('Yes.').
answer(no) :-
  write('No.').
answer(business) :- 
  write('Forbes or BusinessInsider.').
answer(technology) :-
  write('HackerNews or AnandTech.').
answer(science) :-
  write('howstuffworks or New Scientist.').
answer(theory) :-
  write('I am more interested to discover the next new element.').
answer(pratical) :-
  write('I am more interested to invent the next big invention.').


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

answer(-100) :-
  write(1).

answer(-50) :-
  write(2).

answer(0) :-
  write(3).

answer(50) :-
  write(4).

answer(100) :-
  write(5).

% ==========================
% Assign Answer to Questions
% ==========================
science(Answer) :-
  progress(science, Answer).
science(Answer) :-
  \+ progress(science, _),
  ask(science, Answer, [yes, no]).
physics(Answer) :-
  progress(physics, Answer).
physics(Answer) :-
  \+ progress(physics, _),
  ask(physics, Answer, [yes, no]).
maths(Answer) :-
  progress(maths, Answer).
maths(Answer) :-
  \+ progress(maths, _),
  ask(maths, Answer, [yes, no]).
work_with_numbers(Answer) :-
  progress(work_with_numbers, Answer).
work_with_numbers(Answer) :-
  \+ progress(work_with_numbers, _),
  ask(work_with_numbers, Answer, [yes, no]).
computer_or_hands(Answer) :-
  progress(computer_or_hands, Answer).
computer_or_hands(Answer) :-
  \+ progress(computer_or_hands, _),
  ask(computer_or_hands, Answer, [computer, hands]).
blogs(Answer) :-
  progress(blogs, Answer).
blogs(Answer) :-
  \+ progress(blogs, _),
  ask(blogs, Answer, [business, technology, science]).
theory_or_pratical(Answer) :-
  progress(theory_or_pratical, Answer).
theory_or_pratical(Answer) :-
  \+ progress(theory_or_pratical, _),
  ask(theory_or_pratical, Answer, [theory, pratical]).
challenge_yourself(Answer) :-
  progress(challenge_yourself, Answer).
challenge_yourself(Answer) :-
  \+ progress(challenge_yourself, _),
  ask(challenge_yourself, Answer, [yes, no]).


% Engineering
circuits(Answer) :-
  progress(circuits, Answer).
circuits(Answer) :-
  \+ progress(circuits, _),
  ask(circuits, Answer, [yes, no]).

% Science
genetic_engineering(Answer) :-
  progress(genetic_engineering, Answer).
genetic_engineering(Answer) :-
  \+ progress(genetic_engineering, _),
  ask(genetic_engineering, Answer, [yes, no]).

% Business
storytelling(Answer) :-
  progress(storytelling, Answer).
storytelling(Answer) :-
  \+ progress(storytelling, _),
  ask(storytelling, Answer, [yes, no]).

detail_oriented(Answer) :-
  progress(detail_oriented, Answer).
detail_oriented(Answer) :-
  \+ progress(detail_oriented, _),
  ask(detail_oriented, Answer, [yes, no]).

% Art
center_of_attention(Answer) :-
  progress(center_of_attention, Answer).
center_of_attention(Answer) :-
  \+ progress(center_of_attention, _),
  ask(center_of_attention, Answer, [yes, no]).

film_or_perform(Answer) :-
  progress(film_or_perform, Answer).
film_or_perform(Answer) :-
  \+ progress(film_or_perform, _),
  ask(film_or_perform, Answer, [film, perform]).

film(Answer) :-
  progress(film, Answer).
film(Answer) :-
  \+ progress(film, _),
  ask(film, Answer, [yes, no]). 

performing(Answer) :-
  progress(performing, Answer).
performing(Answer) :-
  \+ progress(performing, _),
  ask(performing, Answer, [yes, no]). 

% Hospitality
cook(Answer) :-
  progress(cook, Answer).
cook(Answer) :-
  \+ progress(cook, _),
  ask(cook, Answer, [yes, no]).

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

computer_systems(Answer) :-
  progress(computer_systems, Answer).
computer_systems(Answer) :-
  \+ progress(computer_systems, _),
  ask_with_cf(computer_systems, Answer, [strongly_disagree, disagree, neutral, agree, strongly_agree]).

technology(Answer) :-
  progress(technology, Answer).
technology(Answer) :-
  \+ progress(technology, _),
  ask_with_cf(technology, Answer, [strongly_disagree, disagree, neutral, agree, strongly_agree]).


% Outputs a nicely formatted list of answers
% [First|Rest] is the Choices list, Index is the index of First in Choices
answers([], _).
answers([First|Rest], Index) :-
  write(Index), write(' '), answer(First), nl,
  NextIndex is Index + 1,
  answers(Rest, NextIndex).

% Parses an Index and returns a Response representing the "Indexth" element in
% Choices (the [First|Rest] list)
parse(0, [First|_], First).
parse(Index, [_First|Rest], Response) :-
  Index > 0,
  NextIndex is Index - 1,
  parse(NextIndex, Rest, Response).

% Asks the Question to the user and saves the Answer
ask(Question, Answer, Choices) :-
  question(Question),
  answers(Choices, 0),
  read(Index),
  parse(Index, Choices, Response),
  asserta(progress(Question, Response)),
  Response = Answer.

% Asks the Question to the user and saves the Answer
ask_with_cf(Question, Answer, Choices) :-
  question(Question),
  answers(Choices, 1),
  read(Index),
  asserta(progress(Question, Index)),
  Index = Answer.