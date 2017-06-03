require 'test_helper'

class PorductsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @porduct = porducts(:one)
  end

  test "should get index" do
    get porducts_url
    assert_response :success
  end

  test "should get new" do
    get new_porduct_url
    assert_response :success
  end

  test "should create porduct" do
    assert_difference('Porduct.count') do
      post porducts_url, params: { porduct: {  } }
    end

    assert_redirected_to porduct_url(Porduct.last)
  end

  test "should show porduct" do
    get porduct_url(@porduct)
    assert_response :success
  end

  test "should get edit" do
    get edit_porduct_url(@porduct)
    assert_response :success
  end

  test "should update porduct" do
    patch porduct_url(@porduct), params: { porduct: {  } }
    assert_redirected_to porduct_url(@porduct)
  end

  test "should destroy porduct" do
    assert_difference('Porduct.count', -1) do
      delete porduct_url(@porduct)
    end

    assert_redirected_to porducts_url
  end
end
