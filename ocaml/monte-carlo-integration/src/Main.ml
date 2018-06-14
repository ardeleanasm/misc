open MonteCarlo


(*
F=(b-a)*1/N* sum{0}{N-1}f(X)

*)

let func (x:float):float=2.0*.x+.3.0

(* let pi = 4.0 *. atan 1.0;; *)

let () = 
  MonteCarlo.initializePRNG();
  print_float (MonteCarlo.approximate 0.0 5.0 100000 0 0.0)
