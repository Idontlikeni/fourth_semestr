class MachineError(Exception):
    def __init__(self, msg="default error"):
        self.msg = msg
        super().__init__(self.msg)


class MealyMachine:
    def __init__(self):
        self.state = "D7"
        self.mt = set()
        self.steps = 0
        self.vs = {}
        self.mt = set()
        self.tree = {
            "D7": {"D5": 0},
            "D5": {"D6": 0, "D4": 0},
            "D6": {"D4": 0},
            "D4": {"D2": 0, "D4": 0},
            "D2": {"D1": 0, "D0": 0},
            "D1": {"D3": 0},
            "D0": {"D4": 0},
            "D3": {"D1": 0, "D0": 0},
        }

    def e(self, v):
        self.vs['e'] = v

    def z(self, v):
        self.vs['z'] = v

    def get(self):
        self.steps += 1

        match self.state:
            case "D7" | "D5":
                self.mt.add('get')

        match self.state:
            case "D7":
                self.state = "D5"
                self.tree["D7"]["D5"] += 1
                return "J4"
            case "D5" if self.vs['z'] == 0:
                self.state = "D6"
                self.tree["D5"]["D6"] += 1
                return "J1"
            case "D5" if self.vs['z'] == 1:
                self.state = "D4"
                self.tree["D5"]["D4"] += 1
                return "J0"
            case _:
                self.steps -= 1
                raise MachineError("unsupported")

    def crack(self):
        self.steps += 1

        match self.state:
            case "D6" | "D2" | "D3":
                self.mt.add("crack")

        match self.state:
            case "D6":
                self.state = "D4"
                self.tree["D6"]["D4"] += 1
                return "J3"
            case "D2":
                self.state = "D1"
                self.tree["D2"]["D1"] += 1
                return "J1"
            case "D3":
                self.state = "D1"
                self.tree["D3"]["D1"] += 1
                return "J5"
            case _:
                self.steps -= 1
                raise MachineError("unsupported")

    def paint(self):
        self.steps += 1

        match self.state:
            case "D4":
                self.mt.add("paint")

        match self.state:
            case "D4" if self.vs['e'] == 1:
                self.state = "D4"
                self.tree["D4"]["D4"] += 1
                return "J4"
            case "D4" if self.vs['e'] == 0:
                self.state = "D2"
                self.tree["D4"]["D2"] += 1
                return "J2"
            case _:
                self.steps -= 1
                raise MachineError("unsupported")

    def chain(self):
        self.steps += 1

        match self.state:
            case "D1" | "D3":
                self.mt.add("chain")

        match self.state:
            case "D1":
                self.state = "D3"
                self.tree["D1"]["D3"] += 1
                return "J5"
            case "D3":
                self.state = "D0"
                self.tree["D3"]["D0"] += 1
                return "J2"
            case _:
                self.steps -= 1
                raise MachineError("unsupported")

    def scale(self):
        self.steps += 1

        match self.state:
            case "D2" | "D0":
                self.mt.add("scale")

        match self.state:
            case "D2":
                self.state = "D0"
                self.tree["D2"]["D0"] += 1
                return "J0"
            case "D0":
                self.state = "D4"
                self.tree["D0"]["D4"] += 1
                return "J3"
            case _:
                self.steps -= 1
                raise MachineError("unsupported")

    def seen_method(self, name):
        return name in self.mt

    def seen_edge(self, e1, e2):
        return self.tree[e1][e2]

    def has_max_in_edges(self):
        if self.state == "D4":
            return True
        else:
            return False

    def __getattr__(self, name):
        raise MachineError("unknown")

    def move(self, m):
        match m:
            case 'get':
                return self.get()
            case 'crack':
                return self.crack()
            case 'paint':
                return self.paint()
            case 'chain':
                return self.chain()
            case 'scale':
                return self.scale()
            case _:
                raise MachineError("unknown")


def main():
    return MealyMachine()


def test():
    obj = main()
    assert not obj.seen_method('get')
    assert obj.seen_edge('D7', 'D5') == 0
    assert obj.move('get') == 'J4'  # D5
    assert obj.seen_method('get')
    assert not obj.has_max_in_edges()
    obj.z(0)
    assert obj.move('get') == 'J1'  # D6
    assert obj.move('crack') == 'J3'   # D4
    assert obj.has_max_in_edges()
    obj.e(0)
    assert obj.move('paint') == 'J2'  # D2
    assert obj.move('crack') == "J1"  # D1
    assert obj.move('chain') == 'J5'  # D3
    assert obj.move('crack') == 'J5'  # D1
    assert obj.move('chain') == 'J5'  # D3
    assert obj.move('chain') == 'J2'  # D0
    assert obj.move('scale') == 'J3'  # D4
    obj.e(1)
    assert obj.move('paint') == 'J4'  # D4
    obj.e(0)
    assert obj.move('paint') == 'J2'  # D2
    assert obj.move('scale') == 'J0'  # D0
    assert obj.seen_edge('D7', 'D5') == 1

    try:
        obj.move('get')
    except MachineError as e:
        assert e.msg == "unsupported"

    try:
        obj.move('paint')
    except MachineError as e:
        assert e.msg == "unsupported"

    try:
        obj.move('crack')
    except MachineError as e:
        assert e.msg == "unsupported"

    try:
        obj.move('chain')
    except MachineError as e:
        assert e.msg == "unsupported"

    obj.move('scale')

    try:
        obj.move('scale')
    except MachineError as e:
        assert e.msg == "unsupported"

    try:
        obj.keks()
    except MachineError as e:
        assert e.msg == "unknown"

    try:
        obj.move('keks')
    except MachineError as e:
        assert e.msg == "unknown"

    obj = main()
    assert obj.move('get') == 'J4'  # D5
    obj.z(1)
    assert obj.move('get') == 'J0'  # D5
