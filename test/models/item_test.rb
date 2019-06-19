require 'test_helper'

class ItemTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  test "should not save item without name" do
    User.new :email => 'asdasd@asd.com'
    item = Item.new :user_id => user.id, :description => 'asdasdsadasd'
    assert_not item.save, "Saved the item without a name"
  end

  test "should not save item without description" do
    User.new :email => 'asdasd@asd.com'
    item = Item.new :user_id => user.id, :name => 'asd'
    assert_not item.save, "Saved the item without an description"
  end
end
