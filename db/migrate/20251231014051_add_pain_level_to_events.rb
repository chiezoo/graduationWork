class AddPainLevelToEvents < ActiveRecord::Migration[7.0]
  def change
    add_column :events, :pain_level, :integer
  end
end
