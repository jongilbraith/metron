require File.join(File.dirname(__FILE__), "..", "init")
require 'test/unit'
require 'shoulda'

class ImperialMassTest < Test::Unit::TestCase
  
  context "A mass" do

      context "with another mass of the same units" do

        should "perform multiplication" do
        end

        should "perform addition" do
        end

        should "perform subtraction" do
        end

        should "perform division and return a fixnum" do
        end

        should "recognise if the first is bigger than the second" do
        end

        should "recognise if the first is smaller than the second" do
        end

        should "recognise if the first equal to the second" do
        end

      end

      context "with another mass of different units" do

        should "perform multiplication returning results in the units of the first mass" do
        end

        should "perform addition returning results in the units of the first mass" do
        end

        should "perform subtraction returning results in the units of the first mass" do
        end

        should "perform division and returning a fixnum" do
        end

        should "recognise if the first is bigger than the second" do
        end

        should "recognise if the first is smaller than the second" do
        end

        should "recognise if the first equal to the second" do
        end
        
      end

    end
    
    should "convert to grain" do
      assert_equal ImperialMass.new(1.3, :stone).to_stone, ImperialMass.new(127400, :grain)
    end

    should "convert to drachm" do
      assert_equal ImperialMass.new(6, :stone).to_drachm, ImperialMass.new(21504, :drachm)
    end

    should "convert to ounce" do
      assert_equal ImperialMass.new(1, :pound).to_ounce, ImperialMass.new(16, :ounce)
    end

    should "convert to pound" do
      assert_equal ImperialMass.new(1, :stone).to_pound, ImperialMass.new(14, :pound)
    end

    should "convert to stone" do
      assert_equal ImperialMass.new(403.2, :ounce).to_stone, ImperialMass.new(1.8, :stone)
    end

    should "convert to quarter" do
      assert_equal ImperialMass.new(1120, :ounce).to_quarter, ImperialMass.new(2.5, :quarter)
    end

    should "convert to hundredweight" do
      assert_equal ImperialMass.new(2150.4, :ounce).to_hundredweight, ImperialMass.new(1.2, :hundredweight)
    end

    should "convert to ton" do
      assert_equal ImperialMass.new(78848, :ounce).to_ton, ImperialMass.new(2.2, :ton)
    end
  
end
