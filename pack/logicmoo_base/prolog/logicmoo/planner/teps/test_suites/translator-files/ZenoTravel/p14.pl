:- consult(initial1).

goal(and(all(p, or(not(aircraft(p)), eventually(at(p, city4)))), all(p, all(y, or(not(aircraft(p)), or(not(city(y)), or(not(at(p, y)), eventually(always(at(p, y)))))))))).
