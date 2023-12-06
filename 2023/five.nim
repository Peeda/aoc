import std/sequtils
import std/strutils
import std/algorithm

var curr_line = ""
var ans = 0
var seeds = newSeq[int](0)
var lines = newSeq[string]()
let input = open("temp.txt")

type
    mapping* = object
        source,dest,size:int

proc mapping_cmp(x,y:mapping):int =
    cmp(x.dest,y.dest)
proc mapping_cmp_two(x,y:mapping):int =
    cmp(x.source,y.source)

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

var maps = newSeqWith[0,newSeq[mapping]()]
lines = filter(lines, proc(x: string): bool = x.len != 0)
var curr_map = newSeq[int](0)
for line in lines:
    if line.contains("map:"):
        if curr_map.len != 0:
            var p = 0
            var temp = newSeq[mapping]()
            while p < curr_map.len-1:
                temp.add(mapping(source:curr_map[p+1],dest:curr_map[p],size:curr_map[p+2]))
                p+=3
            maps.add(temp)
        # reset seq
        curr_map = @[]
    else:
        for num in line.split(' '):
            curr_map.add(parseInt(num))
if curr_map.len != 0:
    var p = 0
    var temp = newSeq[mapping]()
    while p < curr_map.len-1:
        temp.add(mapping(source:curr_map[p+1],dest:curr_map[p],size:curr_map[p+2]))
        p+=3
    maps.add(temp)

const biggest:int = (int)1e10;
echo biggest

for i in 0..maps.len-1:
    maps[i].sort(mapping_cmp_two)
for i in 0..maps.len-1:
    if maps[i][0].dest != 0:
        maps[i].add(mapping(dest:0,source:0,size:maps[i][0].dest))
        maps[i].sort(mapping_cmp_two)
    echo maps[i]
