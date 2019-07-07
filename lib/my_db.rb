require "mysql2"
class DBtransaction
    
    def connect
        @mysql = Mysql2::Client.new(:host => "localhost", :username => "sapana", :password => "S@p@n@123", :database => "crud_database")
        puts "connected"
        return true
    end

    def closedb
        @mysql.close()
    end

    def create_table
      stmt=@mysql.prepare(" create table musiclist_table( sid int not null auto_increment primary key, SongList varchar(255) ); ")
     #stmt=@mysql.prepare(" create table playlist_table( pid int not null auto_increment primary key, PlayList varchar(255), foreign key (sid) references musiclist_table(sid) ); ")
      stmt.execute
      
      end

      def create_playlisttable
        stmt=@mysql.prepare(" create table playlist_table( pid int not null auto_increment primary key, PlayList varchar(255));  ")
       
         stmt.execute
      end

      def create_join_table
        stmt=@mysql.prepare(" create table join_table( sid int ,pid int ,foreign key (pid) references playlist_table(pid), foreign key (sid) references musiclist_table(sid) ); ")
      stmt.execute
      end


    
      

    def insert_data
       # mysql= Mysql2::Client.new(:host => "localhost", :username => "sapana", :password => "S@p@n@123", :database => "music")
        puts "inserting data into list table"
        
        a=Dir["/home/sapana/BootcampProjects/CRUD_Application/Music_Player_ClI/list-of-music/*"]
        arr=[]
        a.each do |item|
          arr=File.basename(item)
       

        stmt=@mysql.prepare("insert into musiclist_table(SongList)  values ('#{arr}') ")
        stmt.execute
        end
        
        puts "done"
        
        #mysql.close()
    end

    def view_data
        #mysql = Mysql2::Client.new(:host => "localhost", :username => "sapana", :password => "S@p@n@123", :database => "music")
        result= @mysql.query("select SongList from musiclist_table")
        result.each do |songs|
          puts  songs
         end
     end

     

def musictoplay(mid)
  result= @mysql.query("select SongList from musiclist_table where sid=#{mid}")
  return result
end


    def delete_data
        stmt=@mysql.prepare("delete from musiclist ")
        stmt.execute
    end

    

    def insert_into_playlist
      puts "Enter the name of the playlist"
      playlist_name=gets.chomp
      stmt=@mysql.prepare("insert into playlist_table(PlayList)  values ('#{playlist_name}') ")
      stmt.execute
      $i=0

      
      while $i<5 do
       
    puts "Select the songs to add"
    view_data
    
    songno=gets.chomp.to_i
   
   
    stmt1= @mysql.query("select sid from musiclist_table where sid=#{songno}")
    
    stmt1.each do |x|
     @v1=x['sid']
     
      
    end

    stmt2= @mysql.query("select pid from playlist_table where PlayList='#{playlist_name}'")
    stmt2.each do |y|
     @v2=y['pid']
    end
    
    stmt3=@mysql.prepare("insert into join_table(sid,pid)  values (#{@v1},#{@v2}) ")
    
    
    stmt3.execute
    $i+=1
  end
  end


def view_playlist
  result= @mysql.query("select pid,PlayList from playlist_table")
  result.each do |songs|
    puts  songs
   end
end

#UPDATES
def update_playlist(no,rename)
  stmt=@mysql.prepare("update  playlist_table set PlayList='#{rename}' where pid=#{no} ")
  stmt.execute

end
def delplaylist(delno)
  stmt=@mysql.prepare("delete from playlist_table p join join_table j on p.pid=j.pid  where p.pid=#{delno} ")
  stmt.execute

end


end





