class AddDetailsToEvents < ActiveRecord::Migration[7.0]
  def change
    add_column :events, :memo, :text
    add_column :events, :medicine1, :string
    add_column :events, :medicine2, :string
    add_column :events, :medicine3, :string
  end
end
