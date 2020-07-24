class Game_result
  attr_accessor :myplayer
  attr_accessor :pcplayer
  attr_accessor :compensating
  attr_accessor :continue

  def initialize
    self.myplayer = 0
    self.pcplayer = 0
    self.compensating = 0
    self.continue = true
  end

end