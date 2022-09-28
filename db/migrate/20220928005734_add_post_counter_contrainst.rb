class AddPostCounterContrainst < ActiveRecord::Migration[7.0]
  def change
    change_column_null :users, :post_counter, false
    change_column_default :users, :post_counter, 0
  end
end
