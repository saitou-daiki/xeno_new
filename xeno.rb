require "./deck"
require "./player"
require "./myplayer"
require "./pcplayer"
require "./game_result"
require "./message"

include Message

game_result = Game_result.new 

start_message

while game_result.continue
  deck = Deck.new
  myplayer = Myplayer.new(deck.card.delete_at(0), "あなた")
  pcplayer = Pcplayer.new(deck.card.delete_at(0), "相手")

  while true
    my_turn_message(myplayer)
    myplayer.guard = false
    if deck.card.empty?
      none_deck_message
      myplayer.duel(deck, pcplayer)
      break
    elsif  myplayer.wiseman == true
      myplayer.wiseman_draw(deck, pcplayer)
    else
      myplayer.draw(deck)
    end
    line

    input = myplayer.choice(deck, pcplayer)
    line

    if pcplayer.guard == true && input != MAIDEN && input != WISEMAN
      pcplayer.guard_method(deck, input, myplayer)
    else case input
      when BOY
        myplayer.boy(deck, pcplayer)
      when SOLDIER
        myplayer.soldier(deck, pcplayer)
        break if myplayer.victory == true
      when FORTUNE_TELLER
        myplayer.fortune_teller(deck, pcplayer)
      when MAIDEN
        myplayer.maiden(pcplayer)
      when DEATH_GOD
        myplayer.death_god(deck, pcplayer)
      when ARISTOCRAT
        myplayer.duel(deck, pcplayer)
        break
      when WISEMAN
        myplayer.wiseman_method
      when SPIRIT
        myplayer.spirit(deck, pcplayer)
      when EMPEROR
        myplayer.emperor(deck, pcplayer)
        break if myplayer.victory == true
      end
    end
    line

    pc_turn_message(pcplayer)
    pcplayer.guard = false
    if deck.card.empty?
      none_deck_message
      myplayer.duel(deck, pcplayer)
      break
    elsif pcplayer.wiseman == true
      pcplayer.wiseman_draw(deck)
    else
      pcplayer.draw(deck)
    end
    line

    input = pcplayer.choice(deck)
    
    if myplayer.guard == true && input!= MAIDEN && input!= WISEMAN
      myplayer.guard_method(deck, input, pcplayer)
    else case input
      when BOY
        pcplayer.boy(deck, myplayer)
      when SOLDIER
        pcplayer.soldier(deck, myplayer)
        break if pcplayer.victory == true
      when FORTUNE_TELLER
        pcplayer.fortune_teller(deck, myplayer)
      when MAIDEN
        pcplayer.maiden(myplayer)
      when DEATH_GOD
        pcplayer.death_god(deck, myplayer)
      when ARISTOCRAT
        myplayer.duel(deck, pcplayer)
        break
      when WISEMAN
        pcplayer.wiseman_method
      when SPIRIT
        pcplayer.spirit(deck, myplayer)
      when EMPEROR
        pcplayer.emperor(deck, myplayer)
        break if pcplayer.victory == true
      end 
    end
    line
  end
  line

  if myplayer.victory == true
    game_result.myplayer += 1
  elsif pcplayer.victory == true
    game_result.pcplayer += 1
  else
    game_result.compensating += 1
  end

  myplayer.question_continue_print(game_result)

end

end_message