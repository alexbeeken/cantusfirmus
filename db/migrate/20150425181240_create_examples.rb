class CreateExamples < ActiveRecord::Migration
  def change
    create_table :examples do |t|
      t.string :notes
    end
  end
end
