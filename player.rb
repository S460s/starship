# Player class
class Player
  attr_reader :score

  def initialize
    @image = Gosu::Image.new('media/starfighter.bmp')
    @x = @y = @vel_x = @vel_y = @angle = 0.0
    @beep = Gosu::Sample.new('media/beep.wav')
    @score = 0
  end

  def wrap(x, y)
    @x = x
    @y = y
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

  def move
    @x += @vel_x
    @y += @vel_y
    @x %= 640
    @y %= 480

    @vel_x *= 0.95
    @vel_y *= 0.95
  end

  def draw
    @image.draw_rot(@x, @y, 1, @angle)
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
end
