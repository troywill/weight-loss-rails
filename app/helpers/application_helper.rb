module ApplicationHelper
  def footer
    lbs = number_with_precision(@diff, :precision => 1, :significant => true)
    cals = @diff * 3500
    cals = number_with_precision(cals, :precision => 2, :significant => true)
    return "#{lbs} lbs (#{cals} cal)"
  end
end
