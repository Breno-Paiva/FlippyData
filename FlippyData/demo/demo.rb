require_relative "../lib/db_connection.rb"
require_relative "../lib/flippy_data.rb"
require_relative "../lib/associatable.rb"

DB_FILE = "songs.db"
SQL_FILE = 'songs.sql'

class Artist < FlippyData
  has_many :albums

  finalize!
end

class Album < FlippyData
  belongs_to :artist
  has_many :songs

  finalize!
end

class Song < FlippyData
  belongs_to :album
  has_one_through :artist, :album, :artist

  finalize!
end
