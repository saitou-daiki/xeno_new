module  Message
  ZERO = 0
  BOY = 1
  SOLDIER = 2
  FORTUNE_TELLER = 3
  MAIDEN = 4  
  DEATH_GOD = 5
  ARISTOCRAT = 6
  WISEMAN = 7
  SPIRIT = 8
  EMPEROR = 9
  HERO = 10
  ELEVEN = 11

  def continue
    return clone
  end


  def start_message
    puts "----------ゲームを開始します----------"
  end

  def end_message
    puts "----------ゲームを終了します----------"
  end

  def restart_message
    puts "----------ゲームを再開します----------"
  end

  def none_deck_message
    puts "山札のカードがなくなりました。"
  end

  def line
    puts "--------------------------------------"
  end

  def none_effect_message
    puts "山札にカードがないため、効果を発動しません。"
  end

  def wiseman_method_message
    puts "次のターン、カードを3枚ドローし1枚を選択して手札に加えます。"
  end

  def tutorial_message
    puts <<~text
    カードの種類は全部で１０種類です。

    ① 少年（革命）
    １枚目の捨て札は何の効果も発動しないが、場に２枚目が出た時には皇帝と同じ効果「公開処刑」が発動する。
    --------------------------------------

    ② 兵士（捜査）
    指定した相手の手札を言い当てると相手は脱落する。
    --------------------------------------

    ③ 占い師（透視）
    指定した相手の手札を見る。
    --------------------------------------

    ④ 乙女（守護）
    次の自分の手番まで自分への効果を無効にする。
    --------------------------------------

    ⑤ 死神（疫病）
    指名した相手に山札から１枚引かせる。
    ２枚になった相手の手札を非公開にさせたまま、１枚を指定して捨てさせる。
    --------------------------------------

    ⑥ 貴族（対決）
    指名した相手と手札を見せ合い、数字の小さい方が脱落する。
    見せ合う際には他のプレイヤーに見られないよう密かに見せ合う。
    --------------------------------------

    ⑦ 賢者（選択）
    次の手番で山札から１枚引くかわりに３枚引き、そのうち１枚を選ぶことができる。
    残り２枚は山札へ戻す。
    --------------------------------------

    ⑧ 精霊（交換）
    指名した相手の手札と自分の持っている手札を交換する。
    --------------------------------------

    ⑨ 皇帝（公開処刑）
    指名した相手に山札から１枚引かせて、手札を２枚とも公開させる。
    そしてどちらか１枚を指定し捨てさせる。
    --------------------------------------

    ⑩ 英雄（潜伏・転生）
    場に出すことができず、捨てさせられたら脱落する。
    皇帝以外に脱落させらた時に転生札で復活する。
    --------------------------------------
    text
  end

  def none_card_message
    puts "ありません。"
  end

  def open_card_message
    puts "お互いの持っているカードをオープンします。"
    gets.chomp
  end

  def compensating_message
    puts "持っていたカードが同じのため、相打ちです。"  
  end

  def question_continue_message
    puts <<~text
    もう一度対戦しますか？
    [1]はい。
    [2]いいえ。
    text
  end

  def one_two_message
    puts "１か２の番号を入力してください。"
  end

  def one_ten_message
    puts "1から10までの番号を入力してください。"
  end

  def shuffle_message
    puts "残りのカードを山札に戻してシャッフルしました。"
  end

  def dis_card_choice_message
    puts "[11]使用済みカードを確認する。"
  end

  def tutorial_choice_message 
    puts "[0]チュートリアルを閲覧する。"
  end

  def question_card_message
    puts "どの番号のカードを使用しますか？"
  end

  def question_add_card_message
    puts "どの番号のカードを手札に加えますか？"
  end

  def question_dis_card_message
    puts "どの番号のカードを捨て札に送りますか？"
  end 

  def zero_eleven_message(input)
    puts "#{input}番のカードは選択できません。"
    puts "0か11か手札にあるカードの番号を入力してください。"
    puts "--------------------------------------"
  end

  def hero_not_can_choice_message
    puts "英雄のカードは手札から使用することができません。"
    puts "--------------------------------------"
  end

  def my_turn_message(myplayer)
    puts "#{myplayer.name}のターンです。"
  end

  def pc_turn_message(pcplayer)
    puts "#{pcplayer.name}のターンです。"
  end

  def none_draw_card_message(input)
    puts "#{input}番のカードは、引いたカードの中にありません。"
  end

end