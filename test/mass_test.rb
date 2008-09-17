require File.join(File.dirname(__FILE__), "..", "init")
require 'test/unit'
require 'shoulda'

class MassTest < Test::Unit::TestCase
  
  context "A mass" do

      context "with another mass of the same units" do

        should "perform multiplication" do
          assert_equal MetricMass.new(10, :g) * MetricMass.new(10, :g), MetricMass.new(100, :g)
        end

        should "perform addition" do
          assert_equal MetricMass.new(10, :g) + MetricMass.new(10, :g), MetricMass.new(20, :g)
        end

        should "perform subtraction" do
          assert_equal MetricMass.new(100, :g) - MetricMass.new(50, :g), MetricMass.new(50, :g)
        end

        should "perform division and return a fixnum" do
          assert_equal MetricMass.new(100, :g) / MetricMass.new(10, :g), 10
        end

      end

      context "with another mass of the different units" do

        should "perform multiplication returning results in the units of the first mass" do
          assert_equal MetricMass.new(1000, :g) * MetricMass.new(1, :kg), MetricMass.new(1000000, :g)
        end

        should "perform addition returning results in the units of the first mass" do
          assert_equal MetricMass.new(1000, :g) + MetricMass.new(1, :kg), MetricMass.new(2000, :g)
        end

        should "perform subtraction returning results in the units of the first mass" do
          assert_equal MetricMass.new(10, :kg) - MetricMass.new(1000, :g), MetricMass.new(9, :kg)
        end

        should "perform division and returning a fixnum" do
          assert_equal MetricMass.new(10, :kg) / MetricMass.new(1000, :g), 10
        end

      end

    end
    
    should "convert to mg" do
      assert_equal MetricMass.new(100, :g).to_mg, MetricMass.new(100000, :mg)
    end

    should "convert to dg" do
      assert_equal MetricMass.new(100, :g).to_dg, MetricMass.new(1000, :dg)
    end

    should "convert to g" do
      assert_equal MetricMass.new(100, :g).to_g, MetricMass.new(100, :g)
    end

    should "convert to kg" do
      assert_equal MetricMass.new(100, :g).to_kg, MetricMass.new(0.1, :kg)
    end

    should "convert to tonne" do
      assert_equal MetricMass.new(100, :g).to_tonne, MetricMass.new(0.0001, :tonne)
    end
  
end
