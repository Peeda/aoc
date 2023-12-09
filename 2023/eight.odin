package aoc

import "core:fmt"
import "core:strings"
import "core:strconv"

vals : [dynamic]string
val :: proc(input:string) -> int {
    assert(len(input) == 3)
    for val,i in vals {
        if val == input {
            return i
        }
    }
    append(&vals,input)
    return len(vals)-1
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
    for t in tokens {
        // fmt.println(t)
    }
    fmt.println(path)
    for i := 0; i < len(tokens); i+=3 {
        a,b,c := val(tokens[i]),val(tokens[i+1][1:4]),val(tokens[i+2][0:3])
        graph[a] = [2]int{b,c}
    }
    ans := 0
    curr := val("AAA")
    for curr != val("ZZZ") {
        dir := path[ans % len(path)]
        // fmt.println(dir)
        if dir == 'L' {
            curr = graph[curr][0]
        } else {
            assert(dir == 'R')
            curr = graph[curr][1]
        }
        ans+=1
    }
    fmt.println(ans)
}
