require "test_helper"

class VatCodesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @vat_code = vat_codes(:one)
  end

  test "should get index" do
    get vat_codes_url
    assert_response :success
  end

  test "should get new" do
    get new_vat_code_url
    assert_response :success
  end

  test "should create vat_code" do
    assert_difference("VatCode.count") do
      post vat_codes_url, params: { vat_code: { account: @vat_code.account, account_code: @vat_code.account_code, code: @vat_code.code, description: @vat_code.description, gl_to_pay: @vat_code.gl_to_pay, guid: @vat_code.guid } }
    end

    assert_redirected_to vat_code_url(VatCode.last)
  end

  test "should show vat_code" do
    get vat_code_url(@vat_code)
    assert_response :success
  end

  test "should get edit" do
    get edit_vat_code_url(@vat_code)
    assert_response :success
  end

  test "should update vat_code" do
    patch vat_code_url(@vat_code), params: { vat_code: { account: @vat_code.account, account_code: @vat_code.account_code, code: @vat_code.code, description: @vat_code.description, gl_to_pay: @vat_code.gl_to_pay, guid: @vat_code.guid } }
    assert_redirected_to vat_code_url(@vat_code)
  end

  test "should destroy vat_code" do
    assert_difference("VatCode.count", -1) do
      delete vat_code_url(@vat_code)
    end

    assert_redirected_to vat_codes_url
  end
end
