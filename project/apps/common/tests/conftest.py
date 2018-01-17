import random
import string

import pytest


@pytest.fixture
def a_random_string(N=10):
    return ''.join(random.choices(string.ascii_uppercase + string.digits, k=N))
