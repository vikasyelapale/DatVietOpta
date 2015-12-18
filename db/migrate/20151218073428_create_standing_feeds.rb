class CreateStandingFeeds < ActiveRecord::Migration
  def change
    create_table :standing_feeds do |t|
      t.string :current_round
      t.string :round
      t.string :feed_type
      t.string :competition_code
      t.string :competition_id
      t.string :competition_name
      t.string :game_system_id
      t.string :season_id
      t.string :season_name
      t.string :timestamp
      t.text :competition
      t.text :qualification
      t.text :team

      t.timestamps null: false
    end
  end
end
