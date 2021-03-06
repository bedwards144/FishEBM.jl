#=
  Package: FishEBM
  File: types.jl
  Justin Angevaare, Devin Rose
  Type definitions for the structured stock-level and agent-level model components
  Created: May 2015
=#


"""
  Description: Assumptions regarding mortality, maturity, broodsize, and
    catchability of age specific adult agents.

  naturalmortality = Age specific survivorship (survivorship at carrying
    capacity if density depedence occurs).
  halfmature = Age at 50% mature (Binomial cdf assumed).
  broodsize = Age specific fecundity (i.e. mean quantity of eggs each spawning
    female will produce).
  fecunditycompensation = compensatory strength for changes in fecundity.
    Compensatory strength is a divisor of K which will result in a 68% change in
    fecundity - smaller values indicate lower compensation strength.
    Compensation function based on Normal CDF. Use NaN if compensation is
    assumed to not occur.
  maturitycompensation = compensatory strength for changes in age of sexual
    maturity. Compensatory strength is a divisor of K which will result in a 68%
    change in age of sexual maturity - smaller values indicate lower
    compensation strength. Compensation function based on Normal CDF. Use NaN if
    compensation is assumed to not occur.
  mortalitycompensation = compensatory strength for changes in age of sexual
    maturity. Compensatory strength is a divisor of K which will result in a 68%
    change in natural mortality - smaller values indicate lower compensation
    strength. Compensation function based on Normal CDF. Use NaN if compensation
    is assumed to not occur.

    Last Update: September 2016
"""
type AdultAssumptions
  naturalmortality::Vector{Float64}
  halfmature::Float64
  broodsize::Vector{Int64}
  fecunditycompensation::Float64
  maturitycompensation::Float64
  mortalitycompensation::Float64
  catchability::Vector{Float64}

  AdultAssumptions() = new()
  AdultAssumptions(naturalmortality, halfmature, broodsize, fecunditycompensation, maturitycompensation, mortalitycompensation, catchability) =
    new(naturalmortality, halfmature, broodsize, fecunditycompensation, maturitycompensation, mortalitycompensation, catchability)
end


"""
  Description: Assumptions regarding mortality, movement, and growth of
    autonomous agents.

    naturalmortality = Stage specific survivorship of each habitat type and stage
      of agents.
    extramortality = Stage specific survivorship of agents (each independent life
      stage) in an environment location influenced by anthropogenic effects.
    growth = Growth rate (in weeks) from one life stage to the next.
    movement = Movement weight matrices for each life stage.
    autonomy = Movement autonomy.

  Last Update: October 2016
"""
type AgentAssumptions
  naturalmortality::Array
  extramortality::Vector{Float64}
  growth::Vector{Int64}
  movement::Array
  autonomy::Vector{Float64}

  AgentAssumptions() = new()
  AgentAssumptions(naturalmortality, extramortality, growth, movement, autonomy) =
    new(naturalmortality, extramortality, growth, movement, autonomy)
end


"""
  Description: This "Environment agent" is used to track fish population
    dynamics during a simulation.

  Last Update: September 2016
"""
type EnviroAgent
   # locationID corresponds to the ID in the habitat array
  locationID::Int64

  # Number of alive agents alive in each cohort
  alive::Vector{Int64}

  # Independent mortality tracking by location
  killedNatural::Vector{Int64}
  killedExtra::Vector{Int64}
  harvest::Int64

  # The spawning week of each cohort during the simulation
  weekNum::Vector{Int64}

  EnviroAgent(locationID) = new(locationID, [0], [0,0,0,0], [0,0,0,0], 0, [0])
end


"""
  Description: A specialized type which contains layers of information to
    indicate spawning area, habitat type, and additional risks. Abstract matches areas of interest
    to habitat index number, and hashing matches index numbers to agent numbers. Hash contains agent
    number during run-time.

  Precondition: Location id should be specified as NaN when a valid location
    does not exist.

  Last Update: October 2016
"""
type EnvironmentAssumptions
  # Spawning map and a hashed list of areas
  spawning::Vector{Int64}
  spawningHash::Vector{Int64}

  # Habitat type array
  habitat::Array{Int64}

  # risk map and a hashed list of areas
  risk::Vector{Int64}
  riskHash::Vector{Int64}

  # Harvest map, hashed list and harvest zones
  harvest::Array{Int64}
  abstractHarvest::Vector{Int64}
  harvestZoneNum::Vector{Int64}
  harvestHash::Vector{Int64}

  # Constructors
  EnvironmentAssumptions() = new()
  EnvironmentAssumptions(spawning, spawningHash, habitat, risk, riskHash, harvest, abstractHarvest, harvestZoneNum, harvestHash) =
  new(spawning, spawningHash, habitat, risk, riskHash, harvest, abstractHarvest, harvestZoneNum, harvestHash)
end
