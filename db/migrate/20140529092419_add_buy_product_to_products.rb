class AddBuyProductToProducts < ActiveRecord::Migration
  def change
    add_column :products, :buy_product, :string
  end
end
