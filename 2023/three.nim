import std/strutils
import std/sets

var ans = 0
var curr_line = ""
let input = open("input.txt")
var positions = initHashSet[(int,int)]()
var schema = newSeq[string](0)

proc is_num(x: char): bool = 
    return x >= '0' and x <= '9'

while readLine(input, curr_line):
    schema.add(curr_line)

input.close()
for i,line in schema.pairs:
    for k,ch in line.pairs:
        if (not (is_num(ch))) and (ch != '.'):
            for offset in [(-1,-1),(-1,1),(1,-1),(1,1),(1,0),(0,1),(-1,0),(0,-1)]:
                let new_y = i + offset[0]
                let new_x = k + offset[1]
                if new_x >= 0 and new_x < line.len and new_y >= 0 and new_y < schema.len:
                    positions.incl((new_y,new_x))

for i,line in schema.pairs:
    var k = 0;
    var start,finish = 0
    while k < line.len:
        if is_num(line[k]):
            start = k
            k += 1
            while k < line.len and is_num(line[k]):
                k+=1
            finish = k-1
            for p in countup(start,finish):
                if positions.contains((i,p)):
                    ans += parseInt(line[start..finish])
                    break
        else:
            k+=1

echo ans
