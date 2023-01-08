require "application_system_test_case"

class ServaysTest < ApplicationSystemTestCase
  setup do
    @servay = servays(:one)
  end

  test "visiting the index" do
    visit servays_url
    assert_selector "h1", text: "Servays"
  end

  test "creating a Servay" do
    visit servays_url
    click_on "New Servay"

    click_on "Create Servay"

    assert_text "Servay was successfully created"
    click_on "Back"
  end

  test "updating a Servay" do
    visit servays_url
    click_on "Edit", match: :first

    click_on "Update Servay"

    assert_text "Servay was successfully updated"
    click_on "Back"
  end

  test "destroying a Servay" do
    visit servays_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Servay was successfully destroyed"
  end
end
