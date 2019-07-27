"""
1. Generate a random solution for the problem and call it S
2. Initialize the best solution found so far: Sbest = S
3. Initialize the tabu list: TL = Ф (the empty list)
4. Initialize the tabu tenure K (typically, K is problem-dependent)
5. Compute the neighborhood of S and choose S' as the best solution in the neighborhood such that moving 
from S to S' does not require a tabu move (if S' is better than Sbest yet it is obtained from S by means of 
a tabu move, use the aspiration criterion and ignore the tabu status of the move)
6. If TL is full then go to step 7, else go to step 8
7. Dismiss the oldest entry in TL
8. Insert the move required to obtain S' from S into TL
9. S = S'
10. If S is better than Sbest then go to step 11, else go to step 12
11. Sbest = S
12. If a certain termination condition is true then go to step 13, else go to step 5
13. Return Sbest as the best solution encountered

The tabu list contains the K most recent S→S' moves, where K is the list dimension and is called the "tabu tenure"
the best solution S' from the neighborhood of S is chosen which also satisfies 
the condition that the move from S to S' is not a tabu move.


After choosing the next solution S' the tabu list is altered, such that the oldest entry 
is dismissed and the most recent S→S' 
move taken is inserted (the tabu list may be implemented, therefore, as a queue). 
The tabu status of a move can be overridden when certain aspiration criteria are fulfilled. For example,
if a tabu move would produce a solution which is better than the best found so far, 
the tabu status of that move is dropped.
"""

import numpy as np
import pickle
import random as rn
import copy
from collections import namedtuple

dataset_file="dataset_ds10.pickle"

tabu_tenure = 3
number_of_iterations = 50
"""
G = Maximum weight
N = Number of items
g = weights
v = values
"""
DS=namedtuple('DS','G,N,g,v')

def generate_solution(number_of_items):
    return [rn.randint(0,1) for x in range(0,number_of_items)]

def fitness(solution,max_weight):
    total_value = 0
    total_weight = 0
    for i in range(0,len(solution)):
        if solution[i] == 1:
            total_value += dataset.v[i]
            total_weight += dataset.g[i]
    if total_weight > max_weight:
        return 0
    else:
        return total_value

def compute_neighborhood(S,max_weight):
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
        value = fitness(new_solution,max_weight)
        solutions.append((new_solution,value))
    #best_solution=max(solutions,key=lambda item:item[1])
    #return best_solution[0],best_solution[1]
    return solutions
def ts(dataset,tenure,number_of_iterations):
    S = generate_solution(dataset.N)
    S_best = (copy.deepcopy(S),fitness(S,dataset.G))
    TL = list()
    TL.append(S_best)
    bestCandidate = copy.deepcopy(S_best)
    iteration = 0
    while iteration < number_of_iterations:
        # will obtain a list pairs <solution, value>
        neighborhood = compute_neighborhood(S_best[0],dataset.G)
        for candidate in neighborhood:
            if candidate not in TL and candidate[1] > bestCandidate[1]:
                bestCandidate = copy.deepcopy(candidate)
        if bestCandidate[1] > S_best[1]:
            S_best = copy.deepcopy(bestCandidate)
        TL.append(bestCandidate)
        if len(TL) > tenure:
            TL.pop(0)
        iteration += 1
    return S_best


if __name__ == "__main__":
    pickle_in = open( dataset_file, "rb")
    dataset = pickle.load(pickle_in)
    pickle_in.close()
    S=ts(dataset,tabu_tenure,number_of_iterations)
    print("Best solution:{0} with value {1}".
        format(S[0],S[1]))
