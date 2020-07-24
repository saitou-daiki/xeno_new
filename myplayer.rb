require "./player.rb"
require "./message"

class Myplayer < Player

  include Message

  def wiseman_draw(deck, player) 
    puts "#{self.name}は#{deck.type[7]}のカードの効果により、カードを３枚ドローしました。" 
    wisemans = deck.card.first(3)

    while true     
      puts "#{self.name}の現在の手札にあるのは#{self.card[0]}番の#{deck.type[self.card[0]]}のカードです。"
      question_add_card_message
      dis_card_choice_message
      wisemans.each do |wiseman|
        puts "[#{wiseman}]#{deck.type[wiseman]}のカードを手札に加える。"
      end
      input = gets.chomp.to_i
      if wisemans.any?(input)
        break
      elsif input == ELEVEN
        self.dis_card_print(deck,player)
      else
        none_draw_card_message(input)
      end
    end
  
    self.card[1] = deck.card.delete_at(deck.card.find_index(input))
    deck.card.shuffle!
    puts "#{self.card[1]}番の#{deck.type[self.card[1]]}のカードを手札に加えました。"
    shuffle_message
    self.wiseman = false
  end

  def draw(deck)
    self.card[1] = deck.card.delete_at(0)
    puts "#{self.name}は、山札から#{deck.type[self.card[1]]}のカードをドローしました。"
  end

  def choice(deck, player)
    while true
      puts "#{self.name}の手札にあるのは#{self.card[0]}番の#{deck.type[self.card[0]]}と#{self.card[1]}番の#{deck.type[self.card[1]]}のカードです。"
      question_card_message
      tutorial_choice_message
      dis_card_choice_message
      self.card.each do |card|
        puts "[#{card}]#{deck.type[card]}のカードを使用する。"
      end
      input = gets.chomp.to_i
      if input == HERO
        hero_not_can_choice_message
      elsif self.card.any?(input)
        break
      elsif input == ZERO
        tutorial_message
      elsif input == ELEVEN
        self.dis_card_print(deck,player)
      else
        zero_eleven_message(input)
      end
    end
    self.dis_card << self.card.delete_at(self.card.find_index(input))
    puts "#{self.name}が#{input}番の#{deck.type[input]}のカードを使用しました。"
    return input
  end

  def boy(deck, player)
    if deck.card.empty?
      none_effect_message
    elsif (self.dis_card + player.dis_card).count(1) == 2
      puts "#{deck.type[BOY]}のカードが使われたのは2枚目のため、効果を発動します。"
      player.card[1] = deck.card.delete_at(0)
      puts "#{deck.type[1]}の効果により、#{player.name}がカードを1枚ドローしてオープンします。"  
      
      while true 
        puts "#{player.name}が持っているのは、#{player.card[0]}番の#{deck.type[player.card[0]]}と#{player.card[1]}番の#{deck.type[player.card[1]]}のカードです。"
        question_dis_card_message
        dis_card_choice_message
        player.card.each do |card|
          puts "[#{card}]#{deck.type[card]}のカードを捨て札に送る。"
        end
        input = gets.chomp.to_i
        if player.card.any?(input)
          break
        elsif input == ELEVEN
          self.dis_card_print(deck, player)
        else
          puts "#{input}番のカードは#{player.name}の手札にありません。"
        end
      end
      player.dis_card << player.card.delete_at(player.card.find_index(input))
     
      puts "#{self.name}が#{player.name}の手札にある#{input}番の#{deck.type[input]}のカードを捨て札に送りました。"
      if input == 10
        puts "#{player.name}は#{deck.type[input]}の効果により、#{deck.type[player.card[0]]}のカードを捨て、転生札よりカードを引いて復活します。"
        player.dis_card << player.card[0]
        player.card[0] = deck.reincarnation
      end
    else
      puts "#{deck.type[1]}のカードは初めて使われたため、効果を発動しません。"
    end
  end

  def soldier(deck, player)
    while true
      self.dis_card_print(deck,player)
      puts "#{self.name}がいま持っているカードは#{self.card[0]}番の#{deck.type[self.card[0]]}のカードです。"
      puts "#{player.name}が持っていると思う1から10までのカードの番号を入力してください。"
      input = gets.chomp.to_i
      if input >=1 && input<=10
        break
      else
        one_ten_message
      end
    end

    puts "#{self.name}「#{input}番」"
    gets.chomp

    if input == player.card[0] && input == HERO
      puts "#{player.name}の持っていたのは、#{deck.type[input]}のカードでした。"
      gets.chomp
      puts "#{player.name}は#{deck.type[input]}の効果により、#{deck.type[player.card[0]]}のカードを捨て、転生札よりカードを引いて復活します。"
      player.dis_card << player.card[0]
      player.card[0] = deck.reincarnation
    elsif input == player.card[0]
      puts "#{player.name}「参りました」"
      gets.chomp
      puts "#{player.name}が持っていたのは、#{player.card[0]}番の#{deck.type[player.card[0]]}のカードでした。"
      puts "#{self.name}の勝ちです。"
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
      puts "#{player.name}がカードをドローし、持っているカードをオープンします。"
      player.card[1] = deck.card.delete_at(0)
      while true
        puts "#{player.name}が持っているのは、#{player.card[0]}番の#{deck.type[player.card[0]]}と#{player.card[1]}番の#{deck.type[player.card[1]]}のカードです。"
        puts "#{self.name}の手札にあるのは、#{self.card[0]}番の#{deck.type[self.card[0]]}のカードです。"
        question_dis_card_message
        dis_card_choice_message
        player.card.each do |card|
          puts "[#{card}]#{deck.type[card]}のカードを捨て札に送る。"
        end
        input = gets.chomp.to_i
        if player.card.any?(input)
          break
        elsif input == 11
          self.dis_card_print(deck,player)
        else
          puts "#{input}番のカードは#{player.name}の手札にありません。"
        end
      end

      puts "#{player.name}の#{deck.type[input]}のカードを捨て札に送りました。"
      gets.chomp
      player.dis_card << player.card.delete_at(player.card.find_index(input))
      if input == 10
        puts "#{player.name}「参りました」"
        puts "#{deck.type[EMPEROR]}の効果により、#{deck.type[input]}は転生できないため#{self.name}の勝利です。"
        self.victory = true
      end
    end
  end


  def dis_card_print(deck, player)
    puts "#{self.name}の使用ずみカード"
    if self.dis_card.empty?
      none_card_message
    else
      self.dis_card.each do |dis|
        puts "#{dis}番：#{deck.type[dis]}"
      end
    end
    puts "#{player.name}の使用ずみカード"
    if player.dis_card.empty?
      none_card_message
    else
      player.dis_card.each do |dis|
        puts "#{dis}番：#{deck.type[dis]}"
      end 
    end
    line
  end

  def duel(deck, player)
    open_card_message
    puts "#{self.name}が持っていたのは#{self.card[0]}番の#{deck.type[self.card[0]]}のカードです。"
    gets.chomp
    puts "#{player.name}が持っていたは#{player.card[0]}番の#{deck.type[player.card[0]]}のカードです。"
    gets.chomp
    if self.card[0] == player.card[0]
      compensating_message
    elsif self.card[0] > player.card[0]
      self.victory = true
      puts "#{player.name}「参りました」"
      puts "#{self.name}の勝ちです。"
    else self.card[0] < player.card[0]
      player.victory = true
      puts "#{self.name}の負けです。"
    end
    gets.chomp
  end

  def question_continue_print(game_result)
    while true
      puts "#{self.name}の成績は#{game_result.myplayer}勝#{game_result.pcplayer}敗#{game_result.compensating}分です。"
      question_continue_message
      input = gets.chomp.to_i
      if input == BOY
        restart_message
        break
      elsif input == SOLDIER
        continue = false
        break
      else
        one_two_message
      end
    end
  end

end