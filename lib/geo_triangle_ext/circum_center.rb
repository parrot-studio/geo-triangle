# coding: utf-8
module GeoTriangleExt

  class CircumCenter

    class << self

      def create(*co)
        cc = self.new
        co.take(3).each{|c| cc.coordinates << c}
        cc
      end

    end

    def set_coordinate(x, y)
      coordinates << [x, y]
    end

    def coordinates
      @coordinates ||= []
      @coordinates = @coordinates.uniq
      @coordinates = @coordinates.take(3) if @coordinates.size > 3
      @coordinates
    end

    def valid_coordinates?
      return false unless coordinates.size == 3
      return false unless coordinates.all?{|c| c.size == 2}
      true
    end

    def functions
      @functions ||= create_functions
      @functions
    end

    def valid_functions?
      return false if functions.size < 2
      return false if functions.combination(2).any?{|f1, f2|
        f1.orthogonal_slope == f2.orthogonal_slope}
      true
    end

    def center
      return unless valid_functions?
      @center_point ||= calc_center
      @center_point
    end

    private

    def create_functions
      return [] unless valid_coordinates?
      ret = []
      coordinates.combination(2) do |a, b|
        f = LinearFunction.create(*([a, b].flatten))
        next unless f
        ret << f if f.valid?
      end
      ret
    end

    def calc_center
      return unless valid_functions?

      l1 = functions.first
      l2 = functions.last

      a1 = l1.orthogonal_slope
      b1 = l1.orthogonal_intercept
      a2 = l2.orthogonal_slope
      b2 = l2.orthogonal_intercept

      x = (b2 - b1) / (a1 - a2)
      y = (a1 * b2 - b1 * a2) / (a1 - a2)

      [x, y]
    end

  end

end

