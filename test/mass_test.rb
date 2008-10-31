require File.join(File.dirname(__FILE__), "..", "init")
require 'test/unit'
require 'shoulda'

class MassTest < Test::Unit::TestCase
  
  context "A mass" do

    context "and another mass of the same units" do
      
      context "when compared" do

        should "return true if the first is larger than the second" do
          assert Mass.new(100, :g) > Mass.new(10, :g)
        end

        should "return true if the first is smaller than the second" do
          assert Mass.new(100, :g) < Mass.new(101, :g)
        end

        should "return true if the first is equal to the second" do
          assert Mass.new(100, :g) == Mass.new(100, :g)
        end
      end

      context "when added" do
        should "should return the correct amount in the units of the first argument" do
          assert_equal Mass.new(10, :g) + Mass.new(50, :g), Mass.new(60, :g)
        end
      end

      context "when subtracted" do
        should "should return the correct amount in the units of the first argument" do
          assert_equal Mass.new(100, :g) - Mass.new(50, :g), Mass.new(50, :g)
        end
      end

      context "when divided" do
        should "should return the correct number of times that the first length goes into the second as a fixnum" do
          assert_equal Mass.new(100, :g) / Mass.new(10, :g), 10
        end
      end

    end

    context "and another mass of different units" do

      context "when compared" do

        should "return true if the first is larger than the second" do
          assert Mass.new(100, :kg) > Mass.new(10, :pound)
        end

        should "return true if the first is smaller than the second" do
          assert Mass.new(10, :pound) < Mass.new(100, :kg)
        end

        should "return true if the first is equal to the second" do
          assert Mass.new(1, :pound) == Mass.new(453.59237, :g)
        end

      end

      context "when added" do
        should "should return the correct amount in the units of the first argument" do
          assert_equal Mass.new(1, :pound) + Mass.new(453.59237, :g), Mass.new(2, :pound)
        end
      end

      context "when subtracted" do
        should "should return the correct amount in the units of the first argument" do
          assert_equal Mass.new(2, :pound) - Mass.new(453.59237, :g), Mass.new(1, :pound)
        end
      end

      context "when divided" do
        should "should return the correct number of times that the first length goes into the second as a fixnum" do
          assert_equal Mass.new(10, :pound) / Mass.new(453.59237, :g), 10
        end
      end

    end
    
    context "and another mass of different units and system" do

      context "when compared" do

        should "return true if the first is larger than the second" do
          assert Mass.new(4.95, :pound) > Mass.new(2.1, :kg)
        end

        should "return true if the first is smaller than the second" do
          assert Mass.new(4.95, :pound) < Mass.new(3, :kg)
        end

        should "return true if the first is equal to the second" do
          assert Mass.new(4.95, :pound) == Mass.new(2.2452822, :kg)
        end

      end

      context "when added" do
        should "should return the correct amount in the units of the first argument" do
          assert_equal Mass.new(1, :pound) + Mass.new(453.59237, :g), Mass.new(2, :pound)
        end
      end

      context "when subtracted" do
        should "should return the correct amount in the units of the first argument" do
          assert_equal Mass.new(2, :pound) - Mass.new(453.59237, :g), Mass.new(1, :pound)
        end
      end

      context "when divided" do
        should "should return the correct number of times that the first length goes into the second as a fixnum" do
          assert_equal Mass.new(10, :pound) / Mass.new(453.59237, :g), 10
        end
      end

    end

    context "and a fixnum" do

      context "when multiplied" do
        should "should return the correct value as a mass" do
          assert_equal Mass.new(12.5, :kg) * 2, Mass.new(25, :kg)
        end
      end

      context "when divided" do
        should "should return the correct value as a mass" do
          assert_equal Mass.new(22, :kg) / 2, Mass.new(11, :kg)
        end
      end

    end

  end
  
end
