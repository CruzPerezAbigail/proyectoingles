class AddDocumentoToUser < ActiveRecord::Migration[7.0]
  def change
    add_reference :users, :documento, null: false, foreign_key: true
  end
end
