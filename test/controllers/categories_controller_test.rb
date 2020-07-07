require 'test_helper'

class CategoriesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @category = Category.create(name: "Sports")
  end

  test "should get index" do
    get categories_index_url
    assert_response :success
  end

  test "should show category" do
    get categories_show_url(@category)
    assert_response :success
  end

  test "should get show" do
    get categories_show_url
    assert_response :success
  end

  test "should get edit" do
    get categories_edit_url
    assert_response :success
  end

  test "should get update" do
    get categories_update_url
    assert_response :success
  end

  test "should get destroy" do
    get categories_destroy_url
    assert_response :success
  end

end
