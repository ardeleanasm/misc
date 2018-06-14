open MonteCarlo


(*
F=(b-a)*1/N* sum{0}{N-1}f(X)

*)

let func (x:float):float=2.0*.x+.3.0



let () = 
  MonteCarlo.initializePRNG();
  print_float (MonteCarlo.getRandomNumber ())
