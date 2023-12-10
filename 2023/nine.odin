package aoc

import "core:fmt"
import "core:strings"
import "core:strconv"

main :: proc() {
    histories: [dynamic][dynamic]int
    input := #load("input.txt", string)
    lines := 0
    for line in strings.split(input, "\n") {
        lines += 1
    }
    resize(&histories, lines-1)
    for line,i in strings.split(input, "\n") {
        for token in strings.split(line, " ") {
            if len(token) > 0 {
                val,ok := strconv.parse_int(token)
                assert(ok)
                append(&histories[i], val)
            }
        }
    }
    ans := 0
    for history in histories {
        curr_ans := history[len(history)-1]
        curr: [dynamic]int
        for h in history {
            append(&curr,h)
        }
        next: [dynamic]int
        for {
            for i := 1; i < len(curr); i+=1 {
                append(&next, curr[i] - curr[i-1])
            }
            curr_ans += next[len(next)-1]
            uniform := true
            for i := 1; i < len(next); i+=1 {
                if (next[i] != next[i-1]) {
                    uniform = false
                }
            }
            if uniform {
                break
            } else {
                curr = next
                clear(&next)
            }
        }
        fmt.println(curr_ans)
        ans += curr_ans
    }
    fmt.println(ans)
}
