class Deck
    attr_accessor :card
    attr_accessor :reincarnation
    attr_accessor :type

  def initialize
    self.card = [1, 1, 2, 2, 3, 3, 4, 4, 5, 5, 6, 6, 7, 7, 8, 8, 9, 10].shuffle
    self.reincarnation = self.card.delete_at(0)     
    self.type = {1 => "少年（革命）", 2 => "兵士（捜査）", 3 => "占い師（透視）", 4 => "乙女（守護）", 5 => "死神（疫病）", 6 => "貴族（対決）", 7 => "賢者（選択）", 8 => "精霊（交換）", 9 => "皇帝（公開処刑）", 10 => "英雄（潜伏・転生）"}
  end

end