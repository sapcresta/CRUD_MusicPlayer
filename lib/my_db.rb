class DBtransaction
    
    def connect
        @mysql = Mysql2::Client.new(:host => "localhost", :username => "sapana", :password => "S@p@n@123", :database => "crud_database")
        puts "connected"
        return true
    end

    def closedb
        @mysql.close()
    end

end
connect
closedb