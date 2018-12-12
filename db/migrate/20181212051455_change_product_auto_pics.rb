class ChangeProductAutoPics < ActiveRecord::Migration[5.2]
  def change
  	rename_column :products, :autopics, :autopic
  end
end
