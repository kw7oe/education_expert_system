main :-
  intro,
  reset_answers,
  find_degree(Degree),
  describe(Degree), nl.

intro :-
  write('Which course should I take?'), nl,
  write('To answer, input the number shown next to each answer, followed by a dot (.)'), nl, nl.

find_degree(Degree) :-
  degree(Degree), !.

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
logical_thinking :- logic_or_imagination(logic), rational(yes).
imaginary_thinking :- logic_or_imagination(imagination), rational(no).
physics_person :- work_with_numbers(yes), maths(yes), physics(yes).

% =======
% Subject
% =======
subject(computing) :-
  logical_thinking,
  physics(no),
  better_in(solving_problem),
  computer_or_hands(computer),
  work_with_numbers(yes),
  maths(yes).

subject(computing) :-
  imaginary_thinking,
  better_in(solving_problem),
  computer_or_hands(computer),
  work_with_numbers(no),
  maths(yes).

subject(computing) :-
  computer_or_hands(computer),
  blogs(technology).

subject(engineering) :-
  logical_thinking,
  science(yes),
  theory_or_pratical(pratical),
  better_in(solving_problem),
  challenge_yourself(yes),
  work_with_numbers(yes).

subject(engineering) :- 
  science(yes),
  blogs(science),
  theory_or_pratical(pratical),
  better_in(solving_problem),
  challenge_yourself(yes).

subject(science) :-
  logical_thinking,
  science(yes),
  better_in(solving_problem),
  theory_or_pratical(theory),
  work_with_numbers(yes),
  blogs(science).

subject(science) :-
  science(yes),
  theory_or_pratical(theory).

subject(business) :-  
  like_interact(yes),
  better_in(dealing_with_people),  
  planning(yes),
  risk(yes).

subject(business) :-
  like_interact(yes),
  better_in(dealing_with_people),
  blogs(business),
  planning(yes).

subject(art) :- 
  imaginary_thinking,
  science(no),
  creative_artistic_musical(yes),
  work_with_numbers(no),
  going_museum(yes).

subject(art) :-
  science(no),
  creative_artistic_musical(yes),
  work_with_numbers(no).

subject(hospitality) :-
  computer_or_hands(hands),  
  like_interact(yes),  
  planning(yes),
  service_minded(yes),
  serving_people(yes).

subject(hospitality) :-
  computer_or_hands(hands), 
  service_minded(yes),
  serving_people(yes).

subject(hospitality) :-
  computer_or_hands(hands),
  serving_people(yes).

% ======
% Degree
% ======

% Computing
degree(computer_science) :- 
  subject(computing),
  computer_systems(yes),
  technology(develop).
degree(computer_science) :-
  subject(computing),
  computer_systems(yes).
degree(computer_science) :-
  subject(computing),
  technology(develop).

degree(information_technology) :- 
  subject(computing),
  technology(apply),
  like_interact(yes),
  planning(yes).
degree(information_technology) :-
  subject(computing).

% Engineering
degree(electrical_engineering) :-
  subject(engineering),
  physics(yes),
  circuits(yes).
degree(mechanical_engineering) :-
  subject(engineering),
  physics(yes).
degree(chemical_engineering) :-
  subject(engineering),
  chemistry(yes).

% Science
degree(biotechnology) :-
  subject(science),
  biology(yes),
  genetic_engineering(yes).
degree(pure_science) :- 
  subject(science).

% Business
degree(marketing) :-
  subject(business),
  storytelling(yes).
degree(accounting) :-
  subject(business),
  work_with_numbers(yes),
  detail_oriented(yes).
degree(business_management) :-
  subject(business).

% Arts
degree(performing_art) :-
  subject(art),
  center_of_attention(yes),
  film_or_perform(perform),
  performing(yes).
degree(digital_film_production) :-
  subject(art),
  film_or_perform(film),
  film(yes).

% Hospitality
degree(culinary_art) :- 
  subject(hospitality),
  cook(yes).
degree(hotel_management) :- 
  subject(hospitality).

degree(gap_year).

% =========
% Questions
% =========
question(logic_or_imagination) :-
  write('Are you a person of logic or imagination?'), nl.

question(rational) :-
  write('Are u a rational person?'), nl.

question(ideas) :-
  write('Do you like to deal with ideas, and problems when there is no one clear answer?'), nl.

question(physics) :-
  write('Do you enjoy doing Physics?'), nl.

question(maths) :-
  write('Are you good at Maths?'), nl.

question(science) :-
  write('Do you like Chemistry/Biology/Physics?'), nl.

