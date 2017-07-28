ROM::SQL.migration do
  up do
    create_table :articles do
      primary_key :id
      column :title, :text, null: false
      foreign_key :author_id, :authors, null: false
      column :status, :text, null: false, default: "draft", index: true
      column :published_at, :timestamp
      column :created_at, :timestamp, null: false, default: Sequel.lit("(now() at time zone 'utc')")
      column :updated_at, :timestamp, null: false, default: Sequel.lit("(now() at time zone 'utc')")
    end

    execute <<-SQL
      CREATE TRIGGER touch_updated_at BEFORE UPDATE
      ON articles FOR EACH ROW EXECUTE PROCEDURE
      touch_updated_at();
    SQL
  end

  down do
    execute "DROP TRIGGER IF EXISTS touch_updated_at ON customers;"
    drop_table :authors
  end
end
