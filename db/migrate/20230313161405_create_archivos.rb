class CreateArchivos < ActiveRecord::Migration[7.0]
  def change
    create_table :archivos do |t|
      
      t.timestamps
    end
  end
end
