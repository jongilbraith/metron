require File.join(File.dirname(__FILE__), "..", "init")
require 'test/unit'
require 'shoulda'

class ImperialLengthTest < Test::Unit::TestCase
  
  context "A length" do
    
    should "convert to thou" do
      assert_equal ImperialLength.new(1, :foot).to_thou, ImperialLength.new(12000, :thou)
    end

    should "convert to inch" do
      assert_equal ImperialLength.new(1, :foot).to_inch, ImperialLength.new(12, :inch)
    end

    should "convert to foot" do
      assert_equal ImperialLength.new(12000, :thou).to_foot, ImperialLength.new(1, :foot)
    end

    should "convert to yard" do
      assert_equal ImperialLength.new(3, :foot).to_yard, ImperialLength.new(1, :yard)
    end

    should "convert to furlong" do
      assert_equal ImperialLength.new(660, :foot).to_furlong, ImperialLength.new(1, :furlong)
    end

    should "convert to mile" do
      assert_equal ImperialLength.new(5280, :foot).to_mile, ImperialLength.new(1, :mile)
    end

end
