ROM::SQL.migration do
  up do
    execute <<-SQL
     CREATE OR REPLACE FUNCTION touch_updated_at()
       RETURNS TRIGGER AS $$
         BEGIN
          NEW.updated_at = (now() at time zone 'utc');
          RETURN NEW;
         END;
     $$ language 'plpgsql';
    SQL
  end

  down do
    execute "DROP FUNCTION IF EXISTS touch_updated_at();"
  end
end
