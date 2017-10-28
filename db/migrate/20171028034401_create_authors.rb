ROM::SQL.migration do
  change do
    create_table :authors do
      primary_key :id
      column :name, :text, null: false
      column :created_at, :timestamp, null: false, default: Sequel.lit("(now() at time zone 'utc')")
    end
  end
end
