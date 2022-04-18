# frozen_string_literal: true

require 'test_helper'

class CategoryTest < ActiveSupport::TestCase
  test 'Category should be valid' do
    @category = Category.new(name: 'Sports')
    assert @category.valid?
  end
end
