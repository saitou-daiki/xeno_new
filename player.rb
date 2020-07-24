require "./message"

class Player
  attr_accessor :guard
  attr_accessor :wiseman
  attr_accessor :card
  attr_accessor :dis_card
  attr_accessor :name
  attr_accessor :victory

  include Message

  def initialize(deck_delete, name)
    self.guard = false
    self.wiseman = false
    self.card = [deck_delete]
    self.dis_card = []
    self.name = name
    self.victory = false
  end

  #プレイヤーとPCで共通のメソッドを定義。乙女の効果の発動、４、５、７、８番のカード使用時。
  def guard_method(deck, input, player)
    puts "#{self.name}の#{deck.type[4]}のカードの効果により、#{player.name}の#{deck.type[input]}のカードの効果を無効化しました。"
  end

  def fortune_teller(deck, player) 
    puts "#{player.name}が持っていたのは#{player.card[0]}番の#{deck.type[player.card[0]]}のカードです。"
  end

  def maiden(player)
    puts "次のターンまで#{player.name}の攻撃が無効化されます。"
    self.guard = true
  end

  def death_god(deck, player)
    if deck.card.empty?
      none_effect_message
    else
      puts "#{deck.type[5]}の効果により、#{player.name}がカードを１枚ドローしました。"
      player.card[1] = deck.card.delete_at(0)
      input = player.card.delete_at(player.card.find_index(player.card.sample))
      player.dis_card << input
      if input == 10
        puts "#{deck.type[5]}の効果により、#{deck.type[input]}のカードを捨て札に送りました。"
        puts "#{player.name}は#{deck.type[input]}の効果により、#{deck.type[player.card[0]]}のカードを捨て、転生札よりカードを引いて復活します。"
        player.dis_card << player.card[0]
        player.card[0] = deck.reincarnation
      else
        puts "#{deck.type[5]}の効果により、#{player.name}の#{deck.type[input]}のカードを捨て札に送りました。"
      end
    end 
  end

  def wiseman_method
    wiseman_method_message
    self.wiseman = true
  end

  def spirit(deck, player)
    puts "#{self.name}の持っている#{deck.type[self.card[0]]}のカードと、#{player.name}の持っている#{deck.type[player.card[0]]}のカードを交換しました。"
    self.card[0], player.card[0] = player.card[0], self.card[0]
  end

end