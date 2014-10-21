module TasksHelper
  DESCRIPTION_CHARS_LIMIT = 100

  def format_description(description = "")
    return description if description.size <= DESCRIPTION_CHARS_LIMIT
    description[0..DESCRIPTION_CHARS_LIMIT] + "..."
  end

end
