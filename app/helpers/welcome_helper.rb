module WelcomeHelper
  def readings
    readings = ""
    for reading in @readings
      readings = readings + "#{number_with_precision(reading.weight, :precision => 2 )}<br/>\n"
    end
    return readings.html_safe
  end
end
