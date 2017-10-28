ROM::SQL.migration do
  change do
    create_table :articles do
      primary_key :id
      column :title, :text, null: false
      column :status, :text, null: false, default: "draft", index: true
      foreign_key :author_id, :authors, null: false
      column :published_at, :timestamp
      column :created_at, :timestamp, null: false, default: Sequel.lit("(now() at time zone 'utc')")
    end
  end
end
