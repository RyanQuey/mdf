class FakeSingleton:
    """
    Not a real singleton, but does the same job. 
    - Classes that inherit from this parent class will create multiple instances, but each instance will all share state
    - setting any attribute will set that attribute for all instances
    borrowing from http://www.aleax.it/Python/5ep.html, but calling it singleton instead of borg
    """
    # this gets shared between all instances
    _shared_state = {}

    def __init__(self):
        # overriding the __dict__. This is how all attributes get shared, through how python uses __dict__
        self.__dict__ = self._shared_state
