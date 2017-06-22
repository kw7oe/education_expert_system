main :-
  intro,
  reset_answers,
  find_degree,
  describe_all.

intro :-
  write('Which course should I take?'), nl,
  write('To answer, input the number shown next to each answer, followed by a dot (.)'), nl, nl.

find_degree:-
    degree(_),fail.

find_degree:-
    true.

% Store user answers to be able to track his progress
:- dynamic(progress/2).
:- dynamic(inserted/1).
:- dynamic(describe/1).

% Clear stored user progress
% reset_answers must always return true; because retract can return either true
% or false, we fail the first and succeed with the second.
reset_answers :-
  retractall(inserted(_)),
  retractall(describe(_)),
  retract(progress(_, _)),
  fail.
reset_answers.

% =====
% Rules
% ===== 
logical_thinking(RulesCF) :- 
  logic(CF1),
  rational(CF2),
  larger_than_CF(CF1),
  larger_than_CF(CF2),
  calculate_cf([CF1, CF2], 100, RulesCF).

write_combinedCF(CF1, CF2, CombinedCF) :-
  write('--------'), nl,
  write('CF1: '), write(CF1), nl,
  write('CF2: '), write(CF2), nl,
  write('CombinedCF: '), write(CombinedCF), nl,
  write('--------'), nl.

write_combinedCF(CF1, CF2, CF3, CombinedCF) :-
  write('--------'), nl,
  write('CF1: '), write(CF1), nl,
  write('CF2: '), write(CF2), nl,
  write('CF3: '), write(CF3), nl,
  write('CombinedCF: '), write(CombinedCF), nl,
  write('--------'), nl.

% =======
% Subject
% =======
subject(computing, CombinedCF,E) :-
  logical_thinking(CF1),
  larger_than_CF(CF1),
  physics(no),
  solving_problem(CF2),
  larger_than_CF(CF2),
  computer_or_hands(computer),
  work_with_numbers(yes),
  maths(yes),
  calculate_cf([CF1, CF2], 100, CombinedCF),
  % Debug
  write_combinedCF(CF1, CF2, CombinedCF),
  E='You are a logical person and don\'t like physics. \c 
  However, you are good in maths and solving problems using computer. \c
  So, you are suitable for computing subject.'.

subject(computing, CombinedCF,E) :-
  logical_thinking(CF1),
  larger_than_CF(CF1),
  solving_problem(CF2),
  larger_than_CF(CF2),
  work_with_numbers(no),
  maths(yes),
  calculate_cf([CF1, CF2], 90, CombinedCF),
  % Debug
  write_combinedCF(CF1, CF2, CombinedCF),
  E='You are good in maths and solving problems.\c
  So, you are suitable for computing subject.'.

subject(computing, CombinedCF,E) :-
  logical_thinking(CF1),
  computer_or_hands(computer),
  blogs(technology),
  calculate_cf([CF1], 85, CombinedCF),
  % Debug
  write_combinedCF(CF1, 100, CombinedCF),
  E='You perfer working on a computer and like reading \c 
  blogs related to technology.\c
  So, you are suitable for computing subject.'.

subject(engineering, CombinedCF,E) :-
  logical_thinking(CF1),  
  larger_than_CF(CF1),
  science(CF2),
  larger_than_CF(CF2),
  theory_or_pratical(pratical),
  solving_problem(_),
  challenge_yourself(yes),
  work_with_numbers(yes),
  calculate_cf([CF1, CF2], 100, CombinedCF),
  % Debug
  write_combinedCF(CF1, 100, CombinedCF),
  E='You are a logical person and like science. \c
  You like to do practical stuff and good in solving problems.\c
  You also like to challenge yourself and work with numbers.\c
  So, you are suitable for engineering subject.'.

subject(engineering, CombinedCF,E) :- 
  science(CF1),
  larger_than_CF(CF1),
  blogs(science),
  theory_or_pratical(pratical),
  solving_problem(_),
  challenge_yourself(yes),
  calculate_cf([CF1], 90, CombinedCF),
  % Debug
  write_combinedCF(CF1, 100, CombinedCF),
  E='You love science and like to read blogs related to science.\c
  You like to do practical stuff and good in solving problems.\c
  You also like to challenge yourself.\c
  So, you are suitable for engineering subject.'.

% Subject: Science
subject(science, CombinedCF,E) :-
  logical_thinking(CF1),
  larger_than_CF(CF1),
  science(CF2),  
  larger_than_CF(CF2),
  solving_problem(_),
  theory_or_pratical(theory),
  work_with_numbers(yes),
  blogs(science),
  calculate_cf([CF1, CF2], 100, CombinedCF),
  % Debug
  write_combinedCF(CF1, CF2, CombinedCF),
  E='You are a logical person who love science.\c
  You are good in solving problem and like theory over practical.\c
  You like to work with numbers and read blogs related to science.\c
  So, you are suitable for science subject.'.

