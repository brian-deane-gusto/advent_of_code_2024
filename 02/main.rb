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

pp input.count { |line| safe?(line) }
