# coding: utf-8
require 'bigdecimal'
require 'gravity_center'
require 'geo_triangle_ext/linear_function'
require 'geo_triangle_ext/circum_center'

class GeoTriangle

  class << self

    def center(*val)
      gt = self.new
      v = [val].flatten
      gt.set_coordinate(v[0], v[1])
      gt.set_coordinate(v[2], v[3])
      gt.set_coordinate(v[4], v[5])
      gt.center
    end

  end

  def exist?(lat, lon)
    return false unless lat
    return false unless lon
    return false if lat.abs > 90.0
    return false if lon.abs > 180.0
    true
  end

  def set_coordinate(*val)
    v = [val].flatten
    lat = v[0]
    lon = v[1]
    coordinates << [lat, lon] if exist?(lat, lon)
    self
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

  def center
    return unless valid_coordinates?
    gc = GravityCenter.create(*coordinates)
    lat = gc.center_x.round(6).to_f
    lon = gc.center_y.round(6).to_f
    exist?(lat, lon) ? [lat, lon] : nil
  end

end

