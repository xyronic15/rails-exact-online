require "application_system_test_case"

class VatCodesTest < ApplicationSystemTestCase
  setup do
    @vat_code = vat_codes(:one)
  end

  test "visiting the index" do
    visit vat_codes_url
    assert_selector "h1", text: "Vat codes"
  end

  test "should create vat code" do
    visit vat_codes_url
    click_on "New vat code"

    fill_in "Account", with: @vat_code.account
    fill_in "Account code", with: @vat_code.account_code
    fill_in "Code", with: @vat_code.code
    fill_in "Description", with: @vat_code.description
    fill_in "Gl to pay", with: @vat_code.gl_to_pay
    fill_in "Guid", with: @vat_code.guid
    click_on "Create Vat code"

    assert_text "Vat code was successfully created"
    click_on "Back"
  end

  test "should update Vat code" do
    visit vat_code_url(@vat_code)
    click_on "Edit this vat code", match: :first

    fill_in "Account", with: @vat_code.account
    fill_in "Account code", with: @vat_code.account_code
    fill_in "Code", with: @vat_code.code
    fill_in "Description", with: @vat_code.description
    fill_in "Gl to pay", with: @vat_code.gl_to_pay
    fill_in "Guid", with: @vat_code.guid
    click_on "Update Vat code"

    assert_text "Vat code was successfully updated"
    click_on "Back"
  end

  test "should destroy Vat code" do
    visit vat_code_url(@vat_code)
    click_on "Destroy this vat code", match: :first

    assert_text "Vat code was successfully destroyed"
  end
end
