require File.join(File.dirname(__FILE__), "..", "init")
require 'test/unit'
require 'shoulda'

class ImperialLengthTest < Test::Unit::TestCase
  
  context "A length" do

      context "with another length of the same units" do

        should "perform multiplication" do
          assert_equal ImperialLength.new(12.5, :inch) * ImperialLength.new(2.8, :inch), ImperialLength.new(35, :inch)
        end

        should "perform addition" do
          assert_equal ImperialLength.new(8.8, :inch) + ImperialLength.new(9.6, :inch), ImperialLength.new(18.4, :inch)
        end

        should "perform subtraction" do
          assert_equal ImperialLength.new(13.4, :inch) - ImperialLength.new(5.2, :inch), ImperialLength.new(8.2, :inch)
        end

        should "perform division and return a fixnum" do
          assert_equal ImperialLength.new(22, :inch) / ImperialLength.new(4, :inch), 5.5
        end

        should "recognise if the first is bigger than the second" do
          assert ImperialLength.new(13, :inch) > ImperialLength.new(12, :inch)
        end

        should "recognise if the first is smaller than the second" do
          assert ImperialLength.new(11, :inch) < ImperialLength.new(12, :inch)
        end

        should "recognise if the first equal to the second" do
          assert ImperialLength.new(12, :inch) == ImperialLength.new(12, :inch)
        end

      end

      context "with another length of different units" do

        should "perform multiplication returning results in the units of the first length" do
          assert_equal ImperialLength.new(12.5, :inch) * ImperialLength.new(2.8, :yard), ImperialLength.new(1260, :inch)
        end

        should "perform addition returning results in the units of the first length" do
          assert_equal ImperialLength.new(12.5, :inch) + ImperialLength.new(2.5, :yard), ImperialLength.new(102.5, :inch)
        end

        should "perform subtraction returning results in the units of the first length" do
          assert_equal ImperialLength.new(55.5, :inch) - ImperialLength.new(1.2, :yard), ImperialLength.new(12.3, :inch)
        end

        should "perform division and returning a fixnum" do
          assert_equal ImperialLength.new(81, :inch) / ImperialLength.new(1, :yard), 2.25
        end

        should "recognise if the first is bigger than the second" do
          assert ImperialLength.new(13, :inch) > ImperialLength.new(1, :foot)
        end

        should "recognise if the first is smaller than the second" do
          assert ImperialLength.new(11, :inch) < ImperialLength.new(1, :foot)
        end

        should "recognise if the first equal to the second" do
          assert ImperialLength.new(12, :inch) == ImperialLength.new(1, :foot)
        end
        
      end

    end
    
    should "convert to thou" do
      assert_equal ImperialLength.new(2.3, :yard).to_thou, ImperialLength.new(82800, :thou)
    end

    should "convert to inch" do
      assert_equal ImperialLength.new(2.5, :yard).to_inch, ImperialLength.new(90, :inch)
    end

    should "convert to foot" do
      assert_equal ImperialLength.new(43200, :thou).to_foot, ImperialLength.new(1.2, :yard)
    end

    should "convert to yard" do
      assert_equal ImperialLength.new(54, :inch).to_yard, ImperialLength.new(1.5, :yard)
    end

    should "convert to furlong" do
      assert_equal ImperialLength.new(528, :yard).to_furlong, ImperialLength.new(2.4, :furlong)
    end

    should "convert to mile" do
      assert_equal ImperialLength.new(114048, :inch).to_mile, ImperialLength.new(1.8, :mile)
    end

end