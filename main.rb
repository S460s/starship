require 'gosu'
require_relative 'player'

# class for tutorial
class Tutorial < Gosu::Window
  def initialize
    super 640, 480
    self.caption = 'Tutorial Game'

    @background_imae = Gosu::Image.new('media/space.png', tileable: true)

    @player = Player.new
    @player.wrap(320, 240)
  end

  def update
    @player.turn_left if Gosu.button_down? Gosu::KB_LEFT or Gosu.button_down? Gosu::GP_LEFT
    @player.turn_right if Gosu.button_down? Gosu::KB_RIGHT or Gosu.button_down? Gosu::GP_RIGHT
    @player.accelerate if Gosu.button_down? Gosu::KB_UP or Gosu.button_down? Gosu::GP_BUTTON_0
    @player.move
  end

  def draw
    @player.draw
    @background_imae.draw(0, 0, 0)
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
