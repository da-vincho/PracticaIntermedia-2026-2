divisores(N, Lista) :-
    Limite is N - 1,
    findall(X, (between(1, Limite, X), 0 is N mod X), Lista).

suma(N, Total) :-
    divisores(N, Lista),
    sum_list(Lista, Total).

categoria(N, 'Administrative') :- suma(N, S), S > N.
categoria(N, 'Engineering')    :- suma(N, S), S =:= N.
categoria(N, 'Humanities')     :- suma(N, S), S < N.

periodo(Codigo, Texto) :-
    P is Codigo // 100000,
    Anio is 2000 + P // 10,
    Semestre is P mod 10,
    format(atom(Texto), "~w-~w", [Anio, Semestre]).

numero_categoria(Codigo, Cat) :-
    Cat is (Codigo // 1000) mod 100.

consecutivo(Codigo, Num) :-
    Num is Codigo mod 1000.

paridad(Codigo, even) :- 0 is Codigo mod 2, !.
paridad(_, odd).

periodo_ok(Codigo) :-
    P is Codigo // 100000,
    member(P, [262, 271, 272, 281, 282, 291, 292]).

codigo_ok(Codigo) :-
    Codigo >= 10000000,
    Codigo =< 99999999,
    periodo_ok(Codigo).

describir(Codigo, 'Invalid code') :-
    \+ codigo_ok(Codigo), !.
describir(Codigo, Salida) :-
    periodo(Codigo, Per),
    numero_categoria(Codigo, Num1),
    categoria(Num1, Cat),
    consecutivo(Codigo, Num2),
    paridad(Codigo, Par),
    format(atom(Salida), "~w ~w num~w ~w", [Per, Cat, Num2, Par]).

codigos_de(PeriodoNum, Cat, Codigo) :-
    between(1, 99, Num1),
    categoria(Num1, Cat),
    between(1, 999, Num2),
    Codigo is PeriodoNum * 100000 + Num1 * 1000 + Num2.

:- initialization(main).

main :-
    Codigos = [26276002, 27128112, 27206025, 28124236, 28299115],
    forall(member(C, Codigos),
           ( describir(C, R), format("~w~n", [R]) )),
    halt.