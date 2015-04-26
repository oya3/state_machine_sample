# coding: utf-8
# ruby 風?に実現してみたサンプル
require 'state_machine'
# require 'pry'

class Switcher
  state_machine :state, :initial => :off_state do
    # 状態は以下の通り
    state :off_state, value: "電源OFF"
    state :on_state, value: "電源ON"
    
    after_transition on: :start, do: :can_start
    after_transition on: :stop, do: :can_stop
    after_failure on: :start, do: :cant_start
    after_failure on: :stop, do: :cant_stop
    
    event :start do
      transition off_state: :on_state
    end
    
    event :stop do
      transition on_state: :off_state
    end
  end
  
  def can_start
    puts "状態をONに切り替える処理実行"
  end
  def can_stop
    puts "状態をOFFにする処理実行"
  end
  def cant_start
    puts "何もしない：既にON状態"
  end
  def cant_stop
    puts "何もしない：既にOFF状態"
  end
end

sw = Switcher.new
puts sw.state # 電源OFF
sw.stop  # 何もしない：既にOFF状態
sw.start # 状態をONに切り替える処理実行
sw.start # 何もしない：既にOK状態
sw.stop # 状態をOFFに切り替える処理実行
# binding.pry

