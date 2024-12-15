INPUT = File.readlines('input').map(&:strip).map(&:chars)

DIRECTIONS = [
  [0,1],
  [0,-1],
  [1,0],
  [-1,0],
  [1,1],
  [1,-1],
  [-1,1],
  [-1,-1],
]

def valid_step?(i:, j:, direction:)
  max_length = INPUT.first.length - 1
  max_height = INPUT.length - 1
  a,b = direction
  (i+a).between?(0, max_length) && (j+b).between?(0, max_height)
end

def match_in_direction?(char:, test_word:, target:, i:, j:, direction:)
  return true if target == test_word
  return false unless valid_step?(i:, j:, direction:)

  a,b = direction
  i=i+a
  j=j+b
  char = INPUT[i][j]
  return false unless target[test_word.length] == char

  test_word = test_word + char
  match_in_direction?(char:, test_word:, target:, i:, j:, direction:)
end

def part1
  target = 'XMAS'
  count = 0

  INPUT.each_with_index do |line, i|
    line.each_with_index do |char, j|
      if char == target[0]
        valid_steps = DIRECTIONS.filter { |direction| valid_step?(i:, j:, direction:) }
        valid_steps.each do |direction|
          count += 1 if match_in_direction?(char:, test_word: char, target:, i:, j:, direction:)
        end
      end
    end
  end

  pp count
end

DIAG_DIRECTION_PAIRS = [
  [[1,1], [-1,-1]],
  [[1,-1], [-1,1]],
]

def is_x?(i:, j:)
  DIAG_DIRECTION_PAIRS.all? do |dir1, dir2|
    valid_step?(i:, j:, direction: dir1) &&
      valid_step?(i:, j:, direction: dir2) &&
      [INPUT[i+dir1.first][j+dir1.last], INPUT[i+dir2.first][j+dir2.last]].sort == ['M', 'S']
  end
end

count = 0
INPUT.each_with_index do |line, i|
  line.each_with_index do |char, j|
    if char == 'A'
      # do the thing
      count += 1 if is_x?(i:, j:)
    end
  end
end
pp count
