require "application_system_test_case"

class ServayControllersTest < ApplicationSystemTestCase
  setup do
    @servay_controller = servay_controllers(:one)
  end

  test "visiting the index" do
    visit servay_controllers_url
    assert_selector "h1", text: "Servay Controllers"
  end

  test "creating a Servay controller" do
    visit servay_controllers_url
    click_on "New Servay Controller"

    click_on "Create Servay controller"

    assert_text "Servay controller was successfully created"
    click_on "Back"
  end

  test "updating a Servay controller" do
    visit servay_controllers_url
    click_on "Edit", match: :first

    click_on "Update Servay controller"

    assert_text "Servay controller was successfully updated"
    click_on "Back"
  end

  test "destroying a Servay controller" do
    visit servay_controllers_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Servay controller was successfully destroyed"
  end
end
