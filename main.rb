require 'gosu'
require_relative 'player'
require_relative 'z_order'
require_relative 'star'

# class for tutorial
class Tutorial < Gosu::Window
  def initialize
    super 640, 480
    self.caption = 'Tutorial Game'

    @background_imae = Gosu::Image.new('media/space.png', tileable: true)

    @player = Player.new
    @player.wrap(320, 240)

    @font = Gosu::Font.new(20)

    @star_anim = Gosu::Image.load_tiles('media/star.png', 25, 25)
    @stars = []
  end

  def handle_movement
    @player.turn_left if Gosu.button_down? Gosu::KB_LEFT or Gosu.button_down? Gosu::GP_LEFT
    @player.turn_right if Gosu.button_down? Gosu::KB_RIGHT or Gosu.button_down? Gosu::GP_RIGHT
    @player.accelerate if Gosu.button_down? Gosu::KB_UP or Gosu.button_down? Gosu::GP_BUTTON_0
    @player.decelerate if Gosu.button_down? Gosu::KB_DOWN or Gosu.button_down? Gosu::GP_BUTTON_1
    @player.move
  end

  def update
    handle_movement
    @player.collect_stars(@stars)

    @stars.push(Star.new(@star_anim)) if rand(100) < 3 && @stars.size < 25
  end

  def draw
    @player.draw
    @background_imae.draw(0, 0, ZOrder::BACKGROUND)

    @stars.each(&:draw)
    @font.draw_text("Score: #{@player.score}", 10, 10, ZOrder::UI, 1.0, 1.0, Gosu::Color::YELLOW)
  end

  def button_down(id)
    if id == Gosu::KB_ESCAPE
      close
    else
      super
    end
  end
end

Tutorial.new.show
