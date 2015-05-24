class AddKey < ActiveRecord::Migration
  def change
    add_column :examples, :key, :integer
  end
end
