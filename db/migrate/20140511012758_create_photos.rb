class CreatePhotos < ActiveRecord::Migration
  def change
    create_table :photos do |t|
    t.integer  "status",                   default: 0
    t.integer  "user_id"
    t.integer  "approver_id"
    t.integer  "score",                    default: 0
    t.integer  "votes",                    default: 0
    t.integer  "graveyard_id"
    t.integer  "plot_id"
    t.integer  "width"
    t.integer  "height"
    t.string   "flags",        limit: 10,  default: ""
    t.string   "title",        limit: 100, default: ""
    t.string   "location",     limit: 100, default: ""
    t.text     "caption"
    t.string   "format",       limit: 3,   default: "jpg"
    t.string   "upload"
      t.timestamps
    end
  end
end
