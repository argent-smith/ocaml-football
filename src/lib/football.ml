module Score = struct
  type t = {
      team_a: int;
      team_b: int;
    }

  let of_pair (team_a, team_b) = { team_a; team_b }
end

module Matching = struct
  let exact_match = (=)

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

module Discernment = struct
  type t = Won | Guessed | Lost

  let naive_discern (team_a_bet, team_b_bet) (team_a_real, team_b_real) =
    if team_a_bet = team_a_real && team_b_bet = team_b_real
    then Won
    else if (team_a_bet > team_b_bet && team_a_real > team_b_real)
            || (team_a_bet < team_b_bet && team_a_real < team_b_real)
            || (team_a_bet = team_b_bet && team_a_real = team_b_real)
    then Guessed
    else Lost

  let discern bet real =
    let open Matching in
    match exact_match bet real with
    | true -> Won
    | false -> match balance_match bet real with
               | true -> Guessed
               | false -> Lost
end

let bookmake bet_score real_score =
  let open Discernment in
  match discern bet_score real_score  with
  | Won -> 2
  | Guessed -> 1
  | Lost -> 0
