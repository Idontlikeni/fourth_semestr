
Module(
  body=[
    Expr(
      value=BinOp(
        left=IfExp(
          test=Compare(
            left=Name(id='x', ctx=Load()),
            ops=[
              GtE()],
            comparators=[
              Constant(value=4)]),
          body=Constant(value=3),
          orelse=Name(id='x', ctx=Load())),
        op=Add(),
        right=IfExp(
          test=Compare(
            left=Name(id='x', ctx=Load()),
            ops=[
              Gt()],
            comparators=[
              Constant(value=2)]),
          body=Constant(value=1),
          orelse=BinOp(
            left=Name(id='y', ctx=Load()),
            op=FloorDiv(),
            right=Constant(value=3)))))],
  type_ignores=[])