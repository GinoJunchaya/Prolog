%HECHOS

tiene_cuenta(maria).
tiene_cuenta(jose).
tiene_cuenta(alberto).

contrasenha_usuario(maria, maria123).
contrasenha_usuario(jose, jose123).
contrasenha_usuario(alberto, alberto123).

perfil(maria, 'Maria Gonzalez, Femenino, 10/10/1990').
perfil(jose, 'Jose Gonzalez, Masculino, 15/10/1985').
perfil(alberto, 'Alberto Gonzalez, Masculino, 15/10/1982').

conectado(servidor, 'True').
recibe_maximo(1024).

%REGLAS

es_usuario(X) :- tiene_cuenta(X).
es_valido(X, Y) :- contrasenha_usuario(X, Y).
acceso(X, Y) :- es_usuario(X), es_valido(X,Y).
pueden_chatear(X, Y) :- es_usuario(X), es_usuario(Y), X \= Y.
ver_perfil(X) :- es_usuario(X), perfil(X, Y), write(Y).
iniciar_sesion(X, Y) :- conectado(servidor, Z), Z == 'True', acceso(X, Y).
el_paquete_es_liviano(X) :- recibe_maximo(Y), X =< Y.

recibir_paquete_del_servidor(X, 1) :- X =< 1024, X >= 0.

recibir_paquete_del_servidor(X, Fragmentos) :-
    X > 1024,
    X1 is X - 1024,
    recibir_paquete_del_servidor(X1, Fragmentos1),
    Fragmentos is Fragmentos1 + 1,!.
