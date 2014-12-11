class OperatorPerformance
  include ActiveModel::Model

  attr_accessor :operator, :total, :on_time, :late, :cancelled

  def on_time_proportion
    on_time / total.to_f
  end

  def late_proportion
    late / total.to_f
  end

  def cancelled_proportion
    cancelled / total.to_f
  end
end
