require "application_system_test_case"

class AnexosTest < ApplicationSystemTestCase
  setup do
    @anexo = anexos(:one)
  end

  test "visiting the index" do
    visit anexos_url
    assert_selector "h1", text: "Anexos"
  end

  test "should create anexo" do
    visit anexos_url
    click_on "New anexo"

    click_on "Create Anexo"

    assert_text "Anexo was successfully created"
    click_on "Back"
  end

  test "should update Anexo" do
    visit anexo_url(@anexo)
    click_on "Edit this anexo", match: :first

    click_on "Update Anexo"

    assert_text "Anexo was successfully updated"
    click_on "Back"
  end

  test "should destroy Anexo" do
    visit anexo_url(@anexo)
    click_on "Destroy this anexo", match: :first

    assert_text "Anexo was successfully destroyed"
  end
end
