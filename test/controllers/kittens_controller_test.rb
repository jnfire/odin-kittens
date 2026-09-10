require "test_helper"

class KittensControllerTest < ActionDispatch::IntegrationTest
  setup do
    @kitten = kittens(:one)
  end

  test "should get index as json" do
    get kittens_url(format: :json)
    assert_response :success
  end

  test "should create kitten as json" do
    assert_difference("Kitten.count") do
      post kittens_url(format: :json), params: { kitten: { age: @kitten.age, cuteness: @kitten.cuteness, name: @kitten.name, softness: @kitten.softness } }
    end
    assert_response :created
  end

  test "should show kitten as json" do
    get kitten_url(@kitten, format: :json)
    assert_response :success
  end

  test "should update kitten as json" do
    patch kitten_url(@kitten, format: :json), params: { kitten: { age: @kitten.age, cuteness: @kitten.cuteness, name: @kitten.name, softness: @kitten.softness } }
    assert_response :success
  end

  test "should destroy kitten as json" do
    assert_difference("Kitten.count", -1) do
      delete kitten_url(@kitten, format: :json)
    end
    assert_response :no_content
  end
end
