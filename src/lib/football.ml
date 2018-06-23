(** Score representation for matching operations *)
module Score = struct
  type t = {
      team_a: int;
      team_b: int;
    }

  let of_pair (team_a, team_b) = { team_a; team_b }
end

(** Score matchers *)
module Matching = struct

  (** Simple pair equality testing *)
  let exact_match = (=)

  (** Complex "user guessed the balance" matcher *)
  let balance_match bet real =
    let balance_matcher bet real (<//>) =
      let bet, real = Score.(of_pair bet, of_pair real) in
      bet.team_a <//> bet.team_b && real.team_a <//> real.team_b
    in
    let open List in
    [(>); (<); (=)]
    |> map (balance_matcher bet real)
    |> fold_left (||) false

end

(** Discerning whether the guess is valid: the toplevel logic *)
module Discernment = struct
  type t = Won | Guessed | Lost

  (** Naive all-in-one Pervasives-only algorythm *)
  let naive_discern (team_a_bet, team_b_bet) (team_a_real, team_b_real) =
    if team_a_bet = team_a_real && team_b_bet = team_b_real
    then Won
    else if (team_a_bet > team_b_bet && team_a_real > team_b_real)
            || (team_a_bet < team_b_bet && team_a_real < team_b_real)
            || (team_a_bet = team_b_bet && team_a_real = team_b_real)
    then Guessed
    else Lost

  (** Modularized pattern-matching idiomatic Stdlib-using (List under the hood) algorythm *)
  let discern bet real =
    let open Matching in
    match exact_match bet real with
    | true -> Won
    | false -> match balance_match bet real with
               | true -> Guessed
               | false -> Lost
end

(** Entry point *)
let bookmake bet_score real_score =
  let open Discernment in
  match discern bet_score real_score  with
  | Won -> 2
  | Guessed -> 1
  | Lost -> 0
