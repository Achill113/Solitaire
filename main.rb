class Card
  RANKS = [1,2,3,4,5,6,7,8,9,10,11,12]
  SUIT = {"S" => "Black","C" => "Black","D" => "Red","H" => "Red"}
  attr_accessor :rank, :suit, :color, :visible

  def initialize(id)
    self.rank = RANKS[(id % 13) - 1]
    self.suit = SUIT.keys[id % 4]
    self.color = SUIT[self.suit]
    self.visible = false
  end
end

class Deck
  attr_accessor :cards

  def initialize
    self.cards = (0..51).to_a.shuffle.collect{|id|
      Card.new(id)
    }
  end
end

def build_deck
  d = Deck.new
  @deck = []
  d.cards.each{|card|
    @deck << [card.rank, card.suit, card.visible]
  }
end

build_deck

def setup
  @stacks = []
  @next_card = []

  x = 1
  for i in 0..6
    @stacks[i] = move_from_deck @stacks[i], x
    x += 1
  end

  @a1 = []
  @a2 = []
  @a3 = []
  @a4 = []

  @stacks.each{|stack|
    stack.last[2] = true
  }

  @stacks.each{|stack|
    stack.each{|card|
      if card.last
        puts "#{card[0]}#{card[1]}"
      end
    }
  }
end

def move_from_deck destination, x
  destination = @deck.last(x)
  @deck.pop(x)
end

setup

def move stack1, stack2, num
  if stack1.last.last && stack2.last.last && stack1.last.first == (stack2.last.first + 1)
    stack2 << stack1.last(num).flatten!
    stack1.pop(num)
    stack2.last[2] = true # Set card to visible
  else
    puts "Invalid move"
  end
end

move @stacks[0], @stacks[3], 1
puts @stacks
