require File.join(File.dirname(__FILE__), "..", "init")
require 'test/unit'
require 'shoulda'

class ImperialMassTest < Test::Unit::TestCase
  
  context "A mass" do
    
    context "and another metric mass of the same units" do
      
      context "when compared" do

        should "return true if the first is larger than the second" do
          assert ImperialMass.new(15, :pound) > ImperialMass.new(14, :pound)
        end

        should "return true if the first is smaller than the second" do
          assert ImperialMass.new(13, :pound) < ImperialMass.new(14, :pound)
        end

        should "return true if the first is equal to the second" do
          assert ImperialMass.new(14, :pound) == ImperialMass.new(14, :pound)
        end
      end

      context "when added" do
        should "should return the correct amount in the units of the first argument" do
          assert ImperialMass.new(2, :stone) + ImperialMass.new(2, :stone), ImperialMass.new(4, :stone)
        end
      end

      context "when subtracted" do
        should "should return the correct amount in the units of the first argument" do
          assert ImperialMass.new(5, :stone) - ImperialMass.new(1, :stone), ImperialMass.new(4, :stone)
        end
      end

      context "when divided" do
        should "should return the correct value as a fixnum" do
          assert ImperialMass.new(14, :pound) / ImperialMass.new(2, :pound), 7
        end
      end

    end

    context "and another imperial length of the different units" do

      context "when compared" do

        should "return true if the first is larger than the second" do
          assert ImperialMass.new(1, :stone) > ImperialMass.new(13, :pound)
        end

        should "return true if the first is smaller than the second" do
          assert ImperialMass.new(1, :stone) < ImperialMass.new(15, :pound)
        end

        should "return true if the first is equal than the second" do
          assert ImperialMass.new(1, :stone) == ImperialMass.new(14, :pound)
        end

      end

      context "when added" do
        should "should return the correct amount in the units of the first argument" do
          assert_equal ImperialMass.new(1, :stone) + ImperialMass.new(14, :pound), ImperialMass.new(2, :stone)
        end
      end

      context "when subtracted" do
        should "should return the correct amount in the units of the first argument" do
          assert_equal ImperialMass.new(2, :stone) - ImperialMass.new(14, :pound), ImperialMass.new(1, :stone)
        end
      end

      context "when divided" do
        should "should return the correct value as a fixnum" do
          assert_equal ImperialMass.new(10, :kg) / MetricMass.new(1000, :g), 10
        end
      end

    end

    context "and a fixnum" do

      context "when multiplied" do
        should "should return the correct value as a Metric mass" do
          assert_equal ImperialMass.new(12.5, :stone) * 2, ImperialMass.new(25, :stone)
        end
      end

      context "when divided" do
        should "should return the correct value as a Metric Mass" do
          assert_equal ImperialMass.new(1, :stone) / 2, ImperialMass.new(0.5, :stone)
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
    
    should "convert to metric" do
      assert_equal ImperialMass.new(50, :pound).in_metric, MetricMass.new(22679.6185, :g)
    end
    
  end
  
end
