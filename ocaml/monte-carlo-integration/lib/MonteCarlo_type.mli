module type MonteCarlo_type=sig
  val initializePRNG:unit->unit
  val getRandomNumber:unit->float
  val approximate:(float->float)->float->float->int->int->float->float  
end



