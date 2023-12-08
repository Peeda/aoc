package aoc

import "core:fmt"
import "core:strings"
import "core:strconv"
import "core:slice"

hand :: struct {
    cards: [5]u8,
    orig: [5]u8,
    bet: int,
}
strength :: proc(hand:[5]u8) -> u8 {
    cnt: [100]u8
    for val in hand {
        cnt[val] += 1
    }
    freqs: [dynamic]u8
    for val in hand {
        if cnt[val] > 0 {
            append(&freqs,cnt[val])
            cnt[val] = 0
        }
    }
    slice.sort(freqs[:])
    switch len(freqs) {
    case 5:
        return 1
    case 4:
        return 2
    case 3:
        if freqs[len(freqs)-1] == 3 {
            return 4
        } else {
            return 3
        }
    case 2:
        if freqs[len(freqs)-1] == 4 {
            return 6
        } else {
            return 5
        }
    case 1:
        return 7
    }
    assert(false)
    return 1
}
greater :: proc(a,b: hand) -> bool {
    if strength(a.cards) > strength(b.cards) {
        return true
    } else if strength(a.cards) == strength(b.cards) {
        for i := 0; i < len(a.orig); i+=1 {
            if a.orig[i] > b.orig[i] {
                return true
            } else if b.orig[i] > a.orig[i] {
                return false
            }
        }
    } else {
        return false
    }
    assert(false)
    return false
}
main :: proc() {
    input := #load("input.txt", string)
    lines: [dynamic]string
    for line in strings.split(input, "\n") {
        for token in strings.split(line, " ") {
            if len(token) > 0 {
                append(&lines,token)
            }
        }
    }
    hands: [dynamic]hand
    for i := 0; i < len(lines); i += 2 {
        cards: [5]u8
        for card,index in lines[i] {
            switch card {
            case '2'..='9':
                cards[index] = cast(u8)(cast(u32)card - cast(u32)'1')
            case 'T':
                cards[index] = 10
            case 'J':
                cards[index] = 11
            case 'Q':
                cards[index] = 12
            case 'K':
                cards[index] = 13
            case 'A':
                cards[index] = 14
            }
        }
        orig := cards
        slice.sort(cards[:])
        bet,ok := strconv.parse_int(lines[i+1])
        assert(ok)
        curr := hand{cards, orig, bet}
        append(&hands,curr)
    }
    for hand in hands {
        fmt.println(hand)
    }
    unsorted := true
    for unsorted {
        unsorted = false
        for i := 1; i < len(hands); i+=1 {
            if greater(hands[i-1], hands[i]) {
                unsorted = true
                hands[i-1], hands[i] = hands[i], hands[i-1]
            }
        }
    }
    fmt.println("EEEEE")
    for hand in hands {
        fmt.println(hand)
    }
    ans := 0
    for hand,i in hands {
        fmt.println(hands[i].bet)
        ans += hands[i].bet * (i+1)
    }
    fmt.println(ans)
}
