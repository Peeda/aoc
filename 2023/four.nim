from std/strutils import split, contains, parseInt
import std/math

var curr_line = ""
var ans = 0
let input = open("input.txt")

while readLine(input, curr_line):
    var first: set[int16]
    var second: set[int16]
    for i,nums in curr_line.split('|').pairs():
        for num in nums.split(' '):
            if num.contains("Card") or num.contains(':') or num.len == 0:
                continue
            let val:int16 = int16(parseInt(num))
            if i == 0:
                first.incl(val)
            else:
                second.incl(val)
    let points = card(first*second)
    if points != 0:
        ans += int16(pow(float32(2),float32(points-1)))


echo ans
