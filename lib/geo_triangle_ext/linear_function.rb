# coding: utf-8
module GeoTriangleExt

  class LinearFunction

    attr_writer :ax, :ay, :bx, :by

    class << self

      def create(ax, ay, bx, by)
        lf = self.new
        lf.ax = ax
        lf.ay = ay
        lf.bx = bx
        lf.by = by
        lf
      end

    end

    def ax
      @bax ||= BigDecimal(@ax.to_s)
      @bax

    end

    def ay
      @bay ||= BigDecimal(@ay.to_s)
      @bay
    end

    def bx
      @bbx ||= BigDecimal(@bx.to_s)
      @bbx
    end

    def by
      @bby ||= BigDecimal(@by.to_s)
      @bby
    end

    def valid?
      return false if ax == bx
      return false if ay == by
      true
    end

    def middle_point
      x = (ax + bx) / 2.0
      y = (ay + by) / 2.0
      [x, y]
    end

    def slope
      return unless valid?
      (ay - by) / (ax - bx)
    end

    def intercept
      return unless valid?
      (ax * by - ay * bx) / (ax - bx)
    end

    def orthogonal_slope
      return unless valid?
      (bx - ax) / (ay - by)
    end

    def orthogonal_intercept
      return unless valid?
      (ax*ax + ay*ay - bx*bx - by*by) / (2 * (ay - by))
    end

  end

end

