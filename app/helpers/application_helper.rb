module ApplicationHelper
  def title(value)
    unless value.nil?
      @title = "#{value} | Calguessr"
    end
  end
end
