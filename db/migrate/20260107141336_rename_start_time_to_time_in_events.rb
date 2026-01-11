class RenameStartTimeToTimeInEvents < ActiveRecord::Migration[7.0]
  def change
    rename_column :events, :start_time, :time
  end
end
