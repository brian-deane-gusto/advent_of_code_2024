input = File.readlines('input').map &:strip
input = input.map { |line| line.split.map(&:to_i) }

def safe?(line)
  prev_diff_sign = nil
  line.each_cons(2) do |a,b|
    return false unless (a-b).abs.between?(1,3)

    new_diff_sign = (a-b).positive? ? 1 : -1

    if prev_diff_sign.nil?
      prev_diff_sign = new_diff_sign
      next
    end

    return false if prev_diff_sign != new_diff_sign
  end

  true
end

# part 1
def part1
  pp input.count { |line| safe?(line) }
end

# part 2
count = 0
input.each do |line|
  lines = [line]
  0.upto(line.length-1) do |i|
    lines << line[0...i] + line[i+1..-1]
  end
  count += 1 if lines.any? { safe?(_1) }
end
pp count
