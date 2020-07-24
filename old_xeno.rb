```old_xeno.rb
line = "------------------------------------------"
deck = [10,9,8,8,7,7,6,6,5,5,4,4,3,3,2,2,1,1].shuffle

#自分の手札カードの配列
my_hand = [deck.delete_at(0)]

#相手の手札カードの配列
pc_hand = [deck.delete_at(0)]

#山札の一番下にあるヒーローカードの変数
hero = deck.delete_at(0)

#自分の使用済みカードの配列
my_dis_card = []

#相手の使用済みカードの配列
pc_dis_card = []

#guardとwisemanの値を１に変更することでカードの効果を発動させる。初期は０で定義。
pc_guard = 0
pc_wiseman = 0

#ゲームを続行するかを判定。
continue_game = true

#カード選択画面を表示
def choice(my_hand, line)

  puts "あなたの手札にあるのは#{my_hand[0]}番と#{my_hand[1]}番のカードです"
  puts "どちらのカードを使用しますか"
  puts "#{my_hand[0]}番のカードを使用する"
  puts "#{my_hand[1]}番のカードを使用する"
  puts "0番:チュートリアルを閲覧する"
  puts "11番:使用済みカードを確認する"
  puts line
  input = gets.to_i
  return input
end



#自分の賢者発動
def my_wiseman(line, deck, my_hand)
  wisemans = deck.first(3)
  puts "賢者のカードの効果により、カードをドローします"
  wisemans.each do |wiseman|
    puts "#{wiseman}番"
  end
  puts "あなたの現在の手札にあるのは#{my_hand[0]}番のカードです。"
  puts "どのカードを手札に加えますか。"
  puts line
  input = gets.to_i

  while !wisemans.any?(input) do
    puts "そのカード番号は引いたカードの中にありません"

    wisemans.each do |wiseman|
      puts "#{wiseman}番"
    end

    puts "再度番号を入力してください"
    input = gets.to_i
  end

  my_hand[1] = deck.delete_at(deck.find_index(input))
  deck.shuffle!
  puts "#{my_hand[1]}番のカードを手札に加えました"
  puts "残りのカードを山札に戻してシャッフルします"
end

#PCの賢者発動
def pc_wiseman(line, deck, pc_hand)
  pc_hand[1] = deck.delete_at(deck.find_index(deck.first(3).max))
  deck.shuffle!

  puts "相手は賢者（選択）のカードの効果により、カードをドローしました"
  puts "カードを一枚選んで残りを山札に戻し、シャッフルしました"
  puts line 
end

#自分のターンのメソッド。カード番号により分岐
def my_card_method(my_hand, pc_hand, deck, hero, my_dis_card, pc_dis_card, line, pc_guard, my_choise_number)
  my_wiseman = 0
  my_guard = 0
  if my_choise_number == 4
    puts "あなたが乙女（守護）のカードを使用しました"
    puts "次のターンまで相手の攻撃が無効化されます"
    my_guard = 1

  elsif my_choise_number == 7
    puts "７番の賢者のカードを使用しました"
    puts "次のターンカードを３枚ドローし、一枚選択して手札に加えます"
    my_wiseman = 1

  elsif pc_guard == 1
    puts "相手の乙女（守護）のカードの効果により無効化されました"

  elsif my_choise_number == 9
    puts "皇帝（公開処刑）のカードを使用しました"
    if deck.empty?
      puts "山札にカードがない為、効果を発動しません"
      puts "----------------------------"
    else
      pc_hand[1] = deck.delete_at(0)
      puts "相手がカードをドローし、持っているカードはオープンします"
      puts "相手が持っていたのは#{pc_hand[0]}番と#{pc_hand[1]}番のカードです"
      puts "どちらのカードを指定しますか？"
      puts "あなたの手札にある現在のカードは#{my_hand[0]}番のカードです"
      puts line
      input = gets.to_i

      pc_dis_card = pc_hand.delete_at(pc_hand.find_index(input))
      puts "#{input}番のカードを捨てさせました"
      if input == 10
        puts "英雄のカードは転生できない為、あなたの勝利です"
        exit
      end
    end 

  elsif my_choise_number == 8
    #データ移動用
    puts "精霊（交換）のカードを使用しました"
    puts "あなたの持っている#{my_hand[0]}番のカードと相手の持っている#{pc_hand[0]}番のカードを交換しました"
    my_hand[0], pc_hand[0] = pc_hand[0], my_hand[0]

  elsif my_choise_number == 6
    puts "あなたが貴族のカードを使用しました"
    puts "あなたが持っていたのは#{my_hand[0]}番のカード"
    puts "相手が持っていたのは#{pc_hand[0]}番のカード"

    if my_hand[0] == pc_hand[0]
      puts "持っていたカードが互角の為、相打ちです"
    elsif my_hand[0] > pc_hand[0]
      puts "あなたの勝利です"
    else my_hand[0] < pc_hand[0]
      puts "あなたの負けです"
    end
    exit

  elsif my_choise_number == 5
    puts "あなたが死神（疫病）のカードを使用しました。"
    if deck.empty?
      puts "山札にカードがない為、死神の効果は発動しません。"
    else
      puts "死神の効果により、相手がカードを一枚ドローしました。"
      pc_hand[1] = deck.delete_at(0)

      #PCのカードからランダムにデータを削除
      input = pc_hand.delete_at(pc_hand.find_index(pc_hand.sample))
      if input == 10
        puts "死神の効果により、相手の英雄のカードが墓地に送りました"
        puts "相手は英雄の効果により、転生札よりカードを引いて復活します"
        pc_dis_card << pchand[0]
        pc_hand[0] = hero
      else
        puts "死神の効果により、相手の#{input}番のカードが墓地に送られました"
      end
      pc_dis_card << input
    end

  elsif my_choise_number == 3
    puts "占い師（透視）のカードを使用しました"
    puts "相手が手に持っているカードをオープンします"
    puts "相手が持っていたのは#{pc_hand[0]}番のカードです"

  elsif my_choise_number == 2
    puts "兵士（捜査）のカードを使用しました"
    puts "自分の使用済みカード"
    my_dis_card.each do |mydis|
      puts "#{mydis}番"
    end

    puts "相手の使用済みカード"
    if pc_dis_card.empty?
      puts "ありません"
    else
      pc_dis_card.each do |pcdis|
        puts "#{pcdis}番"
      end
    end
    puts "あなたがいま手に持っているカード"
    puts "#{my_hand[0]}番"

    puts "相手が持っていると思うカード番号を指定してください"
    input = gets.to_i
    while input < 1 || input > 10
      puts "その番号は指定できません"
      puts "１から１０までの番号を指定してください"
      input = gets.to_i
    end
    if input == pc_hand[0] && input == 10
      puts "相手が持っていたのは英雄のカードでした"
      puts "英雄のカードの効果により、手札を捨てて転生します"

      pc_dis_card << pc_hand[0]
      pc_hand[0] = hero
    elsif input == pc_hand[0]
      puts "相手が持っていたのは #{pc_hand[0]}番のカードでした" 
      puts "あなたの勝利です"
      exit
    else
      puts "相手「違います」"
    end

  elsif my_choise_number == 1
    puts "少年（革命）のカードを使用しました"
    if (my_dis_card + pc_dis_card).count(1) == 2
      if deck.empty?
        puts "山札にカードがない為、効果を発動しません"
        puts "----------------------------"
      else
        puts "少年のカードが使われたのは2枚目のため、公開処刑を発動します"
        pc_hand[1] = deck.delete_at(0)
        puts "相手がカードをドローし、持っているカードはオープンします"
        puts "持っていたのは#{pc_hand[0]}番と#{pc_hand[1]}番のカードです"
        puts "どちらのカードを指定しますか？"
        input = gets.to_i
        while !pc_hand.any?(input) 
          puts "その番号のカードは相手の手札にありません"
          puts "相手が持っているのは#{pc_hand[0]}番と#{pc_hand[1]}番のカードです"
          puts "もう一度番号を指定してください"
          input = gets.to_i
        end

        pc_dis_card << pc_hand.delete_at(pc_hand.find_index(input))
        puts "#{input}番のカードを捨てさせました"

        if input == 10
          puts "英雄（潜伏・転生）の効果により、転生札よりカードを引いて復活します"
          pc_dis_card << pchand[0]
          pc_hand[0] = hero
        end
      end 
    else
      puts "少年のカードは初めて使われた為、効果を発動しません"
    end
  else
    puts "エラーです"
  end
  puts line
  return my_guard, my_wiseman
end

#相手ターンのメソッド。カード番号により分岐。
def pc_card_method(my_hand, pc_hand, deck, hero, my_dis_card, pc_dis_card, line, my_guard, pc_choise_number)
  #相手がカードを引こうとして山札にカードがなかった場合、数字の大きさで勝敗を決する。
  pc_guard = 0
  pc_wiseman = 0
  if pc_choise_number == 7
    puts "相手が賢者（選択）のカードを使用しました"
    puts "相手は次のターンにカードを3枚ドローし、１枚を選択して手札に加えます"
    pc_wiseman = 1

  elsif pc_choise_number == 4
    puts "相手が乙女（守護）のカードを使用しました"
    puts "次のターンまであなたの攻撃が無効化されます"
    pc_guard = 1

  elsif my_guard == 1
    puts "乙女（守護の）効果により、相手の#{pc_choise_number}番のカードの効果を無効化しました"

  elsif pc_choise_number == 1    
    if (my_dis_card + pc_dis_card).count(1) == 2
      puts "相手が少年（革命）のカードを使用しました"
      puts "少年のカードが使われたのは二枚目です"

      if deck.empty?
        puts "山札が０枚の為、効果はは発動しませんでした"
      else
        puts "少年のカードの効果により、公開処刑を発動します"
        my_hand[1] = deck.delete_at(0)
        puts "少年のカードの効果により、#{my_hand[1]}番のカードをドローしました"

        input = my_hand.delete_at(my_hand.find_index(my_hand.max))
        puts "相手があなたの手札から#{input}番のカードを墓地へ送りました"
        if input == 10
          puts "英雄（潜伏・転生）の効果により、転生札よりカードを引いて復活します"
          my_dis_card << myhand[0]
          my_hand[0] = hero
        end
      end
    else
      puts "相手が少年のカードを使用しました"
      puts "少年のカードが使われたのは1枚目のため、効果を発動しません"
    end

  elsif pc_choise_number == 2
    puts "相手が兵士（捜査）のカードを使用しました"
    puts "番号を宣言します"
    #デッキのカードと自分のカードからランダムに番号を抽出
    input = (deck + my_hand).sample 
    puts "相手「#{input}番」"
    if my_hand.any?(input)

      if my_hand[0] == 10
        puts "あなたの持っていた英雄のカードが墓地にいきました"
        puts "英雄の効果により、転生札よりカードを引いて復活します"
        my_dis_card << my_hand[0]
        my_hand[0] = hero
      else
        puts "あなたの手札にあったのは#{my_hand[0]}番のカードです"
        puts "あなたの負けです"
        exit
      end
    else
      puts "あなた「違います」"
    end

  elsif pc_choise_number == 3
    puts "相手が占い師(透視)のカードを使用しました"
    puts "相手があなたのカード番号が#{my_hand[0]}番であることを確認しました"

  elsif pc_choise_number == 5 
    puts "相手が死神（疫病）のカードを使用しました。"
    if deck.empty?
      puts "デッキにカードがなかったため、効果を発動しません。"
    else
      my_hand[1] = deck.delete_at(0)
      input = my_hand.delete_at(my_hand.find_index(my_hand.sample))
      if input == 10
        puts "相手が英雄のカードを墓地に送りました。"
        puts "英雄のカードの効果で転生します。"
        my_dis_card << my_hand[0]
        my_hand[0] = hero
      else
        puts "あなたの手札の#{input}番のカードが墓地に送られました。"
      end
    end

  elsif pc_choise_number == 6
    puts "相手が貴族のカードを使用しました。"
    puts "あなたが持っていたのは#{my_hand[0]}番のカード。"
    puts "相手が持っていたのは#{pc_hand[0]}番のカード。"

    if my_hand[0] == pc_hand[0]
      puts "持っていたカードが互角の為、相打ちです。"
    elsif my_hand[0] > pc_hand[0]
      puts "あなたの勝利です。"
    else my_hand[0] < pc_hand[0]
      puts "あなたの負けです。"
    end
    exit

  elsif pc_choise_number == 8 
    puts "相手が精霊（交換)のカードを使用しました"
    puts "あなたの持っている#{my_hand[0]}番のカードと、相手の持っている#{pc_hand[0]}番のカードを交換しました"
    my_hand[0], pc_hand[0] = pc_hand[0], my_hand[0]

  elsif pc_choise_number == 9
    puts "相手が皇帝（公開処刑）のカードを使用しました"
    if deck.empty?
      puts "山札にカードがなかった為、効果を発動しません"
    else
      my_hand[1] = deck.delete_at(0)

      input = my_hand.delete_at(my_hand.find_index(my_hand.max))
      if input == 10
        puts "相手があなたの持っていた英雄のカードを墓地に送りました"
        puts "あなたの負けです"
        exit
      else
        puts "相手があなたの持っていた#{input}番のカードを墓地に送りました"
      end
      my_dis_card << input
    end
  else
    puts "エラーです"
  end
  puts line
  return pc_guard, pc_wiseman
end

#山札にカードがなくなった場合のメソッド。これで決着。
def deck_none(my_hand, pc_hand)
  puts "山札のカードがなくなりました"
  puts "お互いの持っているカードをオープンします"
  puts "あなたの持っているカードは#{my_hand[0]}番です"
  puts "相手が持っているカードは#{pc_hand[0]} 番です"

  if my_hand[0] == pc_hand[0]
    puts "持っていたカードが同じの為、相打ちです"  
  elsif my_hand[0] > pc_hand[0]
    puts "あなたの勝ちです"
  else my_hand[0] < pc_hand[0]
    puts "あなたの負けです"
  end
  exit
end

#カード選択画面で０番を入力した場合、チュートリアルを表示する。
def tutorial(line)
  puts "カードの種類は全部で１０種類です"

  puts "① 少年（革命）"
  puts "１枚目の捨て札は何の効果も発動しないが、場に２枚目が出た時には皇帝と同じ効果「公開処刑」が発動する"
  puts line

  puts "② 兵士（捜査）"
  puts "指定した相手の手札を言い当てると相手は脱落する。"
  puts line

  puts "③ 占い師（透視）"
  puts "指定した相手の手札を見る。"
  puts line

  puts "④ 乙女（守護）"
  puts "次の自分の手番まで自分への効果を無効にする。"
  puts line

  puts "⑤ 死神（疫病）"
  puts "指名した相手に山札から１枚引かせる。"
  puts "２枚になった相手の手札を非公開にさせたまま、１枚を指定して捨てさせる。"
  puts line

  puts "⑥ 貴族（対決）"
  puts "指名した相手と手札を見せ合い、数字の小さい方が脱落する。"
  puts "見せ合う際には他のプレイヤーに見られないよう密かに見せ合う。"
  puts line

  puts "⑦ 賢者（選択）"
  puts "次の手番で山札から１枚引くかわりに３枚引き、そのうち１枚を選ぶことができる。"
  puts "残り２枚は山札へ戻す。"
  puts line

  puts "⑧ 精霊（交換）"
  puts "指名した相手の手札と自分の持っている手札を交換する。"
  puts line


  puts "⑨ 皇帝（公開処刑）"
  puts "指名した相手に山札から１枚引かせて、手札を２枚とも公開させる。"
  puts "そしてどちらか１枚を指定し捨てさせる。"
  puts line

  puts "⑩ 英雄（潜伏・転生）"
  puts "場に出すことができず、捨てさせられたら脱落する。"
  puts "皇帝以外に脱落させらた時に転生札で復活する。"
  puts line
end

#戦闘開始
puts "あなたが先攻です"

while true

  while continue_game

    #カードを１枚ドローする。賢者の効果を使用済みの場合、メソッドを飛ばす。
    if my_hand.length == 1
      my_hand[1] = deck.delete_at(0)
      puts "あなたはカードをドローしました"
      puts "引いたのは#{my_hand[1]}番のカードです"
      puts line
    end

    #カード選択画面を表示
    input = choice(my_hand, line)

    #使用できるカードがない場合は、こちらのメソッドにループする。
    while (input != my_hand[0] && input != my_hand[1]) || input == 10 || input == 11 do
      if input == 0
        tutorial(line)
        input = choice(my_hand, line)

      elsif input == 10
        puts "英雄のカードは手札から使用することができません"
        input = choice(my_hand, line)

      elsif input == 11
        puts "自分の使用済みカード"
        if my_dis_card == []
          puts "ありません"
        else
          my_dis_card.each do |mydis|
            puts "#{mydis}番"
          end
        end

        puts "相手の使用済みカード"
        if pc_dis_card == []
          puts "ありません"
        else
          pc_dis_card.each do |pcdis|
            puts "#{pcdis}番"
          end
        end
        puts line
        input = choice(my_hand, line)
      else
        puts "その番号のカードは手札にありません"
        input= choice(my_hand, line)
      end
    end

    #手札のカードを消去。墓地にカードを送る。
    my_dis_card << my_hand.delete_at(my_hand.find_index(input)) 
    
    #選んだカードの番号によって分岐が別れる
    my_guard, my_wiseman = my_card_method(my_hand, pc_hand, deck, hero, my_dis_card, pc_dis_card, line, pc_guard, input)

    #ここから相手のターン
    if deck.empty?
      deck_none(my_hand, pc_hand)
    end

    #相手が前のターンに賢者を使った場合カードを３ドローする。xeno.firstでデッキの枚数が少なくてもエラーにならない
    if pc_wiseman == 1
      pc_wiseman(line, deck, pc_hand)
    end

    if pc_hand.length == 1
      pc_hand[1] = deck.delete_at(0)
      puts "相手がカードを一枚ドローしました"
    end

    input = pc_hand.delete_at(pc_hand.find_index(pc_hand.min))
    pc_dis_card << input
    pc_guard, pc_wiseman = pc_card_method(my_hand, pc_hand, deck, hero, my_dis_card, pc_dis_card, line, my_guard, input)

    #山札のカードがなくなった場合、互いのカードの数字の大きさで勝敗を決める。
    if deck.empty?
      deck_none(my_hand, pc_hand)
    end

    #ここから自分のターンにループ。前回選んだカードが７番だった場合、賢者の効果を発動する。
    if my_wiseman == 1
      my_wiseman(line, deck, my_hand)
    end
  end

end
```

以上、ご意見頂ければ即座に改善します。