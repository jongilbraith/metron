class ImperialMass

  include Metron::Support
  include Comparable
  
  # All relative to a pound
  # http://en.wikipedia.org/wiki/Imperial_unit
  FACTORS = { :grain => 1.0 / 7000.0,
              :drachm => 1.0 / 256.0,
              :ounce => 1.0 / 16.0,
              :pound => 1.0,
              :stone => 14.0,
              :quarter => 28.0,
              :hundredweight => 112.0,
              :ton =>  2240.0 }

  SYMBOLS = { :grain => "g",
              :drachm => "drachm",
              :ounce => "oz",
              :pound => "lb",
              :stone => "st",
              :quarter => "quarter",
              :cwt => "cwt",
              :ton => "t" }
            
  NAMES = { :grain => "grain",
            :drachm => "drachm",
            :ounce => "ounce",
            :pound => "pound",
            :stone => "stone",
            :quarter => "quarter",
            :hundredweight => "hundredweight",
            :ton => "ton" }

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
    ImperialMass.new(self.amount * BigDecimal.new(fixnum.to_s), self.units)
  end

  # If passed a mass, the result is a fixnum, if passed a fixnum, the result is a mass
  def /(value)
    value.respond_to?(:amount) ? (self.amount / value.convert_to(self.units).amount).to_f : ImperialMass.new((self.amount / BigDecimal.new(value.to_s)), self.units)
  end

  def +(other_mass)
    ImperialMass.new(self.amount + other_mass.convert_to(self.units).amount, self.units)
  end

  def -(other_mass)
    ImperialMass.new(self.amount - other_mass.convert_to(self.units).amount, self.units)
  end
  
  def to_grain
    self.convert_to(:grain)
  end
  
  def to_drachm
    self.convert_to(:drachm)
  end
  
  def to_ounce
    self.convert_to(:ounce)
  end
  
  def to_pound
    self.convert_to(:pound)
  end
  
  def to_stone
    self.convert_to(:stone)
  end
  
  def to_quarter
    self.convert_to(:quarter)
  end
  
  def to_hundredweight
    self.convert_to(:hundredweight)
  end
  
  def to_ton
    self.convert_to(:ton)
  end
  
  def convert_to(new_units)
    ImperialMass.new(self.amount * factor(self.units, new_units), new_units)
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
  def in_metric
    MetricMass.new(self.to_pound * BigDecimal.new("453.59237"), :g)
  end
  
  def imperial?
    true
  end
  
  def metric?
    false
  end
  
  private
    def factor(from, to)
      FACTORS[from.to_sym] / FACTORS[to.to_sym]
    end

end