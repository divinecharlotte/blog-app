class AddDefaultValueToPostCounter < ActiveRecord::Migration[7.0]
  def change
    change_column_default :users, :post_counter, 0
  end
end