question(theory_or_pratical) :-
  write('Do you want to discover the next new element or to build the next big invention?'), nl.

question(better_in) :-
  write('What are you better in?'), nl.

question(bad_at) :-
  write('What are you weak at?'), nl.

question(challenge_yourself) :-
  write('Do you like to challenge yourself?'), nl.

question(lifelong_learner) :-
  write('Are you a lifelong learner?'), nl.

question(try_new_things) :-
  write('Do you like to explore new things?'), nl.

question(computer_or_hands) :-
  write('Do you prefer working on a computer or working with your hands?'), nl.

question(like_interact) :-
  write('I like interacting with people.'), nl.

question(serving_people) :-
  write('I dont mind serving people.'), nl.

question(risk) :-
  write('I like to take risk'), nl.

question(work_with_numbers) :-
  write('Do you like working with numbers?'), nl.

question(creative_artistic_musical) :-
  write('Are you creative or artistic or musical?'), nl.

question(going_museum) :-
  write('Do you enjoy going to movie theater and museums?'), nl.

question(service_minded) :-
  write('Are you service minded with a high stress threshold and want to work with people?'), nl.

question(planning) :-
  write('Do you like planning, organising or managing?'), nl.

question(blogs) :-
  write('If given a choice, which blogs do you prefer to read?'), nl.

% Question for Computing
question(computer_systems) :-
  write('Are you interested in the details of how computer systems or software works?'), nl.

question(technology) :-
  write('Do you prefer to apply or develop technology?'), nl.

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

% General
answer(theory) :-
  write('I am more interested to discover the next new element.').
answer(pratical) :-
  write('I am more interested to invent the next big invention.').

answer(solving_problem) :-
  write('Solving Problem.').

answer(math) :-
  write('Math.').

answer(dealing_with_people) :-
  write('Dealing with People.').

answer(logic) :-
  write('I am a person of logic.').

answer(imagination) :-
  write('I am a person of imagination.').

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

answer(apply) :-
  write('I prefer to apply technology.').

answer(develop) :-
  write('I prefer to develop technology.').

answer(film) :-
  write('I prefer shooting film.').

answer(perform) :-
  write('I prefer performing.').

answer(strongly_disagree) :-
  write('Strongly disagree.').

answer(disagree) :-
  write('disagree.').

answer(neutral) :-
  write('Neutral').

answer(agree) :-
  write('agree.').

answer(strongly_agree) :-
  write('Strongly agree.').

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

chemistry(Answer) :-
  progress(chemistry, Answer).
chemistry(Answer) :-
  \+ progress(chemistry, _),
  ask(chemistry, Answer, [yes, no]).

biology(Answer) :-
  progress(biology, Answer).
biology(Answer) :-
  \+ progress(biology, _),
  ask(biology, Answer, [yes, no]).

theory_or_pratical(Answer) :-
  progress(theory_or_pratical, Answer).
theory_or_pratical(Answer) :-
  \+ progress(theory_or_pratical, _),
  ask(theory_or_pratical, Answer, [theory, pratical]).

better_in(Answer) :-
  progress(better_in, Answer).
better_in(Answer) :-
  \+ progress(better_in, _),
  ask(better_in, Answer, [solving_problem, dealing_with_people]).

bad_at(Answer) :-
  progress(bad_at, Answer).
bad_at(Answer) :-
  \+ progress(bad_at, _),
  ask(bad_at, Answer, [math, dealing_with_people]).

logic_or_imagination(Answer) :-
  progress(logic_or_imagination, Answer).
logic_or_imagination(Answer) :-
  \+ progress(logic_or_imagination, _),
  ask(logic_or_imagination, Answer, [logic, imagination]).

rational(Answer) :-
  progress(rational, Answer).
rational(Answer) :-
  \+ progress(rational, _),
  ask(rational, Answer, [yes, no]).

ideas(Answer) :-
  progress(ideas, Answer).
ideas(Answer) :-
  \+ progress(ideas, _),
  ask(ideas, Answer, [yes, no]).

risk(Answer) :-
  progress(risk, Answer).
risk(Answer) :-
  \+ progress(risk, _),
  ask(risk, Answer, [yes, no]).

challenge_yourself(Answer) :-
  progress(challenge_yourself, Answer).
challenge_yourself(Answer) :-
  \+ progress(challenge_yourself, _),
  ask(challenge_yourself, Answer, [yes, no]).

lifelong_learner(Answer) :-
  progress(lifelong_learner, Answer).
