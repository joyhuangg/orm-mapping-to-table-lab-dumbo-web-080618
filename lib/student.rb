class Student

  # Remember, you can access your database connection anywhere in this class
  #  with DB[:conn]
  attr_accessor :name, :grade
  attr_reader :id
  def initialize(name, grade, id=nil)
    @name = name
    @grade = grade
    @id = id
  end

  def self.create_table
    sql = <<-SQL
      CREATE TABLE IF NOT EXISTS students (id INTEGER PRIMARY KEY, name TEXT, grade TEXT);
    SQL

    DB[:conn].execute(sql)
  end

  def self.drop_table
    sql = <<-SQL
      DROP TABLE students;
    SQL

    DB[:conn].execute(sql)
  end

  def save
    sql = <<-SQL
      INSERT INTO students (name, grade) VALUES ('#{self.name}', '#{self.grade}');
    SQL
    DB[:conn].execute(sql)
    instance = <<-SQL
      SELECT id FROM students ORDER BY id DESC LIMIT 1;
    SQL
    @id = DB[:conn].execute(instance).flatten[0]
  end

  def self.create(attributes)
    student = Student.new(attributes[:name], attributes[:grade])
    student.save
    student
  end




end
