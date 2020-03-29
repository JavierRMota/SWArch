# Command Pattern
# Date: 29-Mar-2020
# Authors:
#          A01372812 José Javier Rodríguez Mota
#          A01379228 Adrián Méndez López

# The source code contained in this file demonstrates how to
# implement the <em>command pattern</em>.

# File: control.rb

# A class that models the RemoteControlWithUndo instance
class RemoteControlWithUndo

  #Creates the instance of RemoteControlWithUndo class
  def initialize
    @on_commands = []
    @off_commands = []
    no_command = NoCommand.new
    7.times do
      @on_commands << no_command
      @off_commands << no_command
    end
    @undo_command = no_command
  end

  #Sets the commands for the RemoteControlWithUndo
  #params slot, on_command, off_command
  def set_command(slot, on_command, off_command)
    @on_commands[slot] = on_command
    @off_commands[slot] = off_command
  end

  #Sets the action released on button pushed for the RemoteControlWithUndo
  #params slot
  def on_button_was_pushed(slot)
    @on_commands[slot].execute
    @undo_command = @on_commands[slot]
  end

  #Sets the action released off button pushed for the RemoteControlWithUndo
  #params slot
  def off_button_was_pushed(slot)
    @off_commands[slot].execute
    @undo_command = @off_commands[slot]
  end

  #Sets the action released undo button push for the RemoteControlWithUndo
  def undo_button_was_pushed()
    @undo_command.undo
  end

  #Inspects the RemoteControlWithUndo instance
  def inspect
    string_buff = ["\n------ Remote Control -------\n"]
    @on_commands.zip(@off_commands) \
        .each_with_index do |commands, i|
      on_command, off_command = commands
      string_buff << \
      "[slot #{i}] #{on_command.class}  " \
        "#{off_command.class}\n"
    end
    string_buff << "[undo] #{@undo_command.class}\n"
    string_buff.join
  end

end

# A class that models the NoCommand instance
class NoCommand

  #Execute action
  def execute
  end

  #Undo action
  def undo
  end

end

# A class that models the Light instance
class Light
  #Getter for level
  attr_reader :level

  #Initialize the instances
  #params: location
  def initialize(location)
    @location = location
    @level = 0
  end

  #Action when on button is pushed
  def on
    @level = 100
    puts "Light is on"
  end

  #Action when off button is pushed
  def off
    @level = 0
    puts "Light is off"
  end

  #Action when dim button is pushed
  #params: level
  def dim(level)
    @level = level
    if level == 0
      off
    else
      puts "Light is dimmed to #{@level}%"
    end
  end

end

# A class that models the CeilingFan instance
class CeilingFan

  # Access these constants from outside this class as
  # CeilingFan::HIGH, CeilingFan::MEDIUM, and so on.

  #High Speed
  HIGH   = 3
  #Medium Speed
  MEDIUM = 2
  #Low Speed
  LOW    = 1
  #Off Speed
  OFF    = 0

  #Getter for speed
  attr_reader :speed

  #Initialize the instances
  #params: location
  def initialize(location)
    @location = location
    @speed = OFF
  end

  #Action when high button is pushed
  def high
    @speed = HIGH
    puts "#{@location} ceiling fan is on high"
  end

  #Action when medium button is pushed
  def medium
    @speed = MEDIUM
    puts "#{@location} ceiling fan is on medium"
  end

  #Action when low button is pushed
  def low
    @speed = LOW
    puts "#{@location} ceiling fan is on low"
  end

  #Action when off button is pushed
  def off
    @speed = OFF
    puts "#{@location} ceiling fan is off"
  end

end

# A class that models the CeilingFanMediumCommand instance
class CeilingFanMediumCommand < CeilingFan

  #Initialize the instances
  #params: fan
  def initialize(fan)
    @fan = fan
    @undo = nil
  end

  #Execute action. Invokes father class action
  def execute
    @undo = @fan.speed
    @fan.medium
  end

  #Undo the action and invokes the previous action
  def undo
    if(@undo == CeilingFan::HIGH)
      @fan.high
    elsif(@undo == CeilingFan::MEDIUM)
      @fan.medium
    elsif(@undo == CeilingFan::LOW)
      @fan.low
    elsif(@undo == CeilingFan::OFF)
      @fan.off
    end
  end
end

# A class that models the CeilingFanHighCommand instance
class CeilingFanHighCommand < CeilingFan

  #Initialize the instances
  #params: fan
  def initialize(fan)
    @fan = fan
    @undo = nil
  end

  #Execute action. Invokes father class action
  def execute
    @undo = @fan.speed
    @fan.high
  end

  #Undo the action and invokes the previous action
  def undo
    if(@undo == CeilingFan::HIGH)
      @fan.high
    elsif(@undo == CeilingFan::MEDIUM)
      @fan.medium
    elsif(@undo == CeilingFan::LOW)
      @fan.low
    elsif(@undo == CeilingFan::OFF)
      @fan.off
    end
  end
end

# A class that models the CeilingFanOffCommand instance
class CeilingFanOffCommand < CeilingFan

  #Initialize the instances
  #params: fan
  def initialize(fan)
    @fan = fan
    @undo = nil
  end

  #Execute action. Invokes father class action
  def execute
    @undo = @fan.speed
    @fan.off
  end

  #Undo the action and invokes the previous action
  def undo
    if(@undo == CeilingFan::HIGH)
      @fan.high
    elsif(@undo == CeilingFan::MEDIUM)
      @fan.medium
    elsif(@undo == CeilingFan::LOW)
      @fan.low
    elsif(@undo == CeilingFan::OFF)
      @fan.off
    end
  end
end

# A class that models the LightOnCommand instance
class LightOnCommand < Light
  ON = 100
  OFF = 0

  #Initialize the instances
  #params: light
  def initialize(light)
    @light = light
    @undo = nil
  end

  #Execute action. Invokes father class action
  def execute
    @undo = @light.level
    @light.on
  end

  #Undo the action and invokes the previous action
  def undo
    if(@undo == ON)
      @light.on
    elsif(@undo == OFF)
      @light.off
    end
  end

end

# A class that models the LightOffCommand instance
class LightOffCommand < Light
  ON = 100
  OFF = 0

  #Initialize the instances
  #params: light
  def initialize(light)
    @light = light
    @undo = nil
  end

  #Execute action. Invokes father class action
  def execute
    @undo = @light.level
    @light.off
  end

  #Undo the action and invokes the previous action
  def undo
    if(@undo == ON)
      @light.on
    elsif(@undo == OFF)
      @light.off
    end
  end

end