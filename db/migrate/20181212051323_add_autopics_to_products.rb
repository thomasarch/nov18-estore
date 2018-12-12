class AddAutopicsToProducts < ActiveRecord::Migration[5.2]
  def change
    add_column :products, :autopics, :string
  end
end
