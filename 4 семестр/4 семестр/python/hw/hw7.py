s = ({'CSON', 'RAML', 'HLSL', 'GOLO'},
     {'CSON', 'RAML', 'HLSL', 'JULIA'},
     {'CSON', 'RAML', 'HLSL', 'GRACE'},
     {'CSON', 'RAML', 'PLSQL', 'JAVA'},
     {'CSON', 'RAML', 'PLSQL', 'CUDA'},
     {'CSON', 'RAML', 'PLSQL', 'XBASE'},
     {'CSON', 'RAML', 'RHTML', 'JAVA'},
     {'CSON', 'RAML', 'RHTML', 'CUDA'},
     {'CSON', 'RAML', 'RHTML', 'XBASE'},
     {'CSON', 'EAGLE'},
     {'CSON', 'GAMS'},
     {'SWIFT'},
     {'SCSS'})


def main(list):
    s1 = set(list)
    return [i for i in range(len(s))
            if not (len(s[i] - s1))][0]

