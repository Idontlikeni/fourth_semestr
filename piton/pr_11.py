class CustomError(Exception):
    def __init__(self, msg):
        self.msg = msg
        super().__init__(self.msg)

    def __str__(self):
        return f"{self.msg} Error code: {self.error_code})"

class MooreMachine:
    def __init__(self):
        self.state = "v7"
        self.vs = {}
        self.mt = set()

    def let_r(self, r):
        self.vs['r'] = r

    def let_y(self, y):
        self.vs['y'] = y

    def boost(self):
        self.mt.add('boost')
        match self.state:
            case "v7":
                self.state = "v1"
            case "v1" if self.vs['y'] == 0:
                self.state = "v0"
            case "v1" if self.vs['y'] == 1:
                self.state = "v2"
            case "v2":
                self.state = "v0"
            case "v4" if self.vs['r'] == 0:
                self.state = "v0"
            case "v4" if self.vs['r'] == 1:
                self.state = "v2"
            case _:
                raise CustomError("unsupported", 400)

    def patch(self):
        self.mt.add('patch')
        match self.state:
            case "v0":
                self.state = "v5"
            case "v6":
                self.state = "v5"
            case "v3":
                self.state = "v4"
            case _:
                raise CustomError("unsupported", 400)

    def tag(self):
        self.mt.add('tag')
        match self.state:
            case "v5":
                self.state = "v6"
            case _:
                raise CustomError("unsupported", 400)

    def init(self):
        self.mt.add('init')
        match self.state:
            case "v6":
                self.state = "v3"
            case "v2":
                self.state = "v1"
            case _:
                raise CustomError("unsupported", 400)
    
    def set_var(self, var, val):
        self.vs[var] = val

    def get_output(self):
        match self.state:
            case "v7" | "v3":
                return "F1"
            case "v1" | "v2":
                return "F0"
            case "v0" | "v5" | "v6" | "v4":
                return "F2"

    def has_path_to(self, state):
        return True if state != 'v7' else False

    def seen_method(self, m):
        return m in self.mt

    def __getattr__(self, name):
        raise CustomError("unkown", 400)
        return lambda: "unknown"

def main():
    return MooreMachine()


def test():
    obj = main()
    assert obj.get_output() == 'F1'
    obj.boost()
    assert obj.get_output() == 'F0'
    obj.let_y(0)
    obj.boost()
    assert obj.get_output() == 'F2'
    obj.patch()
    assert obj.get_output() == 'F2'
    obj.tag()
    assert obj.get_output() == 'F2'
    obj.patch()
    assert obj.get_output() == 'F2'
    obj.tag()
    assert obj.get_output() == 'F2'
    obj.init()
    assert obj.get_output() == 'F1'
    obj.patch()
    assert obj.get_output() == 'F2'
    obj.let_r(0)
    obj.boost()
    assert obj.get_output() == 'F2'
    obj.patch()
    obj.tag()
    obj.init()
    obj.patch()
    obj.let_r(1)
    obj.boost()
    assert obj.get_output() == 'F0'
    obj.init()
    assert obj.get_output() == 'F0'
    obj.let_y(1)
    obj.boost()
    assert obj.get_output() == 'F0'
    obj.boost()
    assert obj.get_output() == 'F2'
    assert obj.seen_method('boost')
    assert obj.has_path_to('v5')
    

