class CreatePorducts < ActiveRecord::Migration[5.1]
  def change
    create_table :porducts do |t|

      t.timestamps
    end
  end
end
