# frozen_string_literal: true

BASE_TITLE = 'Rails Diplomacy'

module ApplicationHelper
  def full_title(page_title = '')
    return BASE_TITLE if page_title.empty?

    "#{page_title} | #{BASE_TITLE}"
  end
end
