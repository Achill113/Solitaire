class Card
  RANKS = [2,3,4,5,6,7,8,9,"J","Q","K","A"]
  SUIT = {"S" => "Black","C" => "Black","D" => "Red","H" => "Red"}
  attr_accessor :rank, :suit, :color

  def initialize(id)
    self.rank = RANKS[(id % 13) - 1]
    self.suit = SUIT.keys[id % 4]
    self.color = SUIT[self.suit]
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

d = Deck.new
@deck = []
d.cards.each{|card|
  @deck << [card.rank, card.suit]
}

def setup
  @s1 = {"Hidden" => [], "Visible" => []}
  @s2 = {"Hidden" => [], "Visible" => []}
  @s3 = {"Hidden" => [], "Visible" => []}
  @s4 = {"Hidden" => [], "Visible" => []}
  @s5 = {"Hidden" => [], "Visible" => []}
  @s6 = {"Hidden" => [], "Visible" => []}
  @s7 = {"Hidden" => [], "Visible" => []}
  @next_card = []

  @s1["Hidden"] = @deck.last
  @deck.pop
  @s2["Hidden"] = @deck.last(2)
  @deck.pop(2)
  @s3["Hidden"] = @deck.last(3)
  @deck.pop(3)
  @s4["Hidden"] = @deck.last(4)
  @deck.pop(4)
  @s5["Hidden"] = @deck.last(5)
  @deck.pop(5)
  @s6["Hidden"] = @deck.last(6)
  @deck.pop(6)
  @s7["Hidden"] = @deck.last(7)
  @deck.pop(7)

  @s1["Visible"] = @s1["Hidden"]
  @s2["Visible"] = @s2["Hidden"].last
  @s3["Visible"] = @s3["Hidden"].last
  @s4["Visible"] = @s4["Hidden"].last
  @s5["Visible"] = @s5["Hidden"].last
  @s6["Visible"] = @s6["Hidden"].last
  @s7["Visible"] = @s7["Hidden"].last

  @a1 = []
  @a2 = []
  @a3 = []
  @a4 = []

  puts "#{@s1["Visible"]} | #{@s2["Visible"]} | #{@s3["Visible"]} | #{@s4["Visible"]} | #{@s5["Visible"]} | #{@s6["Visible"]} | #{@s7["Visible"]}"
end

setup

def draw
  @next_card = @deck.last
  @deck.pop
end

def move(stack1, stack2)
  s1num = stack1["Visible"][0] if stack1["Visible"][0].to_i
  s1num = 1 if stack1["Visible"][0] == "A"
  s1num = 10 if stack1["Visible"][0] == "J"
  s1num = 11 if stack1["Visible"][0] == "Q"
  s1num = 12 if stack1["Visible"][0] == "K"
  s2num = stack2["Visible"][0] if stack2["Visible"][0].to_i
  s2num = 1 if stack2["Visible"][0] == "A"
  s2num = 10 if stack2["Visible"][0] == "J"
  s2num = 11 if stack2["Visible"][0] == "Q"
  s2num = 12 if stack2["Visible"][0] == "K"
  if s1num == (s2num + 1)
    puts stack1
    puts stack2
    stack2["Visible"].last << stack1["Visible"].last
    stack1["Visible"].pop
    stack1["Visible"] << stack1["Hidden"].last
    puts stack1
    puts stack2
  else
    puts "Illegal move"
  end
end

move(@s1, @s2)
puts "#{@s1["Visible"]} | #{@s2["Visible"]} | #{@s3["Visible"]} | #{@s4["Visible"]} | #{@s5["Visible"]} | #{@s6["Visible"]} | #{@s7["Visible"]}"
