class Shooting < ActiveRecord::Base

  belongs_to :competitor
  belongs_to :competition

  before_create :assign_target
  after_find :explode_target
  before_save :implode_target

  serialize :target, Array

  validates :competitor_id, presence: true
  validates :competition_id, presence: true

  def number_of_fields
    self.competition.send(:number_of_shots) if self.competition
  end

  def virtual_attributes
    attributes = self.class.instance_methods(false).grep(/\A(shot_)\d{1,2}\z/)
    if block_given?
      attributes.each_with_index { |attribute, index| yield(attribute, index+1) }
    else
      attributes
    end
  end

  private
  def explode_target
    self.send(:remove_virtual_attributes)

    if number_of_fields
      number_of_fields.times do |index|
        self.class.send(:define_method, "shot_#{index}") { self.target[index] }
        self.class.send(:attr_writer, "shot_#{index}")
      end
    end
  end

  def assign_target
    self.target = Array.new(number_of_fields)
  end
  
  def implode_target
    self.target = []
    self.methods.grep(/\A(shot_)\d{1,2}\z/).each do |method_name|
      self.target << self.instance_variable_get("@#{method_name}")
    end
  end

  def remove_virtual_attributes
    self.methods.grep(/\A(shot_)\d{1,2}=*\z/).each do |method_name|
      self.class.send(:remove_method, method_name)
    end
  end
end
