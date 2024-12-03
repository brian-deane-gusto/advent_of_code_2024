lines = File.readlines('input').map &:strip

# part 1
def part1
  pairs = lines.map(&:split)
  list1, list2 = pairs.transpose.map { |row| row.map(&:to_i) }
  p list1.sort.zip(list2.sort).map { |a, b| (a-b).abs }.sum
end

# part 2
pairs = lines.map(&:split)
list1, list2 = pairs.transpose.map { |row| row.map(&:to_i) }
p list1
  .map { |el| el * list2.count(el) }
  .sum