lifelong_learner(Answer) :-
  \+ progress(lifelong_learner, _),
  ask(lifelong_learner, Answer, [yes, no]).

try_new_things(Answer) :-
  progress(try_new_things, Answer).
try_new_things(Answer) :-
  \+ progress(try_new_things, _),
  ask(try_new_things, Answer, [yes, no]).

like_interact(Answer) :-
  progress(like_interact, Answer).
like_interact(Answer) :-
  \+ progress(like_interact, _),
  ask(like_interact, Answer, [yes, no]).

serving_people(Answer) :-
  progress(serving_people, Answer).
serving_people(Answer) :-
  \+ progress(serving_people, _),
  ask(serving_people, Answer, [yes, no]).

service_minded(Answer) :-
  progress(service_minded, Answer).
service_minded(Answer) :-
  \+ progress(service_minded, _),
  ask(service_minded, Answer, [yes, no]).

planning(Answer) :-
  progress(planning, Answer).
planning(Answer) :-
  \+ progress(planning, _),
  ask(planning, Answer, [yes, no]).

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

creative_artistic_musical(Answer) :-
  progress(creative_artistic_musical, Answer).
creative_artistic_musical(Answer) :-
  \+ progress(creative_artistic_musical, _),
  ask(creative_artistic_musical, Answer, [yes, no]).

going_museum(Answer) :-
  progress(going_museum, Answer).
going_museum(Answer) :-
  \+ progress(going_museum, _),
  ask(going_museum, Answer, [yes, no]).

blogs(Answer) :-
  progress(blogs, Answer).
blogs(Answer) :-
  \+ progress(blogs, _),
  ask(blogs, Answer, [business, technology, science]).

% Computer Science
computer_systems(Answer) :-
  progress(computer_systems, Answer).
computer_systems(Answer) :-
  \+ progress(computer_systems, _),
  ask(computer_systems, Answer, [yes, no]).

technology(Answer) :-
  progress(technology, Answer).
technology(Answer) :-
  \+ progress(technology, _),
  ask(technology, Answer, [apply, develop]).

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

% ============
% Explaination
% ============

% Language descriptions for the knowledge base
describe(computer_science) :-
  write('Computer Science'), nl,
  write('Widely regarded as the best programming language for beginners'), nl,
  write('Easiest to learn').

describe(information_technology) :-
  write('Information Technology'), nl,
  write('Widely regarded as the best programming language for beginners'), nl,
  write('Easiest to learn').

describe(electrical_engineering) :-
  write('Electrical Engineering'), nl,
  write('Widely regarded as the best programming language for beginners'), nl,
  write('Easiest to learn').

describe(mechanical_engineering) :-
  write('Mechanical Engineering'), nl,
  write('Widely regarded as the best programming language for beginners'), nl,
  write('Easiest to learn').

describe(chemical_engineering) :-
  write('Chemical Engineering'), nl,
  write('Widely regarded as the best programming language for beginners'), nl,
  write('Easiest to learn').

describe(biotechnology) :-
  write('Biotechnology'), nl,
  write('Widely regarded as the best programming language for beginners'), nl,
  write('Easiest to learn').

describe(pure_science) :-
  write('Pure Science'), nl,
  write('Widely regarded as the best programming language for beginners'), nl,
  write('Easiest to learn').

describe(marketing) :-
  write('Marketing'), nl,
  write('Widely regarded as the best programming language for beginners'), nl,
  write('Easiest to learn').

describe(accounting) :-
  write('Accounting'), nl,
  write('Widely regarded as the best programming language for beginners'), nl,
  write('Easiest to learn').

describe(business_management) :-
  write('Business Management'), nl,
  write('One of the most in demand & highest paying programming languages'), nl,
  write('Slogan: write once, work everywhere').

describe(performing_art) :-
  write('Performing Art'), nl,
  write('One of the most in demand & highest paying programming languages'), nl,
  write('Slogan: write once, work everywhere').

describe(digital_film_production) :-
  write('Digital Film Production'), nl,
  write('One of the most in demand & highest paying programming languages'), nl,
  write('Slogan: write once, work everywhere').

describe(culinary_art) :-
  write('Culinary Art'), nl,
  write('One of the most in demand & highest paying programming languages'), nl,
  write('Slogan: write once, work everywhere').

describe(hotel_management) :-
  write('Hotel Management'), nl,
  write('One of the most in demand & highest paying programming languages'), nl,
  write('Slogan: write once, work everywhere').

describe(gap_year) :-
  write('Gap Year'), nl.

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
parse(Index, [First|Rest], Response) :-
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
