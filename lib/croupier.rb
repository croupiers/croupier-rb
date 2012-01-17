module Croupier

  # TODO: Discuss if int_length should have an abs call at the end...
  # Uniform distribution.
  def runi(size=1, int_start=0, int_end=1, &block)
    int_length = (int_end - int_start)
    sample = (1..size).map { int_start + int_length * rand }
    sample = sample.map(&block) if block
    first_or_whole sample
  end

  # Exponential distribution
  def rexp(avg=1, size=1)
    runi(size) do |x|
      -avg * Math.log(x)
    end
  end

  # Normal distribution
  def rnorm(avg=0, std=1, size=1)
    sample = runi(12*size).each_slize(12).map do |x|
      avg + std * x.inject(-6, &:+)
    end

    first_or_whole sample
  end

  protected
  def first_or_whole(arr)
    arr.size == 1 ? arr.first : arr
  end
end
