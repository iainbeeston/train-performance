class RtppmOperatorPerformanceMapper
  extend HashMapper

  map from('/Operator/name'),            to('/operator')
  map from('/Operator/Total'),           to('/total') {|t| t.to_i}
  map from('/Operator/OnTime'),          to('/on_time') {|t| t.to_i}
  map from('/Operator/Late'),            to('/late') {|t| t.to_i}
  map from('/Operator/CancelVeryLate'),  to('/cancelled') {|t| t.to_i}
end
