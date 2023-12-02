import std/strutils
import std/strbasics

var curr_line = ""
var ans = 0
let input = open("input.txt")

while readLine(input, curr_line):
    curr_line.add(';')
    var works = true
    var last_val = -1
    var mr,mg,mb = 0
    var r,g,b = 0
    var line_num = -1
    for word in split(curr_line,' '):
        # echo word
        if word.contains(':'):
            var temp = word
            temp.removeSuffix(":")
            line_num = parseInt(temp)
            continue
        elif word == "Game":
            continue
        if word[0] >= '1' and word[0] <= '9':
            last_val = parseInt(word)
        else:
            assert(last_val != -1)
            var is_end = word[^1] == ';'
            var temp = word
            if is_end:
                temp.removeSuffix(';')
            else:
                temp.removeSuffix(',')
            case temp
            of "red":
                r += last_val
            of "blue":
                b += last_val
            of "green":
                g += last_val
            last_val = -1
            if is_end:
                mr = max(mr,r)
                mg = max(mg,g)
                mb = max(mb,b)
                # if r > 12 or g > 13 or b > 14:
                #     works = false
                r = 0
                g = 0
                b = 0
    let power = mr*mg*mb
    ans += power
    # if works:
    #     ans += line_num
echo ans
input.close()
