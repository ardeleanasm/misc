import numpy as np
import pickle
from collections import namedtuple

'''
Based on http://staff.cs.upt.ro/~chirila/teaching/upt/mse12-hm/projects/ksp-ga-ts.pdf
'''

DS=namedtuple('DS','G,N,g,v')

# DS8 = DS(0,8,np.random.randint(1,100,size=8),np.random.randint(1,100,size=8))
#
# DS10 = DS(0,10,np.random.randint(1,100,size=10),np.random.randint(1,100,size=10))
#
# DS50 = DS(0,50,np.random.randint(1,100,size=50),np.random.randint(1,100,size=50))
#
# DS100 = DS(0,100,np.random.randint(1,100,size=100),np.random.randint(1,100,size=100))

DS8=DS(G=115, N=8, g=np.array([19, 94, 10, 23, 57, 76, 65,  6]), v=np.array([33, 66, 26, 67, 78, 37, 58, 84]))

DS10=DS(G=180, N=10, g=np.array([23, 89, 25, 76, 75, 49, 79, 72,  7, 10]), v=np.array([73, 11, 46, 16,  3, 65, 59, 55, 66, 18]))


DS50=DS(G=434, N=50, g=np.array([48, 60, 11,  2, 15, 92, 22, 38, 22, 34, 91, 21, 14, 58, 94, 99, 15,
       81, 20, 17, 81, 74, 70, 65, 93, 46, 59, 51, 19, 53, 19, 70, 65,  2,
        7,  8, 77, 25, 66, 87, 41, 54, 45, 64, 10, 49, 76, 17, 85, 10]), v=np.array([33, 25, 83, 12,  8, 62, 17, 67, 96, 88, 37, 66, 54, 50, 77, 40, 57,
       26, 21, 64, 62, 65, 92, 65, 41, 46, 81,  3, 26, 55, 18, 57, 43, 72,
       16,  8,  3, 72, 65, 84, 71, 79, 48, 74, 69, 12, 94, 60, 31, 48]))

DS100=DS(G=953, N=100, g=np.array([15, 85, 51, 78, 13, 38, 55, 96, 80, 71, 66, 39, 12, 33, 10, 26, 37,
       30, 66, 31, 53, 71, 42, 78, 50, 29, 48, 42, 82, 61, 42,  3, 73, 11,
       84, 49, 54, 93, 72, 94, 11, 19, 74, 98,  2, 59, 80, 54, 42, 43, 65,
       20, 52, 24, 29, 72, 87, 44, 88, 54, 50, 28,  3, 84, 54, 98, 53, 94,
       13, 23, 96, 42, 60,  6, 51, 28, 96, 56, 37, 29, 82, 94, 13,  4, 99,
       60, 10, 14, 88, 94,  6, 68, 44,  5, 13, 65,  4, 89, 60, 93]), v=np.array([73, 69, 62, 83, 64, 57, 67, 48, 32, 38, 99, 85,  6, 39, 91, 48, 39,
       11, 31, 42,  5, 84, 67, 48, 74, 72, 29, 70, 10, 65, 74, 57, 49, 78,
       75, 79, 82,  3, 46, 87, 20, 28, 94, 14, 11, 67, 37, 77, 36, 55, 86,
       56, 60, 84,  6,  5, 66, 18, 53,  4,  2, 90, 34, 95, 33, 46, 80, 54,
       29, 49, 84, 25, 32,  6,  1, 96, 38, 77, 16, 37, 15, 95, 10, 78, 42,
       51, 43,  8,  7, 97, 50, 46,  3, 54, 61, 17, 86, 66, 26,  2]))


if __name__ == '__main__':
    # Replace maximum weights

    # DS8=DS8._replace(G=int(np.median(DS8.g)))
    # DS10 = DS10._replace(G=int(np.median(DS10.g)))
    # DS50 = DS50._replace(G=int(np.median(DS50.g)))
    # DS100 = DS100._replace(G=int(np.median(DS100.g)))

    pickle_out = open("dataset_ds8.pickle", "wb")
    pickle.dump(DS8, pickle_out)
    pickle_out.close()

    pickle_out = open("dataset_ds10.pickle", "wb")
    pickle.dump(DS10, pickle_out)
    pickle_out.close()

    pickle_out = open("dataset_ds50.pickle", "wb")
    pickle.dump(DS50, pickle_out)
    pickle_out.close()

    pickle_out = open("dataset_ds100.pickle", "wb")
    pickle.dump(DS100, pickle_out)
    pickle_out.close()


