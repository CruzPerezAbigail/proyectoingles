require "application_system_test_case"

class ArchivosTest < ApplicationSystemTestCase
  setup do
    @archivo = archivos(:one)
  end

  test "visiting the index" do
    visit archivos_url
    assert_selector "h1", text: "Archivos"
  end

  test "should create archivo" do
    visit archivos_url
    click_on "New archivo"

    click_on "Create Archivo"

    assert_text "Archivo was successfully created"
    click_on "Back"
  end

  test "should update Archivo" do
    visit archivo_url(@archivo)
    click_on "Edit this archivo", match: :first

    click_on "Update Archivo"

    assert_text "Archivo was successfully updated"
    click_on "Back"
  end

  test "should destroy Archivo" do
    visit archivo_url(@archivo)
    click_on "Destroy this archivo", match: :first

    assert_text "Archivo was successfully destroyed"
  end
end
