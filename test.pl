% Partie I
  /*     arc(a,d).
     arc(a,g).
     arc(d,g).
     arc(g,a).
     arc(e,g).
     arc(e,b).
     arc(a,b).
     arc(b,f).
     arc(f,d).
     arc(f,c).
     arc(c,f).
     arc(d,c).
     arc(c,d).
     arc(c,h).*/

% chemin entre deux sommets !

% pour aller de B, vers B, le chemin parcouru est [B]
chemin(B, B, [B]).
% Pour aller de A vers B, il faut qu'il existe un arc de A vers C et un
% chemin de C vers B, le parcour est donc A auquel on concatène le
% chemin de B à C
chemin(A, B, [A,B]):-arc(A,B).
chemin(A, B, [A|L]) :-arc(A,C), chemin(C, B, L).


           %circuit (cycle) !
% pour cycler de x il faut qu'il existe un chemin entre x et lui meme
cycle(X):-chemin(X,X,L).


%l'ensemble des arcs sans cous !
arc(1,2).
arc(1,4).
arc(1,3).
arc(2,3).
arc(2,5).
arc(3,4).
arc(3,5).
arc(4,5).
arcC(1,2,5).
arcC(1,4,6).
arcC(1,3,7).
arcC(2,3,2).
arcC(2,5,4).
arcC(3,4,1).
arcC(3,5,1).
arcC(4,5,2).

/*     arcC(a,d,80).
     arcC(a,g,90).
     arcC(d,g,20).
     arcC(g,a,20).
     arcC(e,g,30).
     arcC(e,b,50).
     arcC(a,b,20).
     arcC(b,f,10).
     arcC(f,d,40).
     arcC(f,c,10).
     arcC(c,f,50).
     arcC(d,c,10).
     arcC(c,d,10).
      arcC(c,h,20).
*/

%chemin avec le cout !
%il faut pas parcourir les sommets deja vesités !

cheminC(A,B,L,P) :-cheminC(A, B, [], L, P).
cheminC(A, B, _, [arc(A,B)], C):- arcC(A,B,C).
cheminC(A, B, V, [arc(A,X)|Chemin], P):-arcC(A, X,C1),
                                      \+ member(X, V),
                                          cheminC(X, B, [A|V], Chemin, C2),
                                       P is C2 + C1.


%Tester pour un sommets s'il peut retournerer a lui meme !

circuit(X):-arc(X,Y),cheminP(Y,X,_).
cycleG([]):- !.
cycleG([X]):- circuit(X),!.
cycleG([X|L]):-!, circuit(X),cycleG(L).

% Connexite
% connexe teste si le graphe est connex !
connex([]):-!.
connex([X,Y|L]):-cheminP(X,Y,_),connex(L).

%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                      %%%%%%%%% Partie 2%%%%%%%

% 1-determiner le plus court chemin entre deux sommets !
%
%min_list(List,Min) determine le minimum d'une liste donnee !
min_list([X|L],Min):-min(X,L,Min).

%insert (x,L1,L2) insetion au debut !
insert(X,[],[X]):-!.
insert(X,[Y|L],[X,Y|L]):-!.

%insert(X,[Y|YS],[Y|ZS]):-X>Y,!,insert(X,YS,ZS).
%insert(X,[Y|YS],[X,Y|ZS]):-X<Y.
%
%min(A,B,X) le minimum entre deux valeurs !
min(X,[],Min):-Min is X.
min(X,[Y|L],Min):-X=<Y,min(X,L,Min).
min(X,[Y|L],Min):-X>=Y,min(Y,L,Min).

% La liste de tous les couts possibles des chemins Possibles !!
list_couts(A,B,L,C):-findall(N,cheminC(A,B,L,N),C).

/* cheminCourt(A,B,[arc(A,B)],Lenght):-arcC(A,B,Lenght). */
% CheminCourt(A,B,M,N) determine le chemin qui a le moindre cout !(Plus
% court chemin !)
cheminCourt(A,B,M,N):-cheminC(A,B,_,_)
                        ,list_couts(A,B,_,C)
                        ,min_list(C,N)
                        ,findall(L,(cheminC(A,B,L,N)),M).

%   2-Les chemins possibles entre deux sommets !
%
cheminP(A,B,L) :-cheminP(A, B, [], L).
cheminP(A, B, _, [arc(A,B)]):- arc(A,B).
cheminP(A, B, V, [arc(A,X)|Chemin]):-arc(A, X),
                                     \+ member(X, V),
                                          cheminP(X, B, [A|V], Chemin).















