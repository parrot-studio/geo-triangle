# coding: utf-8
require 'bigdecimal'

class GravityCenter

  attr_reader :x1, :y1, :x2, :y2, :x3, :y3

  def self.create(*val)
    gc = self.new
    gc.instance_eval do
      v = [val].flatten
      @x1 = BigDecimal(v[0].to_s)
      @y1 = BigDecimal(v[1].to_s)
      @x2 = BigDecimal(v[2].to_s)
      @y2 = BigDecimal(v[3].to_s)
      @x3 = BigDecimal(v[4].to_s)
      @y3 = BigDecimal(v[5].to_s)
    end
    gc
  end

  def sx1
    @sx1 ||= x1 - x3
    @sx1
  end

  def sy1
    @sy1 ||= y1 - y3
    @sy1
  end

  def sx2
    @sx2 ||= x2 - x3
    @sx2
  end

  def sy2
    @sy2 ||= y2 - y3
    @sy2
  end

  def center_sx
    @center_sx ||= calc_center_sx
    @center_sx
  end

  def center_x
    center_sx + x3
  end

  def center_sy
    @center_sy ||= calc_center_sy
    @center_sy
  end

  def center_y
    center_sy + y3
  end

  def center
    [center_x, center_y]
  end

  private

  def calc_center_sx
    (sx1 + sx2) / 3
  end

  def calc_center_sy
    (sy1 + sy2) / 3
  end

end

