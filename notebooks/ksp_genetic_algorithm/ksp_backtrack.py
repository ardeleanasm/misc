import numpy as np
import pickle
import random as rn
from collections import namedtuple

dataset_file="dataset_ds10.pickle"

"""
G = Maximum weight
N = Number of items
g = weights
v = values
"""
DS=namedtuple('DS','G,N,g,v')


def knapsack(max_weight, weights, values, number_of_items):
    # Base Case
    if number_of_items == 0 or max_weight == 0:
        return 0

    # If weight of the nth item is more than Knapsack of capacity
    # W, then this item cannot be included in the optimal solution
    if (weights[number_of_items - 1] > max_weight):
        return knapsack(max_weight, weights, values, number_of_items - 1)
    else:
    # return the maximum of two cases:
    # (1) nth item included
    # (2) not included

        return max(values[number_of_items - 1] + knapsack(max_weight - weights[number_of_items - 1], weights, values, number_of_items - 1),
                   knapsack(max_weight, weights, values, number_of_items - 1))



if __name__ == '__main__':
    pickle_in = open(dataset_file, "rb")
    dataset = pickle.load(pickle_in)
    pickle_in.close()
    print(knapsack(dataset.G , dataset.g , dataset.v , dataset.N))
