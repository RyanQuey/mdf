import pandas as pd
import numpy as np
import h5py

# for now just loading the test data twice
# TODO consider keeping it in hdf5 format and not converting to pandas, for ease of interoperability
def mat2pd():
    """
    Ideas to look into for doing this an easier way:

    - pip3 install mat4py
    - http://pyhogs.github.io/reading-mat-files.html has some example code
    """
    # read the mat file (it is hdf5 under the hood, so can use h5py apparently, but can't use np since it's a newer version of mat data)
    raw_mat_data = h5py.File('../test_data/testJson.mat', "r")['testJson']
    # this makes our test data usable in pd, but also models how we could convert all data types from mat > hdf5 > pd

    data = {}

    for key, value in raw_mat_data.items():
        if type(value) in [float, int]:
            data[key] = value

        # matlab type array
        elif type(value) is list:
            # we don't know if it's originally a list or a string or what yet. So investigate further
            # https://stackoverflow.com/a/46312860/6952495
            if value[0].attrs["MATLAB_class"] is "char":
                # this is an array of characters
                # NOTE maybe don't do [0]?
                data[key] = hdf5obj_to_str(value[0])
            elif value[0].attrs["MATLAB_class"] is "cell":
                # I think should always be an array (python: list) of strings
                # NOTE maybe don't do [0]?
                # 'stringarray' is more tricky
                # https://stackoverflow.com/q/28541847/6952495
                # I have a comment on the answer that explains each step
                data[key] = hdf5objs_arr_to_strs(value[0])

        elif type(value) is dict:
            # TODO iterate over each key and do the same type checking as above, recusrively
            pass


    # TODO this is incomplete...but I'm not sure it's even helpful so just using JSON data files for now!



    df = pd.DataFrame([data] * 2, columns=mat_data_dict.keys())
    return df



def hdf5obj_to_str(hdf5_string_ref, raw_mat_data):
    """
    Looks like we have to iterate over all the characters and turn to a string
    https://stackoverflow.com/q/28541847/6952495

    Args:
    hdf5_string_ref is one sample <HDF5 object reference>

    - see hdf5objs_arr_to_strs for how to use if you ahve array of strings.
    - If you have just a string data type:

    # get one dataset
    raw_mat_data = h5py.File('../test_data/testJson.mat', "r")['testJson']
    # get an array of string refs from that. NOTE maybe don't need to do [0] part...
    hdf5_string_ref = raw_mat_data["my_key_of_string"][0]
    hdf5obj_to_str

    """
    ref = raw_mat_data[hdf5_string_ref]
    # take list of unicode_num, convert each to a character, and join into string
    return ''.join(chr(unicode_num) for unicode_num in ref[:])


def hdf5objs_arr_to_strs(hdf5objs_arr, raw_mat_data):
    """
    but we have a dataset (basically a np array) of these hdf5objs.
    So iterate over each one (using vectorize)
    # TODO might be a better way than vectorize, check here


    How to use:

    # get one dataset
    raw_mat_data = h5py.File('../test_data/testJson.mat', "r")['testJson']
    # get an array of string refs from that. NOTE maybe don't need to do [0] part...
    str_refs_list = raw_mat_data["my_key_for_list_of_strings"][0]

    my_string = hdf5objs_arr_to_strs(str_refs_arr)
    """
    return np.vectorize(hdf5obj_to_str)(hdf5objs_arr, raw_mat_data)


