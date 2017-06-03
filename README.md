FlippyData
==========

FlippyData is an ORM that connects classes to a database.  This allows you to access the database without writing long SQL queries every time.  FlippyData is inspired by the ActiveRecord class in Rails.

How To Use
----------

1. Clone this repo

2. CD into the lib folder and open irb

3. Run the code: load 'flippy_data.rb'

4. Now you can create classes that inherit from FlippyData and you can build associations amogst them


Demo
----
If you would like to test FlippyData's functionality without creating your own database, you can use a sample one that has been provided.

1. cd into the demo folder

2. open irb and run the code : load 'demo.rb'

3. fool around with the data

Methods
-------

Classes that inherit from FlippyData will have the following methods available:

* `::all` - returns an array of
* `::columns` - returns an array of all column names
* `::find` - search a single record by it's key
* `::where` - search for recods that match a given parameter

* `#insert` - insert a new row into the class table
* `#update` - update a row of this class table
* `#save` - will call the method insert or update depending if class exists in table

you can also build table associations by using:
* `::belongs_to`
* `::has_many`
* `::has_one_through`
* `::has_many_through`
