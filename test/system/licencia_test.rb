require "application_system_test_case"

class LicenciaTest < ApplicationSystemTestCase
  setup do
    @licencium = licencia(:one)
  end

  test "visiting the index" do
    visit licencia_url
    assert_selector "h1", text: "Licencia"
  end

  test "should create licencium" do
    visit licencia_url
    click_on "New licencium"

    click_on "Create Licencium"

    assert_text "Licencium was successfully created"
    click_on "Back"
  end

  test "should update Licencium" do
    visit licencium_url(@licencium)
    click_on "Edit this licencium", match: :first

    click_on "Update Licencium"

    assert_text "Licencium was successfully updated"
    click_on "Back"
  end

  test "should destroy Licencium" do
    visit licencium_url(@licencium)
    click_on "Destroy this licencium", match: :first

    assert_text "Licencium was successfully destroyed"
  end
end
