require_relative "my_db.rb"
require "pry"


$dbObj = DBtransaction.new
$dbObj.connect
#$dbObj.create_table
#$dbObj.insert_data
#$dbObj.create_playlisttable
#$dbObj.create_join_table



class PlaylistMain
def menu
    puts "1. View songs"
    puts "2. Play music"
    puts "3. Shuffle"
    puts "4. View Playlist"
    puts "5. Create new Playlist"
    puts "6. Manage Playlist"
    puts "7. Manage songs"
    puts "8. exit"
    puts "Please choose an option"
end

def user_selection
    puts "welcome to music player"
    menu 
    
    loop do
        user_choice=$stdin.gets.chomp.to_i
    case (user_choice)
    when 1
       $dbObj.view_data
       puts "\n\n"
       
    when 2
        puts "choose music number:"
        music_id=$stdin.gets.chomp.to_i
        musicname=$dbObj.musictoplay(music_id)
        musicarray=Array.new
        musicname.each  do |item|
            musicarray<< item
            playmusic(musicarray)
        end
        
       
       # %x(find /home/sapana/repos/bootcamp/music_playlist/list-of-music -type f -name "*.mp3" | mpg123  --control -C --list -)
            #end
    when 3
        %x(mpg123 --control --shuffle -Z ../list-of-music/*)
    when 4
        puts "\n"
       $dbObj.view_playlist
       puts "\n"
       puts "PlayList with SongLists"
       $dbObj.view_songs_in_playlist
    when 5
       $dbObj.insert_into_playlist
       
    when 6
        puts "1.Rename"
        puts "2.Delete Playlist?"
        puts "3.Delete songs from playlist"
        puts  "4.exit"
        user_input=$stdin.gets.chomp.to_i
        case (user_input)
            when 1
                puts "\n"
                puts "select the playlist number to rename"
                renameno=$stdin.gets.chomp.to_i
                
                puts "Enter the name"
                rename=$stdin.gets.chomp
                $dbObj.update_playlist(renameno,rename)
            when 2
                puts "\n"
                puts "Enter the playlist number to delete"
                delno=$stdin.gets.chomp.to_i
                $dbObj.delplaylist(delno)
            when 3
                puts "\n"
                $dbObj.view_songs_in_playlist
                puts "Choose playlist to modify"
                playlistno=$stdin.gets.chomp.to_i
                puts "Enter songid from the playlist"
                songid=$stdin.gets.chomp.to_i
                $dbObj.delfromplaylist(songid,playlistno)
                $dbObj.view_songs_in_playlist

            
            when 4
                break
            end
        
        

    when 7
        puts "\n"
        $dbObj.view_data
        puts "Enter the song number to delete"
                songdel=$stdin.gets.chomp.to_i
                $dbObj.delsonglist(songdel)
                puts "\n"
    when 8
        exit
    else
        puts "invalid command"
    end
menu
end

end
end

def playmusic(array1)
   
    array1.each do |k|
        v=k['SongList']
        puts v
        %x(`mpg123 --control  ../list-of-music/'#{v}'`)   
        %x(`mpg123 --control --continue ../list-of-music/*`) 
    end
end

playlistmain=PlaylistMain.new
playlistmain.user_selection
$dbObj.closedb