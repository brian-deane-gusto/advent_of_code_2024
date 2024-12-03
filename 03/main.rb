lines = File.readlines('input').map(&:strip)

mult_regex = /mul\([1-9][0-9]?[0-9]?,[1-9][0-9]?[0-9]?\)/
score = 0
lines.each do |line|
  line.scan(mult_regex).each do |match|
    a, b = match[4...-1].split(',').map(&:to_i)
    score += a * b
  end
end

pp score
