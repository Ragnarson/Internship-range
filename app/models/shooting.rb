class Shooting < ActiveRecord::Base

  belongs_to :competitor
  belongs_to :competition

  before_create :assign_target
  before_save :implode_target

  serialize :target, Array

  validates :competitor_id, presence: true
  validates :competition_id, presence: true

  def explode_target
    self.send(:wipe_virtual_attributes)

    number_of_fields.times do |index|
      self.class.send(:define_method, "shot_#{index}") { self.target[index] }
      self.class.send(:attr_writer, "shot_#{index}")
    end

    self.send(:virtual_attributes)
  end

  private
  def assign_target
    self.target = Array.new(self.competition.number_of_shots)
  end

  def implode_target
    self.target = []
    self.methods.grep(/\A(shot_)\d{1,2}\z/).each do |method_name|
      self.target << self.instance_variable_get("@#{method_name}")
    end
  end

  def virtual_attributes
    self.class.instance_methods(false).grep(/\A(shot_)\d{1,2}\z/)
  end

  def wipe_virtual_attributes
    self.methods.grep(/\A(shot_)\d{1,2}=*\z/).each do |method_name|
      self.class.send(:remove_method, method_name)
    end
  end

  def number_of_fields
    self.competition.number_of_shots
  end
end
