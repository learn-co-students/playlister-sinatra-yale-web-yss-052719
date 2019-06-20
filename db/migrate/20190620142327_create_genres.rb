class CreateGenres < ActiveRecord::Migration[5.2]
  def change
    create_table :genres do |x|
      x.string :name
    end
  end
end
