require File.join(File.dirname(__FILE__), "..", "init")
require 'test/unit'
require 'shoulda'

class MassTest < Test::Unit::TestCase
  
  context "A metric mass" do
    
    setup do
      @mass = MetricMass.new(100, :g)
    end
    
    should "convert to mg" do
      assert_equal @mass.to_mg, MetricMass.new(100000, :mg)
    end

    should "convert to dg" do
      assert_equal @mass.to_dg, MetricMass.new(1000, :dg)
    end

    should "convert to g" do
      assert_equal @mass.to_g, MetricMass.new(100, :g)
    end

    should "convert to kg" do
      assert_equal @mass.to_kg, MetricMass.new(0.1, :kg)
    end

    should "convert to tonne" do
      assert_equal @mass.to_tonne, MetricMass.new(0.0001, :tonne)
    end
    
  end
  
end
