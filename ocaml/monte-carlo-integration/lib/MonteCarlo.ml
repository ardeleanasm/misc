open Random
open MonteCarlo_type


module MonteCarlo:MonteCarlo_type=struct
  let initializePRNG ()=Random.self_init()
  let getRandomNumber ()=Random.float 1.0
  let approximate a b=a+.b
end



