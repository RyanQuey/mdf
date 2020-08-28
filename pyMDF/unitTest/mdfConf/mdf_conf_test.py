import unittest

def test_sum():
    assert sum([1, 2, 3]) == 6, "Should be 6"

def run_all():
    test_sum()

if __name__ == "__main__":
    run_all()
