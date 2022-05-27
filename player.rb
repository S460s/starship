require_relative 'consts'

# Player class
class Player
  attr_reader :score
  attr_accessor :dead

  def initialize
    @image = Gosu::Image.new('media/ship_3.png')
    @x = Constants::SCREE_SIZE[:width] / 2
    @y = Constants::SCREE_SIZE[:height] / 2

    @vel_x = @vel_y = @angle = 0.0
    @beep = Gosu::Sample.new('media/beep.wav')
    @score = 0

    @dead = false
  end

  def reset
    @dead = false
    @x = Constants::SCREE_SIZE[:width] / 2
    @y = Constants::SCREE_SIZE[:height] / 2
    @score = 0
  end

  def handle_move
    turn_left if Gosu.button_down? Gosu::KB_LEFT
    turn_right if Gosu.button_down? Gosu::KB_RIGHT
    accelerate if Gosu.button_down? Gosu::KB_UP
    decelerate if Gosu.button_down? Gosu::KB_DOWN
    move
  end

  def draw
    @image.draw_rot(@x, @y, Constants::Z_INDEX[:PLAYER], @angle)
  end

  def collect_stars(stars)
    stars.reject! do |star|
      if Gosu.distance(@x, @y, star.x, star.y) < 35
        @score += 1
        @beep.play
        true
      else
        false
      end
    end
  end

  def colide(asteroids)
    asteroids.each do |asteroid|
      if Gosu.distance(@x, @y, asteroid.x, asteroid.y) < 40
        @dead = true
        break
      end
    end
  end

  private

  def move
    @x += @vel_x
    @y += @vel_y
    @x %= Constants::SCREE_SIZE[:width]
    @y %= Constants::SCREE_SIZE[:height]

    @vel_x *= 0.95
    @vel_y *= 0.95
  end

  def turn_left
    @angle -= 4.5
  end

  def turn_right
    @angle += 4.5
  end

  # direction is either 1 or -1
  def accelerate(direction = 1)
    @vel_x = Gosu.offset_x(@angle, 5.5 * direction)
    @vel_y = Gosu.offset_y(@angle, 5.5 * direction)
  end

  def decelerate
    accelerate(-1)
  end
end
