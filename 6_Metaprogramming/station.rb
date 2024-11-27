# frozen_string_literal: true

require_relative 'manufactures'
require_relative 'instance_counter'
require_relative 'validations'
require_relative 'accessors'

class Station
  include Manufactures
  include InstanceCounter
  include Validation
  extend Accessors

  attr_reader :name, :trains_on_station

  attr_accessor_with_history :name

  strong_attr_accessor :name, String

  @@all_stations = []

  class << self
    def all
      @@all_stations
    end
  end

  validate :name, :presence
  validate :name, :type, String

  def initialize(name)
    @name = name
    @trains_on_station = []

    validate!

    @@all_stations << self
    register_instance
  end

  def each_train(&block)
    trains_on_station.each(&block)
  end

  def arrive_train(train)
    @trains_on_station << train
  end

  def depart_train(train)
    @trains_on_station.delete(train)
  end

  def count_trains_by_type(type)
    @trains_on_station.count { |train| train.type == type }
  end

  private

  def all_trains
    @trains_on_station.each { |train| puts train }
  end
end
