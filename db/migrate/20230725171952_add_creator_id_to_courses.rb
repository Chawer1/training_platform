# frozen_string_literal: true

class AddCreatorIdToCourses < ActiveRecord::Migration[7.0]
  def change
    add_column :courses, :creator_id, :integer
  end
end
