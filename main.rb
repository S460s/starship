require 'gosu'
require_relative 'consts'

require_relative 'player'
require_relative 'star'
require_relative 'asteroid'

# class for tutorial
class Tutorial < Gosu::Window
  def initialize
    super Constants::SCREE_SIZE[:width], Constants::SCREE_SIZE[:height]
    self.caption = 'Tutorial Game'
    @background_image = Gosu::Image.new('media/space.png', tileable: true)
    @game_over_image = Gosu::Image.new('media/gg.jpg', tileable: true)
    @star_anim = Gosu::Image.load_tiles('media/star.png', 25, 25)
    @font = Gosu::Font.new(20)

    @asteroid = Gosu::Image.new('media/meteor.png')

    @player = Player.new
    @gg = false
  end

  def update
    @player.handle_move
    @player.collect_stars(Star.stars)
    @player.colide(Asteroid.asteroids)
    Star.add_star(@star_anim)

    Asteroid.add_asteroid(@asteroid)
    Asteroid.clean_asteroids
    Asteroid.move

    @gg = @player.dead if @gg == false
  end

  def draw
    if @gg
      @game_over_image.draw(0, 0, Constants::Z_INDEX[:PLAYER])
      @font.draw_text("You lost. Your final score is: #{@player.score}. Press 'space' to restart.", 200, 240, Constants::Z_INDEX[:UI], 1.0, 1.0,
                      Gosu::Color::YELLOW)
    else
      @background_image.draw(0, 0, Constants::Z_INDEX[:BACKGROUND])
      @player.draw
      Star.stars.each(&:draw)
      Asteroid.asteroids.each(&:draw)

      @font.draw_text("Score: #{@player.score}", 10, 10, Constants::Z_INDEX[:UI], 1.0, 1.0, Gosu::Color::YELLOW)
    end
  end

  def restart
    @player.reset
    @gg = false
    Star.stars.clear
    Asteroid.asteroids.clear
  end

  def button_down(id)
    if id == Gosu::KB_ESCAPE
      close
    elsif id == Gosu::KB_SPACE && @gg
      restart
    else
      super
    end
  end
end

Tutorial.new.show
