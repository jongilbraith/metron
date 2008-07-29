require 'active_support/inflector'
class MetricMass

  include Metron::Support

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
    @amount = amount
    @units = units
  end
  
  def to_mg
    MetricMass.new(self.amount * factor(self.units, :mg), :mg)
  end

  def to_dg
    MetricMass.new(self.amount * factor(self.units, :dg), :dg)
  end

  def to_g
    MetricMass.new(self.amount * factor(self.units, :g), :g)
  end

  def to_kg
    MetricMass.new(self.amount * factor(self.units, :kg), :kg)
  end

  def to_tonne
    MetricMass.new(self.amount * factor(self.units, :tonne), :tonne)
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
  
  private
    def factor(from, to)
      10 ** (FACTORS[from.to_sym] - FACTORS[to.to_sym])
    end
  
end