require_relative 'db_connection'
require 'active_support/inflector'

class SQLObject
  def self.columns
    @all_data ||= DBConnection.execute2(<<-SQL)
      SELECT
        *
      FROM
        #{self.table_name}
    SQL
    @columns = @all_data.first.map!{ |el| el.to_sym }
  end

  def self.finalize!
    self.columns.each do |column|
      define_method(column) do
        self.attributes[column]
      end

      define_method("#{column}=") do |new_info|
        self.attributes[column] = new_info
      end
    end
  end

  def self.table_name=(table_name)
    @table_name = table_name
  end

  def self.table_name
    @table_name = "#{self.to_s.downcase}s"
    # @table_name || "#{self.to_s.tabelize}"
  end

  def self.all
    results = DBConnection.instance.execute(<<-SQL)
      SELECT
      #{self.table_name}.*
      FROM
        #{self.table_name}
    SQL
    self.parse_all(results)
  end

  def self.parse_all(results)
    parsed = []
    results.each do |result|
      parsed << self.new(result)
    end
    parsed
  end

  def self.find(id)
    obj_params = DBConnection.execute(<<-SQL)
      SELECT
        "#{@table_name}".*
      FROM
        "#{@table_name}"
      WHERE
        "#{@table_name}".id = "#{id}"
    SQL
    return nil if obj_params.length == 0
    self.new(obj_params.first)
  end

  def initialize(params = {})
    self.class.finalize!
    params.each do |key,val|
      if self.class.columns.include?(key.to_sym)
        self.send("#{key}=", val)
      else
        raise Exception.new("unknown attribute '#{key}'")
      end
    end
  end

  def attributes
    @attributes ||= {}
    @attributes
  end

  def attribute_values
    values = []
    self.class.columns.each do |column|
      values << self.send(column)
    end
    values
    # debugger
  end

  def insert
    columns = self.class.columns.drop(1)
    col_names = columns.map(&:to_s).join(', ')
    question_marks_array = Array.new(columns.count) {"?"}
    question_marks = question_marks_array.join(", ")
    vals = attribute_values.drop(1)
    DBConnection.execute(<<-SQL, *vals)
    INSERT INTO
      #{self.class.table_name} (#{col_names})
    VALUES
     (#{question_marks})
    SQL

    self.id = DBConnection.last_insert_row_id
  end

  def update
    to_update = self.class.columns.drop(1).map {|attr| "#{attr}= ?"}.join(', ')
    DBConnection.execute(<<-SQL, *attribute_values.drop(1), id)
      UPDATE
        #{self.class.table_name}
      SET
        #{to_update}
      WHERE
        #{self.class.table_name}.id = ?
    SQL
  end

  def save
    id.nil? ? insert : update 
  end
end
