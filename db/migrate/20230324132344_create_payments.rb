class CreatePayments < ActiveRecord::Migration[7.0]
  def change
    create_table :payments do |t|
      t.string :numero_control
      t.string :status
      t.timestamps
    end
  end
end