subject(science, CombinedCF,E) :-
  science(CF1),  
  larger_than_CF(CF1),
  theory_or_pratical(theory),
  calculate_cf([CF1], 90, CombinedCF),
  % Debug
  write_combinedCF(CF1, 100, CombinedCF),
  E='You love science and prefer theory over practical.\c
  So, you are suitable for science subject.'.

% Subject: Business
subject(business, CombinedCF,E) :-  
  like_interact(CF1),   
  larger_than_CF(CF1),
  dealing_with_people(CF2),  
  larger_than_CF(CF2), 
  planning(yes),
  risk(CF3),
  larger_than_CF(CF3),
  calculate_cf([CF1, CF2, CF3], 100, CombinedCF),
  % Debug
  write_combinedCF(CF1, CF2, CombinedCF),
  E='You like to interact with people, dealing with people and like planning.\c
  You are also a risk taker.\c
  So, you are suitable for business subject.'.

subject(business, CombinedCF,E) :-
  like_interact(CF1),
  larger_than_CF(CF1),
  dealing_with_people(CF2),  
  larger_than_CF(CF2),
  blogs(business),
  planning(yes),
  calculate_cf([CF1, CF2], 90, CombinedCF),
  % Debug
  write_combinedCF(CF1, CF2, CombinedCF),
  E='You like to interact and dealing with people.\c
  You also like to read business blog and planning.\c
  So, you are suitable for business subject.'.

% Subject: Art
subject(art, CombinedCF,E) :- 
  imagination(CF1),  
  larger_than_CF(CF1),
  creative_artistic_musical(CF2),
  larger_than_CF(CF2),
  work_with_numbers(no),
  going_museum(yes),
  calculate_cf([CF1, CF2], 100, CombinedCF),
  % Debug
  write_combinedCF(CF1, CF2, CombinedCF),
  E='You are a person who like to imagine and does not like science.\c
  You are also a creative or artistic or musical person.\c
  You does not like working with numbers.\c
  You like going to movie theater or museum.\c
  So, you are suitable for art subject.'.


subject(art, CombinedCF,E) :-
  creative_artistic_musical(CF1),
  work_with_numbers(no),
  calculate_cf([CF1], 90, CombinedCF),
  % Debug
  write_combinedCF(CF1, 100, CombinedCF),
  E='You does not like science.\c
  You are a creative or artistic or musical person.\c
  You does not like working with numbers.\c
  So, you are suitable for art subject.'.


% Subject: Hospitality
subject(hospitality, CombinedCF,E) :-
  computer_or_hands(hands),  
  like_interact(yes),  
  planning(yes),
  service_minded(CF1),
  serving_people(CF2),
  calculate_cf([CF1, CF2], 100, CombinedCF),
  % Debug
  write_combinedCF(CF1, CF2, CombinedCF),
  E='You prefer to working with hands.\c
  You like to interact with people and planning.\c
  You are a service minded person who like to serve people.\c
  So, you are suitable for hospitality subject.'.

subject(hospitality, CombinedCF,E) :-
  computer_or_hands(hands), 
  service_minded(CF1),
  serving_people(CF2),
  calculate_cf([CF1, CF2], 90, CombinedCF),
  % Debug
  write_combinedCF(CF1, CF2, CombinedCF),
  E='You prefer to working with hands.\c
  You are a service minded person who like to serve people.\c
  So, you are suitable for hospitality subject.'.

subject(hospitality, CombinedCF,E) :-
  computer_or_hands(hands),
  serving_people(CF1),
  calculate_cf([CF1], 85, CombinedCF),
  % Debug
  write_combinedCF(CF1, 100, CombinedCF),
  E='You prefer working with hands.\c
  You like to serve people.\c
  So, you are suitable for hospitality subject.'.

