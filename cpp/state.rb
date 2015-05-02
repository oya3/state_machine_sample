# coding: utf-8
# C++ 風に多態で実現してみたサンプル
# require 'pry'

# 状態は以下の通り
module STATE
  OFF  = "電源OFF"
  ON = "電源ON"
end

class StateBase
  include STATE
  def state?
    raise "to be implemented"
  end
  def start
    raise "to be implemented"
  end
  def stop
    raise "to be implemented"
  end
end

class StateOFF < StateBase
  def state?
    puts OFF
  end
  def start
    puts "状態をONに切り替える処理実行"
    StateON.new
  end
  def stop
    puts "何もしない：既にOFF状態"
    self
  end
end

class StateON < StateBase
  def state?
    puts ON
  end
  def start
    puts "何もしない：既にOK状態"
    self
  end
  def stop
    puts "状態をOFFにする処理実行"
    StateOFF.new
  end
end

class Switcher
  # require 'forwardable'
  def initialize
    @state = StateOFF.new
  end
  def state?
    @state.state?
  end
  def start
    @state = @state.start
  end
  def stop
    @state = @state.stop
  end
end

sw = Switcher.new
sw.state? # 電源OFF
sw.stop  # 何もしない：既にOFF状態
sw.state? # 電源OFF
sw.start # 状態をONに切り替える処理実行
sw.state? # 電源ON
sw.start # 何もしない：既にOK状態
sw.state? # 電源ON
sw.stop # 状態をOFFに切り替える処理実行
sw.state? # 電源OFF
# binding.pry
