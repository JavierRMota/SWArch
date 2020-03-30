def pow2(n)
  Enumerator.new do |yielder|
    a = 1
    n.times do
      yielder << a
      a *= 2
    end
  end
end


def pow2_infinity
  Enumerator.new do |yielder|
    a = 1
    while true do
      yielder << a
      a *= 2
    end
  end
end

g = pow2(5)
puts g.to_a
g = pow2_infinity
puts g.take(10).to_a
