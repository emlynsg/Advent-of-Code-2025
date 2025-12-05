#!/usr/bin/env -S julia --project

module AdventOfCodeDay05
    function part1(filename::String)
        (ranges, products) = parse_part1(filename)
        let counter = 0, counted = []
            for product in products
                for range in ranges
                    if !in(product, counted)
                        if product >= range[1] && product <= range[2]
                            counter += 1
                            push!(counted, product)
                        end
                    end
                end
            end
            return counter
        end
    end

    function parse_part1(filename::String)
        file = readlines(open(filename))
        ranges = []
        products = Int64[]
        middle_index = 2^63
        for (index, line) in enumerate(file)
            if all(c->isspace(c), line)
                global middle_index = index
                continue
            end
        end
        for (index, line) in enumerate(file)
            global middle_index
            if index < middle_index
                split_line = split(line, "-")
                push!(ranges, (parse(Int64, String(split_line[1])), parse(Int64, String(split_line[2]))))
            end
            if index > middle_index
                push!(products, parse(Int64, line))
            end
        end
        return (ranges, products)
    end

    function parse_part2(filename::String)
        (ranges, products) = parse_part1(filename)
        return ranges
    end

    function part2(filename::String)
        ranges = parse_part2(filename)
        let ordered_disjoint_ranges = [], merged = false, counter = 0
            max_num = maximum([range[2] for range in ranges])
            for range in ranges
                merged = false
                if isempty(ordered_disjoint_ranges)
                    push!(ordered_disjoint_ranges, range)
                    continue
                end
                for (index, odr) in enumerate(ordered_disjoint_ranges)
                    if range[1] <= odr[1] && range[2] >= odr[1]
                        ordered_disjoint_ranges[index][1] = range[1]
                        merged = true
                    end
                    if range[1] <= odr[2] && range[2] >= odr[2]
                        ordered_disjoint_ranges[index][2] = range[2]
                        merged = true
                        break
                    end
                end
                if !merged
                    push!(ordered_disjoint_ranges, range)
                end
            end
            for num in 0:max_num
                for odr in ordered_disjoint_ranges
                    if num >= odr[1] && num <= odr[2]
                        counter += 1
                        break
                    end
                end
            end
            return counter
        end
        # let counter = 0, counted = BitSet([])
        #     for range in ranges
        #         for num in range[1]:range[2]
        #             if !in(num, counted)
        #                 counter += 1
        #                 union!(counted, Set([num]))
        #             end
        #         end
        #     end
        #     return counter
        # end
            return length(single_set)
    end

    function main()
        @show part1("Day05_Part1_test.txt")
        @show part1("Day05_Part1.txt")
        @show part2("Day05_Part1_test.txt")
        @show part2("Day05_Part1.txt")
    end

    function __init__()
        if abspath(PROGRAM_FILE) == @__FILE__
            main()
        end
    end
end