class UdaciList
  attr_reader :title, :items

  def initialize(options={})
    @title = options[:title] || "Untitled List"
    @items = []
  end

  def add(type, description, options={})
    type = type.downcase
    case type
    when "todo"
      @items.push TodoItem.new(description, options)
    when "event"
      @items.push EventItem.new(description, options)
    when "link"
      @items.push LinkItem.new(description, options)
    else
      raise UdaciListErrors::InvalidItemType, "Invalid item type of #{type}"
    end
  end

  def delete(index)
    if index > 0 && index < @items.length + 1
      @items.delete_at(index - 1)
    else
      raise UdaciListErrors::IndexExceedsListSize, "#{index} is out of range"
    end
  end

  def all
    Formatador.display_line("[red][_yellow_]#{@title}[/]")
    @items.each_with_index do |item, position|
      puts "#{position + 1}) #{item.details}"
    end
  end

  def filter(item_type)
    Formatador.display_line("[red][_yellow_]#{@title} - #{item_type} list[/]")
    @items.select {|item| item.get_type == item_type}.each_with_index do |item, index|
      puts "#{index + 1}) #{item.details}"
    end
  end

  def pretty_print
    table_data = []
    @items.each_with_index do |item, index|
      row = {
        position: index,
        type: item.get_type,
        details: item.details
      }
      table_data << row
    end
    Formatador.display_table(table_data, [:position, :type, :details])
  end

end
