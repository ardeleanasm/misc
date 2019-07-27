import numpy as np
import pickle
import random as rn
from collections import namedtuple

dataset_file="dataset_ds8.pickle"

"""
G = Maximum weight
N = Number of items
g = weights
v = values
"""
DS=namedtuple('DS','G,N,g,v')
dataset = 0
NUMBER_OF_GENERATIONS = 50
POPULATION_SIZE = 100

UNIFORM_RATE = 0.7
MUTATION_RATE = 0.08
TOURNAMENT_SIZE = 5
ELITISM = True

def generate_individual():
    return [rn.randint(0, 1) for x in range(0, dataset.N)]

def generate_population(population_size):
    return [generate_individual() for x in range(0,population_size)]

def fitness(individual):
    total_value=0
    total_weight=0
    for i in range(0,len(individual)):
        if individual[i]==1:
            total_value += dataset.v[i]
            total_weight += dataset.g[i]
    if total_weight > dataset.G:
        return 0
    else:
        return total_value

def crossover(first_individual,second_individual,gene_length):
    new_individual = list()
    for i in range(0,gene_length):
        crossover_value= rn.random()
        if crossover_value > UNIFORM_RATE:
            new_individual.append(first_individual[i])
        else:
            new_individual.append(second_individual[i])
    return new_individual

def mutate(individual,gene_length):
    for i in range(0,gene_length):
        value=rn.random()
        if value <= MUTATION_RATE:
            gene = round(value)
            individual[i]=gene
    return individual

def tournament_selection(population):
    tournament_population=list()
    for i in range (0,TOURNAMENT_SIZE):
        random_index=rn.randint(0,len(population)-1)
        tournament_population.append(population[random_index])
    #get fittest individual
    tournament_population=sorted(tournament_population, key=lambda x: fitness(x),reverse=True)
    return tournament_population[0]

def evolve(population):
    new_population = list()
    elite_offset = 0
    if ELITISM:
        new_population.append(population[0])
        elite_offset = 1
    # Prepare for crossover
    for i in range(elite_offset,len(population)):
        first_individual = tournament_selection(population)
        second_individual = tournament_selection(population)
        new_individual= crossover(first_individual,second_individual,dataset.N)
        new_population.append(new_individual)
    #Mutate
    for i in range(elite_offset,len(population)):
        new_population[i]=mutate(new_population[i],dataset.N)
    return new_population


if __name__ == '__main__':
    pickle_in = open(dataset_file, "rb")
    dataset = pickle.load(pickle_in)
    pickle_in.close()


    #generate initial population
    population = generate_population(POPULATION_SIZE)
    for i in range(0,NUMBER_OF_GENERATIONS):
        print("Generation {0} with {1}".format(i, len(population)))
        #Sort Population
        population = sorted(population, key=lambda x: fitness(x),reverse=True)
        #Print Population
        for ind in population:
            print("\t {0} , fitness {1}".format(str(ind),fitness(ind)))
        population = evolve(population)
    population = sorted(population, key=lambda x: fitness(x), reverse=True)
    print("Best generation {0} with total value {1}".format(population[0],fitness(population[0])))