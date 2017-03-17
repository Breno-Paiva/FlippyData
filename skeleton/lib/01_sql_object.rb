require_relative 'db_connection'
require 'active_support/inflector'
require 'byebug'
# NB: the attr_accessor we wrote in phase 0 is NOT used in the rest
# of this project. It was only a warm up.

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
      ## scope out here is class (Cat)
      define_method(column) do
        ## scope in here is instance (tabby_cat)
        self.attributes[column]
      end

      define_method("#{column}=") do |new_info|
        self.attributes[column] = new_info
      end
    end
  end

  #### add snake_case later vvv BP

  def self.table_name=(table_name)
    @table_name = table_name
  end

  def self.table_name
    @table_name = "#{self.to_s.downcase}s"
  end

  def self.all
    # ...
    results = DBConnection.instance.execute(<<-SQL)
      SELECT
      #{self.table_name}.*
      FROM
        #{self.table_name}
    SQL
    self.parse_all(results)
  end

  def self.parse_all(results)
    # ...
    parsed = []
    results.each do |result|
      parsed << self.new(result)
    end
    parsed
  end

  def self.find(id)
    # ...
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
      # debugger
      unless self.class.columns.include?(key.to_sym)
        raise Exception.new("unknown attribute '#{key}'")
      end

      self.send("#{key}=", val)
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
    col_names = self.class.columns.join(" , ")
    question_marks_array = Array.new(attribute_values.length) {"?"}
    question_marks = question_marks_array.join(" , ")
    vals = attribute_values
    # debugger
    DBConnection.execute(<<-SQL, *vals)
    INSERT INTO
      #{self.class.table_name} (#{col_names})
    VALUES
     (#{question_marks})
    SQL

    
  end

  def update
    # ...
  end

  def save
    # ...
  end
end
