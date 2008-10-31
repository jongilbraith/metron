class Mass
  
  include Metron::Support
  include Comparable
  
  # All relative to a pound
  # http://en.wikipedia.org/wiki/Imperial_unit
  IMPERIAL_FACTORS = { :grain => 1.0 / 7000.0,
                       :drachm => 1.0 / 256.0,
                       :ounce => 1.0 / 16.0,
                       :pound => 1.0,
                       :stone => 14.0,
                       :quarter => 28.0,
                       :hundredweight => 112.0,
                       :ton =>  2240.0 }

  IMPERIAL_SYMBOLS = { :grain => "g",
                       :drachm => "drachm",
                       :ounce => "oz",
                       :pound => "lb",
                       :stone => "st",
                       :quarter => "quarter",
                       :cwt => "cwt",
                       :ton => "t" }
            
 IMPERIAL_NAMES    = { :grain => "grain",
                       :drachm => "drachm",
                       :ounce => "ounce",
                       :pound => "pound",
                       :stone => "stone",
                       :quarter => "quarter",
                       :hundredweight => "hundredweight",
                       :ton => "ton" }

  METRIC_FACTORS   = { :mg => -3,
                       :dg => -1,
                       :g => -0,
                       :kg => 3,
                       :tonne => 6 }

  METRIC_SYMBOLS   = { :mg => "mg",
                       :dg => "dg",
                       :g => "g",
                       :kg => "kg",
                       :tonne => "Mg" }
                  
  METRIC_NAMES     = { :mg => "milligram",
                       :dg => "decigram",
                       :g => "gram",
                       :kg => "kilogram",
                       :tonne => "tonne" }

  attr_accessor :amount
  attr_accessor :units
  
  def initialize(amount, units)
    @amount = BigDecimal.new(amount.to_s)
    @units = units.to_sym
  end
  
  def <=>(other_mass, accuracy = 2)
    self.amount.round(accuracy) <=> other_mass.convert_to(self.units).amount.round(accuracy)
  end
  
  # For all arithmetic, we work on the rule of taking on the units of the first mass
  def *(fixnum)
    self.class.new(self.amount * BigDecimal.new(fixnum.to_s), self.units)
  end

  # If passed a mass, the result is a fixnum, if passed a fixnum, the result is a mass
  def /(value)
    value.respond_to?(:amount) ? (self.amount / value.convert_to(self.units).amount).to_f : self.class.new((self.amount / BigDecimal.new(value.to_s)), self.units)
  end

  def +(other_mass)
    self.class.new(self.amount + other_mass.convert_to(self.units).amount, self.units)
  end

  def -(other_mass)
    self.class.new(self.amount - other_mass.convert_to(self.units).amount, self.units)
  end
  
  def convert_to(new_units)
    self.class.new(self.amount * factor(self.units, new_units), new_units)
  end
  
  def to_f
    self.amount.to_f
  end
  
  def to_s(format = :short)
    if format == :name
      if self.metric?
        pluralize(self.amount, METRIC_NAMES[self.units.to_sym].capitalize)
      elsif self.imperial?
        pluralize(self.amount, IMPERIAL_NAMES[self.units.to_sym].capitalize)
      end
    elsif format == :long
      if self.metric?
        "#{self.amount.to_f} #{METRIC_SYMBOLS[self.units.to_sym]}"
      elsif self.imperial?
        "#{self.amount.to_f} #{IMPERIAL_SYMBOLS[self.units.to_sym]}"
      end
    end
  end
  
  def metric?
    METRIC_SYMBOLS.keys.include?(units.to_sym)
  end

  def imperial?
    IMPERIAL_SYMBOLS.keys.include?(units.to_sym)
  end
  
  def method_missing(method, *args)
    if method.to_s =~ /to_/
      units = method.to_s.split(/to_/)[1].to_sym
      METRIC_SYMBOLS.keys.include?(units) || IMPERIAL_SYMBOLS.keys.include?(units) ? self.convert_to(units) : super
    else
      super
    end
  end

  private
    # Conversion source http://en.wikipedia.org/wiki/Imperial_unit#Measures_of_weight_and_mass
    def factor(from, to)
      if METRIC_FACTORS[from.to_sym] && METRIC_FACTORS[to.to_sym]
        10 ** (METRIC_FACTORS[from.to_sym] - METRIC_FACTORS[to.to_sym])
      elsif IMPERIAL_FACTORS[from.to_sym] && IMPERIAL_FACTORS[to.to_sym]
        IMPERIAL_FACTORS[from.to_sym] / IMPERIAL_FACTORS[to.to_sym]
      elsif METRIC_FACTORS[from.to_sym] && IMPERIAL_FACTORS[to.to_sym]
        (10 ** (METRIC_FACTORS[from.to_sym] - METRIC_FACTORS[:g])) / 453.59237 * (IMPERIAL_FACTORS[:pound] / IMPERIAL_FACTORS[to.to_sym])
      elsif IMPERIAL_FACTORS[from.to_sym] && METRIC_FACTORS[to.to_sym]
        (IMPERIAL_FACTORS[from.to_sym] / IMPERIAL_FACTORS[:pound]) *  453.59237 * (10 ** (METRIC_FACTORS[:g] - METRIC_FACTORS[to.to_sym]))
      end
    end
  
end