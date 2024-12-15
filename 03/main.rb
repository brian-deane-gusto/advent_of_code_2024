lines = File.readlines('sample').map(&:strip)

# part 1
def part1
  mult_regex = /mul\([1-9][0-9]?[0-9]?,[1-9][0-9]?[0-9]?\)/
  score = 0
  lines.each do |line|
    line.scan(mult_regex).each do |match|
      a, b = match[4...-1].split(',').map(&:to_i)
      score += a * b
    end
  end

  pp score
end


mult_regex = /mul\([1-9][0-9]?[0-9]?,[1-9][0-9]?[0-9]?\)/
do_regex = /do\(\)/
dont_regex = /don't\(\)/

score = 0
enabled = true
bitmap = []

lines.each do |line|
  do_matches = line.to_enum(:scan, do_regex).map { Regexp.last_match.offset(0).first }
  dont_matches = line.to_enum(:scan, dont_regex).map { Regexp.last_match.offset(0).first }

  line.length.times do |i|
    if dont_matches.include? i
      enabled = false
    elsif do_matches.include? i
      enabled = true
    end

    bitmap[i] = enabled
  end

  line.to_enum(:scan, mult_regex).each do |match|
    match_data = Regexp.last_match
    i, _ = match_data.offset(0)
    if bitmap[i]
      a, b = match[4...-1].split(',').map(&:to_i)
      score += a * b
    end
  end
end

pp score
