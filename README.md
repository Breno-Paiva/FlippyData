FlippyData
==========

FlippyData is an ORM that connects classes to a database.  This allows you to access the database without writing long SQL queries everytime.  FlippyData is inpsired by the ActiveRecord class in Rails.

How To Use
----------

To use FlippyData clone this repo and make your classes inherit from FlippyData.  A sample database is also provided in this repo.  To create or check associations just open up pry.

Methods
-------

Classes that inherit from FlippyData will have the following methods available:

*`::all` - returns an array of
*`::columns` - returns an array of all column names
*`::find` - search a single record by it's key
*`::where` - search for recods that match a given parameter

*`#insert` - insert a new row into the class table
*`#update` - update a row of this class table
*`#save` - will call the method insert or update depending if class exists in table

you can also build table associations by using:
*`::belongs_to`
*`::has_many`
*`::has_one_through`
*`::has_many_through`
