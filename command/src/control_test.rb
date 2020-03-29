# Command Pattern
# Date: 29-Mar-2020
# Authors:
#          A01372812 José Javier Rodríguez Mota
#          A01379228 Adrián Méndez López

# The source code contained in this file demonstrates how to
# test the <em>command pattern</em>.

# File: control_test.rb

require 'minitest/autorun'
require 'stringio'
require 'control'

class ControlTest < Minitest::Test

  #Prepares the data for creating the ControlTest
  def setup
    set_stdout
    @rc = RemoteControlWithUndo.new
    set_light
    set_fan
  end

  #Invokes the reset_stdout method
  def teardown
    reset_stdout
  end

  #Sets the stdout to old_stdout
  def set_stdout
    @out = StringIO.new
    @old_stdout = $stdout
    $stdout = @out
  end

  #Resets the stdout to old_stdout
  def reset_stdout
    $stdout = @old_stdout
  end

  #Sets the light for the tests
  def set_light
    light = Light.new("Living Room")
    light_on = LightOnCommand.new(light)
    light_off = LightOffCommand.new(light)
    @rc.set_command(0, light_on, light_off)
  end

  #Sets the fan for the tests
  def set_fan
    fan = CeilingFan.new("Living Room")
    fan_medium = CeilingFanMediumCommand.new(fan)
    fan_high = CeilingFanHighCommand.new(fan)
    fan_off = CeilingFanOffCommand.new(fan)
    @rc.set_command(1, fan_medium, fan_off)
    @rc.set_command(2, fan_high, fan_off)
  end

  #Tests the Light instances commands
  def test_light
    @rc.on_button_was_pushed(0)
    @rc.off_button_was_pushed(0)
    p @rc
    @rc.undo_button_was_pushed
    @rc.off_button_was_pushed(0)
    @rc.on_button_was_pushed(0)
    p @rc
    @rc.undo_button_was_pushed
    assert_equal                                                \
      "Light is on\n"                                           \
      "Light is off\n"                                          \
      "\n------ Remote Control -------\n"                       \
      "[slot 0] LightOnCommand  LightOffCommand\n"              \
      "[slot 1] CeilingFanMediumCommand  CeilingFanOffCommand\n"\
      "[slot 2] CeilingFanHighCommand  CeilingFanOffCommand\n"  \
      "[slot 3] NoCommand  NoCommand\n"                         \
      "[slot 4] NoCommand  NoCommand\n"                         \
      "[slot 5] NoCommand  NoCommand\n"                         \
      "[slot 6] NoCommand  NoCommand\n"                         \
      "[undo] LightOffCommand\n\n"                              \
      "Light is on\n"                                           \
      "Light is off\n"                                          \
      "Light is on\n"                                           \
      "\n------ Remote Control -------\n"                       \
      "[slot 0] LightOnCommand  LightOffCommand\n"              \
      "[slot 1] CeilingFanMediumCommand  CeilingFanOffCommand\n"\
      "[slot 2] CeilingFanHighCommand  CeilingFanOffCommand\n"  \
      "[slot 3] NoCommand  NoCommand\n"                         \
      "[slot 4] NoCommand  NoCommand\n"                         \
      "[slot 5] NoCommand  NoCommand\n"                         \
      "[slot 6] NoCommand  NoCommand\n"                         \
      "[undo] LightOnCommand\n\n"                               \
      "Light is off\n", @out.string
  end

  #Tests the Fan instances commands
  def test_fan
    @rc.on_button_was_pushed(1)
    @rc.off_button_was_pushed(1)
    p @rc
    @rc.undo_button_was_pushed
    @rc.on_button_was_pushed(2)
    p @rc
    @rc.undo_button_was_pushed
    assert_equal                                                \
      "Living Room ceiling fan is on medium\n"                  \
      "Living Room ceiling fan is off\n"                        \
      "\n------ Remote Control -------\n"                       \
      "[slot 0] LightOnCommand  LightOffCommand\n"              \
      "[slot 1] CeilingFanMediumCommand  CeilingFanOffCommand\n"\
      "[slot 2] CeilingFanHighCommand  CeilingFanOffCommand\n"  \
      "[slot 3] NoCommand  NoCommand\n"                         \
      "[slot 4] NoCommand  NoCommand\n"                         \
      "[slot 5] NoCommand  NoCommand\n"                         \
      "[slot 6] NoCommand  NoCommand\n"                         \
      "[undo] CeilingFanOffCommand\n\n"                         \
      "Living Room ceiling fan is on medium\n"                  \
      "Living Room ceiling fan is on high\n"                    \
      "\n------ Remote Control -------\n"                       \
      "[slot 0] LightOnCommand  LightOffCommand\n"              \
      "[slot 1] CeilingFanMediumCommand  CeilingFanOffCommand\n"\
      "[slot 2] CeilingFanHighCommand  CeilingFanOffCommand\n"  \
      "[slot 3] NoCommand  NoCommand\n"                         \
      "[slot 4] NoCommand  NoCommand\n"                         \
      "[slot 5] NoCommand  NoCommand\n"                         \
      "[slot 6] NoCommand  NoCommand\n"                         \
      "[undo] CeilingFanHighCommand\n\n"                        \
      "Living Room ceiling fan is on medium\n", @out.string
  end

end