class CreateCurrencies < ActiveRecord::Migration
  def change
    create_table :currencies do |t|
      t.string :charcode
      t.float :value

      t.timestamps
    end
  end
end
