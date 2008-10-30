class MetricMass

  include Metron::Support
  include Comparable

  FACTORS = { :mg => -3,
              :dg => -1,
              :g => -0,
              :kg => 3,
              :tonne => 6 }

  SYMBOLS = { :mg => "mg",
              :dg => "dg",
              :g => "g",
              :kg => "kg",
              :tonne => "Mg" }

  NAMES = { :mg => "milligram",
            :dg => "decigram",
            :g => "gram",
            :kg => "kilogram",
            :tonne => "tonne" }

  # The amount of this mass (Fixnum)
  attr_accessor :amount
  
  # The units of this mass (String)
  attr_accessor :units
  
  def initialize(amount, units)
    @amount = BigDecimal.new(amount.to_s)
    @units = units.to_sym
  end
  
  # For comparison we need to have both values at the same level of accuracy, so we bring the smaller units up to that of the larger for comparison
  def <=>(other_mass)
    FACTORS[self.units] < FACTORS[other_mass.units] ? self.convert_to(other_mass.units).amount <=> other_mass.amount : self.amount <=> other_mass.convert_to(self.units).amount
  end
  
  # For all arithmetic, we work on the rule of taking on the units of the first mass
  def *(fixnum)
    MetricMass.new(self.amount * BigDecimal.new(fixnum.to_s), self.units)
  end

  # If passed a mass, the result is a fixnum, if passed a fixnum, the result is a mass
  def /(value)
    value.respond_to?(:amount) ? (self.amount / value.convert_to(self.units).amount).to_f : MetricMass.new((self.amount / BigDecimal.new(value.to_s)), self.units)
  end

  def +(other_mass)
    MetricMass.new(self.amount + other_mass.convert_to(self.units).amount, self.units)
  end

  def -(other_mass)
    MetricMass.new(self.amount - other_mass.convert_to(self.units).amount, self.units)
  end
  
  def to_mg
    self.convert_to(:mg)
  end

  def to_dg
    self.convert_to(:dg)
  end

  def to_g
    self.convert_to(:g)
  end

  def to_kg
    self.convert_to(:kg)
  end

  def to_tonne
    self.convert_to(:tonne)
  end
  
  def convert_to(new_units)
    MetricMass.new(self.amount * factor(self.units, new_units), new_units)
  end
  
  def to_f
    self.amount.to_f
  end
  
  def to_s(form = nil)
    if !form.nil? && form.to_sym == :name
      pluralize(self.amount, NAMES[self.units.to_sym])
    else
      "#{self.amount.to_f} #{SYMBOLS[self.units.to_sym]}"
    end
  end
  
  # Conversion source http://en.wikipedia.org/wiki/Imperial_unit#Measures_of_weight_and_mass
  def in_imperial
    ImperialMass.new(self.to_g / BigDecimal.new("453.59237"), :pound)
  end
  
  def imperial?
    false
  end
  
  def metric?
    true
  end

  private
    def factor(from, to)
      10 ** (FACTORS[from.to_sym] - FACTORS[to.to_sym])
    end
  
end