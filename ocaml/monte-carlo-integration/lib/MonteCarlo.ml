open Random
open MonteCarlo_type

module MonteCarlo:MonteCarlo_type=struct
  let initializePRNG ()=Random.self_init()
  let getRandomNumber ()=Random.float 1.0
  let pi = 4.0 *. atan 1.0;;
  (* let func (x:float)=sin x *)
  let func (x:float)=2.0*.x+.3.0
  let rec approximate a b n index value=
    if index=(n-1) then
      ((b-.a)/.(float_of_int index))*.value
    else
      let randVal=getRandomNumber() in
      let inInterval=a+.randVal*.(b-.a) in
      let fVal=func inInterval in
      approximate a b n (index+1) (value+.fVal)
      (* func(a+.getRandomNumber()*.(b-.a)) *)

  
end



