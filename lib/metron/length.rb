class Length
  
  include Metron::Support
  include Comparable

  # All relative to a foot - http://en.wikipedia.org/wiki/Imperial_unit#Measures_of_length
  # Additional info - http://www.merriam-webster.com/mw/table/metricsy.htm
  IMPERIAL_FACTORS = { :thou => 1.0 / 12000.0,
                       :inch => 1.0 / 12.0,
                       :foot => 1.0,
                       :yard => 3.0,
                       :furlong => 660.0,
                       :mile => 5280.0,
                       :league => 15840.0 }

  IMPERIAL_SYMBOLS = { :thou => "thou",
                       :inch => "in",
                       :foot => "ft",
                       :yard => "yd",
                       :furlong => "furlong",
                       :mile => "mi",
                       :league => "league" }

 IMPERIAL_NAMES    = { :thou => "thou",
                       :inch => "inch",
                       :foot => "foot",
                       :yard => "yard",
                       :furlong => "furlong",
                       :mile => "mile",
                       :league => "league" }

  METRIC_FACTORS   = { :um => -4,
                       :mm => -1,
                       :cm => -0,
                       :dm => 1,
                       :m => 2,
                       :dam => 3,
                       :hm => 4,
                       :km => 5 }

  METRIC_SYMBOLS   = { :um => "um",
                       :mm => "mm",
                       :cm => "cm",
                       :dm => "dm",
                       :m => "m",
                       :dam => "dam",
                       :hm => "hm",
                       :km => "km" }
                  
  METRIC_NAMES     = { :um => "micrometer",
                       :mm => "milimeter",
                       :cm => "centimeter",
                       :dm => "decimeter",
                       :m => "meter",
                       :dam => "dekameter",
                       :hm => "hectometer",
                       :km => "kilometer" }
  
  attr_accessor :amount
  attr_accessor :units

  def initialize(amount, units)
    @amount = BigDecimal.new(amount.to_s)
    @units = units.to_sym
  end

  def <=>(other_length, accuracy = 2)
    self.amount.round(accuracy) <=> other_length.convert_to(self.units).amount.round(accuracy)
  end

  # For all arithmetic, we work on the rule of taking on the units of the first length
  def *(fixnum)
    self.class.new(self.amount * BigDecimal.new(fixnum.to_s), self.units)
  end

  # If passed a length, the result is a fixnum, if passed a fixnum, the result is a length
  def /(value)
    value.respond_to?(:amount) ? (self.amount / value.convert_to(self.units).amount).to_f : self.class.new((self.amount / BigDecimal.new(value.to_s)), self.units)
  end

  def +(other_length)
    self.class.new(self.amount + other_length.convert_to(self.units).amount, self.units)
  end

  def -(other_length)
    self.class.new(self.amount - other_length.convert_to(self.units).amount, self.units)
  end

  def convert_to(new_units)
    self.class.new(self.amount * factor(self.units, new_units), new_units)
  end

  def to_f
    self.amount.to_f
  end

  def to_s(format = :short)
    if format == :short
      if self.metric?
        "#{self.amount.to_f} #{METRIC_SYMBOLS[self.units.to_sym]}"
      elsif self.imperial?
        "#{self.amount.to_f} #{IMPERIAL_SYMBOLS[self.units.to_sym]}"
      end
    elsif format == :long
      if self.metric?
        pluralize(self.amount, METRIC_NAMES[self.units.to_sym].capitalize)
      elsif self.imperial?
        pluralize(self.amount, IMPERIAL_NAMES[self.units.to_sym].capitalize)
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
    # Conversion source http://en.wikipedia.org/wiki/Imperial_unit#Measures_of_weight_and_length
    def factor(from, to)
      if METRIC_FACTORS[from.to_sym] && METRIC_FACTORS[to.to_sym]
        10 ** (METRIC_FACTORS[from.to_sym] - METRIC_FACTORS[to.to_sym])
      elsif IMPERIAL_FACTORS[from.to_sym] && IMPERIAL_FACTORS[to.to_sym]
        IMPERIAL_FACTORS[from.to_sym] / IMPERIAL_FACTORS[to.to_sym]
      elsif METRIC_FACTORS[from.to_sym] && IMPERIAL_FACTORS[to.to_sym]
        (10 ** (METRIC_FACTORS[from.to_sym] - METRIC_FACTORS[:m])) / 0.9144 * (IMPERIAL_FACTORS[:yard] / IMPERIAL_FACTORS[to.to_sym])
      elsif IMPERIAL_FACTORS[from.to_sym] && METRIC_FACTORS[to.to_sym]
        (IMPERIAL_FACTORS[from.to_sym] / IMPERIAL_FACTORS[:yard]) *  0.9144 * (10 ** (METRIC_FACTORS[:m] - METRIC_FACTORS[to.to_sym]))
      end
    end
    
end