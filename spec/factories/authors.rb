Factory.define :author do |f|
  f.name { fake(:name, :name) }
  f.timestamps
end