% Degree: Computer Science
degree(computer_science) :- 
  subject(computing, CF1,E),  
  larger_than_CF(CF1),
  computer_systems(CF2),  
  larger_than_CF(CF2),
  technology(CF3),
  larger_than_CF(CF3),  
  calculate_cf([CF1, CF2, CF3], 100, CF),
  % Debug 
  write_combinedCF(CF1, CF2, CF3, CF),
  nl,
  \+inserted(computer_science),
  assert(inserted(computer_science)),
  assert(describe(computer_science):- ( 
  nl,nl,
  write('Recommendation: Computer Science '), 
  write('(cf '), write(CF), write(')'), nl,
  write('You are interested in the details of how computer systems or software works.\c
  You also prefer to develop technology rather than apply technology.\c
  So, you are suitable for the degree of computer science.'),nl,
  write(E)),nl,
  write('The careers that suitable for you are:'),nl,
  write('- Chief Technology Officer'),nl,
  write('- Software Engineer / Software Architect'),nl,
  write('- Mobile App Developer'),nl,
  write('- Game Developer'),nl,
  write('- System Designer'),nl,
  write('- Network Specialist'),nl,
  write('- Research Analyst'),nl,
  write('- Software Quality Assurance Officer'),nl,
  write('- Enterprise Distributed Application Developer')).


degree(computer_science) :- 
  subject(computing, CF1,E),  
  larger_than_CF(CF1),
  computer_systems(CF2),
  larger_than_CF(CF2),  
  calculate_cf([CF1, CF2], 95, CF),
  % Debug 
  write_combinedCF(CF1, CF2, CF),
  nl,
  \+inserted(computer_science),
  assert(inserted(computer_science)),
  assert(describe(computer_science):- (
  nl,nl,
  write('Recommendation: Computer Science '), 
  write('(cf '), write(CF), write(')'), nl,
  write('You are interested in the details of how computer systems or software works.\c
  You also prefer to develop technology rather than apply technology.\c
  So, you are suitable for the degree of computer science.'),nl,
  write(E)),nl,
  write('The careers that suitable for you are:'),nl,
  write('- Chief Technology Officer'),nl,
  write('- Software Engineer / Software Architect'),nl,
  write('- Mobile App Developer'),nl,
  write('- Game Developer'),nl,
  write('- System Designer'),nl,
  write('- Network Specialist'),nl,
  write('- Research Analyst'),nl,
  write('- Software Quality Assurance Officer'),nl,
  write('- Enterprise Distributed Application Developer')).

degree(computer_science) :- 
  subject(computing, CF1,E),  
  larger_than_CF(CF1),
  technology(CF2),
  larger_than_CF(CF2),  
  calculate_cf([CF1, CF2], 95, CF),
  % Debug 
  write_combinedCF(CF1, CF2, CF),
  nl, 
  \+inserted(computer_science),
  assert(inserted(computer_science)),
  assert(describe(computer_science):- (
  nl,nl,
  write('Recommendation: Computer Science '), 
  write('(cf '), write(CF), write(')'), nl,
  write('You are interested in the details of how computer systems or software works.\c
  You also prefer to develop technology rather than apply technology.\c
  So, you are suitable for the degree of computer science.'),nl,
  write(E)),nl,
  write('The careers that suitable for you are:'),nl,
  write('- Chief Technology Officer'),nl,
  write('- Software Engineer / Software Architect'),nl,
  write('- Mobile App Developer'),nl,
  write('- Game Developer'),nl,
  write('- System Designer'),nl,
  write('- Network Specialist'),nl,
  write('- Research Analyst'),nl,
  write('- Software Quality Assurance Officer'),nl,
  write('- Enterprise Distributed Application Developer')).

% Degree: Information Technology
degree(information_technology) :- 
  subject(computing, CF1,E),  
  larger_than_CF(CF1),
  like_interact(CF2),  
  larger_than_CF(CF2), 
  planning(yes),
  calculate_cf([CF1, CF2], 100, CF),
  % Debug
  write_combinedCF(CF1, CF2, CF),
  nl, 
  \+inserted(information_technology),
  assert(inserted(information_technology)),
  assert(describe(information_technology):- (
    nl,nl,
  write('Recommendation: Information Technology '), 
  write('(cf '), write(CF), write(')'), nl,
  write('You are interested to interact with people and like to planning.\c
  So, you are suitable for the degree of information technology.'),nl,
  write(E)),nl,
  write('The careers that suitable for you are:'),nl,
  write('- IT Specialist'),nl,
  write('- Network Specialist'),nl,
  write('- System Engineer'),nl,
  write('- Web / E-Commerce Architect'),nl,
  write('- Database Architect'),nl,
  write('- IT Infrastructure Engineer')).

degree(information_technology) :-
  subject(computing, CF1,E),
  larger_than_CF(CF1),
  calculate_cf([CF1], 70, CF),
  % Debug
  write_combinedCF(CF1, 100, CF),
  nl, 
  \+inserted(information_technology),
  assert(inserted(information_technology)),
  assert(describe(information_technology):- (
    nl,nl,
  write('Recommendation: Information Technology '), 
  write('(cf '), write(CF), write(')'), nl,
  write('You are suitable for the degree of information technology.'),nl,
  write(E)),nl,
  write('The careers that suitable for you are:'),nl,
  write('- IT Specialist'),nl,
  write('- Network Specialist'),nl,
  write('- System Engineer'),nl,
  write('- Web / E-Commerce Architect'),nl,
  write('- Database Architect'),nl,
  write('- IT Infrastructure Engineer')).

% Degree: Electrical Engineering
degree(electrical_engineering) :-
  subject(engineering, CF1,E),
  larger_than_CF(CF1),
  physics(CF2),
  larger_than_CF(CF2),
  circuits(yes),
  calculate_cf([CF1, CF2], 95, CF),
  nl,
  \+inserted(electrical_engineering),
  assert(inserted(electrical_engineering)),
  assert(describe(electrical_engineering):- (
    nl,nl,
  write('Recommendation: Electrical Engineering '), 
  write('(cf '), write(CF), write(')'), nl,
  write('You like physics and like to deal with circuits. \c
  You are suitable for the degree of electrical engineering.'),nl,
  write(E)),nl,
  write('The careers that suitable for you are:'),nl,
  write('- Electrical or Electronic Engineer'),nl,
  write('- Design Manager in Designing'),nl,
  write('- Maintenance of Electrical Power System, Electricity Generation, Transmission, Distribution, Utilisation'),nl,
  write('- Electronic System for Operational Safety/Efficiency or Designing Renewable Energy System')).

% Degree: Mechanical Engineering
degree(mechanical_engineering) :-
  subject(engineering, CF1,E),
  larger_than_CF(CF1),
  physics(CF2),
  larger_than_CF(CF2),
  calculate_cf([CF1, CF2], 95, CF),
  nl,
  \+inserted(mechanical_engineering),
  assert(inserted(mechanical_engineering)),
  assert(describe(mechanical_engineering):- (
    nl,nl,
  write('Recommendation: Mechanical Engineering '), 
  write('(cf '), write(CF), write(')'), nl,
  write('You like physics. \c
  You are suitable for the degree of mechanical engineering.'),nl,
  write(E)),nl,
  write('The careers that suitable for you are:'),nl,
  write('- Mechanical Engineer'),nl,
  write('- Production Engineer'),nl,
  write('- Failure Analyst Engineer'),nl,
  write('- M&E Engineer'),nl,
  write('- QC Engineer'),nl,
  write('- Manufacturing Engineer'),nl,
  write('- R&D Engineer'),nl,
  write('- Design Engineer'),nl,
  write('- Product Engineer')).

% Degree: Chemical Engineering
degree(chemical_engineering) :-
  subject(engineering, CF1,E),
  larger_than_CF(CF1),
  chemistry(CF2),
  larger_than_CF(CF2),
  calculate_cf([CF1, CF2], 95, CF),
  nl,
  \+inserted(chemical_engineering),
  assert(inserted(chemical_engineering)),
  assert(describe(chemical_engineering):- (
    nl,nl,
  write('Recommendation: Chemical Engineering '), 
  write('(cf '), write(CF), write(')'), nl,
  write('You like chemistry. \c
  You are suitable for the degree of chemical engineering.'),nl,
  write(E)),nl,
  write('The careers that suitable for you are:'),nl,
  write('- Process Engineer'),nl,
  write('- Quality Assurance Engineer'),nl,
  write('- Chemical & Biochemical Engineer'),nl,
  write('- Contamination Engineer')).

% Degree: Biotechnology
degree(biotechnology) :-
  subject(science, CF1,E),
  larger_than_CF(CF1),
  biology(CF2),
  larger_than_CF(CF2),
  genetic_engineering(CF3),
  larger_than_CF(CF3),
  calculate_cf([CF1, CF2, CF3], 95, CF),
  % Debug 
  write_combinedCF(CF1, CF2, CF3, CF),
  nl,
  \+inserted(biotechnology),
  assert(inserted(biotechnology)),
  assert(describe(biotechnology):- (
    nl,nl,
  write('Recommendation: Biotechnology '), 
  write('(cf '), write(CF), write(')'), nl,
  write('You like biology and find generic engineering interesting.\c
  You are suitable for the degree of biotechnology.'),nl,
  write(E)),nl,
  write('The careers that suitable for you are:'),nl,
  write('- Pharmaceutical Research & Development'),nl,
  write('- Pharmaceutical Marketing Director'),nl,
  write('- Clinical Trial Manager'),nl,
  write('- Clinical Research Scientist'),nl,
  write('- Biomedical & Biotechnology Research Scientist'),nl,
  write('- Medical & Scientific Product Specialist'),nl,
  write('- Medical Laboratories Director'),nl,
  write('- Academia (Science Educator)')
  ).

% Degree: Pure Science
degree(pure_science) :- 
  subject(science, CF1,E),
  larger_than_CF(CF1),
  calculate_cf([CF1], 90, CF),
  % Debug 
  write_combinedCF(CF1, 100, CF),
  nl,
  \+inserted(pure_science),
  assert(inserted(pure_science)),
  assert(describe(pure_science):- (
    nl,nl,
  write('Recommendation: Pure Science '), 
  write('(cf '), write(CF), write(')'), nl,
  write('You are suitable for the degree of pure science.'),nl,
  write(E)),nl,
  write('The careers that suitable for you are:'),nl,
  write('- Analytical/Biomedical chemist'),nl,
  write('- Biotechnologist'),nl,
  write('- Quality controller'),nl,
  write('- Science journalist'),nl,
  write('- Process control specialist')
).

% Degree: Marketing
degree(marketing) :-
  subject(business, CF1,E),
  larger_than_CF(CF1),
  storytelling(CF2),
  calculate_cf([CF1, CF2], 100, CF),
  % Debug 
  write_combinedCF(CF1, CF2, CF),
  nl, 
  \+inserted(marketing),
  assert(inserted(marketing)),
  assert(describe(marketing):- (
    nl,nl,
  write('Recommendation: Marketing '), 
  write('(cf '), write(CF), write(')'), nl,
  write('You like storytelling.\c
  You are suitable for the degree of marketing.'),nl,
  write(E)),nl,
  write('The careers that suitable for you are:'),nl,
  write('- Chief Executive Officer'),nl,
  write('- Chief Marketing Officer'),nl,
  write('- Advertising and Promotions Specialist'),nl,
  write('- Product Manager'),nl,
  write('- Brand Manager'),nl,
  write('- Marketing Consultant'),nl,
  write('- Management Consultant'),nl,
  write('- Retail Expert'),nl,
  write('- Customer Relationship Associate / Manager'),nl,
  write('- Supply Chain Manager'),nl,
  write('- Key Accounts Specialist / Manager'),nl,
  write('- Consumer Research Analyst / Manager'),nl,
  write('- Events Producer')
  ).

% Degree: Accounting
degree(accounting) :-
  subject(business, CF1,E),
  larger_than_CF(CF1),
  work_with_numbers(yes),
  detail_oriented(CF2),
  calculate_cf([CF1, CF2], 100, CF),
  % Debug 
  write_combinedCF(CF1, CF2, CF),
  nl, 
  \+inserted(accounting),
  assert(inserted(accounting)),
  assert(describe(accounting):- (
    nl,nl,
  write('Recommendation: Accounting '), 
  write('(cf '), write(CF), write(')'), nl,
  write('You like working with numbers and you are a detail oriented person.\c
  You are suitable for the degree of accounting.'),nl,
  write(E)),nl,
  write('The careers that suitable for you are:'),nl,
  write('- Chief Financial Officer'),nl,
  write('- Investment Banker'),nl,
  write('- Commercial Banker'),nl,
  write('- Financial Controller'),nl,
  write('- Internal & External Auditor'),nl,
  write('- Management Consultant'),nl,
  write('- Tax Consultant'),nl,
  write('- Finance Analyst'),nl,
  write('- Fund Manager'),nl,
  write('- Financial Planner'),nl,
  write('- Corporate Treasurer')).

% Degree: Business Management
degree(business_management) :-
  subject(business, CF1,E),
  larger_than_CF(CF1), 
  calculate_cf([CF1], 100, CF),
  % Debug 
  write_combinedCF(CF1, 100, CF),
  nl,
  \+inserted(business_management),
  assert(inserted(business_management)),
  assert(describe(business_management):- (
    nl,nl,
  write('Recommendation: Business Management '), 
  write('(cf '), write(CF), write(')'), nl,
  write('You are suitable for the degree of business management'),nl,
  write(E)),nl,
  write('The careers that suitable for you are:'),nl,
  write('- Chief Executive Officer'),nl,
  write('- Business Consultant'),nl,
  write('- Entrepreneur'),nl,
  write('- General Manager'),nl,
  write('- Strategic Planner'),nl,
  write('- Marketing Manager'),nl,
  write('- HR Manager'),nl,
  write('- Operation / Project Manager'),nl,
  write('- Researcher'),nl,
  write('- Organisational Development Manager'),nl,
  write('- Procurement Manager')
  ).

% Degree: Performing Art
degree(performing_art) :-
  subject(art, CF1,E),
  larger_than_CF(CF1),  
  film_or_perform(perform),
  center_of_attention(CF2),
  larger_than_CF(CF2),
  performing(CF3),  
  larger_than_CF(CF3),
  calculate_cf([CF1, CF2, CF3], 90, CF),
  % Debug 
  write_combinedCF(CF1, CF2, CF3, CF),
  nl,
  \+inserted(performing_art),
  assert(inserted(performing_art)),
  assert(describe(performing_art):- (
    nl,nl,
  write('Recommendation: Performing Art '), 
  write('(cf '), write(CF), write(')'), nl,
  write('You like to become the center of attention and like to perform over film.\c
  You are suitable for the degree of performing art.'),nl,
  write(E)),nl,
  write('The careers that suitable for you are:'),nl,
  write('- Actor'),nl,
  write('- Voice Over Talent'),nl,
  write('- Director'),nl,
  write('- Producer'),nl,
  write('- Production Manager'),nl,
  write('- Stage Manager'),nl,
  write('- Cinematographer'),nl,
  write('- Editor'),nl,
  write('- Production Designer'),nl,
  write('- Script Writer'),nl,
  write('- Drama Teacher')
  ).

% Degree: Digital Film Production
degree(digital_film_production) :-
  subject(art, CF1,E),
  larger_than_CF(CF1),
  film_or_perform(film),
  film(CF2),
  larger_than_CF(CF2),
  calculate_cf([CF1, CF2], 90, CF),
  % Debug 
  write_combinedCF(CF1, CF2, CF),
  nl,
  \+inserted(digital_film_production),
  assert(inserted(digital_film_production)),
  assert(describe(digital_film_production):- (
    nl,nl,
  write('Recommendation: Digital Film Production '), 
  write('(cf '), write(CF), write(')'), nl,
  write('You like to film over perform.\c
  You are suitable for the degree of digital film production.'),nl,
  write(E)),nl,
  write('The careers that suitable for you are:'),nl,
  write('- Audio-Visual Producer'),nl,
  write('- Transmedia Designer'),nl,
  write('- Documentary Filmmaker'),nl,
  write('- Creative Entrepreneur'),nl,
  write('- Videographer'),nl,
  write('- Director'),nl,
  write('- Production Designer'),nl,
  write('- Video Producer')
  ).

% Degree: Culinary Art
degree(culinary_art) :- 
  subject(hospitality, CF1,E),
  larger_than_CF(CF1),
  cook(CF2),  
  larger_than_CF(CF2),
  calculate_cf([CF1, CF2], 100, CF),
  % Debug 
  write_combinedCF(CF1, CF2, CF),
  nl,
  \+inserted(culinary_art),
  assert(inserted(culinary_art)),
  assert(describe(culinary_art):- (
    nl,nl,
  write('Recommendation: Culinary Art '), 
  write('(cf '), write(CF), write(')'), nl,
  write('You enjoy cooking.\c
  You are suitable for the degree of culinary art.'),nl,
  write(E)),nl,
  write('The careers that suitable for you are:'),nl,
  write('- Chef de Cuisine / Executive Chef'),nl,
  write('- Banquet Manager'),nl,
  write('- Food and Beverage Manager'),nl,
  write('- In-flight Food Manager'),nl,
  write('- Product Development Manager'),nl,
  write('- Restaurant Owner / Entrepreneur')).

% Degree: Hotel Management
degree(hotel_management) :- 
  subject(hospitality, CF1,E),  
  larger_than_CF(CF1),
  calculate_cf([CF1], 100, CF),
  % Debug 
  write_combinedCF(CF1, 100, CF),
  nl,
  \+inserted(hotel_management),
  assert(inserted(hotel_management)),
  assert(describe(business):- (
    nl,nl,
  write('Recommendation: Hotel Management '), 
  write('(cf '), write(CF), write(')'), nl,
  write('You are suitable for the degree of hotel management.'),nl,
  write(E)),nl,
  write('The careers that suitable for you are:'),nl,
  write('- Sales and Marketing Manager'),nl,
  write('- Front Office Manager'),nl,
  write('- Hotel Human Resource Manager'),nl,
  write('- Rooms Division Manager'),nl,
  write('- Purchasing Manager'),nl,
  write('- Food & Beverage Manager')
  ).

% Degree: Gap Year
degree(gap_year) :-
  \+inserted(_),
  nl, write('Recommendation: Gap Year '), 
  write('(cf '), write('Unknown'), write(')'), nl,
  write('Sorry. We cannot help you because you have a \c
    a variety of traits.').

% ===========
% Uncertainty
% ===========
calculate_cf(CFList, CF, RulesCF) :-
  min_in_list(CFList, Min), !,
  RulesCF is div(Min * CF, 100),
  larger_than_fifty(RulesCF).

larger_than_fifty(CF) :-
  CF>=50.

larger_than_CF(CF):-
  CF>=50.

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
question(maths) :-
  nl, write('Are you good at Maths?'), nl.
question(computer_or_hands) :-
  nl, write('Do you prefer working on a computer or working with your hands?'), nl.
question(work_with_numbers) :-
  nl, write('Do you like working with numbers?'), nl.
question(blogs) :-
  nl, write('If given a choice, which blogs do you prefer to read?'), nl.
question(theory_or_pratical) :-
  nl, write('Do you want to discover the next new element or to build the next big invention?'), nl.
question(challenge_yourself) :-
  nl, write('Do you like to challenge yourself?'), nl.
question(planning) :-
  nl, write('Do you like planning, organising or managing?'), nl.
question(going_museum) :-
  nl, write('Do you enjoy going to movie theater and museums?'), nl.


% CF Unknown
question(logic) :-
  nl, write('Are you a person of logic?'), nl.
question(imagination) :-
  nl, write('Are you a person of imagination?'), nl.
question(rational) :-
  nl, write('Are u a rational person?'), nl.
question(solving_problem) :-
  nl, write('Rate 1 to 5, where 1 refers to weak and 5 refers to excellent, '), nl,
  write('How good your problem solving skill is?'), nl.
question(risk) :-
  nl, write('I like to take risk'), nl.
question(dealing_with_people) :-
  nl, write('Rate 1 to 5, where 1 refers to weak and 5 refers to excellent, '), nl,
  write('How good are you in dealing with people?'), nl.
question(like_interact) :-
  nl, write('I like interacting with people.'), nl.
question(science) :-
  nl, write('I like Chemistry/Biology/Physics.'), nl.
question(physics) :-
  nl, write('I enjoy doing Physics.'), nl.
question(creative_artistic_musical) :-
  nl, write('I am creative/artistic/musical.'), nl.
question(service_minded) :-
  nl, write('Are you service minded with a high stress threshold and want to work with people?'), nl.
question(serving_people) :-
  nl, write('I dont mind serving people.'), nl.

% Computer Science
question(computer_systems) :-
  nl, write('I am interested in the details of how computer systems or software works.'), nl.
question(technology) :-
  nl, write('I prefer to develop technology rather than apply technology.'), nl.

% Question for Engineering
question(circuits) :-
  nl, write('Do you like to deal with circuits?'), nl.
question(chemistry) :-
  nl, write('I like Chemistry.'), nl.

% Question for Science 
question(biology) :-
  nl, write('I like Biology.'), nl.
question(genetic_engineering) :-
  nl, write('I find genetic engineering intersting.'), nl.

% Question for Business
question(detail_oriented) :-
  nl, write('I am detail oriented and pay attention to little things.'), nl.
question(storytelling) :-
  nl, write('I am good at storytelling.'), nl.

% Question for Arts
question(center_of_attention) :-
  nl, write('I like being the center of attention.'), nl.
question(film_or_perform) :-
  nl, write('Do you prefer shooting film or performing?'), nl.
question(film) :-
  nl, write('I am interested in the arts of storytelling and the language of film.'), nl.
question(performing) :-
  nl, write('I prefer to convey artistic expression through acting/dancing/singing.'), nl.

% Question for Hospitality
question(cook) :-
  nl, write('Do you enjoy cooking?'), nl.

% ========
% Answers
% ========
answer(computer) :-
  write('I prefer working on a computer.').
answer(hands) :-
  write('I prefer working with your hands.'), nl.

answer(business) :- 
  write('Forbes or BusinessInsider.').
answer(technology) :-
  write('HackerNews or AnandTech.').
answer(science) :-
  write('howstuffworks or New Scientist.'), nl.

answer(theory) :-
  write('I am more interested to discover the next new element.').
answer(pratical) :-
  write('I am more interested to invent the next big invention.'), nl.

answer(film) :-
  write('I prefer shooting film.').
answer(perform) :-
  write('I prefer performing.'), nl.

answer(yes) :-
  write('Yes.').
answer(no) :-
  write('No.'), nl.

answer(strongly_disagree) :-
  write('Strongly disagree.').
answer(disagree) :-
  write('Disagree.').
answer(neutral) :-
  write('Neutral').
answer(agree) :-
  write('Agree.').
answer(strongly_agree) :-
  write('Strongly agree.'), nl.


% ==========================
% Assign Answer to Questions
% ==========================
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
planning(Answer) :-
  progress(planning, Answer).
planning(Answer) :-
  \+ progress(planning, _),
  ask(planning, Answer, [yes, no]).
going_museum(Answer) :-
  progress(going_museum, Answer).
going_museum(Answer) :-
  \+ progress(going_museum, _),
  ask(going_museum, Answer, [yes, no]).

% Computing 
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

% Engineering
physics(Answer) :-
  progress(physics, Answer).
physics(Answer) :-
  \+ progress(physics, _),
  ask_with_cf(physics, Answer, [strongly_disagree, disagree, neutral, agree, strongly_agree]).
circuits(Answer) :-
  progress(circuits, Answer).
circuits(Answer) :-
  \+ progress(circuits, _),
  ask(circuits, Answer, [yes, no]).

% Science
science(Answer) :-
  progress(science, Answer).
science(Answer) :-
  \+ progress(science, _),
  ask_with_cf(science, Answer, [strongly_disagree, disagree, neutral, agree, strongly_agree]).
biology(Answer) :-
  progress(biology, Answer).
biology(Answer) :-
  \+ progress(biology, _),
  ask_with_cf(biology, Answer, [strongly_disagree, disagree, neutral, agree, strongly_agree]).
chemistry(Answer) :-
  progress(chemistry, Answer).
chemistry(Answer) :-
  \+ progress(chemistry, _),
  ask_with_cf(chemistry, Answer, [strongly_disagree, disagree, neutral, agree, strongly_agree]).

genetic_engineering(Answer) :-
  progress(genetic_engineering, Answer).
genetic_engineering(Answer) :-
  \+ progress(genetic_engineering, _),
  ask_with_cf(genetic_engineering, Answer, [strongly_disagree, disagree, neutral, agree, strongly_agree]).

% Business
risk(Answer) :-
  progress(risk, Answer).
risk(Answer) :-
  \+ progress(risk, _),
  ask_with_cf(risk, Answer, [strongly_disagree, disagree, neutral, agree, strongly_agree]).

storytelling(Answer) :-
  progress(storytelling, Answer).
storytelling(Answer) :-
  \+ progress(storytelling, _),
  ask_with_cf(storytelling, Answer, [strongly_disagree, disagree, neutral, agree, strongly_agree]).

detail_oriented(Answer) :-
  progress(detail_oriented, Answer).
detail_oriented(Answer) :-
  \+ progress(detail_oriented, _),
  ask_with_cf(detail_oriented, Answer, [strongly_disagree, disagree, neutral, agree, strongly_agree]).

% Art
creative_artistic_musical(Answer) :-
  progress(creative_artistic_musical, Answer).
creative_artistic_musical(Answer) :-
  \+ progress(creative_artistic_musical, _),
  ask_with_cf(creative_artistic_musical, Answer, [strongly_disagree, disagree, neutral, agree, strongly_agree]).

center_of_attention(Answer) :-
  progress(center_of_attention, Answer).
center_of_attention(Answer) :-
  \+ progress(center_of_attention, _),
  ask_with_cf(center_of_attention, Answer, [strongly_disagree, disagree, neutral, agree, strongly_agree]).

film_or_perform(Answer) :-
  progress(film_or_perform, Answer).
film_or_perform(Answer) :-
  \+ progress(film_or_perform, _),
  ask(film_or_perform, Answer, [film, perform]).

film(Answer) :-
  progress(film, Answer).
film(Answer) :-
  \+ progress(film, _),
  ask_with_cf(film, Answer, [strongly_disagree, disagree, neutral, agree, strongly_agree]). 

performing(Answer) :-
  progress(performing, Answer).
performing(Answer) :-
  \+ progress(performing, _),
  ask_with_cf(performing, Answer, [strongly_disagree, disagree, neutral, agree, strongly_agree]). 

% Hospitality
serving_people(Answer) :-
  progress(serving_people, Answer).
serving_people(Answer) :-
  \+ progress(serving_people, _),
  ask_with_cf(serving_people, Answer, [strongly_disagree, disagree, neutral, agree, strongly_agree]).
service_minded(Answer) :-
  progress(service_minded, Answer).
service_minded(Answer) :-
  \+ progress(service_minded, _),
  ask_with_cf(service_minded, Answer, [strongly_disagree, disagree, neutral, agree, strongly_agree]).
cook(Answer) :-
  progress(cook, Answer).
cook(Answer) :-
  \+ progress(cook, _),
  ask_with_cf(cook, Answer, [strongly_disagree, disagree, neutral, agree, strongly_agree]).

% CF 
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
  ask_with_cf(solving_problem, Answer, []).  

dealing_with_people(Answer) :-
  progress(dealing_with_people, Answer).
dealing_with_people(Answer) :-
  \+ progress(dealing_with_people, _),
  ask_with_cf(dealing_with_people, Answer, []).

like_interact(Answer) :-
  progress(like_interact, Answer).
like_interact(Answer) :-
  \+ progress(like_interact, _),
  ask_with_cf(like_interact, Answer, [strongly_disagree, disagree, neutral, agree, strongly_agree]).


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
  CF is Index * 20,
  asserta(progress(Question, CF)),
  CF = Answer.

describe_all:-
    describe(_),
    false.

describe_all:-
    true.