class CreateResultFeeds < ActiveRecord::Migration
  def change
    create_table :result_feeds do |t|
      t.string :feed_type
      t.string :competition_code
      t.string :competition_id
      t.string :competition_name
      t.string :game_system_id
      t.string :season_id
      t.string :season_name
      t.string :timestamp
      t.text :match_data
      t.text :timing_types
      t.text :team

      t.timestamps null: false
    end
  end
end
