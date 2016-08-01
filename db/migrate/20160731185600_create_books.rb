class CreateBooks < ActiveRecord::Migration
  def change
    create_table :books do |t|
      t.string :Title
      t.string :Summary
      t.string :Rating
      t.string :Author
      t.integer :Ranking
      t.string :Awards
      t.string :Recommended_by
      t.string :Amazon
      t.string :Audiobook
      t.string :Animated_Review

      t.timestamps null: false
    end
  end
end
