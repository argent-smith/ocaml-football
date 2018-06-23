let test_exact_match_1 () =
  Alcotest.(check int) "match of (2,2) (2,2) returns 2" 2 (Football.bookmake (2,2) (2,2))

let test_exact_match_2 () =
  Alcotest.(check int) "match of (2,1) (2,1) returns 2" 2 (Football.bookmake (2,1) (2,1))

let test_exact_match_3 () =
  Alcotest.(check int) "match of (2,3) (2,3) returns 2" 2 (Football.bookmake (2,3) (2,3))

let test_exact_match_4 () =
  Alcotest.(check int) "match of (0,0) (0,0) returns 2" 2 (Football.bookmake (0,0) (0,0))

let test_match_balance_1 () =
  Alcotest.(check int) "match of (1,0) (4,2) returns 1" 1 (Football.bookmake (1,0) (4,2))

let test_match_balance_2 () =
  Alcotest.(check int) "match of (1,4) (5,6) returns 1" 1 (Football.bookmake (1,4) (5,6))

let test_match_balance_3 () =
  Alcotest.(check int) "match of (1,1) (4,4) returns 1" 1 (Football.bookmake (1,1) (4,4))

let test_nomatch () =
  Alcotest.(check int) "match of (1,1) (1,4) returns 0" 0 (Football.bookmake (1,1) (1,4))


let test_set = [
    "Exact match 1 (2,2) (2,2)", `Quick, test_exact_match_1;
    "Exact match 2 (2,1) (2,1)", `Quick, test_exact_match_2;
    "Exact match 3 (2,3) (2,3)", `Quick, test_exact_match_3;
    "Exact match 4 (0,0) (0,0)", `Quick, test_exact_match_4;
    "Balance match 1 (1,0) (4,2)", `Quick, test_match_balance_1;
    "Balance match 2 (1,4) (4,6)", `Quick, test_match_balance_2;
    "Balance match 3 (1,1) (4,4)", `Quick, test_match_balance_3;
    "No match (1,1) (1,4)", `Quick, test_nomatch;
  ]

let () =
  Alcotest.run "Testing bookmaking" [
      "Bet to real result matching", test_set
    ]
