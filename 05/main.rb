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

puts "Part 1: #{part1(parse('input'))}"

require 'minitest/autorun'

class MyTest < Minitest::Test
  def test_part1
    assert_equal(143, part1(parse('sample')))
  end
end
