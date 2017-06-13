require 'gosu'

class Solitaire < Gosu::Window
  def initialize
    super 650, 480
    self.caption = "Solitaire"

    @background_image = Gosu::Image.new("media/table.jpg", :tileable => false)
  end

  def update
  end

  def draw
    @background_image.draw(0,0,0)
  end
end

Solitaire.new.show
