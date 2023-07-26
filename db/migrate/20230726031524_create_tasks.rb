# frozen_string_literal: true

class CreateTasks < ActiveRecord::Migration[7.0]
  def change
    create_table :tasks do |t|
      t.string :name
      t.text :description
      t.string :materials
      t.datetime :date_created
      t.string :status
      t.references :lesson, null: false, foreign_key: true

      t.timestamps
    end
  end
end
