class ImperialLength
  
  include Metron::Support
  include Comparable

  # All relative to a foot
  # http://en.wikipedia.org/wiki/Imperial_unit
  FACTORS = { :thou => 1.0 / 12000.0,
              :inch => 1.0 / 12.0,
              :foot => 1.0,
              :yard => 3.0,
              :furlong => 660.0,
              :mile => 5280.0,
              :league => 15840.0 }

  # The amount of this length (Fixnum)
  attr_accessor :amount

  # The units of this length (String)
  attr_accessor :units

  def initialize(amount, units)
    @amount = BigDecimal.new(amount.to_s)
    @units = units.to_sym
  end
  
  # For comparison we need to have both values at the same level of accuracy, so we bring the smaller units up to that of the larger for comparison
  def <=>(other_length)
    FACTORS[self.units] < FACTORS[other_length.units] ? self.convert_to(other_length.units).amount <=> other_length.amount : self.amount <=> other_length.convert_to(self.units).amount
  end

  def to_thou
    self.convert_to(:thou)
  end

  def to_inch
    self.convert_to(:inch)
  end

  def to_foot
    self.convert_to(:foot)
  end

  def to_yard
    self.convert_to(:yard)
  end

  def to_furlong
    self.convert_to(:furlong)
  end

  def to_mile
    self.convert_to(:mile)
  end
  
  def to_league
    self.convert_to(:league)
  end

  def convert_to(new_units)
    ImperialLength.new(self.amount * factor(self.units, new_units), new_units)
  end
  
  private
    def factor(from, to)
      FACTORS[from.to_sym] / FACTORS[to.to_sym]
    end
    
end