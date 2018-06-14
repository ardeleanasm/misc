open Random
open MonteCarlo_type

module MonteCarlo:MonteCarlo_type=struct
  let initializePRNG ()=Random.self_init()
  let getRandomNumber ()=Random.float 1.0
  
  let rec approximate f a b n index value=
    if index=(n-1) then
      ((b-.a)/.(float_of_int index))*.value
    else
      let randVal=getRandomNumber() in
      let inInterval=a+.randVal*.(b-.a) in
      let fVal=f inInterval in
      approximate f a b n (index+1) (value+.fVal)
 
end



