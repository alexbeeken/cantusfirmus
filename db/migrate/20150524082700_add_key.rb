class AddKey < ActiveRecord::Migration
  def change
    add_column :examples, :tonic, :integer
  end
end
