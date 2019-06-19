require 'test_helper'

class CategoryTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  test "should not save category without name" do
    cat = Category.new 
    assert_not cat.save, "Saved the category without a title"
  end
end
