import pandas as pd
import numpy as np
import os

def json2pd():
    # array of two length
    dirname = os.path.dirname(__file__)
    abs_path = os.path.join(dirname, "../test_data/testJson_exp.json")
    print("path", abs_path)

    df = pd.read_json(abs_path)
    return df
