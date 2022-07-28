list1 = [1,2,3,4]
list2 = ['ancd\n','or\n','subu\n','xy\n']

while list2[0][0:2] < 'sb' :
    del list2[0]
print(list2)
print(list2[0][0:2])