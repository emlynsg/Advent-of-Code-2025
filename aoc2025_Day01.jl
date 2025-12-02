#!/usr/bin/env -S julia --project
using Base: cumsum
    
module AdventOfCodeDay01
    function parse_part1(filename::String)
        [parse_line_part1(line) for line in eachline(filename)]
    end

    function parse_line_part1(line::String)
        val = parse(Int64, line[2:end])
        if line[1] == 'L'
            val = -1*val
        end
        return val
    end

    function part1(filename::String)
        input = parse_part1(filename)
        val = 50
        # counter_passed_zero = 0
        counter_is_zero = 0
        for line in input
            val = val + line
            # counter_passed_zero += div(val, 100)
            val = rem(val, 100)
            if val == 0
                counter_is_zero += 1
            end
        end
        return counter_is_zero
    end

    function parse_part2(filename::String)
        parse_part1(filename)
    end

    function parse_line_part2(line::String)
        val = parse(Int64, line[2:end])
        if line[1] == 'L'
            val = (-1*val) % 100
        end
        return val
    end

    function part2(filename::String)
        input = parse_part1(filename)
        val = 50
        counter_passed_zero = 0
        counter_is_zero = 0
        for line in input
            val = val + line
            counter_passed_zero += div(val, 100)
            val = rem(val, 100)
            if val == 0
                counter_is_zero += 1
            end
        end
        return counter_passed_zero
    end

    function main()
        @show part1("Day01_Part1.txt")
        @show part1("Day01_Part1_input.txt")
        @show part2("Day01_Part1.txt")
        # @show part2("Day01_Part1_input.txt")
    end

    function __init__()
        if abspath(PROGRAM_FILE) == @__FILE__
            main()
        end
    end
end