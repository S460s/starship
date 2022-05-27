require_relative 'consts'

# A class for asteroids
class Asteroid
  @@asteroids = []

  def self.add_asteroid
    @@asteroids.push(new) if rand(100) < 1 && @@asteroids.size < 25
  end

  def self.asteroids
    @@asteroids
  end

  def initialize
    @image = Gosu::Image.new('media/meteor.png')
    @x, @y = init_coords

    @vel_x = @vel_y = @angle = 0.0
  end

  def draw
    @image.draw(@x, @y, Constants::Z_INDEX[:PLAYER])
  end

  private

  # HACK/REFACTOR
  def init_coords
    flag = rand(2)
    coords = []

    if flag == 1
      coords[0] = 0
      coords[1] = rand(Constants::SCREE_SIZE[:height])
      return coords
    end

    coords[0] = rand(Constants::SCREE_SIZE[:width])
    coords[1] = 0

    coords
  end
end
