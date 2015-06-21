class Pokemon

  attr_accessor :id, :name, :type, :hp, :db

  def initialize(db)
    @db = db
  end


  def self.save(name, type, db)
    sql = <<-SQL 
      INSERT INTO pokemons (name, type) VALUES (?, ?)
    SQL

    db.execute(sql, name, type)
  end

  def self.find(id, db)
    sql = <<-SQL 
      SELECT * FROM pokemons WHERE id = ?
    SQL

    row = db.execute(sql, id).flatten

    Pokemon.new(db).tap do |p|
      p.name = row[1]
      p.type = row[2]
      p.hp = row[3]
    end
  end

  def alter_hp(hp)
    sql = <<-SQL
      UPDATE pokemons SET hp = ? WHERE name = ?
    SQL

    db.execute(sql, hp, name)
  end


end