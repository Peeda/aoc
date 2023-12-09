package aoc

import "core:fmt"
import "core:strings"
import "core:strconv"
import "core:math"

// vals : [dynamic]string
val :: proc(input:string) -> int {
    assert(len(input) == 3)
    return cast(int)input[0]*100*100 + cast(int)input[1]*100 + cast(int)input[2]
    /*
    for val,i in vals {
        if val == input {
            return i
        }
    }
    append(&vals,input)
    return len(vals)-1
    */
}
main :: proc() {
    graph: [dynamic][2]int
    resize(&graph, 1000000)
    input := #load("input.txt", string)
    tokens: [dynamic]string
    path: string
    for line,i in strings.split(input, "\n") {
        if i==0 {
            path = line
        } else {
            for token in strings.split(line, " ") {
                if len(token) > 1 {
                    append(&tokens,token)
                }
            }
        }
    }
    starts: [dynamic]string
    for i := 0; i < len(tokens); i+=3 {
        a,b,c := val(tokens[i]),val(tokens[i+1][1:4]),val(tokens[i+2][0:3])
        graph[a] = [2]int{b,c}
        if tokens[i][2] == 'A' {
            append(&starts,tokens[i])
        }
    }
    fmt.println(starts)
    ans_list: [dynamic]int
    for start,i in starts {
        ans := 0
        curr := val(start)
        for i := 0; i < 1000000; i+=1 {
            if curr % 100 == 90 {
                append(&ans_list,ans)
                break
            }
            dir := path[ans % len(path)]
            if dir == 'L' {
                curr = graph[curr][0]
            } else {
                assert(dir == 'R')
                curr = graph[curr][1]
            }
            ans+=1
        }
    }
    // append(&ans_list,ans)
    fmt.println(ans_list)
    ans := 1
    for a in ans_list {
        ans = math.lcm(a,ans)
    }
    fmt.println(ans)
}
