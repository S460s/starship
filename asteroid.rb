require_relative 'consts'

# A class for asteroids
class Asteroid
  attr_reader :x, :y

  @@asteroids = []

  def self.clean_asteroids
    @@asteroids.filter! do |asteroid|
      asteroid.x.between?(0, Constants::SCREE_SIZE[:width]) &&
        asteroid.y.between?(0, Constants::SCREE_SIZE[:height])
    end
  end

  def self.add_asteroid(image)
    @@asteroids.push new(image) if rand(100) < 3 && @@asteroids.size < 15
  end

  def self.move
    @@asteroids.each(&:move)
  end

  def self.asteroids
    @@asteroids
  end

  def initialize(image)
    @image = image
    @x, @y = init_coords

    @vel_x = 0.0
    @vel_y = 0.0
    @angle = rand(160)
  end

  def draw
    @image.draw(@x, @y, Constants::Z_INDEX[:PLAYER])
  end

  def move
    accelerate
    @x += @vel_x
    @y += @vel_y
  end

  private

  def accelerate
    @vel_x = Gosu.offset_x(@angle, 2.5)
    @vel_y = Gosu.offset_y(@angle, 2.5)
  end

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
