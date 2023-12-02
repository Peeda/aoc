import std/strutils

var curr_line = ""
var ans = 0
let input = open("input.txt")

while readLine(input, curr_line):
    # curr_line = curr_line.multiReplace(("one","1"),("two","2"),("three","3"),
    # ("four","4"),("five","5"),("six","6"),("seven","7"),("eight","8"),("nine","9"))
    const num_words = ["one","two","three","four","five","six","seven","eight","nine"]
    const num_vals = ['1','2','3','4','5','6','7','8','9']
    echo curr_line
    var two_digit = ""
    var last = '\0'
    var i = 0;
    while i < curr_line.len:
        if curr_line[i] >= '1' and curr_line[i] <= '9':
            last = curr_line[i]
            if two_digit.len == 0:
                two_digit.add(curr_line[i])
        else:
            for k,word in num_words.pairs:
                if curr_line[i..min(i+word.len-1,curr_line.len-1)] == word:
                    last = num_vals[k]
                    if two_digit.len == 0:
                        two_digit.add(num_vals[k])

        i += 1
    two_digit.add(last)
    ans += parseInt(two_digit)
echo ans
input.close()
