import std/sequtils
import std/strutils

var curr_line = ""
var ans = 0
var seeds = newSeq[int](0)
var lines = newSeq[string]()
let input = open("input.txt")

var first = true

while readLine(input, curr_line):
    if first:
        for word in curr_line.split(' '):
            if not word.contains("seeds:"):
                seeds.add(parseInt(word))
        first = false
    else:
        lines.add(curr_line)
input.close()

var maps = newSeqWith[0,newSeq[int](0)]
lines = filter(lines, proc(x: string): bool = x.len != 0)
var curr_map = newSeq[int](0)
for line in lines:
    if line.contains("map:"):
        if curr_map.len != 0:
            maps.add(curr_map)
        # reset seq
        curr_map = @[]
    else:
        for num in line.split(' '):
            curr_map.add(parseInt(num))
maps.add(curr_map)

echo maps
echo seeds
for mapping in maps:
    for i in 0..seeds.len-1:
        var k = 0
        while k+2 < mapping.len:
            let diff = seeds[i] - mapping[k+1]
            if diff < mapping[k+2] and diff >= 0:
                seeds[i] = mapping[k] + diff
                break
            k += 3
    echo seeds

echo min(seeds)
