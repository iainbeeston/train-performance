class RtppmOperatorPerformanceMapper
  extend HashMapper

  map from('/Operator/name'),            to('/operator')
  map from('/Operator/Total'),           to('/total')
  map from('/Operator/OnTime'),          to('/on_time')
  map from('/Operator/Late'),            to('/late')
  map from('/Operator/CancelVeryLate'),  to('/cancelled')
end
