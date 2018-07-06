let () =
  let open Printf in
  printf "Bet is (1,2), result is (1,2), prize is %i\n" @@ Football.bookmake (1,2) (1,2)
