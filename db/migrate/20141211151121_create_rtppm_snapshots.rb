class CreateRtppmSnapshots < ActiveRecord::Migration
  def change
    create_table :rtppm_snapshots do |t|
      t.json :raw_data
      t.datetime :imported_at

      t.timestamps
    end
  end
end
