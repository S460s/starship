require_relative 'consts'

# star class
class Star
  attr_reader :x, :y

  @@stars = []

  def initialize(animation)
    @animation = animation
    @color = Gosu::Color::BLACK.dup
    @color.red = rand(256 - 40) + 40
    @color.green = rand(256 - 40) + 40
    @color.blue = rand(256 - 40) + 40
    @x = rand * Constants::SCREE_SIZE[:width]
    @y = rand * Constants::SCREE_SIZE[:height]
  end

  def self.stars
    @@stars
  end

  def self.add_star(animation)
    @@stars.push(new(animation)) if rand(100) < 3 && @@stars.size < 25
  end

  def draw
    img = @animation[Gosu.milliseconds / 100 % @animation.size]
    img.draw(@x - img.width / 2.0, @y - img.height / 2.0,
             Constants::Z_INDEX[:STARS], 1, 1, @color, :add)
  end
end
