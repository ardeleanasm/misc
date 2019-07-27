import numpy as np
import pickle
import random as rn
from collections import namedtuple

dataset_file="dataset_ds100.pickle"


"""
G = Maximum weight
N = Number of items
g = weights
v = values
"""


DS=namedtuple('DS','G,N,g,v')

def generate_solution(number_of_individuals):
    return [rn.randint(0,1) for x in range(0,number_of_individuals)]

def cost_function(solution,max_weight,values,weights):
    total_value = 0
    total_weight = 0
    for i in range(0,len(solution)):
        if solution[i] == 1:
            total_value += values[i]
            total_weight += weights[i]
    if total_weight > max_weight:
        return 0
    else:
        return total_value

def compute_neighborhood(S,max_weight,values,weights):
    '''
    Since the neighborhood of a solution S is made of all  the solutions 
    that that can be obtaine by using only one simple transformation,
    I chose that the simple transformation to be a bit flip
    in current solution S. This means that a value of 1 in solution array represent
    an object that is in the knapsack while a value of 0 represents a missing object.
    '''
    solutions=list()
    for i in range(0,len(S)):
        new_solution=list(S)
        if S[i] == 0:
            new_solution[i] = 1
        else:
            new_solution[i] = 0
        value = cost_function(new_solution,max_weight,values,weights)
        solutions.append((new_solution,value))
    best_solution=max(solutions,key=lambda item:item[1])
    return best_solution[0],best_solution[1]

def kn(dataset):
    S = generate_solution(dataset.N)
    while True:
        new_solution,new_cost=compute_neighborhood(S,dataset.G,dataset.v,dataset.g)
        old_cost = cost_function(S,dataset.G,dataset.v,dataset.g)
        if new_cost > old_cost:
            S = new_solution
        else:
            break
    print("Best solution:{0} with value {1}".
        format(S,cost_function(S,dataset.G,dataset.v,dataset.g)))




if __name__ == "__main__":
    pickle_in = open( dataset_file, "rb")
    dataset = pickle.load(pickle_in)
    pickle_in.close()
    kn(dataset)