require File.join(File.dirname(__FILE__), "..", "init")
require 'test/unit'
require 'shoulda'

class ImperialLengthTest < Test::Unit::TestCase
  
  context "An imperial length" do
    
    context "and another imperial length of the same units" do
      
      context "when compared" do
        
        should "return true if the first is larger than the second" do
          assert ImperialLength.new(13, :inch) > ImperialLength.new(12, :inch)
        end

        should "return true if the first is smaller than the second" do
          assert ImperialLength.new(11, :inch) < ImperialLength.new(12, :inch)
        end

        should "return true if the first is equal to the second" do
          assert ImperialLength.new(12, :inch) == ImperialLength.new(12, :inch)
        end
      end

      context "when added" do
        should "should return the correct amount in the units of the first argument" do
          assert_equal ImperialLength.new(8.8, :inch) + ImperialLength.new(9.6, :inch), ImperialLength.new(18.4, :inch)
        end
      end

      context "when subtracted" do
        should "should return the correct amount in the units of the first argument" do
          assert_equal ImperialLength.new(13.4, :inch) - ImperialLength.new(5.2, :inch), ImperialLength.new(8.2, :inch)
        end
      end
      
      context "when divided" do
        should "should return the correct number of times that the first length goes into the second as a fixnum" do
          assert_equal ImperialLength.new(81, :inch) / ImperialLength.new(1, :yard), 2.25
        end
      end

    end

    context "and another imperial length of the different units" do

      context "when compared" do
        
        should "return true if the first is larger than the second" do
          assert ImperialLength.new(13, :inch) > ImperialLength.new(1, :foot)
        end

        should "return true if the first is smaller than the second" do
          assert ImperialLength.new(11, :inch) < ImperialLength.new(1, :foot)
        end

        should "return true if the first is equal than the second" do
          assert ImperialLength.new(12, :inch) == ImperialLength.new(1, :foot)
        end
        
      end

      context "when added" do
        should "should return the correct amount in the units of the first argument" do
          assert_equal ImperialLength.new(12.5, :inch) + ImperialLength.new(2.5, :yard), ImperialLength.new(102.5, :inch)
        end
      end
      
      context "when subtracted" do
        should "should return the correct amount in the units of the first argument" do
          assert_equal ImperialLength.new(55.5, :inch) - ImperialLength.new(1.2, :yard), ImperialLength.new(12.3, :inch)
        end
      end
      
      context "when divided" do
        should "should return the correct number of times that the first length goes into the second as a fixnum" do
          assert_equal ImperialLength.new(81, :inch) / ImperialLength.new(9, :inch), 9
        end
      end
      
    end
    
    context "and a fixnum" do
      
      context "when multiplied" do
        should "should return the correct value as a Metric mass" do
          assert_equal ImperialLength.new(22, :inch) * 2, ImperialLength.new(44, :inch)
        end
      end
      
      context "when divided" do
        should "should return the correct value as an Imperial Length" do
          assert_equal ImperialLength.new(22, :inch) / 5.5, ImperialLength.new(4, :inch)
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

end
