class TodoItem
  include Listable
  attr_reader :description, :due, :priority

  def initialize(description, options={})
    @description = description
    @due = options[:due] ? Chronic.parse(options[:due]) : options[:due]
    @priority = options[:priority]
    if @priority && !["low", "medium", "high"].include?(@priority)
      raise UdaciListErrors::InvalidPriorityValue, "No priority value of #{@priority}"
    end
  end

  def details
    format_description(get_type, @description) + "due: " +
    format_date(@due) +
    format_priority(@priority)
  end

  def get_type
    "todo"
  end

  def change_priority(priority)
    if @priority != priority && ["low", "medium", "high"].include?(priority)
      @priority = priority
    end
  end

end
