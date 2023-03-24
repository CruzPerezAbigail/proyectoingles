class CreateAnexos < ActiveRecord::Migration[7.0]
  def change
    create_table :anexos do |t|
      t.string :titulo
      
      t.timestamps
    end
  end
end
