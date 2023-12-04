from std/strutils import split, contains, parseInt
import std/math

var curr_line = ""
var ans = 0
let input = open("input.txt")
var scores = newSeq[int](0)

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
    let matches = card(first*second)
    scores.add(matches)

var counts = newSeq[int](scores.len)
for i in 0..counts.len-1:
    counts[i] = 1

for i in 0..scores.len-1:
    for k in i+1..i+scores[i]:
        counts[k] += counts[i]

for i in 0..counts.len-1:
    ans += counts[i]

echo ans
