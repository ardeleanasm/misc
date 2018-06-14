open MonteCarlo



let func (x:float):float=2.0*.x+.3.0

(* let pi = 4.0 *. atan 1.0;; *)
(* let func (x:float)=sin x *)
let () = 
  MonteCarlo.initializePRNG();
  print_float (MonteCarlo.approximate func 0.0 5.0 100000 0 0.0)
