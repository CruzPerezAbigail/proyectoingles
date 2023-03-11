class CreateDocumentos < ActiveRecord::Migration[7.0]
  def change
    create_table :documentos do |t|
      t.string :oficio
      t.string :asunto
      t.date :fecha
      t.string :planestudos
      t.string :seccion
      t.integer :numerocontrol
      t.string :nombre

      t.timestamps
    end
  end
end
