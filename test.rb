# This class is used for logins
class User
  attr_reader :sessions, :users

  # Receives a hash with usernames as keys and passwords as values
  def initialize(hash)
    @sessions = []
    @users = []
	@users = hash
  end
  
  # Check password
  def check_password(user, password)
	password_correct = users[user]
	result = password == password_correct
    return result
  end
  
  # login users
  def login(user, password)
	if check_password(user, password)
      sessions << user
    end
  end

  #logout users
  def logout(user)
    sessions.each_with_index do |session, i|
      sessions[i] = nil if session == user
    end
    sessions.compact!
  end
 
  # Register user
  def register_user(user, password)    
	if !user_exists(user)
		users[user] = password
	end
  end

  # Delete users
  def remove_user(user)
    index = users.find_index(user)
    users[index] = nil
    passwords[index] = nil
    users.compact!
    passwords.compact!
  end 

  # Update password
  def update_password(user, old_password, new_password)
    # Check if the user exists
	if user_exists(user)
	  # Check password
	  if check_password(user, old_password)
		users[user] = new_password
        return true
      end
    end
    return false
  end
  
  # Checks if user exists
  def user_exists(user)
    users.include? user
  end
end


registered_users = {
  'user1' => 'pass1',
  'user2' => 'pass2',
  'user3' => 'pass3'
}

user = User.new(registered_users)

user.register_user('user4', 'pass4');
user.login('user4', 'pass4');
user.update_password('user3', 'pass3', 'pass5');
user.login('user3', 'pass5');
user.logout('user4');
user.logout('user3');