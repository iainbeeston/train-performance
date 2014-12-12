class OperatorPerformance
  include ActiveModel::Model

  attr_accessor :operator, :total, :on_time, :late, :cancelled

  def on_time_proportion
    proportion(on_time)
  end

  def late_proportion
    proportion(late)
  end

  def cancelled_proportion
    proportion(cancelled)
  end

  protected

  def proportion(count)
    total == 0 ? 0.0 : (count / total.to_f)
  end
end
