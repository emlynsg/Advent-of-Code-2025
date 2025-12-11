#!/usr/bin/env -S julia --project

module AdventOfCodeDay11
    function part1(filename::String)
        dict = parse_part1(filename)
        return iter("you", dict, 0)
    end

    function iter(node::String, data::Dict{String, Set{String}}, num::Int64=0)
        let num = num
            for key in data[node]
                if key == "out"
                    num += 1
                    continue
                else
                    num = iter(key, data, num)
                end
            end
            return num
        end
    end

    function parse_part1(filename::String)
        file = readlines(open(filename))
        dict::Dict{String, Set{String}} = Dict()
        for line in file
            (key, values) = split(line, ": ")
            value_set::Set{String} = Set()
            for value in split(values, " ")
                push!(value_set, value)
            end
            dict[key] = value_set
        end
        return dict
    end

    function parse_part2(filename::String)
        return parse_part1(filename)
    end

    function part2(filename::String)
        dict = parse_part2(filename)
        history::Set{String} = Set()
        push!(history, "svr")
        number = iter_hist("svr", dict, history, 0)
        return number
    end

    function iter_hist(node::String, data::Dict{String, Set{String}}, hist::Set{String}, num::Int64=0)
        let num = num, current_hist = deepcopy(hist)
            for key in data[node]
                new_hist = deepcopy(current_hist)
                push!(new_hist, key)
                if key == "out"
                    if "dac" in new_hist && "fft" in new_hist
                        num += 1
                    end
                    continue
                else
                    num = iter_hist(key, data, new_hist, num)
                end
            end
            return num
        end
    end

    function main()
        @show part1("Day11_Part1_test.txt")
        @show part1("Day11_Part1.txt")
        @show part2("Day11_Part2_test.txt")
        @show part2("Day11_Part1.txt")
    end

    function __init__()
        if abspath(PROGRAM_FILE) == @__FILE__
            main()
        end
    end
end