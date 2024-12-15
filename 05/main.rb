# Gregor I'm stealing your style
def parse(fname)
  File.read(fname).lines.map(&:strip)
end

def part1(input)
  page_order = {}
  instructions = input
    .take_while { !_1.empty? }
    .map { _1.split('|').map &:to_i }

  instructions.each do |p1, p2|
    page_order[p1] ||= []
    page_order[p1] << p2
  end

  updates = input[instructions.length+1..-1].map { _1.split(',').map &:to_i }

  valid_updates = updates.filter do |pages|
    pages.each_with_index.all? do |page, i|
      pages[i+1..-1].all? { page_order[page]&.include? _1 }
    end
  end

  valid_updates.map { _1[_1.length/2] }.reduce(&:+)
end

def part2(input)
  page_order = {}
  instructions = input
    .take_while { !_1.empty? }
    .map { _1.split('|').map &:to_i }

  instructions.each do |p1, p2|
    page_order[p1] ||= []
    page_order[p1] << p2
  end

  updates = input[instructions.length+1..-1].map { _1.split(',').map &:to_i }

  invalid_updates = updates.reject do |pages|
    pages.each_with_index.all? do |page, i|
      pages[i+1..-1].all? { page_order[page]&.include? _1 }
    end
  end

  valid_updates = invalid_updates.map do |pages|
    # order these correctly
    pages.sort do |p1, p2|
      ordering = page_order[p1]
      if ordering.nil?
        99
      elsif ordering.include? p2
        -1
      else
        1
      end
    end
  end

  valid_updates.map { _1[_1.length/2] }.reduce(&:+)
end

puts "Part 1: #{part1(parse('input'))}"
puts "Part 2: #{part2(parse('input'))}"

require 'minitest/autorun'

class MyTest < Minitest::Test
  def test_part1
    assert_equal(143, part1(parse('sample')))
  end

  def test_part2
    assert_equal(123, part2(parse('sample')))
  end
end
