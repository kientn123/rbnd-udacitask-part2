module Listable
  # Listable methods go here
  def format_description(item_type, description)
    "#{item_type}: #{description}".ljust(30)
  end

  def format_date(*dates)
    raise ArgumentError, "Invalid number of arguments" if dates.length > 2 || dates.length == 0
    # For TodoItem
    if dates.length == 1
      due = dates[0]
      return due ? due.strftime("%D") : "No due date"
    else # for EventItem
      start_date = dates[0]
      end_date = dates[1]
      dates_to_return = start_date.strftime("%D") if start_date
      dates_to_return << " -- " + end_date.strftime("%D") if end_date
      dates_to_return = "N/A" if start_date.nil? && end_date.nil?
      return dates_to_return
    end
  end

  def format_priority(priority)
    value = " ⇧".colorize(:red) if priority == "high"
    value = " ⇨".colorize(:blue) if priority == "medium"
    value = " ⇩".colorize(:green) if priority == "low"
    value = "" if !priority
    return value
  end

end
