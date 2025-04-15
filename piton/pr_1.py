
def main(s):
    dct = dict()

    s = s.replace("\n", " ")
    s = s.replace("<:", "").replace(":>", "").replace("do var ", "")
    s = s.replace("array(", "").replace(")", "")
    s = s.split("end")
    s = [i.split(":=") for i in s]

    for i in s:
        if(len(i) == 2):
            dct[i[0].strip()] = list(map(int, i[1].strip().split(',')))
    return dct

#  print(main('<: do var eroror_601 := array(2816 , -8595 , -5388 , 2978 )end do var razati_883 := array( -9709 , -2010 , -7553 , 2)end do var erdi:= array( 6400 , -5978 ,173 )end:>'))