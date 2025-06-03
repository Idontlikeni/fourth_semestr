class MealyError(Exception):
    def __init__(self, msg="default error"):
        self.msg = msg
        super().__init__(self.msg)

    # def __str__(self):
    #     return f"{self.msg} Error code"


class MealyMachine:
    def __init__(self):
        self.state = "B4"
        self.mt = set()
        self.steps = 0
        self.tree = {
            "B4": {"B1": 0},
            "B1": {"B2": 0},
            "B2": {"B1": 0, "B3": 0, "B4": 0},
            "B3": {"B0": 0, "B1": 0},
            "B0": {"B5": 0},
            "B5": {"B2": 0}
        }

    def drag(self):
        self.steps += 1
        match self.state:
            case "B4":
                self.state = "B1"
                self.tree["B4"]["B1"] += 1
                return "T2"
            case "B3":
                self.state = "B1"
                self.tree["B3"]["B1"] += 1
                return "T1"
            case _:
                self.steps -= 1
                MealyError("unsupported")

    def rev(self):
        self.steps += 1
        match self.state:
            case "B0":
                self.state = "B5"
                self.tree["B0"]["B5"] += 1
                return "T3"
            case _:
                self.steps -= 1
                raise MealyError("unsupported")

    def add(self):
        self.steps += 1
        match self.state:
            case "B1":
                self.state = "B2"
                self.tree["B1"]["B2"] += 1
                return "T3"
            case "B3":
                self.state = "B1"
                self.tree["B3"]["B1"] += 1
                return "T1"
            case _:
                self.steps -= 1
                raise MealyError("unsupported")

    def stand(self):
        self.steps += 1
        match self.state:
            case "B2":
                self.state = "B1"
                self.tree["B2"]["B1"] += 1
                return "T1"
            case _:
                self.steps -= 1
                raise MealyError("unsupported")
    
    def snap(self):
        self.steps += 1
        match self.state:
            case "B2":
                self.tree["B2"]["B3"] += 1
                self.state = "B3"
                return "T2"
            case _:
                self.steps -= 1
                raise MealyError("unsupported")
    
    def erase(self):
        self.steps += 1
        match self.state:
            case "B5":
                self.tree["B5"]["B2"] += 1
                self.state = "B2"
                return "T1"
            case "B2":
                self.state = "B4"
                self.tree["B2"]["B4"] += 1
                return "T1"
            case _:
                self.steps -= 1
                raise MealyError("unsupported")

    def seen_edge(self, e1, e2):
        return self.tree[e1][e2]

    def has_max_in_edges(self):
        if self.state == "B1":
            return True
        else:
            return False

    def get_step(self):
        return self.steps

    def __getattr__(self, name):
        raise MealyError("unknown")


def main():
    return MealyMachine()


def test():
    obj = main()
    assert obj.drag() == 'T2'
    assert obj.has_max_in_edges() == True
    assert obj.add() == 'T3'
    assert obj.has_max_in_edges() == False
    
    assert obj.rev() == 'T3'
    assert obj.erase() == 'T1'
    assert obj.stand() == 'T1'
    assert obj.add() == 'T3'
    assert obj.erase() == 'T1'
    assert obj.seen_edge("B4", "B1") == 1
    assert obj.get_step() == 8
    assert obj.drag() == 'T2'
    assert obj.add() == 'T3'
    assert obj.snap() == 'T2'

    # try:
    #     obj.add()
    # except MealyError as e:
    #     assert e.msg == "unsupported"

    try:
        obj.rev()
    except MealyError as e:
        assert e.msg == "unsupported"

    try:
        obj.snap()
    except MealyError as e:
        assert e.msg == "unsupported"

    try:
        obj.erase()
    except MealyError as e:
        assert e.msg == "unsupported"

    try:
        obj.stand()
    except MealyError as e:
        assert e.msg == "unsupported"

    try:
        obj.keks()
    except MealyError as e:
        assert e.msg == "unknown"
