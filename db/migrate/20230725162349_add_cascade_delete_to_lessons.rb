# frozen_string_literal: true

class AddCascadeDeleteToLessons < ActiveRecord::Migration[7.0]
  def change
    remove_foreign_key :lessons, :courses
    add_foreign_key :lessons, :courses, on_delete: :cascade
  end
end
