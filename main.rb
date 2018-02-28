require 'gosu'

class Solitaire < Gosu::Window

  attr_accessor :deck

  def initialize
    super 800, 500
    self.caption = "Solitaire"

    @background_image = Gosu::Image.new("media/table.jpg", :tileable => false)
    @deck = Deck.new
  end

  def update
  end

  def draw
    @background_image.draw(0,0,0)
    @deck.stacks.each{|stack|
      stack.each{|card|
        card.face.draw(card.x,card.y,card.z,scale_x=1,scale_y=1)
      }
    }
  end

  def needs_cursor?
    true
  end
end

class Card
  RANKS = [1,2,3,4,5,6,7,8,9,10,11,12,13]
  SUIT = {"S" => "Black","C" => "Black","D" => "Red","H" => "Red"}
  attr_accessor :rank, :suit, :color, :visible, :face, :x, :y, :z

  def initialize(id)
    self.rank = RANKS[id % 13]
    self.suit = SUIT.keys[id % 4]
    self.color = SUIT[self.suit]
    self.visible = false
    case self.suit
    when "C"
      self.face = Gosu::Image.new("media/#{self.rank}_of_clubs.png", options = {:rect => [0,0,5,10]})#, tileable => false)
    when "S"
      self.face = Gosu::Image.new("media/#{self.rank}_of_spades.png", options = {:rect => [0,0,5,10]})#, tileable => false)
    when "D"
      self.face = Gosu::Image.new("media/#{self.rank}_of_diamonds.png", options = {:rect => [0,0,5,10]})#, tileable => false)
    when "H"
      self.face = Gosu::Image.new("media/#{self.rank}_of_hearts.png", options = {:rect => [0,0,5,10]})#, tileable => false)
    end
    self.x = 0
    self.y = 0
    self.z = 0
  end
end

class Deck
  attr_accessor :cards, :deck, :stacks

  def initialize
    @cards = (0..51).to_a.shuffle.collect{|id|
      Card.new(id)
    }
    build_deck
    setup
  end

  public

  def build_deck
    @deck = []
    @cards.each{|card|
      @deck << card
    }
  end

  def setup
    @stacks = []
    $next_card = []
    $card_back = Gosu::Image.new("media/card_back.png", options = {:rect => [0,0,5,10]})#, tileable => false)

    x = 1
    for i in 0..6
      @stacks[i] = move_from_deck @stacks[i], x
      x += 1
    end

    $a1 = []
    $a2 = []
    $a3 = []
    $a4 = []

    @stacks.each{|stack|
      stack.last.visible = true
    }
    x = 20
    y = 100
    @stacks.each{|stack|
      z = 0
      stack.each{|card|
        if card.visible
          card.x = x
          card.y = y
          card.z = z
        else
          card.face = $card_back
          card.x = x
          card.y = y
          card.z = z
        end
        z += 1
      }
      x += 50
    }
  end

  def move_from_deck destination, x
    destination = @deck.last(x)
    @deck.pop(x)
  end
end

def move stack1, stack2, num
  if stack1.last.visible && stack2.last.visible && stack1.last.rank == (stack2.last.rank + 1)
    stack2 << stack1.last(num).flatten!
    stack1.pop(num)
    stack2.last.visible = true # Set card to visible
  else
    puts "Invalid move"
  end
end

GUI = Thread.new{
  $game = Solitaire.new
}
