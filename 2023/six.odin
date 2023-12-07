package aoc
import "core:fmt"
import "core:strings"
import "core:strconv"

main :: proc() {
    input := #load("input.txt", string)
    times, dists : u128
    for line,index in strings.split(input,"\n") {
        builder := strings.builder_make()
        for token in strings.split(line," ") {
            if len(token) > 0 && !strings.contains(token, ":") {
                strings.write_string(&builder, token)
            }
            // if len(token) > 0 && !strings.contains(token,":") {
            //     n,_ := strconv.parse_int(token)
            //     if index == 0 {
            //         append(&times,n)
            //     } else {
            //         append(&dists,n)
            //     }
            // }
        }
        // fmt.println(strings.to_string(builder))
        n,_ := strconv.parse_u128(strings.to_string(builder))
        if index == 0 {
            times = n
        } else if index == 1 {
            dists = n
        }
    }
    l_ans, r_ans:u128
    //n * (t-n) > dists
    l:u128 = 1
    r:u128 = 1e7
    for l <= r {
        mid := l + (r-l)/2
        bound := dists/mid
        if dists % mid != 0 {
            bound+=1;
        }
        if times-mid >= bound {
            r = mid-1
            l_ans = mid
        } else {
            l = mid + 1
        }
    }
    l = 1e7
    r = 1e8
    for l <= r {
        mid := l + (r-l)/2
        bound := dists/mid
        if dists % mid != 0 {
            bound+=1;
        }
        if times-mid >= bound {
            l = mid + 1
            r_ans = mid
        } else {
            r = mid-1
        }
    }
    fmt.println(l_ans)
    fmt.println(r_ans)
    fmt.println(r_ans - l_ans + 1)
}
