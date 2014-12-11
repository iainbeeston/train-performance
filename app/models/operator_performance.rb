class OperatorPerformance
  include ActiveModel::Model

  attr_accessor :operator, :total, :on_time, :late, :cancelled
end
