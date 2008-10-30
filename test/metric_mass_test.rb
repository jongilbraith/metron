require File.join(File.dirname(__FILE__), "..", "init")
require 'test/unit'
require 'shoulda'

class MetricMassTest < Test::Unit::TestCase
  
  context "A metric mass" do

    context "and another metric mass of the same units" do
      
      context "when compared" do

        should "return true if the first is larger than the second" do
          assert MetricMass.new(100, :g) > MetricMass.new(10, :g)
        end

        should "return true if the first is smaller than the second" do
          assert MetricMass.new(100, :g) < MetricMass.new(101, :g)
        end

        should "return true if the first is equal to the second" do
          assert MetricMass.new(100, :g) == MetricMass.new(100, :g)
        end
      end

      context "when added" do
        should "should return the correct amount in the units of the first argument" do
          assert_equal MetricMass.new(10, :g) + MetricMass.new(10, :g), MetricMass.new(20, :g)
        end
      end

      context "when subtracted" do
        should "should return the correct amount in the units of the first argument" do
          assert_equal MetricMass.new(100, :g) - MetricMass.new(50, :g), MetricMass.new(50, :g)
        end
      end

      context "when divided" do
        should "should return the correct number of times that the first mass goes into the second as a fixnum" do
          assert_equal MetricMass.new(100, :g) / MetricMass.new(10, :g), 10
        end
      end

    end

    context "and another imperial mass of the different units" do

      context "when compared" do

        should "return true if the first is larger than the second" do
          assert MetricMass.new(1001, :g) > MetricMass.new(1, :kg)
        end

        should "return true if the first is smaller than the second" do
          assert MetricMass.new(1, :kg) < MetricMass.new(1001, :g)
        end

        should "return true if the first is equal than the second" do
          assert MetricMass.new(1000, :g) == MetricMass.new(1, :kg)
        end

      end

      context "when added" do
        should "should return the correct amount in the units of the first argument" do
          assert_equal MetricMass.new(1000, :g) + MetricMass.new(1, :kg), MetricMass.new(2000, :g)
        end
      end

      context "when subtracted" do
        should "should return the correct amount in the units of the first argument" do
          assert_equal MetricMass.new(10, :kg) - MetricMass.new(1000, :g), MetricMass.new(9, :kg)
        end
      end

      context "when divided" do
        should "should return the correct number of times that the first mass goes into the second as a fixnum" do
          assert_equal MetricMass.new(10, :kg) / MetricMass.new(1000, :g), 10
        end
      end

    end

    context "and a fixnum" do

      context "when multiplied" do
        should "should return the correct value as a Metric mass" do
          assert_equal MetricMass.new(12.5, :kg) * 2, MetricMass.new(25, :kg)
        end
      end

      context "when divided" do
        should "should return the correct value as an Imperial Mass" do
          assert_equal MetricMass.new(22, :kg) / 2, MetricMass.new(11, :kg)
        end
      end

    end
      
    should "convert to mg" do
      assert_equal MetricMass.new(1.3, :kg).to_mg, MetricMass.new(1300000, :mg)
    end

    should "convert to dg" do
      assert_equal MetricMass.new(6, :kg).to_dg, MetricMass.new(60000, :dg)
    end

    should "convert to g" do
      assert_equal MetricMass.new(34, :dg).to_g, MetricMass.new(3.4, :g)
    end

    should "convert to kg" do
      assert_equal MetricMass.new(2860, :dg).to_kg, MetricMass.new(0.286, :kg)
    end

    should "convert to tonne" do
      assert_equal MetricMass.new(3506, :kg).to_tonne, MetricMass.new(3.506, :tonne)
    end
    
    should "convert to imperial" do
      assert_equal MetricMass.new(50, :kg).in_imperial, ImperialMass.new(110.231131092438, :pound)
    end

  end
  
end
