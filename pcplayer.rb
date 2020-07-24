require "./player"
require "./message"

class Pcplayer < Player

  include Message

  def wiseman_draw(deck)
    self.card[1] = deck.card.delete_at(deck.card.first(3).find_index(deck.card.first(3).max))
    deck.card.shuffle!
    puts "#{self.name}が#{deck.type[7]}の効果により、カードを３枚ドローし1枚を選択して手札に加えました。"
    shuffle_message
    self.wiseman = false
  end

  def draw(deck)
    self.card[1] = deck.card.delete_at(0)
    puts "#{self.name}は山札からカードをドローしました。"
  end

  def choice(deck)
    input = self.card.delete_at(self.card.find_index(self.card.min))
    self.dis_card << input
    puts "#{self.name}が#{input}番の#{deck.type[input]}のカードを使用しました。"
    return input
  end

  def boy(deck, player)
    if deck.card.empty?
      none_effect_message
    elsif (self.dis_card + player.dis_card).count(1) == 2
      puts "#{deck.type[1]}のカードが使われたのは2枚目のため、効果を発動します。"
      player.card[1] = deck.card.delete_at(0)
      puts "#{deck.type[1]}の効果により、#{player.name}は山札から#{deck.type[player.card[1]]}のカードをドローして公開します。"   

      player.dis_card << input = player.card.delete_at(player.card.find_index(player.card.max))

      puts "#{self.name}が#{player.name}の手札にある#{deck.type[input]}のカードを捨て札に送りました。"
      if input == 10
        puts "#{deck.type[input]}の効果により、#{player.name}は#{player.card[0]}の#{deck.type[player.card[0]]}のカードを捨て、転生札よりカードを引いて復活します。"
        player.dis_card << player.card[0]
        player.card[0] = deck.reincarnation
      end
    else
      puts "#{deck.type[1]}のカードは初めて使われたため、効果を発動しません。"
    end
  end

  def soldier(deck, player)
    puts "#{deck.type[2]}の効果により、#{self.name}がカードの番号を宣言します。"
    input = (deck.card + player.card).sample 
    gets.chomp
    puts "#{self.name}「#{input}番」"
    gets.chomp
    if input == 10 && input == player.card[0]
      puts "#{player.name}の持っていた#{deck.type[input]}のカードを捨て札に送りました。"
      gets.chomp
      puts "#{deck.type[input]}の効果により、転生札よりカードを引いて復活します。"
      player.dis_card << player.card[0]
      player.card[0] = deck.reincarnation
    elsif input == player.card[0]
      puts "#{player.name}が持っていたのは、#{deck.type[player.card[0]]}のカードでした。"
      gets.chomp
      puts "#{player.name}の負けです。"
      self.victory = true
    else
      puts "#{player.name}「違います」"
      gets.chomp
    end

  end

  def emperor(deck, player)
    if deck.card.empty?
      none_effect_message
    else
      player.card[1] = deck.card.delete_at(0)
      puts "#{deck.type[9]}の効果により、#{player.name}は山札からカードをドローしてオープンします。"
      gets.chomp
      input = player.card.max
      puts "#{self.name}が#{input}番の#{deck.type[input]}のカードを捨て札に送りました。"
      gets.chomp
      player.dis_card << player.card.delete_at(player.card.find_index(input))
      if input == 10
        puts "#{deck.type[9]}の効果により、#{deck.type[10]}は転生できないため#{self.name}の勝ちです。"
        self.victory = true
        gets.chomp
      end
    end
  end

end