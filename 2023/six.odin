package aoc
import "core:fmt"
import "core:strings"
import "core:strconv"

main :: proc() {
    input := #load("input.txt", string)
    times, dists : [dynamic]int
    for line,index in strings.split(input,"\n") {
        for token in strings.split(line," ") {
            if len(token) > 0 && !strings.contains(token,":") {
                n,_ := strconv.parse_int(token)
                if index == 0 {
                    append(&times,n)
                } else {
                    append(&dists,n)
                }
            }
        }
    }

    assert(len(times) == len(dists))
    ans := 1
    //score(n) = n * (t-n)
    for i := 0; i < len(times); i+=1 {
        ways := 0
        for charge := 1; charge < times[i]; charge += 1 {
            if charge * (times[i] - charge) > dists[i] {
                ways += 1
            }
        }
        ans *= ways
    }
    fmt.println(ans)
}
