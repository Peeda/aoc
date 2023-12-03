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
            positions.clear()
            for offset in [(-1,-1),(-1,0),(-1,1),(1,-1),(1,0),(1,1),(0,1),(0,-1)]:
                let new_y = i + offset[0]
                let new_x = k + offset[1]
                if new_x >= 0 and new_x < line.len and new_y >= 0 and new_y < schema.len:
                    var valid = not (positions.contains((new_y,new_x-1)) or positions.contains((new_y,new_x+1)))
                    # to put top right or bottom right one given that tl/bl is on, the middle has to be off
                    var extra = false
                    if (offset[1] == 1) and (offset[0] == 1 or offset[0] == -1):
                        extra = not is_num(schema[new_y][new_x-1])
                    if positions.contains((new_y,new_x-2)):
                        valid = valid and extra
                    if is_num(schema[new_y][new_x]) and valid:
                        positions.incl((new_y,new_x))
            if positions.len == 2:
                var temp = 0
                for pos in positions:
                    let y = pos[0]
                    var l,r = pos[1]
                    while l >= 0 and is_num(schema[y][l]):
                        l-=1
                    l += 1
                    while r < schema[y].len and is_num(schema[y][r]):
                        r+=1
                    r-=1
                    let val = parseInt(schema[y][l..r])
                    if temp == 0:
                        temp = val
                    else:
                        ans += val * temp
                echo i, " ", k, " ", schema[i][k], " ", temp
echo ans
