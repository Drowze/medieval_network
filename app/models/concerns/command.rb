module Command
  extend ActiveSupport::Concern

  attr_reader :outputs

  module ClassMethods
    def run(**inputs)
      new(**inputs).run
    end
  end

  def initialize(**inputs)
    @inputs = Struct.new(*inputs.keys).new(*inputs.values)
    @outputs = OpenStruct.new(errors: [])
  end

  def execute
    raise NotImplementedError
  end

  def run
    execute
    @outputs
  end

  def errors
    @outputs.errors
  end

  def valid?
    errors.empty?
  end
end
