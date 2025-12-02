#!/usr/bin/env -S julia --project

module AdventOfCodeDay02
    function part1(filename::String)
        file = readlines(open(filename))[1]
        input_array = split(file, ",")
        for line in input_array
            sub_array = [parse(Int64, elt) for elt in eachsplit(line, "-")]
            left = sub_array[1]
            right = sub_array[2]
            left_as_string = string(left)
            right_as_string = string(right)
            left_length = length(left_as_string)
            right_length = length(right_as_string)
            if left_length % 2 != 0
                if right_length == left_length
                    continue
                else
                    left = ^(10, left_length)
                    left_as_string = string(left)
                end
            if right_length % 2 != 0
                right = ^(10, right_length - 1)
            bottom_half = left_as_string[1:div(length(left_length),2)]
            top_half = right_as_string[1:div(length(right_length),2)]
            println(left, " ", right, " ", bottom_half, " ", top_half, "\n")
        end
    end

    function parse_part2(filename::String)
        parse_part1(filename)
    end

    function part2(filename::String)
        parse_part2(filename)
    end

    function main()
        @show part1("Day02_Part1_test.txt")
        # @show part1("Day01_Part1.txt")
        # @show part2("Day01_Part2_test.txt")
        # @show part2("Day01_Part2.txt")
    end

    function __init__()
        if abspath(PROGRAM_FILE) == @__FILE__
            main()
        end
    end
end