ROM::SQL.migration do
  up do
    create_table :authors do
      primary_key :id
      column :name, :text, null: false
      column :created_at, :timestamp, null: false, default: Sequel.lit("(now() at time zone 'utc')")
      column :updated_at, :timestamp, null: false, default: Sequel.lit("(now() at time zone 'utc')")
    end

    execute <<-SQL
      CREATE TRIGGER touch_updated_at BEFORE UPDATE
      ON authors FOR EACH ROW EXECUTE PROCEDURE
      touch_updated_at();
    SQL
  end

  down do
    execute "DROP TRIGGER IF EXISTS touch_updated_at ON authors"
    drop_table :authors
  end
end
