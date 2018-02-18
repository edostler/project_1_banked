require_relative("../db/sql_runner")

class Tag

  attr_reader :id
  attr_accessor :name, :total_spend

  def initialize(options)
    @id = options["id"].to_i if options["id"]
    @name = options['name']
    @total_spend = options['total_spend'].to_f
  end

  def save()
    sql = "INSERT INTO tags (name, total_spend) VALUES ($1, $2) RETURNING id"
    values = [@name, @total_spend]
    tag = SqlRunner.run(sql, values)[0]
    @id = tag["id"].to_i
  end

  def update()
    sql = "UPDATE tags SET (name, total_spend) = ($1, $2) WHERE id = $3"
    values = [@name, @total_spend, @id]
    SqlRunner.run( sql, values )
  end

  def merchants()
    sql = "SELECT merchants.* FROM merchants INNER JOIN transactions ON transactions.merchant_id = merchants.id WHERE transactions.merchant_id = $1;"
    values = [@id]
    merchants = SqlRunner.run(sql, values)
    return merchants.map {|merchant| Merchant.new(merchant)}
  end

  def self.sum_tag_values(id)
    sql = "SELECT SUM(value) FROM transactions WHERE tag_id = $1"
    values = [id]
    return SqlRunner.run(sql, values).first[:sum.to_s].to_f
  end

  def self.delete_all()
    sql = "DELETE FROM tags"
    values = []
    SqlRunner.run(sql, values)
  end

  def self.all()
    sql = "SELECT * FROM tags"
    values = []
    tag = SqlRunner.run(sql, values)
    return tag.map{|tag| Tag.new(tag)}
  end

  def self.find(id)
    sql = "SELECT * FROM tags WHERE id = $1"
    values = [id]
    tag = SqlRunner.run(sql, values)
    return Tag.new(tag.first)
  end

  def self.delete(id)
    sql = "DELETE FROM tags WHERE id = $1"
    values = [id]
    SqlRunner.run(sql, values)
  end

end
